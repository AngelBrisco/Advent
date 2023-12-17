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