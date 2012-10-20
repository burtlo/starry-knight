class PreTitleScene < Metro::Scene

  actors :title, :player

  def initialize
    @title = Title.new view['title']
    @player = Player.new view['logo']
  end

  def show
    add_player_animation

    enqueue Metro::ImplicitAnimation.new actor: title,
      to: { alpha: 255 }, interval: 200

  end

  def events(e)
    e.on_up Gosu::KbEscape do
      transition_to :title
    end
  end

  def update ; end

  def draw ; end

  def add_player_animation
    final_x, final_y = Metro::Game.center

    move_with_partial_fade = Metro::ImplicitAnimation.new actor: player,
      to: { y: 80, alpha: 50 },
      interval: 120,
      context: self

    move_with_partial_fade.on_complete do

      full_fade_in = Metro::ImplicitAnimation.new actor: player,
        to: { alpha: 255 },
        interval: 80,
        context: self

      full_fade_in.on_complete do
        transition_to :title
      end

      enqueue full_fade_in
    end

    enqueue move_with_partial_fade
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

  class Player < Metro::Generic

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

    def image
      @image ||= Gosu::Image.new window, asset_path(path), false
    end

    def draw
      image.draw_rot(x,y,1,angle,0.5,0.5,1,1,color)
    end
  end

end