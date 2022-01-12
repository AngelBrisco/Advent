lines = open("p12.txt") do file
    readlines(file)
end

path_dict = Dict()

for line in lines
    k,v = string.(split(line,"-"))
    (k in keys(path_dict)) ? path_dict[k]=[v,path_dict[k]...] : path_dict[k]=[v]
    (k=="start")&&continue
    (v=="end")&&continue
    k,v = v,k
    (k in keys(path_dict)) ? path_dict[k]=[v,path_dict[k]...] : path_dict[k]=[v]
end 

path_dict


function cave_explorer(path_dict,explored=[],current_cave="start",path_taken=[])
    path_taken = copy(path_taken)
    push!(path_taken,current_cave)
    explored = copy(explored)
    end_reached=0
    (current_cave[1] in 'a':'z')&&push!(explored,current_cave)
    for next_cave in path_dict[current_cave]
        if next_cave=="end"
            end_reached+=1
            #println(path_taken)
            continue
        end

        if (next_cave in explored)
            continue
        end

        end_reached += cave_explorer(path_dict,explored,next_cave,path_taken)
    end
    return end_reached
end

cave_explorer(path_dict)

function cave_explorer2(path_dict,explored=[],current_cave="start",path_taken=[])
    path_taken = copy(path_taken)
    push!(path_taken,current_cave)
    explored = copy(explored)
    end_reached=0
    (current_cave[1] in 'a':'z')&&push!(explored,current_cave)
    small_twice = length(unique(explored))!=length(explored)
    for next_cave in path_dict[string(current_cave)]
        if next_cave=="end"
            end_reached+=1
            #println(path_taken)
            continue
        end

        if next_cave=="start"
            continue
        end

        if ((next_cave in explored)|(string(next_cave) in explored))&small_twice
            continue
        end

        end_reached += cave_explorer2(path_dict,explored,next_cave,path_taken)
    end
    return end_reached
end

cave_explorer2(path_dict)
