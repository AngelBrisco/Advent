using Statistics

s = open("p3.txt") do file
    readlines(file)
end

d = zeros(12)

s_matrix = [sn[i] for sn in s, i in 1:12]
s_matrix = parse.(Int16,s_matrix)

for i in 1:12
    d[i]=(mean(s_matrix[:,i])>=0.5).*1
end

d2 = (d.==0).*1

function bin_dc(a)
    accum = 0
    for i in 1:12
        accum += a[i]*2^(12-i)
    end
    return accum
end

g_rate = bin_dc(d)
e_rate = bin_dc(d2)

pwr_con = g_rate*e_rate

println("power ", pwr_con)

#Part 2


function loc_o2(a,ind)
    (length(a)==12)&&(return a)
    a_out = []
    d = zeros(12)
    for i in 1:12
        d[i]=(mean(a[:,i])>=0.5).*1
    end
    for r in (1:Int32(length(a)/12))
        (a[r,ind]==d[ind])&&(push!(a_out,a[r,:]...))
    end
    a_out = [a_out[c+(12*r)] for r in 0:(Int32(length(a_out)/12)-1), c in 1:12]
    return loc_o2(a_out,ind+1)
end

function loc_co2(a,ind)
    (length(a)==12)&&(return a)
    a_out = []
    d = zeros(12)
    for i in 1:12
        d[i]=(mean(a[:,i])>=0.5).*1
    end
    for r in (1:Int32(length(a)/12))
        (a[r,ind]!=d[ind])&&(push!(a_out,a[r,:]...))
    end
    a_out = [a_out[c+(12*r)] for r in 0:(Int32(length(a_out)/12)-1), c in 1:12]
    return loc_co2(a_out,ind+1)
end

o2_r = loc_o2(s_matrix,1)
o2_r = bin_dc(o2_r)
co2_r = loc_co2(s_matrix,1)
co2_r = bin_dc(co2_r)
ls_r = o2_r*co2_r

println("life support ", ls_r)
