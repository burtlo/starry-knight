class TitleScene < Metro::Scene

  draws :title, :logo, :galaxy

  draw :menu, options: [ 'Start Game', 'Exit' ]

  def show
    animate actor: galaxy, to: { alpha: 100 }, interval: 60
  end

  def start_game
    transition_to :title_transition
  end

  def exit
    window.close
  end

end