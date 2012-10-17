class TitleScene < Metro::Scene

  attr_reader :font
  attr_accessor :index

  def options
    view["option"]["options"]
  end

  def show
    @index = 0
    @font = Gosu::Font.new(window, Gosu::default_font_name, 20)
  end

  def events(e)
    e.on_up Gosu::KbLeft, Gosu::GpLeft, Gosu::KbUp, Gosu::GpUp, do: :select_previous_item
    e.on_up Gosu::KbRight, Gosu::GpRight, Gosu::KbDown, Gosu::GpDown, do: :select_next_item
    e.on_up Gosu::KbEnter, Gosu::KbReturn, do: :exit_or_main
  end

  def exit_or_main
    if options[index] == 'Exit'
      exit_game
    else
      start_game
    end
  end

  def start_game
    window.scene = MainScene
  end

  def exit_game
    window.close
  end

  def select_previous_item
    @index = index - 1
    @index = options.length - 1 if @index <= -1
    options[index]
  end

  def select_next_item
    @index = index + 1
    @index = 0 if @index >= options.length
  end

  def draw
    options.each_with_index do |option,op_index|
      option_color = op_index == index ? 0xffffff00 : 0xffffffff
      font.draw option, view["option"]["x"], view["option"]["y"] + view["option"]["padding"] * op_index, Metro::Game::UI, 1.0, 1.0, option_color
    end
  end

end