#part 1
input = readlines("./day4/input.txt")

rows = []
for line in input
    push!(rows, [if x == '.' 0 else 1 end for x in line])
end

total = 0

for i in 1:length(rows)
    global total
    for j in 1:length(rows[i])
        if rows[i][j] == 0
            continue
        end
        surrounding = 0
        if i > 1
            surrounding += sum(rows[i-1][max(j-1, 1):min(j+1, length(rows[i]))])
        end
        if i < length(rows)
            surrounding += sum(rows[i+1][max(j-1, 1):min(j+1, length(rows[i]))])
        end
        if j > 1
            surrounding += rows[i][j-1] #already checked the corners
        end
        if j < length(rows[i])
            surrounding += rows[i][j+1]
        end
        if surrounding < 4
            total += 1
        end
    end
end

println(total)

#part 2

total = 0
replaced = 1

next_rows = deepcopy(rows)

while replaced > 0
    global total
    global replaced
    global rows

    replaced = 0
    rows = deepcopy(next_rows)

    for i in 1:length(rows)
        for j in 1:length(rows[i])
            if rows[i][j] == 0
                continue
            end
            surrounding = 0
            if i > 1
                surrounding += sum(rows[i-1][max(j-1, 1):min(j+1, length(rows[i]))])
            end
            if i < length(rows)
                surrounding += sum(rows[i+1][max(j-1, 1):min(j+1, length(rows[i]))])
            end
            if j > 1
                surrounding += rows[i][j-1] #already checked the corners
            end
            if j < length(rows[i])
                surrounding += rows[i][j+1]
            end
            if surrounding < 4
                total += 1
                next_rows[i][j] = 0
                replaced += 1
            end
        end
    end
end

println(total)

