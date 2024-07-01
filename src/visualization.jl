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
    viz[2maze.startNode[1], 2maze.startNode[2]] = 3
    viz[2maze.endNode[1], 2maze.endNode[2]] = 4

    maze.visual = viz
    return viz
end

function Base.show(io::IO, viz::MazeViz)
    for i in 1:size(viz)[1]
        for j in 1:size(viz)[2]
            if viz[i, j] == 0
                print("  ")
            elseif viz[i, j] == 1
                print("██")
            elseif viz[i, j] == 2
                print("··")
            elseif viz[i, j] == 3
                print("● ")
            elseif viz[i, j] == 4
                print("* ")
            end
        end
        print("\n")
    end
end