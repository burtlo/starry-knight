class ScriptedPlayer

  attr_accessor :x, :y, :angle

  attr_accessor :window

  def initialize
    @x = @y = @angle = 0
  end

  def image
    @image ||= Gosu::Image.new window, asset_path("player.png"), false
  end

  def draw
    image.draw_rot(x,y,1,angle)
  end

end

class Title

  attr_accessor :x, :y, :z, :x_factor, :y_factor, :color, :alpha, :text

  attr_accessor :window

  def alpha
    color.alpha
  end

  def font
    @font ||= Gosu::Font.new(window, Gosu::default_font_name, 20)
  end

  def color=(value)
    @color = Gosu::Color.new(value.to_i(16))
  end

  def alpha=(value)
    color.alpha = value.floor
  end

  def draw
    font.draw text, x, y, z, x_factor, y_factor, color
  end

end

class TitleTransitionScene < Metro::Scene

  attr_reader :player

  attr_reader :title

  attr_reader :animations

  def initialize
    @animations = []
  end

  def prepare_transition_from(title_scene)
    hero_logo = title_scene.view['logo']
    @player = ScriptedPlayer.new
    player.x = hero_logo['x']
    player.y = hero_logo['y']

    title_label = title_scene.view['title']
    @title = Title.new
    title.text = title_label['text']
    title.x = title_label['x']
    title.y = title_label['y']
    title.z = title_label['z-order']
    title.x_factor = title_label['x-factor']
    title.y_factor = title_label['y-factor']
    title.color = title_label['color']
  end

  def show
    player.window = window
    title.window = window
    add_player_animation
    add_title_fade_animation
  end

  def add_player_animation
    final_x, final_y = Metro::Game.center

    animation = ImplicitAnimation.new actor: player,
      to: { x: final_x, y: final_y, angle: -360.0 },
      interval: 80.0,
      easing: :ease_in,
      context: self

    animation.on_complete do
      transition_to :main
    end

    animations.push animation
  end

  def add_title_fade_animation
    animation = ImplicitAnimation.new actor: title,
      to: { alpha: 0 }, interval: 70.0

    animations.push animation
  end

  def events(e)
    e.on_up Gosu::KbEscape do
      transition_to :main
    end
  end

  def update
    animations.each { |animation| animation.step! }
  end

  def draw
    player.draw
    title.draw
  end

end