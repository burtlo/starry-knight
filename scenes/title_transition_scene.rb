class TitleTransitionScene < GameScene

  draw :logo, model: 'metro::ui::image', from: :previous_scene
  draw :title, model: 'metro::ui::label', from: :previous_scene

  draw :galaxy, model: 'metro::ui::image', from: :previous_scene
  draw :background_space1, model: 'background_space', from: :previous_scene
  draw :background_space2, model: 'background_space', from: :previous_scene


  def show
    animate :logo, to: { x: Game.center.x, y: Game.center.y, angle: -360.0 }, interval: 80, easing: :ease_in do
      transition_to :main
    end

    animate :title, to: { alpha: 0 }, interval: 1.second
  end

  event :on_up, KbEscape do
    transition_to :main, with: :fade, interval: 30.ticks
  end

end