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

  attr_reader :step_count

  def initialize(options)
    @step_count = 0

    options.each do |key,value|
      send :instance_variable_set, "@#{key}".to_sym, value
      puts "Defining Reader Method for #{key}"
      self.class.send :define_method, key do
        instance_variable_get("@#{key}")
      end
    end
    after_initialize
  end

  def completed?
    @step_count >= @animation_steps
  end

  def step!
    return if completed?
    @step_block.call
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

class ImplicitAnimation < Animation

  def after_initialize
    @animation_steps = interval

    distance_x = to[:x] - actor.x
    distance_y = to[:y] - actor.y
    distance_rot = to[:angle]

    @update_x = distance_x / interval
    @update_y = distance_y / interval
    @update_angle = distance_rot / interval

    step do
      actor.x = actor.x + @update_x
      actor.y = actor.y + @update_y
      actor.angle = actor.angle + @update_angle
    end

  end

end

class TitleTransitionScene < Metro::Scene

  attr_reader :player

  attr_reader :animations

  def prepare_transition_from(title_scene)
    logo = title_scene.view['logo']
    @start_x = logo['x']
    @start_y = logo['y']
  end

  def show
    @animations = []
    @player = ScriptedPlayer.new window
    player.warp @start_x, @start_y

    final_x, final_y = Metro::Game.center

    animation = ImplicitAnimation.new actor: player,
      to: { x: final_x, y: final_y, angle: -360.0 },
      interval: 80.0,
      scene: self,
      completed: lambda { |scene| transition_to :main }

    animations.push animation
  end

  def events(e)
    e.on_up Gosu::KbEscape do
      transition_to :main
    end
  end

  def update
    animations.each { |animation| animation.step! }
  end

  def draw
    player.draw
  end

end