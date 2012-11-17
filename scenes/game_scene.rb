class GameScene < Metro::Scene

  event :on_up, KbR do |event|
    if event.control?
      Metro.reload!
      transition_to scene_name
    end
  end

  event :on_up, KbE do |event|
    transition_to scene_name, with: :edit
  end

  def fade_in_and_out(name)
    animate name, to: { alpha: 255, background_color_alpha: 20 }, interval: 2.seconds do
      after 1.second do
        animate name, to: { alpha: 0, background_color_alpha: 0 }, interval: 1.second do
          yield if block_given?
        end
      end
    end
  end

end

