class ScoreBoard < Metro::Model

  property :position, default: Point.at(10,10)
  property :scale, default: Scale.one

  property :color, default: "rgb(255,255,0)"

  property :font, default: { size: 20 }

  def after_initialize
    @score = Hash.new(0)
  end

  attr_reader :score

  property :ding, type: :sample, path: "pickup.wav"

  event :notification, :star_collected do |target,sender|
    target.ding.play
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

  def draw
    font.draw text, x, y, z_order, x_factor, y_factor, color
  end

end