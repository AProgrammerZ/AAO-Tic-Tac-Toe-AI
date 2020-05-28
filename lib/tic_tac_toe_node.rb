require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board, @next_mover_mark, @prev_move_pos = board, next_mover_mark, prev_move_pos
  end

  def losing_node?(evaluator)
    if board.over?
      if board.winner == next_mover_mark
        return true
      elsif board.winner == nil || board.winner == self.get_my_mark
        return false
      end
    end

    if next_mover_mark == evaluator
      self.children.all? { |child| self.losing_node?(evaluator) }
    else
      self.children.any? { |child| self.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    if board.over?
      if board.winner == self.get_my_mark
        return true
      elsif board.winner == nil || board.winner == next_mover_mark
        return false
      end
    end

    if next_mover_mark == evaluator
      self.children.any? { |child| self.winning_node?(evaluator) }
    else
      self.children.all? { |child| self.winning_node?(evaluator) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children_nodes = []

    @board.rows.each_with_index do |row, idx_r|
      row.each_with_index do |col, idx_c|
        if col.nil?
          new_node = TicTacToeNode.new(@board.dup, @next_mover_mark, prev_move_pos = [idx_r, idx_c])
          new_node.board.rows[idx_r][idx_c] = @next_mover_mark
          self.alternate_mark
          children_nodes << new_node
        end
      end
    end

    children_nodes
  end

  def alternate_mark
    @next_mover_mark = :x if @next_mover_mark == :o
    @next_mover_mark = :o if @next_mover_mark == :x
  end

  def get_my_mark
    return :x if @next_mover_mark == :o
    return :o if @next_mover_mark == :x 
  end
end
