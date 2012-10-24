class TitleScene < Metro::Scene

  draws :title, :logo, :galaxy

  draw :menu, options: [ 'Start Game', 'Exit' ]

  animate actor: :galaxy, to: { alpha: 100 }, interval: 60

  def start_game
    transition_to :title_transition
  end

  def exit
    window.close
  end

end