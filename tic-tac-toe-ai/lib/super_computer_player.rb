require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)

    queue = [node]
    until queue.empty?
      current = queue.shift
      return current.prev_move_pos if current.winning_node?(mark)

      node.children.each do |kid|
        queue << kid
      end
      
    end

    # kids = node.children
    # kids.each do |child|
    #   return child.prev_move_pos if child.winning_node?(mark)
    # end

    kids.select {|child| !child.losing_node?(mark) }.first
    
  end
end

# def bfs(target_value)
#   queue = [self]
#   until queue.empty?
#       current = queue.shift
#       return current if current.value == target_value

#       current.children.each do |child|
#           queue << child
#       end
#   end
#   nil
# end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
