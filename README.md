# Starry Knight

This is an example of a game built with [metro](https://github.com/burtlo/metro), a library that gives structure to [gosu](https://github.com/jlnr/gosu) the 2D game development library in Ruby.

## Execution

```
git clone git://github.com/burtlo/starry-knight.git
cd starry-knight
bundle
bundle exec metro
```

### Description

This is a near duplicate of the tutorial that you create at the end of the [ruby tutorial for gosu](https://github.com/jlnr/gosu/wiki/Ruby-Tutorial). However, if you look at the structure of this project you will find distinct differences and that is because it is using [metro](https://github.com/burtlo/metro) to take care of a lot of the tedious coding tasks.

### Layout

The root file is the `metro` file which is a Ruby DSL that allows you to specify detail about the game.

> At the moment the options are limited to the `resolution` and the `first_scene`

```ruby
resolution 1024, 768

first_scene :title
```

#### Scenes

Scenes are different screens or stages within a game. Within this small game, it represents the title screen and the main game screen. They are all located within the scenes directory and are subclasses of Scene.

#### Title Scene

```ruby
class TitleScene < Metro::Scene

  def show
    window.caption = "Starry Knight"
  end

  def start_game
    transition_to :main
  end

  def exit
    window.close
  end

end
```

The `TitleScene` is a subclass of the `Metro::Scene`. There you are able to access the traditional [window](https://github.com/jlnr/gosu/blob/master/Gosu/Window.hpp) instance to set the caption when the scene is shown (by way of the `show` method).

A reference to `window` is also used to close the window when `exit` is called. `start_game` also has a special method `transitioned_to` which allows transition from one scene to the next scene. However, it is not immediately clear how `start_game` or `exit` are even called. To understand more we need to look at the view defined for Title Scene.

#### Views

A scene may have a view defined for it. If one is defined, by default it should match the prefix of the scene name (e.g. TitleScene : title.json). A template can be defined in YAML or JSON format.

#### Title View (title.json)

```json
{
  "title" : {
    "type"    : "label",
    "text"    : "STARRY KNIGHT",
    "x"       : 20,
    "x-factor": 5,
    "y-factor": 5,
    "y"       : 20,
    "z-order" : 4,
    "color"   : "0xffffff00" },

  "menu" : {
    "type" : "select",
    "x" : 100,
    "y" : 150,
    "z-order" : 5,
    "padding" : 40,
    "color"   : "0xffffffff", "selected-color" : "0xffff0000",
    "options" : [ "Start Game", "Exit" ] }
}
```

Metro tries to make it easier to build common output and interface components. Here the title screen has a title labell and menu of options. Each element has some information about placement, z-ordering and colors. As always, it is good to have this display logic removed from the codebase to allow for it to easily be manipulated and changed.

The `select` type generates a menu which has two options: 'Start Game' and 'Exit'. The arrow keys and gamepad keys allow you navigate between the choices and the enter key or gamepad 0 key will select the currently highlighted one. The names of the options are mapped to the methods that we saw previously (downcasing and replacing all spaces with undescores). This convention makes it easy to make a simple menu of options and listen for the events from each of the events.


#### Main Scene

```ruby
class MainScene < Metro::Scene

  attr_reader :player, :star_generator

  def show
    @player = Player.new window
    player.warp *Metro::Game.center
    @star_generator = StarGenerator.new(window)
  end

  def events(e)
    e.on_hold Gosu::KbLeft, Gosu::GpLeft do |scene|
      player.turn_left
    end

    e.on_hold Gosu::KbRight, Gosu::GpRight do |scene|
      player.turn_right
    end

    e.on_hold Gosu::KbUp, Gosu::GpButton0 do |scene|
      player.accelerate
    end

    e.on_hold Gosu::KbEscape do |scene|
      transition_to :title
    end
  end

  def update
    player.move
    player.collect_stars star_generator.stars
    star_generator.generate
  end

  def draw
    player.draw
    star_generator.draw
  end

end
```

This main scene is the a near copy of the results from completing the [ruby tutorial for gosu](https://github.com/jlnr/gosu/wiki/Ruby-Tutorial). The largest difference is the `evenets` method. This method receives an `EventRelay` which allows you to easily prescribe keystrokes and gamepad events (on_up, on_down, on_hold) to an action. 

This makes more declarative statements about the events you are interested in receiving, unifies all of the events (button_up, button_down, and button_down?) into similar declarations, and removes the excess noise that usually appears in `update`.

