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

  def validate_position
    l_position = CP::Vec2.new(body.p.x % Game.width, body.p.y % Game.height)
    body.p = l_position
  end

  def warp(point)
    body.p = point
  end

end
