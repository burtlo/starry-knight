class Star
  attr_accessor :x, :y, :animation, :color, :window

  def initialize
    @color = Gosu::Color.new(0xff000000)
    @color.red = rand(256-40) + 40
    @color.green = rand(256-40) + 40
    @color.blue = rand(256-40) + 40
  end

  def animation
    @animation ||= Gosu::Image::load_tiles(window, asset_path("star.png"), 25, 25, false)
  end

  def x
    @x ||= rand * Metro::Game.width
  end

  def y
    @y ||= rand * Metro::Game.height
  end

  def draw
    img = animation[Gosu::milliseconds / 100 % animation.size ]
    img.draw(x - img.width / 2.0, y - img.height / 2.0, Metro::Game::Stars, 1, 1, color, :add)
  end
end
