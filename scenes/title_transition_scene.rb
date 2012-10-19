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

class TitleTransitionScene < Metro::Scene

  attr_reader :player

  attr_reader :animations

  def initialize
    @animations = []
  end

  def prepare_transition_from(title_scene)
    logo = title_scene.view['logo']
    @player = ScriptedPlayer.new
    player.x = logo['x']
    player.y = logo['y']
  end

  def show
    player.window = window
    final_x, final_y = Metro::Game.center

    animation = ImplicitAnimation.new actor: player,
      to: { x: final_x, y: final_y, angle: -360.0 },
      interval: 80.0,
      easing: :ease_in,
      context: self,
      completed: lambda { |scene| transition_to :main }

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
  end

end