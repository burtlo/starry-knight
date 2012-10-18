class TitleScene < Metro::Scene

  def show
    window.caption = "Starry Knight"
  end

  def start_game
    transition_to :main
  end

  def exit
    window.close
  end

end