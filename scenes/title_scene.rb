class TitleScene < Metro::Scene

  draws :title, :logo, :galaxy

  draw :menu, options: [ 'Start Game', 'Exit' ]

  animate :galaxy, to: { alpha: 100 }, interval: 1.second

  def start_game
    transition_to :title_transition
  end

  def exit
    window.close
  end

end