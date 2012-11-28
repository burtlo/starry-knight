module ImagePlacementHelpers

  def middle_x(image)
    x - image.width / 2.0
  end

  def middle_y(image)
    y - image.height / 2.0
  end

  def left
    middle_x(animation.image)
  end

  def right
    left + animation.image.width * x_factor
  end

  def top
    middle_y(animation.image)
  end

  def bottom
    top + animation.image.height * y_factor
  end

end
