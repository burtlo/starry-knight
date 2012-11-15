class LightBeam < Metro::Model
  property :position
  property :animation, path: "beam-of-light.png",
    dimensions: Dimensions.of(128,128)
  property :color

  def show
    @start_time = Gosu::milliseconds
  end

  def middle_x(image)
    x - image.width / 2.0
  end

  def middle_y(image)
    y - image.height / 2.0
  end

  def draw
    image = animation.image(@start_time,100)
    image.draw(middle_x(image),middle_y(image), 1, 2.5, 2.5, color, :add)
  end
end