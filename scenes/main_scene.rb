class MainScene < Metro::Scene

  draws :player, :star_generator, :score, :galaxy

  animate actor: :galaxy, to: { alpha: 160 }, interval: 60

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