#part 1
lines = readlines("./day1/input.txt")

password = 0
dial = 50
for line in lines
    global password
    global dial
    if line[1] == 'R'
        dial += parse(Int, line[2:end])
    else
        dial -= parse(Int, line[2:end])
    end

    dial = dial % 100

    if dial == 0
        password += 1
    end
end

println(password)

#part 2
password = 0
dial = 50
for line in lines
    global password
    global dial
    amount = parse(Int, line[2:end])

    password += Int(floor(abs(amount/100)))
    amount = amount % 100
    
    if line[1] == 'R'
        dial += amount
    else
        dial -= amount
    end

    #this ended up being messier than I'd like but there are some annoying edge cases.
    #there's probably a more streamlined way to do this but I didn't notice it.
    if dial >= 100
        password += 1
        dial -= 100
    #accounting for the case where the dial starts on 0 and then is moved left
    elseif (dial < 0) && (abs(dial) != amount)
        dial += 100
        password += 1
    elseif dial < 0
        dial += 100
    elseif dial == 0
        password += 1
    end
end

println(password)