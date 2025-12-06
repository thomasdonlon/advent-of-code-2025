#part 1
content = readlines("./day6/input.txt")

nums = []
for line in content[1:end-1]
    push!(nums, collect(parse.(Int, split(line))))
end
operators = collect(split(content[end]))

#transpose nums
nums = [[nums[i][j] for i in eachindex(nums)] for j in eachindex(nums[1])]

total = 0
for i in eachindex(operators)
    global total
    if operators[i] == "+"
        total += sum(nums[i])
    elseif operators[i] == "*"
        total += prod(nums[i])
    end
end

println(total)

#part 2
content = readlines("./day6/input.txt")

nums = []
nums_i = []
operators = []
for i in eachindex(content[1])
    global nums_i
    column = prod(string.([content[j][i] for j in 1:length(content) - 1]))
    column = replace(column, " " => "")
    if column == ""
        push!(nums, nums_i)
        nums_i = []
    else
        num = parse.(Int, column)
        push!(nums_i, num)
    end
    if content[end][i] != ' '
        push!(operators, content[end][i])
    end
    if i == length(content[1]) #have to catch the last one
        push!(nums, nums_i)
    end
end

total = 0
for i in eachindex(operators)
    global total
    if operators[i] == '+'
        total += sum(nums[i])
    elseif operators[i] == '*'
        total += prod(nums[i])
    end
end

println(total)
    

