class Velocity < Struct.new(:x,:y,:z,:decay)

  def self.of(x,y,z=0,decay=0.95)
    new x, y, z, decay
  end

  def self.parse(string)
    of *string.split(",",4).map(&:to_f)
  end

  def decay!
    self.x *= decay
    self.y *= decay
  end

  def to_s
    "#{x},#{y},#{z},#{decay}"
  end

end