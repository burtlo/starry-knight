class MainScene < Metro::Scene

  draws :player, :star_generator, :score_board, :galaxy

  animate :galaxy, to: { alpha: 160 }, interval: 1.seconds

  event :on_up, Gosu::KbEscape do
    transition_to :title
  end

  def show
    player.warp *Metro::Game.center
  end

  def update
    player.move
    player.collect_stars star_generator.stars
    star_generator.generate
  end

  def draw ; end

end