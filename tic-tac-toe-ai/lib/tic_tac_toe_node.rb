require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark
  attr_writer :next_mover_mark

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    board.rows.each_with_index do |row, i|
      row.each_with_index do |ele, j|
        if ele == nil
          pos = [i,j]
          children << board.dup[pos] = board.next_mover_mark
        end
      end
    end
    children 
  end
end


