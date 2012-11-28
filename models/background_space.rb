class BackgroundSpace < Metro::Model
  property :position
  property :animation, path: "space.png", dimensions: Dimensions.of(256,256),
    tileable: true, time_per_image: 50
  property :color
  property :scale, default: Scale.to(1.0,1.0)

  def bounds
    Bounds.new left: left, right: right, top: top, bottom: bottom
  end

  include ImagePlacementHelpers

  def draw
    image = animation.image
    image.draw(middle_x(image),middle_y(image), z_order, x_factor, y_factor, color, :add)
  end

end