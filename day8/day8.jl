#part 1

content = collect(([parse.(Int, split(x, ",")) for x in readlines("day8/input.txt")]))
lim = 1000 #should be 10 for example, 1000 for real input

#for each point, compute the distance to each other point 
#keep all non-duplicate distances in edge_array
edge_array = []
for i in eachindex(content)
    point = content[i]
    distances = []
    for j in eachindex(content)
        if i > j
            other_point = content[j]
            dist = sqrt((point[1] - other_point[1])^2 + (point[2] - other_point[2])^2 + (point[3] - other_point[3])^2)
            push!(distances, (i, j, dist))
        end
    end
    sort!(distances, by=x->x[3])

    append!(edge_array, distances)
end

sort!(edge_array, by=x->x[3])

function check_in_circuit(point_index, circuits)
    for i in eachindex(circuits)
        if point_index in circuits[i]
            return i
        end
    end
    return 0
end

circuits = []
for i in eachindex(edge_array[1:min(end, lim)]) #only check first <lim> if large input
    #check if one or both points are already in a circuit
    point1_in_circuit = check_in_circuit(edge_array[i][1], circuits) #returns the index of the circuit or 0 if not found
    point2_in_circuit = check_in_circuit(edge_array[i][2], circuits)
    if point1_in_circuit == 0 && point2_in_circuit == 0 #neither found, push both to new circuit
        push!(circuits, [edge_array[i][1], edge_array[i][2]])
    elseif point1_in_circuit > 0 && point2_in_circuit == 0 #found first point
        push!(circuits[point1_in_circuit], edge_array[i][2])
    elseif point1_in_circuit == 0 && point2_in_circuit > 0 #found second point
        push!(circuits[point2_in_circuit], edge_array[i][1])
    elseif point1_in_circuit == point2_in_circuit #found both points in same circuit, do nothing
        continue
    else #found both points in different circuits, merge circuits
        append!(circuits[point1_in_circuit], circuits[point2_in_circuit])
        deleteat!(circuits, point2_in_circuit)
    end
end

sort!(circuits, by=x->length(x), rev=true)
out = prod(collect(length.(circuits))[1:3])
println(out)

#part 2

circuits = []
i = 1
last_two = [0, 0]
while length(circuits) == 0 || length(circuits[1]) < length(content)
    global i
    global last_two
    #check if one or both points are already in a circuit
    point1_in_circuit = check_in_circuit(edge_array[i][1], circuits) #returns the index of the circuit or 0 if not found
    point2_in_circuit = check_in_circuit(edge_array[i][2], circuits)
    if point1_in_circuit == 0 && point2_in_circuit == 0 #neither found, push both to new circuit
        push!(circuits, [edge_array[i][1], edge_array[i][2]])
    elseif point1_in_circuit > 0 && point2_in_circuit == 0 #found first point
        push!(circuits[point1_in_circuit], edge_array[i][2])
        last_two = [edge_array[i][1], edge_array[i][2]]
    elseif point1_in_circuit == 0 && point2_in_circuit > 0 #found second point
        push!(circuits[point2_in_circuit], edge_array[i][1])
        last_two = [edge_array[i][1], edge_array[i][2]]
    elseif point1_in_circuit == point2_in_circuit #found both points in same circuit, do nothing
    else #found both points in different circuits, merge circuits
        append!(circuits[point1_in_circuit], circuits[point2_in_circuit])
        deleteat!(circuits, point2_in_circuit)
        last_two = [edge_array[i][1], edge_array[i][2]]
    end
    i += 1
end

out = content[last_two[1]][1] * content[last_two[2]][1]
println(out)