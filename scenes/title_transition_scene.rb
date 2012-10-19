class ScriptedPlayer

  attr_accessor :x, :y, :angle

  attr_accessor :window

  def initialize
    @x = @y = @angle = 0
  end

  def image
    @image ||= Gosu::Image.new window, asset_path("player.png"), false
  end

  def warp(x,y)
    @x, @y = x, y
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

    if respond_to? :step_block
      scene.instance_eval(&step_block)
    else
      @step_block.call
    end

    @step_count = @step_count + 1

    if completed?
      if respond_to? :completed
        scene.instance_eval(&completed)
      else
        @completed.call
      end
    end
  end

  def step(&block)
    @step_block = block if block
  end

  def completed(&block)
    @completed = block if block
  end

end

class ImplicitAnimation < Animation

  attr_reader :deltas

  def after_initialize
    @deltas = {}
    @animation_steps = interval

    to.each do |attribute,final|
      delta = final - actor.send(attribute)
      deltas[attribute] = delta / interval
    end

    step do
      deltas.each do |attribute,delta_per_interval|
        updated_value = actor.send(attribute) + delta_per_interval
        actor.send("#{attribute}=",updated_value)
      end
    end
  end

end

class TitleTransitionScene < Metro::Scene

  attr_reader :player

  attr_reader :animations

  def initialize
    @animations = []
  end

  def prepare_transition_from(title_scene)
    logo = title_scene.view['logo']
    @player = ScriptedPlayer.new
    player.warp logo['x'], logo['y']
  end

  def show
    player.window = window
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