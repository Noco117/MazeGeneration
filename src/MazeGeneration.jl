module MazeGeneration

export maze, visualize, solve

include("core.jl")
using .Core

include("randomizedMaze.jl")
include("visualization.jl")
include("solver.jl")

end # module MazeGeneration