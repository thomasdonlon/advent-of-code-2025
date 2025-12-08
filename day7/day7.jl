#part 1

lines = collect([collect(line) for line in readlines("day7/input.txt")])

#construct the tachyon beam
for (i, line) in enumerate(lines)
    out_line = collect("."^length(line))
    for (j, char) in enumerate(line)
        if char == 'S'
            out_line[j] = '|'
        elseif i > 1
            if lines[i-1][j] == '|'
                if char == '^'
                    if j > 1
                        out_line[j-1] = '|'
                    end
                    if j < length(line)
                        out_line[j+1] = '|'
                    end
                    out_line[j] = '^'
                else
                    out_line[j] = '|'
                end
            end
        end
    end
    lines[i] = out_line
end

#count number of times '|' appears directly above a '^'
num_splits = 0
for i in eachindex(lines[2:end])
    global num_splits
    for j in 1:length(lines[i])
        if lines[i][j] == '^' && lines[i-1][j] == '|'
            num_splits += 1
        end
    end
end

println(num_splits)

#can show the final tachyon beam if desired
# for line in lines
#     println(String(line))
# end

#part 2

lines = collect(Any, [collect(line) for line in readlines("day7/input.txt")])

#turn all the '.' into zeros (the Int, not the char)
#can't use a char because the number could get larger than 9
for (i, line) in enumerate(lines)
    for (j, char) in enumerate(line)
        if char == '.'
            lines[i][j] = 0
        end
    end
end

#construct the tachyon beam
for (i, line) in enumerate(lines)
    out_line = collect(Any, zeros(Int, length(line)))
    for (j, char) in enumerate(line)
        if char == 'S'
            out_line[j] = 1
        elseif i > 1
            if typeof(lines[i-1][j]) == Int
                if char == '^'
                    if j > 1
                        out_line[j-1] += lines[i-1][j]
                    end
                    if j < length(line)
                        out_line[j+1] += lines[i-1][j]
                    end
                    out_line[j] = '^'
                else
                    out_line[j] += lines[i-1][j]
                end
            end
        end
    end
    lines[i] = out_line
end

#can show the final tachyon beam if desired
# for line in lines
#     println(line)
# end

#sum the numbers in the bottom row
total = 0
for char in lines[end]
    global total
    if typeof(char) == Int
        total += char
    end
end

println(total)