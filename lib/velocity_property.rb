require_or_load 'lib/velocity'

class VelocityProperty < Metro::Model::Property

  get do |value|
    default_velocity
  end

  get String do |value|
    Velocity.parse(value)
  end

  set do |value|
    default_velocity.to_s
  end

  set Velocity do |vel|
    vel.to_s
  end

  set String do |value|
    value
  end

  def default_velocity
    options[:default] || Velocity.of(0,0,0,0.95)
  end

end