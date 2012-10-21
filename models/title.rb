class Title < Metro::Model

  def font
    @font ||= Gosu::Font.new(window, Gosu::default_font_name, 20)
  end

  def draw
    font.draw text, x, y, z_order, x_factor, y_factor, color
  end
end