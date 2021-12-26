s = open("p4.txt") do file
    readlines(file)
end

num = split(s[1],",")
num = parse.(Int32,num)

tables = []
for l in 3:6:length(s), i in 0:4
    push!(tables, split.(s[l+i]," ")...)
end

filter!(x->x!="",tables)
tables = parse.(Int32,tables)
tables = reshape(tables,5,5,:)

function chk_bingo(tables)
    tables = (tables.==-1)*1
    rows = (sum(tables,dims=1)).==5
    cols = (sum(tables,dims=2)).==5
    bing_by_row = sum(rows,dims=2)
    bing_by_col =sum(cols,dims=1)
    for i in 1:length(bing_by_col)
        (bing_by_col[i]==1)&&(return i)
    end
    for i in 1:length(bing_by_row)
        (bing_by_row[i]==1)&&(return i)
    end
    return 0
end


function lst_bing_num(tables,num)
    l=[]
    for i in num
        tables[tables.==i].=-1
        c_b = chk_bingo(tables)
        while c_b!=0
            ts = (sum(tables[:,:,c_b])+sum(tables[:,:,c_b].==-1))*i
            push!(l,(c_b,i,(sum(tables[:,:,c_b])+sum(tables[:,:,c_b].==-1)),ts))
            tables[:,:,c_b].=-2
            c_b = chk_bingo(tables)
        end
    end
    return l
end

println(lst_bing_num(tables,num))