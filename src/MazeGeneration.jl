module MazeGeneration
include("core.jl")
include("randomizedMaze.jl")

# nodes = [Node(0, nothing, nothing, nothing, nothing) Node(0, nothing, nothing, nothing, nothing)
#          Node(0, nothing, nothing, nothing, nothing) Node(0, nothing, nothing, nothing, nothing)]

# nodes[1, 1].right = nodes[1, 2]
# nodes[1, 2].left = nodes[1, 1]
# nodes[1, 2].down = nodes[2, 2]
# nodes[2, 2].up = nodes[1, 2]
# nodes[2, 2].left = nodes[2, 1]
# nodes[2, 1].right = nodes[2, 2]

# function Base.show(io::IO, node::Node) 
#     println(io, [!isnothing(node.left), !isnothing(node.right), !isnothing(node.up), !isnothing(node.down)])
# end

# alt = maze(3, 3)
# print(alt.nodes)

end # module MazeGeneration

