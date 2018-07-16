class Node
    attr_accessor :x, :y, :children, :parent
    # Creates a new node on the chess board where the knight could travel.
    def initialize(x, y)
        @x = x
        @y = y
        @children = []
        @parent = nil
    end

end

class KnightTravel
    attr_accessor :root, :target, :spaces
    def initialize(root, target)
        @spaces = []
        build_board
        connect_spaces
        @root = find_node(root[0], root[1])
        @target = find_node(target[0], target[1])
        @path = search(@root, @target)
        
    end

    def build_board
        #build graph of children moves on board.
        board = []
        (8).times do |x|
            (8).times do |y|
                new_node = Node.new(x, y)
                spaces << new_node
            end
        end
    end

    def connect_spaces
        #connect each space with a knights available moves from that space
        spaces.each do |space|
            [-1,1,-2,2].each do |x_move|
                (x_move.abs == 1)? (y_move = 2) : (y_move = 1)
                #find the nodes that match these coordinates
                new_x = space.x + x_move
                new_pos_y = space.y + y_move
                new_neg_y =  space.y - y_move
                found_node_pos =  find_node(new_x, new_pos_y)
                space.children << found_node_pos if found_node_pos
                found_node_neg =  find_node(new_x, new_neg_y)
                space.children << found_node_neg if found_node_neg
            end
        end
        
    end

    def find_node(x,y)
        spaces.each do |space|
            if space.x == x
                if space.y == y
                    return space
                end
            end
        end

        nil
    end

    def search(start, stop)
        queue = [start]
        visited = []
        while !queue.empty?
            node = queue.delete_at(0)
            return print_path(start,stop) if node == stop
            node.children.each do |child|
                if !visited.include?(child)
                    child.parent = node
                    queue << child
                end
                visited << node
            end
        end
    end

    def print_path(start, stop)
        queue = [stop]
        while queue[-1] != start
            queue << queue[-1].parent
        end
        queue.reverse!
        print "["
        queue.each do |node|
            print "[#{node.x},#{node.y}]"
        end
        print "]"
    end

end

new_travel = KnightTravel.new([0,0], [7,7])


