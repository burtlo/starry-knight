class MainScene < Scene

  attr_reader :player, :star_generator, :font

  def show
    caption = "Gosu Tutorial Game"
    @player = Player.new window
    player.warp *Metro::Game.center

    @star_generator = StarGenerator.new(window)
    @font = Gosu::Font.new(window, Gosu::default_font_name, 20)
  end

  def events(e)
    e.on_down Gosu::KbLeft, Gosu::GpLeft do |scene|
      player.turn_left
    end

    e.on_down Gosu::KbRight, Gosu::GpRight do |scene|
      player.turn_right
    end

    e.on_down Gosu::KbUp, Gosu::GpButton0 do |scene|
      player.accelerate
    end
  end

  def update
    player.move
    player.collect_stars star_generator.stars
    star_generator.generate
  end

  def draw
    player.draw
    star_generator.draw
    font.draw("Score: #{player.score}", 10, 10, Metro::Game::UI, 1.0, 1.0, 0xffffff00)
  end

end