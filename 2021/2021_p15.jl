s = open("p15.txt") do file
    readlines(file)
end

s=split.(s,"")
s2=[]
for i in 1:length(s)
    append!(s2, parse.(Int32,s[i])...)
end

sq_s=length(s)

mat=reshape(s2,(sq_s,sq_s))
djt=Dict()

for c in 1:sq_s, r in 1:sq_s
    djt["$r,$c"]=[Inf,"x"]
end
djt["1,1"]=[0,"1,1"]

explored=[]
known=["1,1"]


function djt_step(known,explored,mat,djt)
    min_k=known[1]
    ml = size(mat)[1]
    for k in known
        (djt[min_k][1]>djt[k][1]) && (min_k=k)
    end
    r,c=parse.(Int32,split(min_k,","))
    if (r!=1)&!("$(r-1),$c" in explored)
        (mat[r-1,c]+djt[min_k][1]<djt["$(r-1),$c"][1]) && (djt["$(r-1),$c"]=[mat[r-1,c]+djt[min_k][1],min_k])
        !("$(r-1),$c" in known) && (push!(known,"$(r-1),$c"))
    end
    if (c!=1)&!("$r,$(c-1)" in explored)
        (mat[r,c-1]+djt[min_k][1]<djt["$r,$(c-1)"][1]) && (djt["$r,$(c-1)"]=[mat[r,c-1]+djt[min_k][1],min_k])
        !("$r,$(c-1)" in known) && (push!(known,"$r,$(c-1)"))
    end
    if (r!=ml)&!("$(r+1),$c" in explored)
        (mat[r+1,c]+djt[min_k][1]<djt["$(r+1),$c"][1]) && (djt["$(r+1),$c"]=[mat[r+1,c]+djt[min_k][1],min_k])
        !("$(r+1),$c" in known) && (push!(known,"$(r+1),$c"))
    end
    if (c!=ml)&!("$r,$(c+1)" in explored)
        (mat[r,c+1]+djt[min_k][1]<djt["$r,$(c+1)"][1]) && (djt["$r,$(c+1)"]=[mat[r,c+1]+djt[min_k][1],min_k])
        !("$r,$(c+1)" in known) && (push!(known,"$r,$(c+1)"))
    end
    push!(explored,min_k)
    filter!(x-> x!=min_k,known)
end

#Part1
while !("$sq_s,$sq_s" in explored)
    djt_step(known,explored,mat,djt)
end
println(djt["$sq_s,$sq_s"])

mat = Int16.(mat)

mat2 = fill(Int16(0),size(mat).*5)

mat2[1:sq_s,1:sq_s].=mat.+0
mat2[1:sq_s,(sq_s+1):(sq_s*2)].=mat.+1
mat2[1:sq_s,(sq_s*2+1):(sq_s*3)].=mat.+2
mat2[1:sq_s,(sq_s*3+1):(sq_s*4)].=mat.+3
mat2[1:sq_s,(sq_s*4+1):(sq_s*5)].=mat.+4

mat2[sq_s+1:(sq_s*2),:].=mat2[1:sq_s,:].+1
mat2[(sq_s*2)+1:(sq_s*3),:].=mat2[sq_s+1:(sq_s*2),:].+1
mat2[(sq_s*3)+1:(sq_s*4),:].=mat2[(sq_s*2)+1:(sq_s*3),:].+1
mat2[(sq_s*4)+1:(sq_s*5),:].=mat2[(sq_s*3)+1:(sq_s*4),:].+1

mat2 .= mat2.%9
mat2 .+= (mat2.==0).*9

djt=Dict()

for c in 1:(sq_s*5), r in 1:(sq_s*5)
    djt["$r,$c"]=[Inf,"x"]
end
djt["1,1"]=[0,"1,1"]

explored=[]
known=["1,1"]

while !("$(sq_s*5),$(sq_s*5)" in explored)
    djt_step(known,explored,mat2,djt)
end
println(djt["$(sq_s*5),$(sq_s*5)"])