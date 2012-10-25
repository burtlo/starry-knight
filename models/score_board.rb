class ScoreBoard < Metro::Model

  def after_initialize
    @x = 10
    @y = 10
    @z_order = 5
    @x_factor = @y_factor = 1.0
    @color = Gosu::Color.new 0xffffff00
    @score = Hash.new(0)
  end

  attr_accessor :x, :y, :z_order, :x_factor, :y_factor, :color

  attr_reader :score

  event :notification, :star_collected do |target,sender|
    target.score[sender] += 1
  end

  def text
    score.each_with_index.map do |score,index|
      "#{player_label(score.first,index)} #{score.last}"
    end.join("\n")
  end
  
  #
  # While the score board can support mulitple users,
  # we are not going to show the name or player number
  # and simply display score:
  # 
  def player_label(player,index)
    "Score:"
  end

  def font
    @font ||= Gosu::Font.new(window, Gosu::default_font_name, 20)
  end

  def draw
    font.draw text, x, y, z_order, x_factor, y_factor, color
  end

end