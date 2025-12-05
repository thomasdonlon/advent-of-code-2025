#parsing the data file
content = readlines("./day5/input.txt")

ranges = []
ids = []

in_ids = false
for line in content
    global in_ids
    if line == ""
        in_ids = true
        continue
    end
    if in_ids
        push!(ids, parse(Int, line))
        continue
    end
    push!(ranges, collect(parse.(Int, split(line, "-"))))
end

#part 1
num_good_ids = 0
for id in ids
    global num_good_ids
    for range in ranges 
        if id >= range[1] && id <= range[2]
            num_good_ids += 1
            break
        end
    end
end

println(num_good_ids)

#part 2
#a little messy (can probably combine the found_overlap and found_update logic) but it works

simplified_ranges = []
found_update = true
while found_update
    global found_update
    global simplified_ranges
    global ranges
    found_update = false
    simplified_ranges = []
    for range in ranges
        found_overlap = false
        for (i, srange) in enumerate(simplified_ranges)
            if !(found_overlap)
                if range[1] >= srange[1] && range[2] <= srange[2] #entirely inside existing range, no need to update
                    found_overlap = true
                    found_update = true
                    break
                elseif range[1] <= srange[1] && range[2] >= srange[2] #entirely encompasses existing range, replace
                    simplified_ranges[i] = range
                    found_overlap = true
                    found_update = true
                    break
                elseif (range[1] <= srange[1] && range[2] >= srange[1]) || (range[1] <= srange[2] && range[2] >= srange[2]) #overlaps one side
                    simplified_ranges[i] = [min(range[1], srange[1]), max(range[2], srange[2])]
                    found_overlap = true
                    found_update = true
                    break
                end
            end
        end
        if !(found_overlap)
            push!(simplified_ranges, range)
        end
    end
    ranges = deepcopy(simplified_ranges)
end

total = 0
for range in simplified_ranges
    global total
    total += range[2] - range[1] + 1
end

println(total)