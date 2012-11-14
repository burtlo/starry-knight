class BackgroundSpace < Metro::Model
  property :position
  property :animation, path: "space.png", dimensions: Dimensions.of(256,256), tileable: true
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
    image.draw(middle_x(image),middle_y(image), 1, 1, 1, color, :add)
  end
end