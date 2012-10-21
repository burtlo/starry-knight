class MainScene < Metro::Scene

  draws :player, :star_generator, :score

  def show
    player.warp *Metro::Game.center
  end

  def events(e)
    e.on_hold Gosu::KbLeft, Gosu::GpLeft do
      player.turn_left
    end

    e.on_hold Gosu::KbRight, Gosu::GpRight do
      player.turn_right
    end

    e.on_hold Gosu::KbUp, Gosu::GpButton0 do
      player.accelerate
    end

    e.on_up Gosu::KbEscape do
      transition_to :title
    end
  end

  def update
    player.move
    player.collect_stars star_generator.stars
    star_generator.generate
  end

  def draw ; end

end