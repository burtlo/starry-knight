class Star < Metro::Model

  property :position
  property :color
  property :scale, default: Scale.one

  class Forming < Metro::Model
    property :animation, path: "implode.png", dimensions: Dimensions.of(64,64), time_per_image: 25
    property :state, type: :text, default: "forming"

    def image
      animation.image
    end

    def completed?
      animation.complete?
    end

    def next
      create "Star::Living"
    end
  end

  class Living < Metro::Model
    property :animation, path: "living.png", dimensions: Dimensions.of(64,64), time_per_image: 100
    property :state, type: :text, default: "living"

    def image
      animation.image
    end

    def next
      create "Star::Collapsed"
    end
  end

  class Collapsed < Metro::Model
    property :animation, path: "explode.png", dimensions: Dimensions.of(64,64), time_per_image: 25
    property :state, type: :text, default: "collapsed"

    def image
      animation.image
    end

    def completed?
      animation.complete?
    end

    def next
      create "Star::Dead"
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

  def show
    @state = create "Star::Forming"
  end

  def current_state
    @state.completed? ? @state = @state.next : @state
  end

  def state
    current_state.state
  end

  def collapse
    @state = @state.next if @state.state == "living"
  end

  include ImagePlacementHelpers

  def draw
    image = current_state.image
    image.draw(middle_x(image),middle_y(image), z_order, x_factor, y_factor, color, :add)
  end
end