class Numeric
  def radians_to_vec2
    CP::Vec2.new(Math::cos(self), Math::sin(self))
  end

  def to_degrees
    self * 180 / Math::PI
  end

  def to_radians
    self * Math::PI / 180
  end

end

module CP
  class Vec2
    def self.parse(value)
      new *value.to_s.split(",",2).map(&:to_f)
    end
  end
end

module Metro
  module Units

    class Point
      def to_vec2
        CP::Vec2.new x, y
      end
    end

  end
end


module Metro
  class Model

    class BodyProperty < Property

      get do |value|
        default_body
      end

      get Hash do |value|
        mass = value[:mass].to_i
        moment_of_interia = value[:moment_of_interia].to_i
        position = CP::Vec2.parse(value[:position])
        velocity = CP::Vec2.parse(value[:velocity])
        angle = value[:angle].to_f * Math::PI/2.0

        body_with mass, moment_of_interia, position, velocity, angle
      end

      set CP::Body do |body|
        { mass: body.m, moment_of_interia: body.i,
          position: "#{body.p.x},#{body.p.y}",
          velocity: "#{body.v.x},#{body.v.y}",
          # TODO: This angle might very well be wrong
          angle: "#{body.a}" }
      end

      def default_body
        body_with default_mass, default_moment,
          default_position, default_velocity,
          default_angle
      end

      def default_mass
        options[:mass] || 10
      end

      def default_moment
        options[:moment_of_interia] || 10
      end

      def default_position
        options[:position] || CP::Vec2.new(0,0)
      end

      def default_velocity
        options[:velocity] || CP::Vec2.new(0,0)
      end

      def default_angle
        options[:angle] || 0
      end

      def body_with(mass,moment_of_interia,position,velocity,angle)
        body = CP::Body.new(mass,moment_of_interia)
        body.p = position
        body.v = velocity
        body.a = angle
        body
      end

    end

  end
end

module Metro
  class Model

    class ShapeProperty < Property

      get do |value|
        default_shape
      end

      def default_shape
        shape_with poly
      end

      def poly
        if options[:poly]
          rectangle_shape_array options[:poly]
        else
          default_poly
        end
      end

      def rectangle_shape_array(bounds)
        [ bounds.top_left.to_vec2, bounds.bottom_left.to_vec2, bounds.bottom_right.to_vec2, bounds.top_right.to_vec2 ]
      end

      def default_poly
        [ CP::Vec2.new(-28.0, -28.0), CP::Vec2.new(-28.0, 28.0), CP::Vec2.new(28.0, 28.0), CP::Vec2.new(28.0, -28.0)]
      end

      def shape_with(shape_poly)
        puts shape_poly
        new_shape = CP::Shape::Poly.new(model.body, shape_poly, CP::Vec2.new(0,0))
        new_shape.collision_type = :player
        new_shape
      end
    end
  end
end


class Player < Metro::UI::Sprite
  property :image, path: "player.png"

  property :turn_amount, default: 80
  property :velocity, default: 4000

  property :body
  property :shape, name: :player, poly: RectangleBounds.new(left: -28.0,right: 28.0,top: -28.0,bottom: 28.0)

  event :on_hold, KbLeft, GpLeft do
    body.t -= turn_amount
  end

  event :on_hold, KbRight, GpRight do
    body.t += turn_amount
  end

  event :on_hold, KbUp, GpButton0 do
    force = body.a.radians_to_vec2 * (velocity)
    relative_offset_from_center_of_gravity = CP::Vec2.new(0.0, 0.0)
    body.apply_force(force,relative_offset_from_center_of_gravity)
  end

  def validate_position
    l_position = CP::Vec2.new(body.p.x % Game.width, body.p.y % Game.height)
    body.p = l_position
  end


  def warp(point)
    body.p = point
  end

  def draw
    # puts body.v.to_s
    # dim = Dimensions.of(shape.bb.r - shape.bb.l,shape.bb.b - shape.bb.t)
    # border = create "metro::ui::border", position: Point.at(shape.bb.l,shape.bb.t), dimensions: dim
    # border.draw
    dangle = body.a.to_degrees
    image.draw_rot(body.p.x,body.p.y,2,dangle)
  end

end
