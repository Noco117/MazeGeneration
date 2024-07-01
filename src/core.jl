module Core

export Node, Maze, MazeViz, neighbors


mutable struct Node
    key::Tuple{Int, Int}

    up::Union{Node, Nothing}
    down::Union{Node, Nothing}
    left::Union{Node, Nothing}
    right::Union{Node, Nothing}
end


function neighbors(node::Node)::Vector{Node}
    temp::Vector{Node} = []
    for neighbor in [node.up, node.down, node.left, node.right]
        if !isnothing(neighbor)
            push!(temp, neighbor)
        end
    end
    return temp
end


mutable struct MazeViz <:  AbstractMatrix{Int}
    data::Array{Int, 2}
end

Base.size(viz::MazeViz) = size(viz.data)

Base.getindex(viz::MazeViz, i::Int, j::Int) = viz.data[i, j]

Base.setindex!(viz::MazeViz, v::Int, i::Int, j::Int) = (viz.data[i, j] = v)



mutable struct Maze
    nodes::Matrix{Node}
    visual::Union{MazeViz, Nothing}
    path::Union{Vector{Node}, Nothing}

    startNode::Union{Tuple{Int, Int}, Nothing}
    endNode::Union{Tuple{Int, Int}, Nothing}

    Maze(height::Int, width::Int) = new([Node((0, 0), nothing, nothing, nothing, nothing) for i in 1:height, j in 1:width], nothing, nothing, nothing, nothing)
end


Base.getindex(maze::Maze, I...) = getindex(maze.nodes, I...)
Base.setindex!(maze::Maze, v, I...) = setindex!(maze.nodes, v, I...)
Base.size(maze::Maze) = size(maze.nodes)


end # Module Core