class MainScene < GameScene

  draws :player, :star_generator, :score_board, :galaxy
  draws :background_space1, :background_space2

  event :on_up, KbEscape do
    transition_to :title
  end

  def show
    player.warp Game.center
  end

  def collect_stars!
    living_stars = star_generator.living_stars

    living_stars.find_all {|star| Gosu.distance(player.x, player.y, star.x, star.y) < 35 }.each do |star|
      star.collapse
      notification :star_collected
    end
  end

  def update
    collect_stars!
    player.position = Point.new (player.x % Game.width), (player.y % Game.height)
  end

end