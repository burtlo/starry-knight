class Timer < Metro::Model

  property :position
  property :dimensions
  property :color, default: "rgba(255,255,255,0.5)"
  property :fill_color, type: :color, default: "rgba(255,255,255,0.5)"
  property :current, default: 100
  property :total, default: 100
  property :border, default: 2

  def draw
    draw_border
    draw_fill
    # draw a rectangle top line, left, right, bottom
    # draw a rectangle in the center based on the current / total
  end

  def draw_border
    # puts "#{x},#{y} #{width},#{height}"
    draw_top
    draw_bottom
    draw_left
    draw_right
  end

  def draw_top
    window.draw_quad(x + border,y,color,
      width + x,y,color,
      x + width,y + border,color,
      x + border,y + border,color,z_order)
  end

  def draw_left
    window.draw_quad(x,y,color,
      border + x,y,color,
      x + border,y + border + height,color,
      x,y + border + height,color,z_order)
  end

  def draw_right
    window.draw_quad(x + width,y,color,
      x + width + border,y,color,
      x + width + border,y + border + height,color,
      x + width,y + border + height,color,z_order)

  end

  def draw_bottom
    window.draw_quad(x + border,y + height,color,
      width + x,y + height,color,
      x + width,y + border + height,color,
      x + border,y + border + height,color,z_order)
  end

  def fill_width
    self.current = 1 if current < 1
    width * (current / total)
  end

  def draw_fill
    window.draw_quad(x + border,y + border,fill_color,
      x + fill_width,y + border,fill_color,
      x + fill_width,y + height,fill_color,
      x + border,y + height,fill_color, z_order)
  end
end
