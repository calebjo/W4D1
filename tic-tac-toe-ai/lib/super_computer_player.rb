require_relative 'tic_tac_toe_node'
require "byebug"

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)

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

    return kids.select {|child| !child.losing_node?(mark) }.first.prev_move_pos
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


#<TicTacToeNode:0x0000560d8dca9d10 @board=#<Board:0x0000560d8dcaa1c0 @rows=[[:x, :x, nil], [:o, nil, nil], [:x, :o, nil]]>, @next_mover_mark=:o, @prev_move_pos=[0, 1]>,

#<TicTacToeNode:0x0000560d8dca9568 @board=#<Board:0x0000560d8dca9770 @rows=[[:x, nil, :x], [:o, nil, nil], [:x, :o, nil]]>, @next_mover_mark=:o, @prev_move_pos=[0, 2]>,

#<TicTacToeNode:0x0000560d8dc9adb0 @board=#<Board:0x0000560d8dc9add8 @rows=[[:x, nil, nil], [:o, :x, nil], [:x, :o, nil]]>, @next_mover_mark=:o, @prev_move_pos=[1, 1]>,

#<TicTacToeNode:0x0000560d8dc9a978 @board=#<Board:0x0000560d8dc9aa18 @rows=[[:x, nil, nil], [:o, nil, :x], [:x, :o, nil]]>, @next_mover_mark=:o, @prev_move_pos=[1, 2]>,
 #<TicTacToeNode:0x0000560d8dc982e0 @board=#<Board:0x0000560d8dc98308 @rows=[[:x, nil, nil], [:o, nil, nil], [:x, :o, :x]]>, @next_mover_mark=:o, @prev_move_pos=[2, 2]>]

