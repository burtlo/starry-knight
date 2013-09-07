class StarCollectionMonitor < Metro::Model

  attr_accessor :player, :star_generator

  def show
    scene.space.collision_between(:player, :star) do |ship, star_shape|
      star_collected(star_shape)
    end

    scene.space.collision_between(:star, :star, &nil)
  end

  def star_collected(shape)
    found_stars = star_generator.living_stars.find_all do |star|
      star.shape == shape
    end

    found_stars.each do |star|
      star.collapse
      scene.space.remove_object(star)
      notification :star_collected
    end
  end

  def update
    return unless player and star_generator
  end

end