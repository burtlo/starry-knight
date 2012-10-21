class Logo < Metro::Model

  attr_accessor :x, :y, :z_order, :x_factor, :y_factor

  def image
    @image ||= Gosu::Image.new window, asset_path(path), false
  end

  def draw
    image.draw_rot(x,y,1,angle,0.5,0.5,1,1,color)
  end
end
