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
        # @considered_pos.select {|pos| self.valid_moves(pos)}
        new_moves = KnightPathFinder.valid_moves(pos).select { |pos| !@considered_pos.include?(pos)}
        new_moves.each do |move|
            @considered_pos << move
        end
        # @considered_pos << new_moves 
        new_moves  
    end
  
    def build_move_tree
        start_pos = PolyTreeNode.new(starting_pos)

        queue = [start_pos]
        until queue.empty?
            this_pos = queue.shift
            
            # valid_moves = KnightPathFinder.valid_moves(this_pos.value)
            valid_moves = new_move_positions(this_pos.value)
            
            valid_moves.each do |move|
                # debugger
                move_tree = PolyTreeNode.new(move)
                this_pos.add_child(move_tree)
                # move_tree.parent = this_pos
                # puts "this node is #{move} This is the parent #{this_pos.value}"
                queue << move_tree
                # debugger
            end
        end

    end
    
end

k = KnightPathFinder.new([4,4])
# k.build_move_tree

# def bfs(target_value)
#     queue = [self]
#     until queue.empty?
#         current = queue.shift
#         return current if current.value == target_value

#         current.children.each do |child|
#             queue << child
#         end
#     end
#     nil
# end