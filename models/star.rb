class Star < Metro::Model

  property :position
  property :color

  class Forming < Metro::Model
    property :animation, path: "implode.png", dimensions: Dimensions.of(64,64)
    property :state, type: :text, default: "forming"

    def after_initialize
      @start_time = Gosu::milliseconds
    end

    def completed?
      (Gosu::milliseconds - @start_time) > 800
    end

    def next
      l = Living.new
      l.window = window
      l
    end

    def image
      animation.image(@start_time)
    end

  end

  class Living < Metro::Model
    property :animation, path: "star3.png", dimensions: Dimensions.of(64,64)
    property :state, type: :text, default: "living"

    def after_initialize
      @start_time = Gosu::milliseconds
    end

    def next
      c = Collapsed.new
      c.window = window
      c
    end
    
    def image
      animation.image(@start_time)
    end
    
  end

  class Collapsed < Metro::Model
    property :animation, path: "star-pickup.png", dimensions: Dimensions.of(64,64)
    property :state, type: :text, default: "collapsed"

    def after_initialize
      @start_time = Gosu::milliseconds
    end

    def completed?
      (Gosu::milliseconds - @start_time) > 1500
    end

    def next
      Dead.new
    end

    def image
      animation.image(@start_time)
    end

  end

  class Dead < Metro::Model
    property :state, type: :text, default: "dead"

    class NoImage
      def draw(*args) ; end
      def width ; 1 ; end
      def height ; 1 ; end
    end

    def image
      NoImage.new
    end

    def next
      raise "The World Is Collpasing!"
    end

  end

  def middle_x(image)
    x - image.width / 2.0
  end

  def middle_y(image)
    y - image.height / 2.0
  end

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