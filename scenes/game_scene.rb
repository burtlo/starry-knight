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

end

