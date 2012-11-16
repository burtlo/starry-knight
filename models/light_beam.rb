class LightBeam < Metro::Model
  property :position
  property :animation, path: "beam-of-light.png",
    dimensions: Dimensions.of(128,128), time_per_image: 100
  property :color
  property :scale, default: Scale.to(2.5,2.5)

  include ImagePlacementHelpers

  def draw
    image = animation.image
    image.draw(middle_x(image),middle_y(image), 1, x_factor, y_factor, color, :add)
  end
end