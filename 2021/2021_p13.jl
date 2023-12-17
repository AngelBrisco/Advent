lines = open("p13.txt") do file 
    readlines(file)
end

x_coor = []
y_coor = []
x_fold = []
y_fold = []

for line in lines
    line=="" && continue
    if occursin("fold",line)
        line = replace(line, "fold along "=>"")
        ax, v = split(line,"=")
        ax=="x" ? push!(x_fold,parse(Int32,v)) : push!(y_fold,parse(Int32,v))
    else
        xi, yi = parse.(Int32,split(line,","))
        push!(y_coor,xi)
        push!(x_coor,yi)
    end
end

x_coor.+=1
y_coor.+=1
x_fold.+=1
y_fold.+=1


mat = zeros(Int8,maximum(x_coor),maximum(y_coor))

for i in 1:length(x_coor)
    mat[x_coor[i],y_coor[i]]=1
end

mat

function fold_mat(mat,c,v)
    mat=copy(mat)
    if c=="y"
        first_mat = mat[1:(v-1),:]
        second_mat = mat[(v+1):end,:]
    else
        first_mat = mat[:,1:(v-1)]
        second_mat = mat[:,(v+1):end]
    end
    (c=="y") && (second_mat = reverse(second_mat,dims=1))
    (c=="x") && (second_mat = reverse(second_mat,dims=2))
    mat = (first_mat .+ second_mat).>0

    return mat
end

output_1 = sum(fold_mat(mat,"x",x_fold[1]))

final_mat = copy(mat)

for v in x_fold
    final_mat = fold_mat(final_mat,"x",v)
end
for v in y_fold
    final_mat = fold_mat(final_mat,"y",v)
end

using Plots
Plots.heatmap(reverse(final_mat,dims=1))
