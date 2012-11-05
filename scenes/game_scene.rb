class GameScene < Metro::Scene
  event :on_up, KbR do
    Metro.reload!
    transition_to scene_name
  end
end