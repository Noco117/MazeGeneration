using .Core, Random
using DataStructures

# maze Konstruktor, der ein zufälliges n x m Maze per Tiefensuche generiert
function maze(height::Int, width::Int)::Maze
    
    #Initialisiert Matrix mit unbesuchten Knoten die paarweise unzusammenhängend sind
    nodes::Matrix{Node} = [Node(0, nothing, nothing, nothing, nothing) for i in 1:height, j in 1:width]
    
    #Wählt zufälligen Startknoten im Labyrinth
    i = rand(1:height)
    j = rand(1:width)

    #Erstellt einen Stack für die Tiefensuche und fügt den Startknoten hinzu
    stack = Stack{Node}()
    push!(stack, nodes[i,j])

    #Führt randomisierte Tiefensuche aus also wird immer ein zufälliger unbesuchter Knoten in den Stack hinzugefügt
    while !isempty(stack)
        node = top(stack)
        node.key = 1 # Markiert Knoten als besucht
        
        adjacent_dirs = [x for x in [[-1, 0], [1, 0], [0, -1], [0, 1]] if 1 <= x[1] + i && x[1] + i <= height && 1 <= x[2] + j && x[2] + j <= width]
        unvisited_adjacent_dirs = [coord for coord in adjacent_dirs if nodes[i + coord[1], j + coord[2]].key == 0]
        
        if isempty(unvisited_adjacent_dirs)
            pop!(stack)
            continue
        end

        direction = rand(unvisited_adjacent_dirs)
        
        k, l = i+direction[1], j+direction[2]
        next_node = nodes[i, j]
        
        if direction == [0, -1]
            node.left = next_node
            next_node.right = node
        elseif direction == [0, 1]
            node.right = next_node
            next_node.left = node
        elseif direction == [-1, 0]
            node.up = next_node
            next_node.down = node
        else
            node.down = next_node
            next_node.up = node
        end

        push!(stack, next_node)
        i, j = k, l
    end

    return Maze(nodes, nothing)
end