### A Pluto.jl notebook ###
# v0.17.1

using Markdown
using InteractiveUtils

# ╔═╡ 1a6404a0-6908-11ec-3f41-6be87a68d341
begin
	s = open("p8.txt") do file
		readlines(file)
	end
	s = split.(s,"|")
end

# ╔═╡ e8cea33b-2c06-493d-81f7-9bdf7f36983e
begin
	sum([sum(in([2,4,7,3]).(length.(split(l[2]," ")))) for l in s])
end

# ╔═╡ f3b96106-f955-47e7-8000-c1c17fcdccc7
begin
	function clean_chars(line)
		
		line = split(line," ")
		uniq_2 = []
		uniq_3 = []
		uniq_4 = []
		uniq_7 = []
		group_6 = []
		group_5 = []
		for chrs in line
			(length(chrs)==2)&&(uniq_2 = split(chrs,""))
			(length(chrs)==3)&&(uniq_3 = split(chrs,""))
			(length(chrs)==4)&&(uniq_4 = split(chrs,""))
			(length(chrs)==7)&&(uniq_7 = split(chrs,""))
			(length(chrs)==5)&& push!(group_5,split(chrs,""))
			(length(chrs)==6)&& push!(group_6,split(chrs,""))
		end
		top = ""
		left_up = ""
		left_down = ""
		middle = ""
		right_down = ""
		right_up = ""
		down = ""
		
		
		for i in uniq_3
			!(i in uniq_2) && (top=i)
		end
		
		for chr in uniq_4
			(chr in group_6[1])&(chr in group_6[2])&(chr in group_6[3])&!(chr in uniq_2)&&(left_up=chr)
			((((chr in group_6[1])&(chr in group_6[2])&(chr in group_6[3]))==false)&!(chr in uniq_2))&&(middle=chr)
		end
		
		for chr in uniq_2
			(chr in group_6[1])&(chr in group_6[2])&(chr in group_6[3])&&(right_down=chr)
			(((chr in group_6[1])&(chr in group_6[2])&(chr in group_6[3]))==false)&&(right_up=chr)
		end
		
		for chr in unique(hcat(group_6...))
			((((chr in group_6[1])&(chr in group_6[2])&(chr in group_6[3]))==false) &(chr!=middle) & (chr!=right_up))&&(left_down =chr)
		end

		for chr in ["a","b","c","d","e","f","g"]
			!(chr in [top,left_up,left_down,middle,right_down,right_up])&&(down=chr)
		end

		nums_d = Dict("0" => [top,left_up,left_down,down,right_down,right_up],
		"1" => [right_down,right_up],
		"2" => [top,left_down,down, middle, right_up],
		"3" => [top, down, middle, right_down, right_up],
		"4" => [left_up, middle, right_down,right_up],
		"5" => [top,left_up,down, middle, right_down],
		"6" => [top,left_up,left_down,down,middle,right_down],
		"7" => [top, right_down,right_up],
		"8" => [top,left_up,left_down,down,middle ,right_down,right_up],
		"9" => [top,left_up,down, middle, right_down,right_up],)

		nums_d
	
	end
	clean_chars(s[5][1])
end

# ╔═╡ 43f55eab-4533-431d-8243-66f2fc08dcdc
begin
	function analize_end(line)
		num_dict = clean_chars(line[1])
		l = []
		for num in split(line[2]), k in num_dict
			(length(k[2])==length(num))&(all(in(k[2]).(split(num,""))))&&(push!(l, k[1]))
		end
		parse.(Int32,join(l))
	end
	analize_end(s[1])
end

# ╔═╡ 00bc0587-5b8f-4c09-bc19-def0e110c821
sum([analize_end(line) for line in s])

# ╔═╡ Cell order:
# ╠═1a6404a0-6908-11ec-3f41-6be87a68d341
# ╠═e8cea33b-2c06-493d-81f7-9bdf7f36983e
# ╠═f3b96106-f955-47e7-8000-c1c17fcdccc7
# ╠═43f55eab-4533-431d-8243-66f2fc08dcdc
# ╠═00bc0587-5b8f-4c09-bc19-def0e110c821
