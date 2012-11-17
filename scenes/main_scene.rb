class MainScene < GameScene

  draws :player, :star_generator, :star_collection_monitor, :score_board
  draws :background_space1, :background_space2, :galaxy

  draw :move_instruction, position: (Game.center + Point.at(0,100,12))
  draw :steering_instruction, position: (Game.center + Point.at(0,100,12))
  
  after 1.second do
    fade_in_and_out(:move_instruction) do
      after 2.seconds do
        fade_in_and_out(:steering_instruction)
      end
    end
  end

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