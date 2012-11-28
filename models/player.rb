class Player < Metro::Model

  property :position, default: Point.at(320,240,10)
  property :angle, default: 0.0
  property :turn_amount, default: 4.5
  property :image, path: "player.png"

  property :acceleration, default: 0.5
  property :velocity, default: Velocity.of(0,0,0,0.95)

  property :dimensions do
    image.dimensions
  end

  def bounds
    Bounds.new left: left, right: right, top: top, bottom: bottom
  end

  def left
    position.x - width/2
  end

  def right
    left + width
  end

  def top
    position.y - height/2
  end

  def bottom
    top + height
  end

  event :on_hold, KbLeft, GpLeft do
    self.angle = self.angle - turn_amount
  end

  event :on_hold, KbRight, GpRight do
    self.angle = self.angle + turn_amount
  end

  event :on_hold, KbUp, GpButton0 do
    velocity.x += Gosu.offset_x(angle.to_f,acceleration)
    velocity.y += Gosu.offset_y(angle.to_f,acceleration)
  end

  def warp(point)
    self.position = point
  end

  def update
    self.position = self.position + velocity
    velocity.decay!
  end

  def draw
    image.draw_rot(x,y,z_order,angle.to_f)
  end

end
