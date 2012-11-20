class StarGenerator < Metro::Model

  property :max_stars, default: 25
  property :percentage_chance_of_new_star, default: 5

  def stars
    @stars ||= []
  end

  def living_stars
    stars_in_state :living
  end

  def update
    if rand(100) < percentage_chance_of_new_star and stars.size < max_stars
      star = generate_star
      stars.push star
    end
    stars.reject! { |star| star.state == "dead" }
  end

  def draw
    stars.each { |star| star.draw }
  end

  private

  def stars_in_state(state)
    stars.find_all { |star| star.state == state.to_s }
  end

  def generate_star
    star = create "star"
    star.color = random_color_within_range(40,256)
    star.position = random_position
    star.show
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

end