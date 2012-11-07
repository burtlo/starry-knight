class Star < Metro::Model

  property :position
  property :animation, path: "star.png", dimensions: Dimensions.of(25,25)
  property :color

  def draw
    img = animation.image
    img.draw(x - img.width / 2.0, y - img.height / 2.0, 1, 1, 1, color, :add)
  end
end
