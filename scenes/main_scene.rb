class MainScene < GameScene
  draw :fps, model: "metro::ui::fps", placement: 'top'

  # This has to go first before the other things that depend on the space
  draw :space, model: "metro::ui::space"

  draws :player, :star_generator, :star_collection_monitor, :score_board
  draws :background_space1, :background_space2, :galaxy

  draw :story_01, position: (Game.center + Point.at(0,100,12))
  draw :story_02, position: (Game.center + Point.at(0,100,12))
  # draw :move_instruction, position: (Game.center + Point.at(0,100,12))
  # draw :steering_instruction, position: (Game.center + Point.at(0,100,12))

  draw :timer, position: Point.at(20,440,15), dimensions: Dimensions.of(600,20)

  # after 1.second do
  #   story_01.sample.play
  #   fade_in_and_out(:story_01) do
  #     after 1.second do
  #       story_02.sample.play
  #       fade_in_and_out(:story_02)
  #     end
  #   end
  # end

  # after 1.second do
  #   fade_in_and_out(:move_instruction) do
  #     after 2.seconds do
  #       fade_in_and_out(:steering_instruction)
  #     end
  #   end
  # end

  event :on_up, KbEscape do
    transition_to :title
  end

  def show
    configure_star_collection_monitoring
    space.add_object(player)
    player.warp Game.center.to_vec2
  end

  def update
    # player.position = Point.new (player.x % Game.width), (player.y % Game.height)
    player.validate_position
    # check to see if we have reached the required score for the level
    timer.current -= 0.1

    transition_to :game_over if timer.complete?

    space.step
    space.clean_up
  end

  private

  def configure_star_collection_monitoring
    star_collection_monitor.player = player
    star_collection_monitor.star_generator = star_generator
  end

end