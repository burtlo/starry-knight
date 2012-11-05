class GameScene < Metro::Scene
  event :on_up, KbR do |event|
    if event.control?
      Metro.reload!
      transition_to self.class.scene_name
    end
  end
end