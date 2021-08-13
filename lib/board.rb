class Board
  attr_accessor :cells

  def initialize
    self.cells = Array.new(9, " ")
  end

  def display
    puts " #{self.cells[0]} | #{self.cells[1]} | #{self.cells[2]} "
    puts "-----------"
    puts " #{self.cells[3]} | #{self.cells[4]} | #{self.cells[5]} "
    puts "-----------"
    puts " #{self.cells[6]} | #{self.cells[7]} | #{self.cells[8]} "
  end

  def valid_index?(index)
    index.between?(0, 8)
  end

  def valid_position?(index)
    cell = self.cells[index]
    cell == " "
  end

  def update(index, token)
    self.cells[index] = token
  end

  def full?
    self.cells.none? {|cell| cell == " "}
  end
end