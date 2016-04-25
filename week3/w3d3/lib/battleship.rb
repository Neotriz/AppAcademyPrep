require_relative "board"
require_relative "player"

class BattleshipGame
  attr_reader :board, :player
  def initialize(player = HumanPlayer.new, board = Board.random)
    @player = player
    @board = board
  end
  def play
    board.place_random_ship
    until game_over?
      board.display
      p board.grid
      play_turn
    end
    puts "Congrats! You've won"
  end
  def [](pos)
    x, y = pos
    board.grid[x][y]
  end

  def []=(pos,mark)
    x, y = pos
    # p "#{x} is x and #{y} is y and #{mark} is mark"
    if board.grid[x][y] == :s
      board.grid[x][y] = :a
    elsif board.grid[x][y] == :a
      puts "Already Attacked!"
    else
       board.grid[x][y] = mark
     end
  end

  def attack(pos)
    self[pos] = :x
  end

  def count
    board.count
  end

  def game_over?
    board.won?
  end

  def play_turn
    pos = player.get_play
    puts "This is pos:#{pos} "
    until valid_play?(pos)
      puts "Try again! Wrong input"
      pos = player.get_play
    end
    attack(pos)
  end
  def valid_play?(pos)
    board.in_range?(pos)
  end
end

if __FILE__ == $PROGRAM_NAME
  BattleshipGame.new.play
end
