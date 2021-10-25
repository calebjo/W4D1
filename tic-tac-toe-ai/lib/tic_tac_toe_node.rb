require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  attr_writer :next_mover_mark

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    evaluator == :x ? opponent_mark = :o : opponent_mark = :x
    return true if board.winner == opponent_mark && board.over?

    if children.all? { |child| child.losing_node?(opponent_mark)} 
      return false
    elsif children.any? { |child| child.losing_node?(evaluator)}
      return true
    end

    false
  end

  def winning_node?(evaluator)
    evaluator == :x ? opponent_mark = :o : opponent_mark = :x
    return true if board.winner == evaluator && board.over?

    if children.all? { |child| child.losing_node?(evaluator)} 
      return false
    elsif children.any? { |child| child.losing_node?(opponent_mark)}
      return true
    end

    false

  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    board.rows.each_with_index do |row, i|
      row.each_with_index do |ele, j|
        if ele == nil
          pos = [i,j]
          child_board = board.dup
          child_board[pos] = next_mover_mark
          next_mover_mark == :x ? next_mover_mark = :o : next_mover_mark = :x 
          children << TicTacToeNode.new(child_board, next_mover_mark, pos)
        end
      end
    end
    children 
  end

end


