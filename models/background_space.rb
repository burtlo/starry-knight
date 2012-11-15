class BackgroundSpace < Metro::Model
  property :position
  property :animation, path: "space.png", dimensions: Dimensions.of(256,256), tileable: true
  property :color

  include ModelWithAnimation

  def time_per_image
    100
  end

  def draw
    image = animation.image(start_time: start_time, image_time: time_per_image)
    image.draw(middle_x(image),middle_y(image), 1, 1, 1, color, :add)
  end

end