### A Pluto.jl notebook ###
# v0.17.1

using Markdown
using InteractiveUtils

# ╔═╡ 4a0d6b82-6901-11ec-2833-79c110100ff5
begin
	s = open("p7.txt") do file
		readlines(file)
	end
	s = parse.(Int32,split(s[1],","))
end

# ╔═╡ 72183b26-db2c-4b2a-a477-590be188c3ca
begin
	dist_dic = Dict()
	for i in minimum(s):maximum(s)
		dist_dic[i] = sum([abs(num-i) for num in s])
	end
	dist_dic
end

# ╔═╡ f072111e-7acf-4f49-a143-014af3ad4928
findmin(dist_dic), argmin(dist_dic)

# ╔═╡ f426e9b0-88ec-4bae-9c5d-0ab873a06a87
begin
	dist_dic2 = Dict()
	for i in minimum(s):maximum(s)
		dist_dic2[i] = sum([(abs(num-i)+1)*((abs(num-i))/2) for num in s])
	end
	dist_dic2
end

# ╔═╡ 0e7295c3-a51c-4982-ac70-a03920f7eb46
findmin(dist_dic2)

# ╔═╡ 84e083d9-e552-4e39-af42-a1977f59b07c
Int.(findmin(dist_dic2))

# ╔═╡ Cell order:
# ╠═4a0d6b82-6901-11ec-2833-79c110100ff5
# ╠═72183b26-db2c-4b2a-a477-590be188c3ca
# ╠═f072111e-7acf-4f49-a143-014af3ad4928
# ╠═f426e9b0-88ec-4bae-9c5d-0ab873a06a87
# ╠═0e7295c3-a51c-4982-ac70-a03920f7eb46
# ╠═84e083d9-e552-4e39-af42-a1977f59b07c
