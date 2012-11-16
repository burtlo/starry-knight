class StarCollectionMonitor < Metro::Model

  attr_accessor :player, :star_generator

  def update
    living_stars = star_generator.living_stars
    living_stars.find_all {|star| Gosu.distance(player.x, player.y, star.x, star.y) < 35 }.each do |star|
      
      star.collapse
      notification :star_collected
    end
  end

end