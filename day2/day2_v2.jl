#rewriting this with a new trick to not be slow
#it looks way grosser now but boy is it speedy

#part 1
content = read("./day2/input.txt", String)

function sum_invalid_between_range(low, high)
    if length(low) != length(high) 
        return sum_invalid_between_range(low, "9"^length(low)) + #recursion baby, just like mama used to make
               sum_invalid_between_range("1" * "0"^(length(high)-1), high)
    end

    if length(low) % 2 != 0
        return 0
    end

    start_val = parse(Int, low[1:floor(Int, length(low)/2)])
    end_val = parse(Int, high[1:floor(Int, length(high)/2)])
    comp_val_low = parse(Int, low[end-floor(Int, length(low)/2)+1:end])
    comp_val_high = parse(Int, high[end-floor(Int, length(high)/2)+1:end])

    total = 0
    for i in range(start_val, end_val)
        if (start_val == end_val) && (i < comp_val_low || i > comp_val_high)
            continue
        end
        if (i == start_val && i >= comp_val_low) || (i == end_val && i <= comp_val_high) || (i > start_val && i < end_val)
            total += i * (10^(length(string(i))) + 1)
        end
    end
    return total
end

total = 0
ranges = split(content, ",")
for r in ranges 
    global total
    bounds = collect(split(r, "-"))

    total += sum_invalid_between_range(bounds[1], bounds[2])
end

println(total)

#part 2

function sum_invalid_between_range_all_mod(low, high)
    if length(low) != length(high) 
        return sum_invalid_between_range_all_mod(low, "9"^length(low)) + #recursion baby, just like mama used to make
               sum_invalid_between_range_all_mod("1" * "0"^(length(high)-1), high)
    end

    total = 0
    found_numbers = [] #have to check for collisions across different mods, ex. 222222 is 22 repeated thrice and 222 repeated twice
    for mod in 2:floor(Int, length(low))
        
        if length(low) % mod != 0
            continue
        end

        start_val = parse(Int, low[1:floor(Int, length(low)/mod)])
        end_val = parse(Int, high[1:floor(Int, length(high)/mod)])
        comp_val_low = parse(Int, low[floor(Int, length(low)/mod)+1:end])
        comp_val_high = parse(Int, high[floor(Int, length(high)/mod)+1:end])

        for i in range(start_val, end_val)
            check_val = parse(Int, repeat(string(i), mod-1))
            if (start_val == end_val) && (check_val < comp_val_low || check_val > comp_val_high)
                continue
            elseif (i == start_val && check_val >= comp_val_low) || (i == end_val && check_val <= comp_val_high) || (i > start_val && i < end_val)
                num = parse(Int, string(i)*string(check_val))
                if num in found_numbers
                    continue
                end
                push!(found_numbers, num)
                total += num
            end
        end
    end
    return total
end

total = 0
ranges = split(content, ",")
for r in ranges 
    global total
    bounds = collect(split(r, "-"))

    total += sum_invalid_between_range_all_mod(bounds[1], bounds[2])
end

println(total)

