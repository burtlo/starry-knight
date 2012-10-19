class TitleScene < Metro::Scene

  def show
    window.caption = "Starry Knight"
  end

  def start_game
    transition_to :titletransition
  end

  def exit
    window.close
  end

end