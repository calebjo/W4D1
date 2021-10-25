require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)

    # queue = [node]
    # until queue.empty?
    #   current = queue.shift
    #   return current.prev_move_pos if current.winning_node?(mark)


    #   node.children.each do |kid|
    #     puts "#{node.children}"
    #     queue << kid

    #   end
      
    # end

    kids = node.children
    kids.each do |child|
      # puts "#{child.prev_move_pos}"
      return child.prev_move_pos if child.winning_node?(mark)
      
      grandkids = child.children
      grandkids.each do |grandkid|
        # puts "#{grandkid.prev_move_pos}"
        return grandkid.prev_move_pos if grandkid.winning_node?(mark)
      end
    end

    # end

    # kids.select {|child| !child.losing_node?(mark) }.first
    raise 'no non-losing nodes'
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


