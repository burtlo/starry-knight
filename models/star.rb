class Star < Metro::Model

  property :position
  property :animation, path: "star.png", dimensions: Dimensions.of(25,25)
  property :color
  
  def middle_x(image)
    x - image.width / 2.0
  end
  
  def middle_y(image)
    y - image.height / 2.0
  end

  def draw
    img = animation.image
    img.draw(middle_x(img),middle_y(img), 1, 1, 1, color, :add)
  end
end
