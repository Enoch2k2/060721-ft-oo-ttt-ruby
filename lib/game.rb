class Game
  attr_accessor :player_1, :player_2, :board

  WIN_COMBINATIONS = [
    [0, 1, 2], # top row win (horizontal)
    [3, 4, 5], # middle row win (horizontal)
    [6, 7, 8], # bottom row win (horizontal)
    [0, 3, 6], #  left side win (vertical)
    [1, 4, 7], # middle win (vertical)
    [2, 5, 8], # right side win (vetical)
    [0, 4, 8], # top left bottom right (diagnol)
    [2, 4, 6] # top right bottom left (diagnol)
  ]

  def initialize(board = Board.new)
    self.board = board
  end

  def start
    puts "Welcome to Tic Tac Toe!"
    self.assign_players

    self.board.display
    self.play
  end

  def play
    until self.over?
      turn
    end

    if self.won?
      puts "#{winner} won!"
    else
      puts "Cat's Game!"
    end

    play_again?
  end

  def play_again?
    answer = multiple_choice("Play Again?", ["yes", "no"])
    if answer == "yes"
      Game.new.start
    else
      puts "Come back and play again!"
    end
  end

  def winner
    index = self.won?[0]
    self.board.cells[index]
  end
  
  def turn
    puts "Turn #{self.turn_count + 1}: #{self.current_player.name}'s turn. (#{self.current_player.token})"
    index = self.question("Choose 1-9 in order to make your move:").to_i - 1
    if self.valid_move?(index)

      self.move(index, self.current_player.token)
      self.board.display
    else
      puts "You must choose a spot that is empty, and between 1 - 9"
      turn
    end
  end

  def move(index, token)
    self.board.update(index, token)
  end

  def valid_move?(index)
    self.board.valid_index?(index) && self.board.valid_position?(index)
  end

  def turn_count
    self.board.cells.count {|cell| cell != " "}
  end

  def current_player
    self.turn_count.even? ? self.player_1 : self.player_2
  end


  def over?
    self.board.full? || self.won?
  end

  def won?
    WIN_COMBINATIONS.detect do |win_combo| 
      unique_token_length = win_combo.map{|num| self.board.cells[num]}.uniq.length 
      token = self.board.cells[win_combo[0]]
      unique_token_length == 1 && token != " "
    end
  end

  def assign_players(player_number = 1)
    player_name = question("What is player #{player_number}'s name?")
    
    if player_number == 1
      player_token = multiple_choice("What token would player #{player_number} want?", ["X", "O"])
      self.player_1 = Player.new(name: player_name, token: player_token)
      player_number += 1
      self.assign_players(player_number)
    else
      self.player_2 = Player.new(name: player_name, token: self.player_1.token == "X" ? "O" : "X")
    end
  end

  def question(q)
    puts q
    gets.strip
  end

  def multiple_choice(q, choices)
    prompt = TTY::Prompt.new
    prompt.select(q, choices)
  end
end