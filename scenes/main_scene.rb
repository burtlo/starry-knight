class MainScene < Metro::Scene

  draws :player, :star_generator, :score, :galaxy

  animate actor: :galaxy, to: { alpha: 160 }, interval: 60

  def show
    player.warp *Metro::Game.center
  end
  
  event :on_hold, Gosu::KbLeft, Gosu::GpLeft do
    player.turn_left
  end
  
  event :on_hold, Gosu::KbRight, Gosu::GpRight do
    player.turn_right
  end

  event :on_hold, Gosu::KbUp, Gosu::GpButton0 do
    player.accelerate
  end

  event :on_up, Gosu::KbEscape do
    transition_to :title
  end

  def update
    player.move
    player.collect_stars star_generator.stars
    star_generator.generate
  end

  def draw ; end

end