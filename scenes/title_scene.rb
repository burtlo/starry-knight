class TitleScene < GameScene

  draws :title, :logo, :galaxy

  draw :menu, options: [ 'Start Game', 'Exit' ]

  animate :menu, to: { alpha: 255 }, interval: 1.second

  play :theme, song: "title.ogg", volume: 0.2

  change :theme, to: { volume: 0.8 }, interval: 2.seconds

  event :on_up, KbP do |event|
    theme.pause
  end

  def start_game
    transition_to :title_transition
  end

  def exit
    window.close
  end

end