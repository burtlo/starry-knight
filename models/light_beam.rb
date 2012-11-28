class LightBeam < Metro::Model
  property :position
  property :animation, path: "beam-of-light.png",
    dimensions: Dimensions.of(128,128), time_per_image: 100
  property :color
  property :scale, default: Scale.to(2.5,2.5)

  def bounds
    Bounds.new left: left, right: right, top: top, bottom: bottom
  end

  include ImagePlacementHelpers

  def draw
    image = animation.image
    image.draw(middle_x(image),middle_y(image), z_order, x_factor, y_factor, color, :add)
  end
end