using ..Core
using Random

function solve(maze::Maze)::Vector{Node}


    directions = ["left", "up", "right", "down"]
    left_to_right = Dict(
        "left" => 1,
        "up" => 2,
        "right" => 3,
        "down" => 4,
    )


    function getNode(node::Node, direction::String)
        @assert direction in directions
        if direction == "up"
            return node.up
        elseif direction == "right"
            return node.right
        elseif direction == "down"
            return node.down
        elseif direction == "left"
            return node.left
        end
    end

    hasWall(node::Node, direction::String) = isnothing(getNode(node, direction))
    turnRight(direction::String) = directions[(left_to_right[direction] % 4) + 1]
    
    function turnLeft(direction::String)::String 
        if direction == "left"
            return "down"
        else
            return directions[(left_to_right[direction] - 1)]
        end
    end


    path = Vector{Node}()
    current = maze[maze.startNode...]
    endNode = maze[maze.endNode...]
    facing_dir = rand(directions)

    i = 10
    while current != endNode# && i < 100
        i = i + 1
        if !(current in path)
            push!(path, current)
        end

        facing_dir = turnRight(facing_dir)
        
        while hasWall(current, facing_dir)
            facing_dir = turnLeft(facing_dir)
        end

        if getNode(current, facing_dir) in path
            pop!(path)
        end

        current = getNode(current, facing_dir)
    end
    push!(path, current)

    maze.path = path
    return path
end

# function solve(maze::Maze)::Vector{Node}
#     # Direction vectors
#     directions = Dict(
#         "up" => (-1, 0),
#         "right" => (0, 1),
#         "down" => (1, 0),
#         "left" => (0, -1)
#     )
    
#     # Turn right mapping
#     turn_right = Dict(
#         "up" => "right",
#         "right" => "down",
#         "down" => "left",
#         "left" => "up"
#     )

#     # Turn left mapping
#     turn_left = Dict(
#         "up" => "left",
#         "left" => "down",
#         "down" => "right",
#         "right" => "up"
#     )
    
#     function move(node::Node, direction::String)
#         d = directions[direction]
#         return maze[node.key[1] + d[1], node.key[2] + d[2]]
#     end
    
#     function has_wall(node::Node, direction::String)
#         neighbor = move(node, direction)
#         return isnothing(neighbor)
#     end

#     # Initialize
#     path = Vector{Node}()
#     current_node = maze[maze.startNode...]
#     end_node = maze[maze.endNode...]
#     current_direction = "up"

#     while current_node != end_node
#         right_direction = turn_right[current_direction]

#         if !has_wall(current_node, right_direction)
#             current_direction = right_direction
#             current_node = move(current_node, current_direction)
#         elseif !has_wall(current_node, current_direction)
#             current_node = move(current_node, current_direction)
#         else
#             current_direction = turn_left[current_direction]
#         end
        
#         push!(path, current_node)
#     end

#     Maze(maze).path = path
#     return path
# end