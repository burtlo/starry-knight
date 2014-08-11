# module Metro
#   class Model

#     class BodyProperty < Property

#       get do |value|
#         default_body
#       end

#       get Hash do |value|
#         mass = value[:mass].to_i
#         moment_of_interia = value[:moment_of_interia].to_i
#         position = CP::Vec2.parse(value[:position])
#         velocity = CP::Vec2.parse(value[:velocity])
#         angle = value[:angle].to_f * Math::PI/2.0

#         body_with mass, moment_of_interia, position, velocity, angle
#       end

#       set CP::Body do |body|
#         { mass: body.m, moment_of_interia: body.i,
#           position: "#{body.p.x},#{body.p.y}",
#           velocity: "#{body.v.x},#{body.v.y}",
#           # TODO: This angle might very well be wrong
#           angle: "#{body.a}" }
#       end

#       def default_body
#         body_with default_mass, default_moment,
#           default_position, default_velocity,
#           default_angle
#       end

#       def default_mass
#         options[:mass] || 10
#       end

#       def default_moment
#         options[:moment_of_interia] || 10
#       end

#       def default_position
#         options[:position] || CP::Vec2.new(0,0)
#       end

#       def default_velocity
#         options[:velocity] || CP::Vec2.new(0,0)
#       end

#       def default_angle
#         options[:angle] || 0
#       end

#       def body_with(mass,moment_of_interia,position,velocity,angle)
#         body = CP::Body.new(mass,moment_of_interia)
#         body.p = position
#         body.v = velocity
#         body.a = angle
#         body
#       end

#     end

#   end
# end

# module Metro
#   class Model

#     class ShapeProperty < Property

#       get do |value|
#         default_shape
#       end

#       def default_shape
#         shape_with poly
#       end

#       def poly
#         if options[:poly]
#           rectangle_shape_array options[:poly]
#         else
#           default_poly
#         end
#       end

#       def rectangle_shape_array(bounds)
#         [ bounds.top_left.to_vec2, bounds.bottom_left.to_vec2, bounds.bottom_right.to_vec2, bounds.top_right.to_vec2 ]
#       end

#       def default_poly
#         [ CP::Vec2.new(-28.0, -28.0), CP::Vec2.new(-28.0, 28.0), CP::Vec2.new(28.0, 28.0), CP::Vec2.new(28.0, -28.0)]
#       end

#       def shape_with(shape_poly)
#         puts shape_poly
#         new_shape = CP::Shape::Poly.new(model.body, shape_poly, CP::Vec2.new(0,0))
#         new_shape.collision_type = :player
#         new_shape
#       end
#     end
#   end
# end
