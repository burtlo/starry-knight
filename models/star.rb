class Star < Metro::Model

  property :position
  property :color

  class Forming < Metro::Model
    property :animation, path: "implode.png", dimensions: Dimensions.of(64,64)
    property :state, type: :text, default: "forming"

    def start_time
      @start_time ||= Gosu::milliseconds
    end

    def current_time
      Gosu::milliseconds
    end

    def lifetime
      800
    end
    
    def completed?
      (current_time - start_time) > lifetime
    end

    def next
      l = Living.new
      l.window = window
      l
    end

    def image
      animation.image(start_time: start_time, image_time: 50)
    end

  end

  class Living < Metro::Model
    property :animation, path: "star3.png", dimensions: Dimensions.of(64,64)
    property :state, type: :text, default: "living"

    def next
      c = Collapsed.new
      c.window = window
      c
    end
    
    def start_time
      @start_time ||= Gosu::milliseconds
    end

    def image
      animation.image(start_time: start_time, image_time: 50)
    end
    
  end

  class Collapsed < Metro::Model
    property :animation, path: "star-pickup.png", dimensions: Dimensions.of(64,64)
    property :state, type: :text, default: "collapsed"

    def start_time
      @start_time ||= Gosu::milliseconds
    end

    def current_time
      Gosu::milliseconds
    end

    def lifetime
      750
    end

    def completed?
      (current_time - start_time) > lifetime
    end

    def next_state
      Dead
    end

    def next
      next_state.new
    end

    def image
      animation.image(start_time: start_time, image_time: 25)
    end

  end

  class Dead < Metro::Model
    property :state, type: :text, default: "dead"

    def image
      NoImage.new
    end

    def next
      raise "The World Is Collpasing!"
    end

  end

  include ModelWithAnimation

  def show
    f = Forming.new
    f.window = window
    @state = f
  end

  def current_state
    @state = @state.next if @state.completed?
    @state
  end

  def state
    current_state.state
  end

  def collapse
    @state = @state.next if state == "living"
  end

  def draw
    image = current_state.image
    image.draw(middle_x(image),middle_y(image), 1, 1, 1, color, :add)
  end
end