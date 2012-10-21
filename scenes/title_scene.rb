class TitleScene < Metro::Scene

  draws :title, :logo, :menu

  def show
    window.caption = "Starry Knight"
  end

  def start_game
    transition_to :title_transition
  end

  def exit
    window.close
  end

end