class MainScene < Metro::Scene

  attr_reader :player, :star_generator

  def show
    @player = Player.new window
    player.warp *Metro::Game.center
    @star_generator = StarGenerator.new(window)
  end

  def events(e)
    e.on_hold Gosu::KbLeft, Gosu::GpLeft do |scene|
      player.turn_left
    end

    e.on_hold Gosu::KbRight, Gosu::GpRight do |scene|
      player.turn_right
    end

    e.on_hold Gosu::KbUp, Gosu::GpButton0 do |scene|
      player.accelerate
    end

    e.on_hold Gosu::KbEscape do |scene|
      transition_to :title
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
  end

end