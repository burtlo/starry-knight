class TitleTransitionScene < Metro::Scene

  attr_reader :player, :title

  attr_reader :animations

  def initialize
    @animations = []
  end

  def prepare_transition_from(title_scene)
    @player = Player.new title_scene.view['logo']
    @title = Title.new title_scene.view['title']
  end

  def show
    player.window = window
    title.window = window
    add_player_animation
    add_title_fade_animation
  end

  def add_player_animation
    final_x, final_y = Metro::Game.center

    animation = Metro::ImplicitAnimation.new actor: player,
      to: { x: final_x, y: final_y, angle: -360.0 },
      interval: 80,
      easing: :ease_in,
      context: self

    animation.on_complete do
      transition_to :main
    end

    animations.push animation
  end

  def add_title_fade_animation
    animation = Metro::ImplicitAnimation.new actor: title,
      to: { alpha: 0 }, interval: 70

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


  class Player < Metro::Generic
    def image
      @image ||= Gosu::Image.new window, asset_path(path), false
    end

    def draw
      image.draw_rot(x,y,1,angle)
    end
  end

  class Title < Metro::Generic

    def color=(value)
      value = value.to_i(16) if value.is_a? String
      @color = Gosu::Color.new(value)
    end

    def alpha
      color.alpha
    end

    def alpha=(value)
      color.alpha = value.floor
    end

    def font
      @font ||= Gosu::Font.new(window, Gosu::default_font_name, 20)
    end

    def draw
      font.draw text, x, y, z_order, x_factor, y_factor, color
    end
  end

end