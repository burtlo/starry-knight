class LabelWithImage < Metro::Model

  property :position

  property :align, type: :text, default: "left"

  property :color, default: "rgba(255,255,255,1.0)"
  property :background_color, type: :color, default: "rgba(127,127,127,1.0)"

  property :font, default: { size: 20 }
  property :text

  property :padding, default: 10

  property :image
  property :angle, default: 0
  property :center_x, type: :numeric, default: 0
  property :center_y, type: :numeric, default: 0

  def show
    background_color.alpha = color.alpha
  end

  property :scale, default: Scale.one
  property :dimensions do
    width = text_width + padding + image.width
    height = (text_height > image.height ? text_height : image.height)
    Dimensions.of width, height
  end

  def text_width
    (font.text_width(text) * x_factor)
  end

  def text_height
    (font.height * y_factor)
  end

  def background_left_x
    x - padding/2 - x_offset
  end

  def background_top_y
    y - padding/2
  end

  def background_right_x
    x + padding/2 + x_offset
  end

  def background_bottom_y
    y + height + padding/2
  end

  def horizontal_alignments
    { left: 0,
      center: (width/2),
      right: width }
  end

  def x_offset
    horizontal_alignments[align.to_sym]
  end

  def text_x_position
    (x + image.width + padding) - x_offset
  end

  def draw_background
    window.draw_quad(background_left_x,background_top_y,background_color,
      background_right_x,background_top_y,background_color,
      background_right_x,background_bottom_y,background_color,
      background_left_x,background_bottom_y,background_color,z_order - 1)
  end

  def draw_image
    image.draw_rot x - x_offset, y, z_order, angle.to_f, center_x, center_y, x_factor, y_factor, color
  end

  def draw_text
    font.draw text, text_x_position, y + padding, z_order, x_factor, y_factor, color
  end

  def draw
    draw_background
    draw_image
    draw_text
  end

end