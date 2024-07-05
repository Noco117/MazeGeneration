module Core

export Node, Maze, MazeViz, neighbors

# Node struct mit Nachbarknoten als Feld und Position im Labyrinth als Schlüssel
mutable struct Node
    key::Tuple{Int, Int}

    up::Union{Node, Nothing}
    down::Union{Node, Nothing}
    left::Union{Node, Nothing}
    right::Union{Node, Nothing}
end

# Überladene show Funktion printet key vom Knoten
Base.show(io::IO, node::Node) = println(io, node.key)

# Neighbors Funktion gibt einen Array der benachbarten Knoten zurück
function neighbors(node::Node)::Vector{Node}
    temp::Vector{Node} = []
    for neighbor in [node.up, node.down, node.left, node.right]
        if !isnothing(neighbor)
            push!(temp, neighbor)
        end
    end
    return temp
end

# MazeViz als WrapperStruct für 2d Matrix aus Int (wobei 0 begehbare Orte, 1 Wände, 2 der Pfad, 3 der Startknoten und 4 der Zielknoten ist)
mutable struct MazeViz <:  AbstractMatrix{Int}
    data::Array{Int, 2}
end

# MazeViz inherited die Standard Funktionen der Zugrundeliegenden Matrix
Base.size(viz::MazeViz) = size(viz.data)
Base.getindex(viz::MazeViz, i::Int, j::Int) = viz.data[i, j]
Base.setindex!(viz::MazeViz, v::Int, i::Int, j::Int) = (viz.data[i, j] = v)

# MazeViz hat abweichende show Funktion die einfach die Matrix als 2-dimensionales Feld von Chars printet wobei
# jede Zahl von 1-4 einem Char entspricht
function Base.show(io::IO, viz::MazeViz)
    for i in 1:size(viz)[1]
        for j in 1:size(viz)[2]
            if viz[i, j] == 0
                print("  ")
            elseif viz[i, j] == 1
                print("██")
            elseif viz[i, j] == 2
                printstyled("██"; color = :red)
            elseif viz[i, j] == 3
                print("● ")
            elseif viz[i, j] == 4
                print("* ")
            end
        end
        print("\n")
    end
end

# weiterer Overload damit die diplay() Funktion (im REPL) auch 
# die custom show() Funktion anwendet
Base.show(io::IO, ::MIME"text/plain", viz::MazeViz) = show(io, viz)


# Maze Struct, das Knoten als Matrix, eine Visualisierung, Start-, Endknoten und den Lösungsweg speicherrt
#
mutable struct Maze
    nodes::Matrix{Node}
    visual::Union{MazeViz, Nothing}
    path::Union{Vector{Node}, Nothing}

    startNode::Union{Tuple{Int, Int}, Nothing}
    endNode::Union{Tuple{Int, Int}, Nothing}

    # innerer Konstruktor der ein pre-initialisiertes Maze mit unverbundenen Knoten und Null-key generiert
    Maze(height::Int, width::Int) = new([Node((0, 0), nothing, nothing, nothing, nothing) for i in 1:height, j in 1:width], nothing, nothing, nothing, nothing)
end

# Maze inherited wieder die Standard Indexfunktionen von der Zugrundeliegenden 2d Matrix
Base.getindex(maze::Maze, I...) = getindex(maze.nodes, I...)
Base.setindex!(maze::Maze, v, I...) = setindex!(maze.nodes, v, I...)
Base.size(maze::Maze) = size(maze.nodes)

# Die show() Funktion wird mit der von der Visualisierung gleichgesetzt.
Base.show(io::IO, maze::Maze) = show(io, maze.visual)

end # Module Core