using ..Core
using Random
using DataStructures

# maze Konstruktor, der ein zufälliges n x m Maze per Tiefensuche generiert
function maze(height::Int, width::Int)::Maze
    
    #Initialisiert Matrix mit unbesuchten Knoten die paarweise unzusammenhängend sind
    rmaze::Maze = Maze(height, width)
    
    #Wählt zufälligen Startknoten im Labyrinth
    i = rand(1:height)
    j = rand(1:width)

    #Erstellt einen Stack für die Tiefensuche und fügt den Startknoten mit seinen Koordinaten im Maze hinzu
    stack = Stack{Tuple{Node, Int, Int}}()
    push!(stack, (rmaze[i,j], i, j))


    #Führt randomisierte Tiefensuche aus also wird immer ein zufälliger unbesuchter Knoten in den Stack hinzugefügt
    while !isempty(stack)
        node, i, j = top(stack)
        node.key = (i, j) # Markiert Knoten als besucht


        # Überprüft für alle Richtungen ob Knoten ob es benachbarte Knoten gibt, bzw. ob in der Richtung ein Rand ist.
        # Dann werden alle Richtungen in einer Liste gespeichert, für die sich der Knoten, der sich in der Richtung befindet noch unbesucht ist
        adjacent_dirs = [x for x in [[-1, 0], [1, 0], [0, -1], [0, 1]] if 1 <= x[1] + i && x[1] + i <= height && 1 <= x[2] + j && x[2] + j <= width]
        unvisited_adjacent_dirs = [coord for coord in adjacent_dirs if rmaze[i + coord[1], j + coord[2]].key == (0, 0)]
        
        if isempty(unvisited_adjacent_dirs)
            pop!(stack)
            continue
        end

        # Wählt züfällige Richtung aus
        direction = rand(unvisited_adjacent_dirs)


        # Geht in die ausgewählte Richtung und findet den sich dort befindenden Knoten
        i, j = i+direction[1], j+direction[2]
        next_node = rmaze[i, j]
        
        # Verbindet Ursprungsknoten mit dem ausgewählten nächsten Knoten
        if direction == [0, -1]
            node.left = next_node
            next_node.right = node
        elseif direction == [0, 1]
            node.right = next_node
            next_node.left = node
        elseif direction == [-1, 0]
            node.up = next_node
            next_node.down = node
        elseif direction == [1, 0]
            node.down = next_node
            next_node.up = node
        end

        # Fügt neuen Knoten in den Stack ein
        push!(stack, (next_node, i, j))
    end

    # Wählt zufälligen Start- und Zielknoten
    rmaze.startNode = (rand(1:height), rand(1:width))
    rmaze.endNode = (rand(1:height), rand(1:width))

    
    return rmaze
end