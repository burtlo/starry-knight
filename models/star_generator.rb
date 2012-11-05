class StarGenerator < Metro::Model

  attr_accessor :stars

  def initialize
    @stars = []
  end

  def update
    if rand(100) < 5 and stars.size < 25
      star = Star.new
      star.window = window
      stars.push star
    end
  end

  def draw
    stars.each do |star|
      star.draw
    end
  end
end