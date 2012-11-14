class LightBeam < Metro::Model
  property :position
  property :animation, path: "beam-of-light.png",
    dimensions: Dimensions.of(128,128)
  property :color

  def show
    @start_time = Gosu::milliseconds
  end

  def middle_x(image)
    x - image.width / 2.0
  end

  def middle_y(image)
    y - image.height / 2.0
  end

  def draw
    image = animation.image(@start_time,100)
    image.draw(middle_x(image),middle_y(image), 1, 2.5, 2.5, color, :add)
  end
end

class TitleScene < GameScene

  draws :title, :logo, :galaxy, :background_space1, :background_space2

  draw :light_beam, position: "450,180,2", color: "rgba(255,255,255,0.0)"
  
  animate :light_beam, to: { alpha: 255 }, interval: 1.second

  draw :menu, options: [ 'Start Game', 'Exit' ]

  animate :menu, to: { alpha: 255 }, interval: 1.second

  play :theme, song: "title.ogg", volume: 0.2

  change :theme, to: { volume: 0.8 }, interval: 2.seconds

  event :on_up, KbP do |event|
    theme.pause
  end

  def start_game
    transition_to :title_transition
  end

  def exit
    window.close
  end

end