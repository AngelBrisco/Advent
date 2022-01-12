s = open("p11.txt") do file
    readlines(file)
end

function parse_inp(inp)
    n_rows = length(inp)
    n_cols = length(inp[1])
    mat = []
    for line in inp
        append!(mat,split(line,""))
    end
    mat = parse.(Int32,reshape(mat, (n_cols,n_rows)))'
    return mat
end

mat = parse_inp(s)


function mat_step(mat)
    s = 0
    n_rows,n_cols = size(mat)
    mat .+= 1
    flashed_in_step = zeros(Int32,n_rows,n_cols) #prevents multiple flashes per turn
    while any(mat.>9)
        #println("vuelta: ", s)
        #println("mat")
        #println(mat)
        flashed = mat.>9 
        flashed_in_step += flashed
        #println("flashed_in_step")
        #println(flashed_in_step)
        expansion = zeros(Int32,n_rows,n_cols)
        for r in 1:n_rows, c in 1:n_cols
            ri = maximum([r-1,1])
            rf = minimum([r+1,n_rows])
            ci = maximum([c-1,1])
            cf = minimum([c+1,n_cols])
            expansion[r,c] = sum(flashed[ri:rf,ci:cf].==1) # amount of flashes around each point
        end
        #println("expansion")
        #println(expansion)
        mat .+= expansion #expand flash
        mat[flashed_in_step.==1].=0 #turn flashed to 0
    end
    return mat,flashed_in_step
end


function mat_steps(mat, steps)
    mat = copy(mat)
    for s in 1:steps
        mat = mat_step(mat)[1]
    end
    return mat
end

function count_flashes(mat,steps)
    mat = copy(mat)
    t_flashes = 0
    for s in 1:steps
        mat, flashes = mat_step(mat)
        t_flashes += sum(flashes)
    end
    return t_flashes
end
        
output1 = count_flashes(mat,100)

function sincro_flashes(mat)
    mat = copy(mat)
    sincro_step = false
    s = 0
    while !sincro_step
        s+=1
        mat, flashes = mat_step(mat)
        (sum(flashes)==reduce(*,size(mat)))&& return s
    end
end

sincro_flashes(mat)