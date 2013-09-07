class ScoreBoard < Metro::Model

  property :position, default: Point.at(10,10)
  property :ding, type: :sample, path: "pickup.wav"

  property :score, default: 0

  property :label, type: :model do
    create "metro::ui::label", text: "", position: position,
      font: { size: 30 }, color: "rgb(255,255,0)"
  end

  property :dimensions do
    Dimensions.of label.width, label.height
  end

  def bounds
    Bounds.new left: position.x, right: (position.x + width),
      top: position.y, bottom: (position.y + height)
  end

  event :notification, :star_collected do |sender,event_name|
    ding.play
    self.score += star_collected_score
    label.text = text
  end

  def star_collected_score
    1
  end

  def text
    "Score: #{score.to_i}"
  end

  def draw
    label.draw
  end

end