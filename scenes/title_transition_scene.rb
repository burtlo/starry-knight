class TitleTransitionScene < Metro::Scene

  draw :logo, model: 'metro::models::image', from: :previous_scene
  draw :title, model: 'metro::models::label', from: :previous_scene

  def show
    final_x, final_y = Metro::Game.center
    
    animate actor: logo, to: { x: final_x, y: final_y, angle: -360.0 }, interval: 80, easing: :ease_in do
      transition_to :main
    end

    animate actor: title, to: { alpha: 0 }, interval: 70
  end

  def events(e)
    e.on_up Gosu::KbEscape do
      transition_to :main
    end
  end

  def update ; end

  def draw ; end

end