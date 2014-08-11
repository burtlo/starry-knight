class Star < Metro::Model

  property :position
  property :color
  property :scale, default: Scale.one

  def shape
    @shape ||= begin
      shape_array = [CP::Vec2.new(-24.0, -24.0), CP::Vec2.new(-24.0, 24.0),
        CP::Vec2.new(24.0, 24.0), CP::Vec2.new(24.0, -24.0)]
      new_shape = CP::Shape::Poly.new(body, shape_array, CP::Vec2.new(-32,32))
      new_shape.collision_type = :star
      new_shape.sensor = true
      new_shape
    end
  end

  def body
    @body ||= begin
      new_body = CP::Body.new(10,8)
      new_body.p = CP::Vec2.new(position.x,position.y)
      new_body.v = CP::Vec2.new(0.0,0.0)
      new_body.a = (3*Math::PI/2.0)
      new_body
    end
  end


  class Forming < Star
    property :animation, path: "implode.png", dimensions: "64,64", time_per_image: 25
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

  class Living < Star
    property :animation, path: "living.png", dimensions: "64,64", time_per_image: 100
    property :state, type: :text, default: "living"

    def image
      animation.image
    end

    def completed? ; false ; end

    def next
      create "Star::Collapsed"
    end

    def completed?
      false
    end
  end

  class Collapsed < Star
    property :animation, path: "explode.png", dimensions: "64,64", time_per_image: 25
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

  class Dead < Star
    property :state, type: :text, default: "dead"

    def image
      NoImage.new
    end

    def next
      # raise "The World Is Collpasing!"
      self
    end

    def completed?
      true
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

  def image
    current_state.image
  end

  def draw
    image.draw(body.p.x,body.p.y,z_order, x_factor, y_factor, color, :add)
    draw_bounding_box if debug?
  end

  def debug?
    false
  end

  def draw_bounding_box
    @bounding_box_border ||= create "metro::ui::border"
    @bounding_box_border.position = Point.at(position.x,shape.bb.t)
    @bounding_box_border.dimensions = Dimensions.of(shape.bb.r - shape.bb.l,shape.bb.b - shape.bb.t)
    @bounding_box_border.draw
  end

end