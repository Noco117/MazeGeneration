# Importieren des Moduls
include("src/MazeGeneration.jl")
using .MazeGeneration

Maze1 = maze(10, 10)
Maze2 = maze(20, 20)
Maze3 = maze(10, 20)

visualize(Maze1)
visualize(Maze2)
visualize(Maze3)

print(Maze1)