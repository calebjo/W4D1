require_relative "00_tree_node.rb"
require "byebug"

class KnightPathFinder
    attr_reader :starting_pos
    attr_writer :considered_pos

    def initialize(starting_pos)
        @starting_pos = starting_pos
        @root_node = PolyTreeNode.new(starting_pos)
        @considered_pos = [starting_pos]
        build_move_tree
    end

    def self.valid_moves(pos)
        array = []
        row, col = pos

        array << [row + 1, col + 2]
        array << [row + 1, col - 2]
        array << [row - 1, col + 2]
        array << [row - 1, col - 2]
        array << [row + 2, col + 1]
        array << [row + 2, col - 1]
        array << [row - 2, col + 1]
        array << [row - 2, col - 1]

        array.select do |pos|
            row, col = pos 
            (row >= 0 && row < 8) && (col >= 0 && col < 8)
        end
    end


    def new_move_positions(pos)
        new_moves = KnightPathFinder.valid_moves(pos).select { |pos| !@considered_pos.include?(pos)}
        new_moves.each do |move|
            @considered_pos << move
        end
        new_moves  
    end
  
    def build_move_tree
        queue = [@root_node]
        until queue.empty?
            this_node = queue.shift
            
            valid_moves = new_move_positions(this_node.value)
            
            valid_moves.each do |move|
                move_tree = PolyTreeNode.new(move)
                this_node.add_child(move_tree)
                queue << move_tree
            end
        end
        @root_node
    end

    def find_path(end_pos)
        start_node = @root_node.bfs(end_pos)
        trace_back_path(start_node)
    end

    def trace_back_path(end_node)
        path = [end_node.value]
        while end_node.parent != nil
            end_node = end_node.parent
            path.unshift(end_node.value)
        end
        path
    end
end

kpf = KnightPathFinder.new([0, 0])
p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]