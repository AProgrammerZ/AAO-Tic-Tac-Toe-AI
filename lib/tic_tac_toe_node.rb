require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board, @next_mover_mark, @prev_move_pos = board, next_mover_mark, prev_move_pos
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    @board.rows.each_with_index do |row, idx_r|
      row.each_with_index do |col, idx_c|
        if col.nil? # (empty)
          new_node = TicTacToeNode.new(@board.dup, @next_mover_mark, prev_move_pos = [idx_r, idx_c])
          new_node.board.rows[idx_r][idx_c] = @next_mover_mark
          self.alternate_mark
        end
      end
    end
  end

  def alternate_mark
    @next_mover_mark = "X" if @next_mover_mark == "O"
    @next_mover_mark = "O" if @next_mover_mark == "X"
  end
end
