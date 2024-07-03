using ..Core

function visualize(maze::Maze)::MazeViz
    height = size(maze)[1]
    width = size(maze)[2]
    viz = MazeViz([1 for i in 1:(2height + 1), j in 1:(2width + 1)])

    for i in 1:height
        row = 2i
        for j in 1:width
            column = 2j
            viz[row, column] = 0

            viz[(row + 1), column] = Int(isnothing(maze[i, j].down))
            viz[row, (column + 1)] = Int(isnothing(maze[i, j].right))
        end
    end

    if !isnothing(maze.path)
        for i in 1:(length(maze.path)-1)
            current_node = maze.path[i]
            next = maze.path[i + 1]

            viz[(2 .* current_node.key)...] = 2
            viz[((2 .* current_node.key) .+ (next.key .- current_node.key))...] = 2
        end
    end
    viz[(2 .* maze.startNode)...] = 3
    viz[(2 .* maze.endNode)...] = 4

    maze.visual = viz
    return viz
end