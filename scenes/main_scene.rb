class MainScene < Metro::Scene

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

  event :on_up, KbR do
    Metro.reload!
    transition_to self.class.scene_name
  end

  def show
    player.warp *Game.center
  end

  def update
    player.move
    player.collect_stars star_generator.stars
    star_generator.generate
  end

end