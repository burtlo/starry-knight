class Player < Metro::UI::Sprite
  property :turn_amount, default: 4.5
  property :image, path: "player.png"

  property :acceleration, default: 0.5
  property :velocity, default: Velocity.of(0,0,0,0.95)

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

  # Use the default sprite draw

end
