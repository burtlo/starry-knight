class MainScene < GameScene

  draws :player, :star_generator, :score_board, :galaxy

  animate :galaxy, to: { alpha: 160 }, interval: 1.seconds

  event :on_up, KbEscape do
    transition_to :title
  end

  event :on_up, KbE do
    # TODO: this should instead transition to an edit scene of the current scene.
    # enable_edit_mode
    log.debug "Going to edit mode"
    transition_to self, with: :edit
  end

  def show
    player.warp Game.center
  end

  def update
    player.collect_stars star_generator.stars
    player.position = Point.new (player.x % Game.width), (player.y % Game.height)
    
  end

end