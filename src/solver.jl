using ..Core
using Random

# Gibt einen weg aus, und ersetzt damit das path Feld des Eingabe-Mazes,
# der durch die Suche mit der Rechten-Hand-Regel entsteht
function solve(maze::Maze)::Vector{Node}

    # Definiert Maps von den Richtungen als Strings zu Ints
    directions = ["left", "up", "right", "down"]
    left_to_right = Dict(
        "left" => 1,
        "up" => 2,
        "right" => 3,
        "down" => 4,
    )

    # Findet für einen Knoten und eine Richtung den Knoten in im Maze der sich in der Richtung befindet
    function getNode(node::Node, direction::String)
        @assert direction in directions
        if direction == "up"
            return node.up
        elseif direction == "right"
            return node.right
        elseif direction == "down"
            return node.down
        elseif direction == "left"
            return node.left
        end
    end

    # hasWall überprüft ob es eine Wand in der gefragten Richtung gibt
    hasWall(node::Node, direction::String) = isnothing(getNode(node, direction))

    # turnRight und turnLeft geben für einen Richtungsstring jeweils die Richtung aus, die man erhält wenn man sich um
    # 90° im bzw. gegen den Uhrzeigersinn dreht

    turnRight(direction::String) = directions[(left_to_right[direction] % 4) + 1]
    function turnLeft(direction::String)::String 
        if direction == "left"
            return "down"
        else
            return directions[(left_to_right[direction] - 1)]
        end
    end

    # Initialisiert leeren Weg, Anfangs und endKnoten und die wählt zufällige Richtung aus
    path = Vector{Node}()
    current = maze[maze.startNode...]
    endNode = maze[maze.endNode...]
    facing_dir = rand(directions)

    # Findet Weg mit der rechten Hand Regel
    while current != endNode
        
        # Fügt unbesuchte Knoten in den Weg ein
        if !(current in path)
            push!(path, current)
        end

        # Rotiert nach Rechts
        facing_dir = turnRight(facing_dir)
        
        # Rotiert solange nach links, bis die Richtung begehbar ist
        while hasWall(current, facing_dir)
            facing_dir = turnLeft(facing_dir)
        end
        
        # geht zum nächsten Knoten

        current = getNode(current, facing_dir)

        # Falls nächster Knoten schon im Path ist wird gebacktracked, indem der letzte Knoten entfernt aus dem Array entfernt wird
        if current in path
            pop!(path)
        end
    end
    
    #Endknoten wird seperat hinzugefügt
    push!(path, current)

    maze.path = path
    return path
end