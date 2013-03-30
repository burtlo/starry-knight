class MainScene < GameScene

  draw :fps, model: "metro::ui::fps", placement: 'top'

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
    space.add_body player.body
    space.add_shape player.shape
    player.warp Game.center.to_vec2
  end

  def update
    # player.position = Point.new (player.x % Game.width), (player.y % Game.height)
    player.validate_position
    # check to see if we have reached the required score for the level
    # timer.current -= 1
    # puts "Game Over" if timer.current == 1

    space.step(delta)
    player.shape.body.reset_forces
  end

  def delta
    @delta ||= (1.0/60.0)
  end

  def space
    @space ||= begin
      s = CP::Space.new
      s.damping = 0.6
      s
    end
  end


  private

  def configure_star_collection_monitoring
    star_collection_monitor.player = player
    star_collection_monitor.star_generator = star_generator
  end

end