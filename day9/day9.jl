#part 1

tiles = collect([parse.(Int, split(x, ",")) for x in readlines("day9/input.txt")])

largest_rectangle = 0
for i in eachindex(tiles)
    global largest_rectangle
    for j in eachindex(tiles)
        if i > j
            x1, y1 = tiles[i][1], tiles[i][2]
            x2, y2 = tiles[j][1], tiles[j][2]
            width = abs(x2 - x1) + 1
            height = abs(y2 - y1) + 1
            area = width * height
            if area > largest_rectangle
                largest_rectangle = area
            end
        end
    end
end

println(largest_rectangle)

#part 2

# I HATE POLYGONS I HATE POLYGONS I HATE POLYGONS

#track the two non-trivial corners of the rectangle too
#the two corners that are given are automatically in the polygon spanned by all tiles, 
#we only need to check that the other pair are both inside the polygon
rectangles = []
for i in eachindex(tiles)
    for j in eachindex(tiles)
        if i > j
            x1, y1 = tiles[i][1], tiles[i][2]
            x2, y2 = tiles[j][1], tiles[j][2]
            width = abs(x2 - x1) + 1
            height = abs(y2 - y1) + 1
            area = width * height
            push!(rectangles, (area, (x1, y2), (x2, y1)))
        end
    end
end

sort!(rectangles, by=x->x[1], rev=true)

#compute a list of all vertical and horizontal lines (pairs of points) for easy lookup

edges = [(tiles[i], tiles[i==length(tiles) ? 1 : i+1]) for i in eachindex(tiles)]
vertical_lines = filter(x -> x[1][1] == x[2][1], edges)
horizontal_lines = filter(x -> x[1][2] == x[2][2], edges)

#a point is inside the polygon if a ray to the right intersects the polygon an odd number of times
#or if it lies exactly on a vertical edge
function point_in_polygon(px, py)
    intersections = 0
    for line in vertical_lines
        (x, y1), (x, y2) = line
        if px == x && py >= min(y1, y2) && py <= max(y1, y2)
            return true
        elseif px < x && py >= min(y1, y2) && py < max(y1, y2)
            intersections += 1
        end
    end
    for line in horizontal_lines
        (x1, y), (x2, y) = line
        if py == y && px >= min(x1, x2) && px <= max(x1, x2)
            return true
        end
    end
    return isodd(intersections)
end

#check the non-trivial corners
#then check the collisions between the edges of the rectangle and the polygon edges
#remove any consecutive collision points
#then if there are no collisions left, we have found our rectangle
for rect in rectangles
    area, corner1, corner2 = rect
    #println(area)
    x1, y1 = corner1
    x2, y2 = corner2

    left_x = min(corner1[1], corner2[1])
    right_x = max(corner1[1], corner2[1])
    bottom_y = min(corner1[2], corner2[2])
    top_y = max(corner1[2], corner2[2])

    #check the non-trivial corners
    if point_in_polygon(corner1[1], corner1[2]) && point_in_polygon(corner2[1], corner2[2])
        interior_tiles = false
        for tile in tiles
            tx, ty = tile[1], tile[2]
            if tx > left_x && tx < right_x && ty > bottom_y && ty < top_y
                interior_tiles = true
                break
            end
        end

        if !interior_tiles
            left_x = min(x1, x2)
            right_x = max(x1, x2)
            top_y = max(y1, y2)
            bottom_y = min(y1, y2)

            collision = false
            for line in vertical_lines
                (x, y1), (x, y2) = line 
                line_top = max(y1, y2)
                line_bottom = min(y1, y2)
                if x > left_x && x < right_x
                    #top edge
                    if (line_bottom < top_y && line_top > top_y)
                        collision = true
                        break
                    end
                    #bottom edge
                    if (line_bottom < bottom_y && line_top > bottom_y)
                        collision = true
                        break
                    end
                end
            end
            if !collision 
                for line in horizontal_lines
                    (x1, y), (x2, y) = line 
                    line_left = min(x1, x2)
                    line_right = max(x1, x2)
                    if y > bottom_y && y < top_y
                        #left edge
                        if (line_left < left_x && line_right > left_x)
                            collision = true
                            break
                        end
                        #right edge
                        if (line_left < right_x && line_right > right_x)
                            collision = true
                            break
                        end
                    end
                end
            end

            if !collision
                println(area)
                break
            end
        end
    end
end
