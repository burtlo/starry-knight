class MainScene < GameScene

  draws :player, :star_generator, :star_collection_monitor, :score_board
  draws :background_space1, :background_space2, :galaxy

  event :on_up, KbEscape do
    transition_to :title
  end

  def show
    configure_star_collection_monitoring
    player.warp Game.center
  end

  def update
    player.position = Point.new (player.x % Game.width), (player.y % Game.height)
  end

  private

  def configure_star_collection_monitoring
    star_collection_monitor.player = player
    star_collection_monitor.star_generator = star_generator
  end

end

