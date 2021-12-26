s = open("p2.txt") do file
    readlines(file)
end
s = split.(s)
x_plane = 0
y_plane = 0

for i in s
    (i[1]=="forward")&&(global x_plane+=parse(Int32,i[2]))
    (i[1]=="up")&&(global y_plane-=parse(Int32,i[2]))
    (i[1]=="down")&&(global y_plane+=parse(Int32,i[2]))
end
println(x_plane*y_plane)

#part 2
x_plane = 0
y_plane = 0
aim = 0

for i in s
    if i[1]=="forward"
        global x_plane += parse(Int32,i[2])
        global y_plane += parse(Int32,i[2])*aim
    end
    (i[1]=="up")&&(global aim-=parse(Int32,i[2]))
    (i[1]=="down")&&(global aim+=parse(Int32,i[2]))
end
println(x_plane*y_plane)