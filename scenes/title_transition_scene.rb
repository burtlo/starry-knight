class TitleTransitionScene < Metro::Scene

  draw :logo, model: 'metro::models::image', from: :previous_scene
  draw :title, model: 'metro::models::label', from: :previous_scene
  draw :galaxy, model: 'metro::models::image', from: :previous_scene
  
  def show
    final_x, final_y = Metro::Game.center
    
    animate :logo, to: { x: final_x, y: final_y, angle: -360.0 }, interval: 80, easing: :ease_in do
      transition_to :main
    end

    animate :title, to: { alpha: 0 }, interval: 1.second
  end

  event :on_up, KbEscape do
    transition_to :main
  end

end