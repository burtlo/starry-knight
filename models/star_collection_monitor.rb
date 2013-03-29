class StarCollectionMonitor < Metro::Model

  attr_accessor :player, :star_generator

  def show
    scene.space.add_collision_func(:player, :star) do |ship, star_shape|
      star_collected(star_shape)
    end

    scene.space.add_collision_func(:star, :star, &nil)
  end

  def star_collected(shape)
    found_stars = star_generator.living_stars.find_all do |star|
      star.shape == shape
    end

    found_stars.each do |star|
      star.collapse
      scene.space.remove_body(star.body)
      scene.space.remove_shape(star.shape)
      notification :star_collected
    end
  end

  def update
    return unless player and star_generator

    # living_stars = star_generator.living_stars
    # living_stars.find_all {|star| Gosu.distance(player.x, player.y, star.x, star.y) < 35 }.each do |star|

    #   star.collapse
    #   notification :star_collected
    # end
  end

end