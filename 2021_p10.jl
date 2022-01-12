s = open("p10.txt") do file
    readlines(file)
end

function is_corrupted(line)
    ch_l = []
    for ch in line
        in_len = length(ch_l)
        (ch=='[')&&push!(ch_l,ch)
        (ch=='(')&&push!(ch_l,ch)
        (ch=='<')&&push!(ch_l,ch)
        (ch=='{')&&push!(ch_l,ch)
        
        ((length(ch_l)>0)&&((ch==']')&(ch_l[end]=='['))) && (ch_l=ch_l[1:in_len-1])
        ((length(ch_l)>0)&&((ch==')')&(ch_l[end]=='('))) && (ch_l=ch_l[1:in_len-1])
        ((length(ch_l)>0)&&((ch=='>')&(ch_l[end]=='<'))) && (ch_l=ch_l[1:in_len-1])
        ((length(ch_l)>0)&&((ch=='}')&(ch_l[end]=='{'))) && (ch_l=ch_l[1:in_len-1])

        (in_len==length(ch_l))&&return(ch)
    end
    return ch_l
end


corrupted_lines = is_corrupted.(s)
output1 = sum(corrupted_lines.==')')*3 + 
sum(corrupted_lines.==']')*57 +
sum(corrupted_lines.=='}')*1197  + 
sum(corrupted_lines.=='>')*25137

function completion_value(line)
    ch_l = is_corrupted(line)
    (typeof(ch_l)==Char)&&return 0
    output = 0

    for ch in ch_l[end:-1:1]
        (ch=='(') && (output = (output*5) + 1)
        (ch=='[') && (output = (output*5) + 2)
        (ch=='{') && (output = (output*5) + 3)
        (ch=='<') && (output = (output*5) + 4)
    end

    return output
end

output2 = sort(filter(x-> x!=0, completion_value.(s)))
output2 = output2[(length(output2)÷2)+1]

function cvt(lines)
    output2 = zeros(length(lines))
    Threads.@threads for i in 1:length(lines)
        output2[i] = completion_value(lines[i])
    end
    output2 = sort(filter(x-> x!=0, output2))
    output2 = output2[(length(output2)÷2)+1]
    output2
end


using BenchmarkTools

@benchmark completion_value.(s)
@benchmark cvt(s)

