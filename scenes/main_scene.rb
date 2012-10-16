class MainScene < Scene

  attr_reader :player, :star_generator, :font

  def show
    caption = "Gosu Tutorial Game"
    @player = Player.new window
    player.warp *Misfits::Game.center

    @star_generator = StarGenerator.new(window)
    @font = Gosu::Font.new(window, Gosu::default_font_name, 20)
  end

  def update
    if window.button_down? Gosu::KbLeft or window.button_down? Gosu::GpLeft then
      player.turn_left
    end
    if window.button_down? Gosu::KbRight or window.button_down? Gosu::GpRight then
      player.turn_right
    end
    if window.button_down? Gosu::KbUp or window.button_down? Gosu::GpButton0 then
      player.accelerate
    end
    player.move
    player.collect_stars star_generator.stars

    star_generator.generate
  end

  def draw
    player.draw
    star_generator.draw
    font.draw("Score: #{player.score}", 10, 10, Misfits::Game::UI, 1.0, 1.0, 0xffffff00)
  end

end