class StarGenerator < Metro::Model

  attr_accessor :stars

  def initialize
    @stars = []
  end

  def update
    if rand(100) < 5 and stars.size < 25
      star = generate_star
      star.window = window
      stars.push star
    end
  end

  def generate_star
    star = Star.new
    star.color = random_color_within_range(40,256)
    star.position = random_position
    star
  end

  def random_color_within_range(min,max)
    "rgba(#{rand_between(min,max)},#{rand_between(min,max)},#{rand_between(min,max)},1.0)"
  end

  def rand_between(min,max)
    rand(max-min) + min
  end
  
  def random_position
    Point.at (rand * Game.width), (rand * Game.height)
  end

  def draw
    stars.each do |star|
      star.draw
    end
  end
end