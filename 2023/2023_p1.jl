s = open("Advent/2023/p1.txt") do file
    readlines(file)
end
s
# star one 
function lineproc(l)
    l = replace(l, "one"=>"1", "two"=>"2", "three"=>"3", "four"=>"4", "five"=>"5", "six"=>"6","seven"=>"7","eight"=>"8","nine"=>"9")
    digits = findall(r"\d",l)
    val = l[digits[1]]*l[digits[end]]
    return val
end


linevalues = lineproc.(s) 
linevalues = parse.(Int32, linevalues)
out = sum(linevalues)

#star two
function lineproc(l)
    l = replace(l, "twone" => "21", "oneight" => "18", "threeight" => "38", "fiveight" => "58", "sevenine" => "79", "eightwo" => "82", "eighthree" => "83")
    l = replace(l, "one"=>"1", "two"=>"2", "three"=>"3", "four"=>"4", "five"=>"5", "six"=>"6","seven"=>"7","eight"=>"8","nine"=>"9")
    digits = findall(r"\d",l)
    val = l[digits[1]]*l[digits[end]]
    return val
end


linevalues = lineproc.(s) 
linevalues = parse.(Int32, linevalues)
out = sum(linevalues)
