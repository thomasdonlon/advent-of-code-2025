#part 1
#this is slow because we're checking so many unecessary numbers that we know won't work, but it runs quickly enough
#a "better" solution would iterate up on the first half of the number
content = read("./day2/input.txt", String)

total = 0
ranges = split(content, ",")
for r in ranges 
    global total
    bounds = [parse(Int, x) for x in split(r, "-")]
    for i in range(bounds[1], bounds[2])
        stri = string(i)
        if length(stri) % 2 == 0
            if stri[1:Int(length(stri)/2)] == stri[Int(length(stri)/2)+1:end]
                total += i
            end
        end
    end
end

println(total)

#part 2
#again very slow, but it's less clear how to speed this part up vs. the first part
total = 0
ranges = split(content, ",")
for r in ranges 
    global total
    bounds = [parse(Int, x) for x in split(r, "-")]
    for i in range(bounds[1], bounds[2])
        stri = string(i)
        for j in range(1, floor(Int, length(stri)/2))
            if length(stri) % j == 0
                rstr = "($(stri[1:j])){$(Int(length(stri)/j)),}"
                if occursin(Regex(rstr), stri)
                    total += i 
                    break #don't count invalid numbers multiple times
                end
            end
        end
    end
end

println(total)