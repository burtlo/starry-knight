class TitleScene < Metro::Scene

  draws :title, :logo, :galaxy

  draw :menu, options: [ 'Start Game', 'Exit' ]

  animate :menu, to: { alpha: 255 }, interval: 1.second

  def start_game
    transition_to :title_transition
  end

  def exit
    window.close
  end

  # TODO: this is an event that needs to be defined globally within the game when in debug mode

  event :on_up, KbE do
    # TODO: this should instead transition to an edit scene of the current scene.
    # enable_edit_mode
    log.debug "Going to edit mode"
    transition_to self, with: :edit
  end

  event :on_up, KbR do |event|
    Metro.reload!
    transition_to self.class.scene_name
  end

  event :on_up, KbL do |event|
    log.debug "L #{event.modifier_keys}"
    log.debug "Going to Love Mode" if event.alt?
  end

end