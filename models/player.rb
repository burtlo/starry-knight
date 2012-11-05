class Player < Metro::Model

  attr_reader :x, :y, :angle

  event :on_hold, Gosu::KbLeft, Gosu::GpLeft do
    turn_left
  end

  event :on_hold, Gosu::KbRight, Gosu::GpRight do
    turn_right
  end

  event :on_hold, Gosu::KbUp, Gosu::GpButton0 do
    accelerate
  end

  def initialize
    @x = @y = @vel_x = @vel_y = @angle = 0
  end

  def image
    @image ||= Gosu::Image.new window, asset_path("player.png"), false
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
    @x %= Game.width
    @y %= Game.height

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def collect_stars(stars)
    if stars.reject! {|star| Gosu::distance(x, y, star.x, star.y) < 35 }
      notification :star_collected
    end
  end

  def draw
    image.draw_rot(x,y,2,angle)
  end

end
