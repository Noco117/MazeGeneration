module Core

export Node, Maze, neighbors

mutable struct Node
    key::Int

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

mutable struct Maze
    nodes::Matrix{Node}
    # visual::Union
    path::Union{Vector{Node}, Nothing}
end

function Base.getindex(maze::Maze, I...)
    return getindex(Maze.nodes, I...)
end

function Base.setindex!(maze::Maze, v, I...)
    setindex!(Maze.nodes, v, I...)
end

end