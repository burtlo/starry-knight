class LightBeam < Metro::Model
  property :position
  property :animation, path: "beam-of-light.png",
    dimensions: Dimensions.of(128,128)
  property :color
  property :scale, default: Scale.to(2.5,2.5)

  include ModelWithAnimation

  def time_per_image
    100
  end

  def draw
    image = animation.image(start_time: start_time, image_time: time_per_image)
    image.draw(middle_x(image),middle_y(image), 1, x_factor, y_factor, color, :add)
  end
end