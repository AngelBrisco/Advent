s = open("p9.txt") do file
    readlines(file)
end

n_rows = length(s)
n_cols = length(s[1])

s_matrix = parse.(Int32, split(join(s),""))
s_matrix = reshape(s_matrix,n_cols,n_rows)'


function find_lmin(mat)
    nrows, ncols = size(mat)
    height_map = zeros( size(mat))
    for r in 1:nrows, c in 1:ncols
        right,left,up,down = 1,1,1,1
        (c<ncols)&&(right = mat[r,c]<mat[r,c+1])
        (c>1)&&(left = mat[r,c]<mat[r,c-1])
        (r<nrows)&&(up = mat[r,c]<mat[r+1,c]) 
        (r>1)&&(down = mat[r,c]<mat[r-1,c])
        height_map[r,c] = right*left*up*down
    end
    return height_map
end

local_mins = find_lmin(s_matrix)


function find_lmin_indx(mat)
    nrows, ncols = size(mat)
    l_mins = []
    for r in 1:nrows, c in 1:ncols
        right,left,up,down = 1,1,1,1
        (c<ncols)&&(right = mat[r,c]<mat[r,c+1])
        (c>1)&&(left = mat[r,c]<mat[r,c-1])
        (r<nrows)&&(up = mat[r,c]<mat[r+1,c]) 
        (r>1)&&(down = mat[r,c]<mat[r-1,c])
        (1 == right*left*up*down)&&(push!(l_mins,(r,c)))
    end
    return l_mins
end

find_lmin_indx(s_matrix)


function explorer(seed,mat)
    nrows, ncols = size(mat)
    explored = []
    known = [seed]
    while known!=[]
        r,c = known[1]
        ((c<ncols)&&(mat[r,c+1]<9))&&push!(known,(r,c+1))
        ((c>1)&&(mat[r,c-1]<9))&&push!(known,(r,c-1))
        ((r<nrows)&&(mat[r+1,c]<9))&&push!(known,(r+1,c))
        ((r>1)&&(mat[r-1,c]<9))&&push!(known,(r-1,c))
        push!(explored,(r,c))
        filter!(x-> !(x in explored),known)
    end
    return explored
end

function basins_explorer(mat)
    seeds = find_lmin_indx(mat)
    basins = []
    for seed in seeds
        push!(basins,explorer(seed,mat))
    end
    return basins
end

reduce(*,sort(length.(basins_explorer(s_matrix)),rev=true)[1:3])