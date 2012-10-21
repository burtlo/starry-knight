class TitleScene < Metro::Scene

  draws :title, :logo

  draw :menu, options: [ 'Start Game', 'Exit' ]

  def start_game
    transition_to :title_transition
  end

  def exit
    window.close
  end

end