#part 1
banks = readlines("./day3/input.txt")

#take the left-most biggest number (not including the last character in the string)
#and then take the biggest number to the right of that

total = 0
for bank in banks
    global total
    numbers = parse.(Int, collect(bank))
    left_max, left_max_indx = findmax(numbers[1:end-1])
    right_max = maximum(numbers[left_max_indx+1:end])
    total += left_max*10 + right_max
end

println(total)

#part 2

#need 12 digits,
#take the left-most biggest number (not including the last 11 characters in the string)
#repeat this (but not including the last 10, 9, ... digits) until we have 12 digits

total = 0
for bank in banks
    global total
    output = Int64[]
    numbers = parse.(Int, collect(bank))
    left_indx = 1
    for i in 1:12
        left_max, left_max_indx = findmax(numbers[left_indx:end - (12 - i)])
        push!(output, left_max)
        left_indx += left_max_indx
    end
    total += parse(Int64, join(output))
end

println(total)


