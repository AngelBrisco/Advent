s = open("Advent/2023/p2.txt") do file
    readlines(file)
end
s

#part 1
function data_extraction(l)
    game, game_data = split(l,":")
    game = parse(Int32,split(game," ")[2])
    game
    game_data = split(game_data,";")
    return game, game_data
end

data_extraction(s[1])

function game_eval(game_data, red, green, blue)
    throws = split(game_data,",")
    throws = split.(throws, " ")
    for t in throws
        ((t[3]=="red").&(parse(Int32,t[2])>red))&&(return false)
        ((t[3]=="green").&(parse(Int32,t[2])>green))&&(return false)
        ((t[3]=="blue").&(parse(Int32,t[2])>blue))&&(return false)
    end
    true
end

function full_eval(l,red, green, blue)
    game, game_data = data_extraction(l)
    eval = all(game_eval.(game_data, red, green, blue))
    return [game, eval]
end

out = 0
for i in full_eval.(s, 12, 13, 14) 
    (i[2]==1)&&(out+=i[1])
end
out

#part 2

function val_col(game_data)
    throws = split(game_data,",")
    throws = split.(throws, " ")
    red_val = Int32(0)
    green_val = Int32(0)
    blue_val = Int32(0)
    for t in throws
        (t[3]=="red")&&(red_val = parse(Int32,t[2]))
        (t[3]=="green")&&(green_val = parse(Int32,t[2]))
        (t[3]=="blue")&&(blue_val = parse(Int32,t[2]))
    end
    [red_val, green_val, blue_val]
end

val_col(data_extraction(s[1])[2][1])

function biggest_val_col(game_data)
    maximum(hcat(val_col.(game_data)...),dims=2)
end

biggest_val_col(data_extraction.(s[5])[2])
out2=0
for g in data_extraction.(s)
    out2 += reduce(*,biggest_val_col(g[2]))
end
out2