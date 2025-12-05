#rewriting this with a new trick to not be slow
#NOT COMPLETE, IGNORE FOR NOW

#part 1
content = read("./day2/example.txt", String)

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
#THSI IS BROKEN AT THE MOMENT

function sum_invalid_between_range_all_mod(low, high)
    if length(low) != length(high) 
        return sum_invalid_between_range_all_mod(low, "9"^length(low)) + #recursion baby, just like mama used to make
               sum_invalid_between_range_all_mod("1" * "0"^(length(high)-1), high)
    end

    total = 0
    for mod in 2:floor(Int, length(low)/2)
        
        if length(low) % mod != 0
            return 0
        end

        start_val = parse(Int, low[1:floor(Int, length(low)/mod)])
        end_val = parse(Int, high[1:floor(Int, length(high)/mod)])
        comp_val_low = parse(Int, low[end-floor(Int, length(low)/mod)+1:end])
        comp_val_high = parse(Int, high[end-floor(Int, length(high)/mod)+1:end])

        println("mod: $mod, start_val: $start_val, end_val: $end_val, comp_val_low: $comp_val_low, comp_val_high: $comp_val_high")

        for i in range(start_val, end_val)
            check_val = parse(Int, repeat(string(i), mod-1))
            println("i: $i, check_val: $check_val")
            if (start_val == end_val) || (check_val < comp_val_low || check_val > comp_val_high)
                continue
            elseif (i == start_val && check_val >= comp_val_low) || (i == end_val && check_val <= comp_val_high) || (i > start_val && i < end_val)
                total += parse(Int, string(i)*string(check_val))
                println("added: $(parse(Int, string(i)*string(check_val)))")
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

