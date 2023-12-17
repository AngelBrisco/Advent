s = open("p5.txt") do file
    readlines(file)
end

coor_matrix = reshape(parse.(Int32,hcat(split.(hcat(split.(s," -> ")...),",")...)).+1,4,:)
x1 = coor_matrix[1,:]
y1 = coor_matrix[2,:]
x2 = coor_matrix[3,:]
y2 = coor_matrix[4,:]

coordenates = [x1,y1,x2,y2]

function field_gen(coordenates)
    x1,y1,x2,y2 = coordenates
    mx_num = maximum([x1;y1;x2;y2])
    field = zeros(mx_num,mx_num)
    return field
end


function fill_field(coordenates)
    field = field_gen(coordenates)
    x1,y1,x2,y2 = coordenates
    for i in 1:length(x1)
        (x1[i]==x2[i])&&(field[x1[i],minimum([y1[i],y2[i]]):maximum([y1[i],y2[i]])].+=1)
        (y1[i]==y2[i])&&(field[minimum([x1[i],x2[i]]):maximum([x1[i],x2[i]]),y1[i]].+=1)
    end
    return field
end

field = fill_field(coordenates)

println(sum(field.>=2))

function fill_field2(coordenates)
    field = field_gen(coordenates)
    x1,y1,x2,y2 = coordenates
    for i in 1:length(x1)
        (x1[i]==x2[i])&&(field[x1[i],minimum([y1[i],y2[i]]):maximum([y1[i],y2[i]])].+=1)
        (y1[i]==y2[i])&&(field[minimum([x1[i],x2[i]]):maximum([x1[i],x2[i]]),y1[i]].+=1)
        if abs(x1[i]-x2[i]) == abs(y1[i]-y2[i])
            min_x = minimum([x1[i],x2[i]])
            max_x = maximum([x1[i],x2[i]])
            x1[i]==min_x ? ((s_y, f_y) = (y1[i], y2[i])) : ((s_y, f_y) = (y2[i], y1[i]))
            s_y<f_y ? step = 1 : step = -1
            xs = [i for i in min_x:max_x]
            ys = [i for i in s_y:step:f_y]
            for i2 in 1:length(xs)
                field[xs[i2],ys[i2]]+=1
            end
        end
    end
    return field
end

println(sum(fill_field2(coordenates).>=2))
