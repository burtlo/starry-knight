require 'gosu'

module Game
  extend self
  Background, Stars, Players, UI = *0..3
  Width, Height = 640, 480

  def center
    [ Width / 2 , Height / 2 ]
  end

end

class StarGenerator

  attr_accessor :stars
  attr_reader :star_animation

  def initialize(window)
    @star_animation = Gosu::Image::load_tiles(window, "star.png", 25, 25, false)
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

class GameWindow < Gosu::Window

  attr_reader :background_image, :player, :stars

  def initialize
    super Game::Width, Game::Height, false
    caption = "Gosu Tutorial Game"

    # @background_image = Gosu::Image.new self, "8bit.png", true

    @player = Player.new self
    player.warp *Game.center

    @star_generator = StarGenerator.new(self)
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
  end


  def update
    if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft then
      player.turn_left
    end
    if button_down? Gosu::KbRight or button_down? Gosu::GpRight then
      player.turn_right
    end
    if button_down? Gosu::KbUp or button_down? Gosu::GpButton0 then
      player.accelerate
    end
    player.move
    player.collect_stars @star_generator.stars

    @star_generator.generate

  end

  def draw
    # background_image.draw 0, 0, 0
    player.draw
    @star_generator.draw
    @font.draw("Score: #{@player.score}", 10, 10, Game::UI, 1.0, 1.0, 0xffffff00)
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end

end

class Player

  attr_reader :x, :y, :angle, :image, :score

  def initialize(window)
    @x = @y = @vel_x = @vel_y = @angle = @score = 0
    @image = Gosu::Image.new window,"player.png", false
  end

  def warp(x,y)
    @x, @y = x, y
  end

  def turn_left
    @angle -= 4.5
  end

  def turn_right
    @angle += 4.5
  end

  def accelerate
    @vel_x += Gosu::offset_x(angle,0.5)
    @vel_y += Gosu::offset_y(angle,0.5)
  end

  def move
    @x += @vel_x
    @y += @vel_y
    @x %= Game::Width
    @y %= Game::Height

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def collect_stars(stars)
    if stars.reject! {|star| Gosu::distance(x, y, star.x, star.y) < 35 }
      @score += 1
    end
  end

  def draw
    image.draw_rot(x,y,1,angle)
  end

end

class Star
  attr_reader :x, :y, :animation, :color

  def initialize(animation)
    @animation = animation
    @color = Gosu::Color.new(0xff000000)
    @color.red = rand(256-40) + 40
    @color.green = rand(256-40) + 40
    @color.blue = rand(256-40) + 40
    @x = rand * Game::Width
    @y = rand * Game::Height
  end

  def draw
    img = animation[Gosu::milliseconds / 100 % animation.size ]
    img.draw(x - img.width / 2.0, y - img.height / 2.0, Game::Stars, 1, 1, color, :add)
  end
end

window = GameWindow.new
window.show