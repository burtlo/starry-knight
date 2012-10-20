class StarData < Metro::Generic
  def animation
    Gosu::Image::load_tiles(window, asset_path(path), width, height, tileable)
  end
end

class PreTitleScene < Metro::Scene

  actors :title, :player, :star, :star2, :star3

  def initialize
    @title = Title.new view['title']
    @player = Player.new view['logo']

    star_data = StarData.new view['star']
    @star = Star.new
    @star.x = star_data.x
    @star.y = star_data.y
    # TODO not setting the path data to create the animation

    star_data2 = StarData.new view['star2']
    @star2 = Star.new
    @star2.x = star_data2.x
    @star2.y = star_data2.y
    # TODO not setting the path data to create the animation

    star_data3 = StarData.new view['star3']
    @star3 = Star.new
    @star3.x = star_data3.x
    @star3.y = star_data3.y
    # TODO not setting the path data to create the animation

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
        interval: 40,
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