using ..Core


function solve(maze::Maze)::Vector{Node}
    # Direction vectors
    directions = Dict(
        "up" => (-1, 0),
        "right" => (0, 1),
        "down" => (1, 0),
        "left" => (0, -1)
    )
    
    # Turn right mapping
    turn_right = Dict(
        "up" => "right",
        "right" => "down",
        "down" => "left",
        "left" => "up"
    )

    # Turn left mapping
    turn_left = Dict(
        "up" => "left",
        "left" => "down",
        "down" => "right",
        "right" => "up"
    )
    
    function move(node::Node, direction::String)
        d = directions[direction]
        return maze[node.key[1] + d[1], node.key[2] + d[2]]
    end
    
    function has_wall(node::Node, direction::String)
        neighbor = move(node, direction)
        return isnothing(neighbor)
    end

    # Initialize
    path = Vector{Node}()
    current_node = maze[maze.startNode...]
    end_node = maze[maze.endNode...]
    current_direction = "up"

    while current_node != end_node
        right_direction = turn_right[current_direction]

        if !has_wall(current_node, right_direction)
            current_direction = right_direction
            current_node = move(current_node, current_direction)
        elseif !has_wall(current_node, current_direction)
            current_node = move(current_node, current_direction)
        else
            current_direction = turn_left[current_direction]
        end
        
        push!(path, current_node)
    end

    Maze(maze).path = path
    return path
end