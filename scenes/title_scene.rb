class TitleScene < GameScene

  draws :title, :logo, :galaxy

  draw :menu, options: [ 'Start Game', 'Exit' ]

  animate :menu, to: { alpha: 255 }, interval: 1.second

  def start_game
    transition_to :title_transition
  end

  def exit
    window.close
  end

end