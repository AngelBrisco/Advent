xt = [20,30]
yt = [-10,-5]

position = [0,0]
vel = [9,0]


num_y = [0]
for i in 1:1000
    push!(num_y, num_y[end]+i)
end
num_y .= num_y.*-1

function pos_y(num_y, y)
    out = []
    uplim = y
    if y<0
        for i in y:-1
            any((num_y .- num_y[-i])[-i:end].==y) && (push!(out,i))
        end
        uplim = abs(uplim)-1
    end
    for i in 0:uplim
        any((num_y .- num_y[1+i]).==y) && (push!(out,i))
    end
    out
end

pos_y(num_y,-7)

function pos_x(x)
    nx = abs(x)
    out = []
    for i in 1:nx
        if nx%i == 0
            push!(out, (nx÷i)+(i÷2))
        end
    end
    sort(unique(out))
end


pos_x(15)

coor = [28,-7]
pos_y(num_y,9)
pos_x(300)

function y_peak(vel)
    maximum(num_y .- num_y[1+vel])
end

maximum(y_peak.(filter(x-> x>0, vcat([pos_y(num_y,i) for i in -80:-45]...))))

sort(unique(vcat([pos_y(num_y,i) for i in -10:-5]...)))
sort(unique(vcat([pos_x(i) for i in 20:30]...)))

function check_vel(velx, vely, xt, yt)
    pos = [0,0]
    while true
        if pos[1]>xt[2]
            return false
        end
        if (pos[2]<yt[1])&(vely<0)
            return false
        end
        if xt[1]<=pos[1]<=xt[2]
            if yt[1]<=pos[2]<=yt[2]
                return true
            end
        end
        pos[1] += velx
        pos[2] += vely
        vely -= 1
        velx==0 ? velx = 0 : velx -= velx/(abs(velx))
    end
end

xt = [282,314]
yt = [-45,80]
#xt = [20,30]
#yt = [-10,-5]

pos_velocities2 = []
for vely in sort(unique(vcat([pos_y(num_y,i) for i in yt[1]:yt[2]]...)))
    for velx in sort(unique(vcat([pos_x(i) for i in xt[1]:xt[2]]...)))
        if any(check_vel2(velx, vely, xt, yt))
            push!(pos_velocities2, [velx, vely])
        end
    end
end

pos_velocities2
unique(pos_velocities)
for i in pos_velocities2
    if (i in pos_velocities)==false
        println(i)
    end
end

function check_vel2(velx, vely, xt, yt)
    pos = [0,0]
    xpos = [velx]
    ypos = num_y
    for i in (velx-1):-1:1
        push!(xpos,xpos[end]+i)
    end
    if vely>0
        ypos = num_y .- num_y[1+vely]
        for i in ypos[1:vely]
            pushfirst!(ypos,i)
        end
    end
    if vely<0
        ypos = (num_y .- num_y[-vely])[-vely+1:end]
    end
    xpos = vcat([xpos,ones(Int64,(length(ypos)-length(xpos)))*xpos[end]]...)
    bool_X = (xpos.>=xt[1]).&(xpos.<=xt[2])
    bool_y = (ypos.>=yt[1]).&(ypos.<=yt[2])
    any(bool_X .& bool_y)
    ypos
end

check_vel2(9, 1, xt, yt)
check_vel(9, 1, xt, yt)
