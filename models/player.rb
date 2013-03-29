class Numeric
  def radians_to_vec2
    CP::Vec2.new(Math::cos(self), Math::sin(self))
  end
end

class Player < Metro::UI::Sprite
  property :turn_amount, default: 4.5
  property :image, path: "player.png"

  property :acceleration, default: 0.5
  property :velocity, default: Velocity.of(0,0,0,0.95)

  event :on_hold, KbLeft, GpLeft do
    # self.angle = self.angle - turn_amount
    body.t -= 80.0
  end

  event :on_hold, KbRight, GpRight do
    # self.angle = self.angle + turn_amount
    body.t += 80.0
  end

  event :on_hold, KbUp, GpButton0 do
    # velocity.x += Gosu.offset_x(angle.to_f,acceleration)
    # velocity.y += Gosu.offset_y(angle.to_f,acceleration)
    force = body.a.radians_to_vec2 * (4000.0)
    relative_offset_from_center_of_gravity = CP::Vec2.new(0.0, 0.0)
    body.apply_force(force,relative_offset_from_center_of_gravity)
  end

  # TODO: what are the values in th shape and how can I configure them

  def shape
    @shape ||= begin
      shape_array = [CP::Vec2.new(-28.0, -28.0), CP::Vec2.new(-28.0, 28.0), CP::Vec2.new(28.0, 28.0), CP::Vec2.new(28.0, -28.0)]
      new_shape = CP::Shape::Poly.new(body, shape_array, CP::Vec2.new(0,0))
      new_shape.collision_type = :player
      new_shape
    end
  end

  def body
    @body ||= begin
      new_body = CP::Body.new(10,8)
      new_body.p = CP::Vec2.new(0.0,0.0)
      new_body.v = CP::Vec2.new(0.0,0.0)
      new_body.a = (3*Math::PI/2.0)
      new_body
    end
  end

  def rtod(r)
    r * 180 / Math::PI
  end

  def dtor(d)
    d * Math::PI / 180
  end

  def validate_position
    l_position = CP::Vec2.new(body.p.x % Game.width, body.p.y % Game.height)
    body.p = l_position
  end


  def warp(point)
    self.position = point
    body.p = CP::Vec2.new point.x, point.y
  end


  def draw
    dangle = rtod body.a
    # puts shape.bb
    dim = Dimensions.of(shape.bb.r - shape.bb.l,shape.bb.b - shape.bb.t)
    border = create "metro::ui::border", position: Point.at(shape.bb.l,shape.bb.t), dimensions: dim
    border.draw
    image.draw_rot(body.p.x,body.p.y,2,dangle + 90)
  end

  # Use the default sprite draw

end
