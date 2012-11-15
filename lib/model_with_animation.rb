module ModelWithAnimation

  def start_time
    @start_time ||= Gosu::milliseconds
  end

  def middle_x(image)
    x - image.width / 2.0
  end

  def middle_y(image)
    y - image.height / 2.0
  end

end
