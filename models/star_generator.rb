class StarGenerator

  attr_accessor :stars
  attr_reader :star_animation

  def initialize(window)
    @star_animation = Gosu::Image::load_tiles(window, asset_path("star.png"), 25, 25, false)
    @stars = []
  end

  def generate
    if rand(100) < 5 and stars.size < 25
      stars.push Star.new @star_animation
    end
  end
  
  def draw
    stars.each do |star|
      star.draw
    end
  end
end