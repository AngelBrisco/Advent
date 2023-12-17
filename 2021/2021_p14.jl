lines = open("p14.txt") do file
    readlines(file)
end

template = lines[1]

rules = lines[3:end]

dict_rules = Dict(v[1]=>v[2] for v in split.(rules, " -> "))

function ins_step(template, rules)
    insertions = fill("0",length(template))
    for i in 1:(length(template)-1)
        (template[i:(i+1)] in keys(rules))&&(insertions[i]=rules[template[i:(i+1)]])
    end
    new_template = fill("0",length(template)+length(insertions))
    for i in 1:2:(length(new_template))
        new_template[i]=string(template[Int((i/2)+0.5)])
        new_template[i+1]=insertions[Int((i/2)+0.5)]
    end
    return join(filter(x -> x!="0", new_template))
end

template_copy = template
n_steps = 10
for n in 1:n_steps
    template_copy = ins_step(template_copy, dict_rules)
end

c_uni=string.(unique(template_copy))
c_val=[]

for c in c_uni
    push!(c_val,sum(c.==split(template_copy,"")))
end

maximum(c_val)-minimum(c_val) #first answer with total list in memory


#second part will make a string to long to save so we save a dict with pair => intance of pair
function count_keys(template,rules)
    c_d = Dict(k => 0 for k in keys(rules))
    for i in 1:(length(template)-1)
        (template[i:i+1] in keys(c_d))&&(c_d[template[i:i+1]]+=1)
    end
    return c_d
end

counted_dict = count_keys(template,dict_rules)

function abstract_step(counted_dict,rules,chr_vals)
    new_cd = Dict(k=>0 for k in keys(counted_dict))
    for k in keys(rules)
        new_k = string(k[1])*rules[k]
        new_cd[new_k]+=counted_dict[k]
        (rules[k] in keys(chr_vals)) ? chr_vals[rules[k]]+=counted_dict[k] : chr_vals[rules[k]]=counted_dict[k] 
        new_k = rules[k]*string(k[2])
        new_cd[new_k]+=counted_dict[k]
    end
    return new_cd, chr_vals
end

chr_vals =  Dict(k=>0 for k in values(dict_rules)) 
for c in template
    c = string(c)
    chr_vals[c]+=1
end # for counting the number of letters in the template

ncd = copy(counted_dict) #to work on a copy of counted_dict and dont do it inplace
n_steps = 40
for n in 1:n_steps
    ncd,chr_vals = abstract_step(ncd,dict_rules,chr_vals)
end

maximum(values(chr_vals))-minimum(values(chr_vals))