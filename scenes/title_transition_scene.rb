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

class Animation

  def initialize(options)
    options.each do |key,value|
      send :instance_variable_set, "@#{key}".to_sym, value
      self.class.send :define_method, key do
        instance_variable_get("@#{key}")
      end
    end
  end

  def completed?
    @step_count >= @animation_steps
  end

  def step!
    scene.instance_eval(&@step_block)
    @step_count = @step_count + 1
    scene.instance_eval(&@completed) if completed?
  end

  def step(&block)
    @step_block = block if block
  end

  def completed(&block)
    @completed = block if block
  end

end

class TitleTransitionScene < Metro::Scene

  attr_reader :player

  def prepare_transition_from(title_scene)
    logo = title_scene.view['logo']
    @start_x = logo['x']
    @start_y = logo['y']
  end

  def show
    @player = ScriptedPlayer.new window
    player.warp @start_x, @start_y

    final_x, final_y = Metro::Game.center

    move_player to: { x: final_x, y: final_y, angle: -360.0 }, interval: 80.0
  end

  def move_player(data)
    distance_x = data[:to][:x] - player.x
    distance_y = data[:to][:y] - player.y
    distance_rot = data[:to][:angle]

    update_x = distance_x / data[:interval]
    update_y = distance_y / data[:interval]
    update_rot = distance_rot / data[:interval]
    step_count = 0

    @animation = Animation.new update_x: update_x,
      update_y: update_y,
      update_rot: update_rot,
      step_count: step_count,
      animation_steps: data[:interval],
      scene: self

    @animation.step do
      player.shift(update_x,update_y)
      player.rotate(update_rot)
    end

    @animation.completed do
      transition_to :main
    end

  end

  def events(e)
    e.on_up Gosu::KbEscape do
      transition_to :main
    end
  end

  def update
    @animation.step!
  end

  def draw
    player.draw
  end

end