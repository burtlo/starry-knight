class BackgroundSpace < Metro::Model
  property :position
  property :animation, path: "space.png", dimensions: Dimensions.of(256,256),
    tileable: true, time_per_image: 50
  property :color

  include ImagePlacementHelpers

  def draw
    image = animation.image
    image.draw(middle_x(image),middle_y(image), 1, 1, 1, color, :add)
  end

end