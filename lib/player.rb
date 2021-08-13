class Player
  attr_accessor :name, :token

  def initialize(name:, token:)
    self.name = name
    self.token = token
  end
end