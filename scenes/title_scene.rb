class TitleScene < Metro::Scene

  draws :title, :logo, :galaxy

  draw :menu, options: [ 'Start Game', 'Exit' ]

  animate :galaxy, to: { alpha: 100 }, interval: 1.second

  def start_game
    transition_to :title_transition
  end

  def exit
    window.close
  end


  # this is an event that needs to be defined globally within the game when in debug mode

  event :on_up, KbE do
    # this should instead transition to an edit scene of the current scene.
    enable_edit_mode
  end
  
  def enable_edit_mode
    window.cursor = true
  end

  event :on_down, MsLeft do |event|
    puts "Looking for targets at #{event.mouse_x},#{event.mouse_y}"

    hit_drawers = drawers_at(event.mouse_x,event.mouse_y)

    @selected_drawers = hit_drawers
    @last_event = event
    # if the click is within the bounding box of an on screen item
    # then we want to add that item to the list of items that are going to be dragged
    # We also need to make sure we maintain the offset that we selected them at.
  end

  event :on_hold, MsLeft do |event|
    # puts "Dragging targets to #{event.mouse_x},#{event.mouse_y}"

    offset_x = event.mouse_x - @last_event.mouse_x
    offset_y = event.mouse_y - @last_event.mouse_y

    # puts "Offset: #{offset_x},#{offset_xset_y}"
    @selected_drawers.each do |d|
      d.offset(offset_x,offset_y)
    end

    @last_event = event

  end

  event :on_up, MsLeft do |event|
    puts "Releasing targets at #{event.mouse_x},#{event.mouse_y}"

    # maybe snapping to a grid or rounding their location
    offset_x = event.mouse_x - @last_event.mouse_x
    offset_y = event.mouse_y - @last_event.mouse_y

    @selected_drawers.each do |d|
      d.offset(offset_x,offset_y)
    end

    @selected_drawers = []
    @last_event = event

  end

  def drawers_at(x,y)
    hit_drawers = drawers.find_all do |drawer|
      # where x and y is within the bounds of the drawer
      drawer.contains?(x,y)
    end
    
    puts "Found: #{hit_drawers}"
    # Filter on z-order
    top_drawer = hit_drawers.inject(hit_drawers.first) {|top,drawer| drawer.z_order > top.z_order ? drawer : top }
    [ top_drawer ].compact
  end

  event :on_up, KbS do
    save
  end
  
  def save
    puts "Saving"
    save_view
  end

end

class Bounds

  attr_reader :min_x, :min_y, :max_x, :max_y

  def initialize(min_x,min_y,max_x,max_y)
    @min_x = min_x
    @min_y = min_y
    @max_x = max_x
    @max_y = max_y
  end

  def contains?(x,y)
    x > min_x and x < max_x and y > min_y and y < max_y
  end
  
  def to_s
    "(#{min_x},#{min_y}) to (#{max_x},#{max_y})"
  end

end

class Metro::Models::Label

  def contains?(x,y)
    bounds.contains?(x,y)
  end
  
  def bounds
    Bounds.new x, y, x + width, y + height
  end
  
  def width
    font.text_width(text) * x_factor
  end
  
  def height
    font.height * y_factor
  end

end

class Metro::Models::Menu
  
  def contains?(x,y)
    bounds.contains?(x,y)
  end
  
  def bounds
    Bounds.new x, y, x + width, y + height
  end
  
  def width
    font.text_width(longest_option_text)# * x_factor
  end
  
  def longest_option_text
    longest = options.map {|opt| opt }.inject("") {|longest,opt| opt.length > longest.length ? opt : longest }
  end
  
  def height
    # options.length * font.height * y_factor + (options.length - 1) * padding
    options.length * font.height + (options.length - 1) * padding
  end
  
end

class Metro::Models::Image
  
  def contains?(x,y)
    bounds.contains?(x,y)
  end
  
  def bounds
    Bounds.new x - (width * center_x), y - (height * center_y), x + (width * center_x), y + (height * center_y)
  end

  def width
    image.width
  end
  
  def height
    image.height
  end
  
end

module Metro::SceneView
  
  def save_view
    parser = _view_parsers.find { |parser| parser.exists? self.class.view_name }
    parser.write(self)
  end
  
end

class Metro::Model

  def offset(x,y)
    self.x += x
    self.y += y
  end

  def to_hash
    data_export = @_loaded_options.map {|option| [ option, send(option) ] }
    pure_data = data_export.reject {|item| item.first == "name" }
    # puts "Pure: #{pure_data}"
    pure_data_hash = pure_data.inject({}) {|hash,elem| hash[elem.first] = elem.last ; hash }
    json_hash = { name => pure_data_hash }
    # puts "Data: #{json_hash}"
    json_hash
  end
  
  def to_json
    to_hash.to_json
  end

end

class Metro::Window

  attr_accessor :cursor

  alias_method :needs_cursor?, :cursor

  def mouse_position
    [ mouse_x, mouse_y ]
  end

end

class Metro::SceneView::JSONView
  
  def self.write(scene)
    puts "Writing Scene"
    drawn = scene.drawers.inject({}) do |hash,drawer|
      drawer_hash = drawer.to_hash
      hash.merge drawer_hash
    end
    
    File.write(self.json_view_name(scene.class.view_name),drawn.to_json)
  end
  
end