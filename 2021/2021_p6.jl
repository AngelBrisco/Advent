s = open("p6.txt") do file
    readlines(file)
end

s=parse.(Int32,split(s[1],","))

function school_progress1(school, days)
    (days>80)&&(return)
    school = copy(school)
    for day in 1:days
        new_fish = ones(sum(school.==0)).*8
        school .-= 1
        school[school.==-1] .= 6
        append!(school,new_fish)
    end
    return length(school)
end

println(school_progress1(s, 18))

function school_progress2(school, days)
    value_by_day = [sum(school.==i) for i in 0:8]

    for day in 1:days
        value_by_day = [value_by_day[2],
        value_by_day[3],
        value_by_day[4],
        value_by_day[5],
        value_by_day[6],
        value_by_day[7],
        value_by_day[8]+value_by_day[1],
        value_by_day[9],
        value_by_day[1]]
    end

    return sum(value_by_day)
end

println(school_progress2(s,256))

using BenchmarkTools

@benchmark school_progress2(s,80)
@benchmark school_progress1(s,80)
