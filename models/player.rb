class Player < Metro::Model

  property :position
  property :angle, type: :numeric, default: 0.0
  property :vel_x, type: :numeric, default: 0.0
  property :vel_y, type: :numeric, default: 0.0
  property :image

  event :on_hold, Gosu::KbLeft, Gosu::GpLeft do
    turn_left
  end

  event :on_hold, Gosu::KbRight, Gosu::GpRight do
    turn_right
  end

  event :on_hold, Gosu::KbUp, Gosu::GpButton0 do
    accelerate
  end


  def warp(point)
    self.position = point
  end

  def turn_left
    self.angle -= 4.5
  end

  def turn_right
    self.angle += 4.5
  end

  def accelerate
    self.vel_x += Gosu::offset_x(angle,0.5)
    self.vel_y += Gosu::offset_y(angle,0.5)
  end

  def update
    self.x += vel_x
    self.y += vel_y
    self.x %= Game.width
    self.y %= Game.height

    self.vel_x *= 0.95
    self.vel_y *= 0.95
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
