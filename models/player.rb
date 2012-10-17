class Player

  attr_reader :x, :y, :angle, :image, :score

  def initialize(window)
    @x = @y = @vel_x = @vel_y = @angle = @score = 0
    @image = Gosu::Image.new window, asset_path("player.png"), false
  end

  def warp(x,y)
    @x, @y = x, y
  end

  def turn_left
    @angle -= 4.5
  end

  def turn_right
    @angle += 4.5
  end

  def accelerate
    @vel_x += Gosu::offset_x(angle,0.5)
    @vel_y += Gosu::offset_y(angle,0.5)
  end

  def move
    @x += @vel_x
    @y += @vel_y
    @x %= Metro::Game::Width
    @y %= Metro::Game::Height

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def collect_stars(stars)
    if stars.reject! {|star| Gosu::distance(x, y, star.x, star.y) < 35 }
      @score += 1
    end
  end

  def draw
    image.draw_rot(x,y,1,angle)
  end

end
