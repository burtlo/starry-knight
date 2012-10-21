class TitleTransitionScene < Metro::Scene

  draw :logo, model: 'metro::models::image', from: :previous_scene
  draw :title, model: 'metro::models::label', from: :previous_scene

  def show
    add_player_animation
    add_title_fade_animation
  end

  def events(e)
    e.on_up Gosu::KbEscape do
      transition_to :main
    end
  end

  def update ; end

  def draw ; end

  def add_player_animation
    final_x, final_y = Metro::Game.center

    animation = Metro::ImplicitAnimation.new actor: logo,
      to: { x: final_x, y: final_y, angle: -360.0 },
      interval: 80,
      easing: :ease_in,
      context: self

    animation.on_complete do
      transition_to :main
    end

    enqueue animation
  end

  def add_title_fade_animation
    animation = Metro::ImplicitAnimation.new actor: title,
      to: { alpha: 0 }, interval: 70

    enqueue animation
  end

end