class Player < Metro::UI::PhysicsSprite
  property :image, path: "player.png"

  property :shape_name, type: :text, default: "player"
  property :moment_of_interia, default: 16
  property :shape_size, default: 24.0

  property :turn_amount, default: 8

  event :on_hold, KbLeft, GpLeft do
    body.t -= turn_amount
  end

  event :on_hold, KbRight, GpRight do
    body.t += turn_amount
  end

  event :on_hold, KbUp, GpButton0 do
    force = body.a.radians_to_vec2 * (80)
    # relative_offset_from_center_of_gravity = CP::Vec2.new(0.0, 0.0)
    # body.apply_force(force,relative_offset_from_center_of_gravity)
    puts force
    push(force.x,force.y)
  end

  def show
    self.debug = true
  end

  def validate_position
    l_position = CP::Vec2.new(body.p.x % Game.width, body.p.y % Game.height)
    body.p = l_position
  end

  def warp(point)
    body.p = point
  end

  # def update
  #   self.x = body.p.x
  #   self.y = body.p.y
  #   puts "body.t = #{body.t}"
  # end
  # def draw
  #   # puts body.v.to_s
  #   # dim = Dimensions.of(shape.bb.r - shape.bb.l,shape.bb.b - shape.bb.t)
  #   # border = create "metro::ui::border", position: Point.at(shape.bb.l,shape.bb.t), dimensions: dim
  #   # border.draw
  #   dangle = body.a.to_degrees
  #   image.draw_rot(body.p.x,body.p.y,2,dangle)
  # end

end
