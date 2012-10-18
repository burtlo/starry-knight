class TitleScene < Metro::Scene

  attr_reader :font
  attr_accessor :index

  def show
    window.caption = "Starry Knight"
  end

  def start_game
    transition_to :main
  end

  def exit_game
    window.close
  end

end