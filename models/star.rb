class Star < Metro::Model

  property :animation, default: { path: "star.png", 
    dimensions: Metro::Dimensions.of(25,25) }
  # property :image_path, type: :text, default: "missing.png"
  property :color

  attr_writer :x, :y, :animation

  def after_initialize
    self.color = "rgba(#{rand_between(40,256)},#{rand_between(40,256)},#{rand_between(40,256)},1.0)"
  end
  
  def rand_between(bottom,top)
    rand(top-bottom) + bottom
  end

  # def animation
  #   @animation ||= Gosu::Image::load_tiles(window, asset_path(image_path), 16, 16, false)
  # end

  def x
    @x ||= rand * Game.width
  end

  def y
    @y ||= rand * Game.height
  end

  def draw
    img = animation.image
    img.draw(x - img.width / 2.0, y - img.height / 2.0, 1, 1, 1, color, :add)
  end
end
