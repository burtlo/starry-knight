class GameOverScene < GameScene
  # By default the Scene Name is based on the class name
  # but that can be overridden with the scene_name class method
  # scene_name "credits"

  draw :title

  #
  # Before a scene is transitioned to it is called with the previous scene. This
  # allows for the new scene to retrieve any data from the previous scene to assist
  # with the layout of the current scene.
  #
  def prepare_transition_from(old_scene)
    self.title.text = old_scene.score_board.score if old_scene.respond_to?(:score_board)
  end

end
