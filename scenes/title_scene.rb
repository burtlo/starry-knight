class TitleScene < Metro::Scene

  draws :title, :logo, :menu

  def start_game
    transition_to :title_transition
  end

  def exit
    window.close
  end

end