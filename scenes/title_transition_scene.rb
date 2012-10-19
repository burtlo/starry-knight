class ScriptedPlayer

  attr_accessor :x, :y, :angle, :image

  def initialize window
    @x = @y = @angle = 0
    @image = Gosu::Image.new window, asset_path("player.png"), false
  end

  def warp(x,y)
    @x, @y = x, y
  end

  def shift(delta_x,delta_y)
    @x += delta_x
    @y += delta_y
  end
  
  def rotate(delta_degrees)
    @angle += delta_degrees
  end

  def draw
    image.draw_rot(x,y,1,angle)
  end

end

class TitleTransitionScene < Metro::Scene

  attr_reader :player

  def show
    @player = ScriptedPlayer.new window

    start_x, start_y = 540, 80
    final_x, final_y = Metro::Game.center

    distance = Gosu.distance(start_x,start_y,final_x,final_y)

    distance_x = final_x - start_x
    distance_y = final_y - start_y
    distance_rot = 1 * 360 * -1

    @update_x = distance_x / 80.0
    @update_y = distance_y / 80.0
    @update_rot = distance_rot / 80.0
    @update_count = 0

    player.warp start_x, start_y
  end

  def events(e)
    e.on_up Gosu::KbEscape do
      transition_to :title
    end
  end

  def update
    # spin hero
    # move the hero to the center
    if @update_count != 0
      player.shift(@update_x,@update_y)
      player.rotate(@update_rot)
    end
    # when hero has reached center transition to main scene

    transition_to :main if @update_count == 80.0

    @update_count += 1


  end

  def draw
    player.draw
  end

end