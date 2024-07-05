using ..Core

# Generiert eine Visualisierung in Form des MazeViz structs und ersetzt Feld visual des Eingabe-Mazes
function visualize(maze::Maze)::MazeViz
    height = size(maze)[1]
    width = size(maze)[2]
    viz = MazeViz(ones(Int, 2height + 1, 2width + 1)) # initialisiert Leeres MazeViz Struct (Matrix) der Größe (2n + 1) x (2m + 1), wobei alle Einträge
                                                                     # eine 1 sind, also eine Wand darstellen


    # Fügt der Reihenfolge nach jeden Knoten ein (indem die 1en mit 0en ersetzt)
    # und ersetzt jeweils die benachbarten Felder mit 0en Falls auf der Seite ein begehbarer Knoten ist 
    # (nur von rechts und unten um Dopplung in den Iterationen zu vermeiden)

    for i in 1:height
        row = 2i
        for j in 1:width
            column = 2j
            viz[row, column] = 0

            viz[(row + 1), column] = Int(isnothing(maze[i, j].down))
            viz[row, (column + 1)] = Int(isnothing(maze[i, j].right))
        end
    end

    # Falls das Maze einen Pfad hat wird jeder Knoten außer der Endknoten mit einer 2 markiert und die nächste verbindende Wand ebenfalls entfernt (mit einer 0 entfernt)
    if !isnothing(maze.path)
        for i in 1:(length(maze.path)-1)
            current_node = maze.path[i]
            next = maze.path[i + 1]

            viz[(2 .* current_node.key)...] = 2
            viz[((2 .* current_node.key) .+ (next.key .- current_node.key))...] = 2
        end
    end

    # Die Start und Endknoten bekommen eine besondere Darstellung
    viz[(2 .* maze.startNode)...] = 3
    viz[(2 .* maze.endNode)...] = 4

    
    maze.visual = viz
    return viz
end
