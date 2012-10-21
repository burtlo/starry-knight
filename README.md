# Starry Knight

This is an example of a game built with [metro](https://github.com/burtlo/metro), a library that gives structure to [gosu](https://github.com/jlnr/gosu) (the 2D game development library in Ruby).

## Execution

```
git clone git://github.com/burtlo/starry-knight.git
cd starry-knight
bundle
bundle exec metro
```

### Description

This is a near duplicate of the tutorial that you create at the end of the [ruby tutorial for gosu](https://github.com/jlnr/gosu/wiki/Ruby-Tutorial). However, if you look at the structure of this project you will find distinct differences and that is because it is using [metro](https://github.com/burtlo/metro) to take care of a lot of the tedious coding tasks.

> NOTE: This state of the game, as is the Metro library, under active development, so it is possible that some of the information within this README is inaccurate and has not kept pace with the latest developments.

### Layout

The root file is the `metro` file which is a Ruby DSL that allows you to specify detail about the game.

```ruby
name "Starry Knight"
resolution 640, 480
first_scene :title
```

Here you can set the name of the game, the `resolution width, height`, and the scene to start the game.

#### Scenes

Scenes are different screens or stages within a game. Within this small game, it represents the "pre-title" animation, the title screen, the "title to game" animation. They are all located within the scenes directory and are subclasses of Scene.

Let's look at a few of the characteristics of the scenes:

#### Title Scene

The title scene is by far the simpliest to comprehend of the scenes. This is where the player can choose to start a game or exit.

![Title Scene](http://cloud.github.com/downloads/burtlo/starry-knight/title-screen-10-18-12.png)


```ruby
class TitleScene < Metro::Scene

  draws :title, :logo, :menu

  def start_game
    transition_to :title_transition
  end

  def exit
    window.close
  end

end
```

The `TitleScene` is a subclass of the `Metro::Scene`.

**draws** is a special method tells the scene you want to draw the 'title', 'logo', and the 'menu' throughout the scene. What those are is not explicitly clear at this moment and will require us to look at the game's models and views.

**start_game** uses a method called `transition_to` which is another special method to move from one scene to another scene. When the start_game method is called the game will move to the 'TitleTransitionScene'. All scenes have names and by default the name is based on the class name of the scene, though it can be overridden if desired.

**exit** references `window`, which is how you gain acess to the [Gosu::Window ](https://github.com/jlnr/gosu/blob/master/Gosu/Window.hpp) instance. Which may be necessary from time to time.

#### Title View (title.json)

Every scene has a view associated with it and by default it is based on the name of the scene, though that too can be overriden if desired. All views are located in the views directory and defined in either YAML or JSON format.

The title view is an example of a view defined in JSON:

```json
{
  "title" : {
    "model"    : "metro::models::label"
    "text"     : "STARRY KNIGHT",
    "x"        : 30,
    "y"        : 50,
    "z-order"  : 4,
    "x-factor" : 3,
    "y-factor" : 3,
    "color"    : "0xffffff00" },

  "logo" : {
    "model"   : "metro::models::image",
    "x"       : 540,
    "y"       : 80,
    "z-order" : 4,
    "color"   : "0xffffffff",
    "path"    : "player.png" },

  "menu" : {
    "model"   : "metro::models::menu",
    "x"       : 260,
    "y"       : 200,
    "z-order" : 5,
    "padding" : 40,
    "color"   : "0xff777777", "highlight-color" : "0xffffffff",
    "options" : [ "Start Game", "Exit" ] }
}
```

Metro tries to make it easier to build common output and interface components. Defined here is the title, logo and menu. Each element has some information about placement, z-ordering and colors.

The Scene's `draw` method specified these elements. The scene takes care of loading all the view related information from this file and then sets that data on a model. By default the model that is used is based on the name (e.g. 'title', 'logo', 'menu'). However, a model name can be provided (e.g. 'menu'). Metro even provides some simple models to assist with common tasks for creating labels, images, and menus.

The `metro::models::menu` model generates a menu which has two options: 'Start Game' and 'Exit'. The arrow keys and gamepad keys allow you navigate between the choices and the enter key or gamepad-0 key will select the currently highlighted one. The names of the options are mapped to the methods that we saw previously (downcasing and replacing all spaces with undescores). This convention makes it easy to make a simple menu of options and listen for the events from each of the events.

#### Main Scene

![Main Scene](http://cloud.github.com/downloads/burtlo/starry-knight/main-screen-10-18-12.png)

```ruby
class MainScene < Metro::Scene

  draws :player, :star_generator, :score

  def show
    player.warp *Metro::Game.center
  end

  def events(e)
    e.on_hold Gosu::KbLeft, Gosu::GpLeft do
      player.turn_left
    end

    e.on_hold Gosu::KbRight, Gosu::GpRight do
      player.turn_right
    end

    e.on_hold Gosu::KbUp, Gosu::GpButton0 do
      player.accelerate
    end

    e.on_up Gosu::KbEscape do
      transition_to :title
    end
  end

  def update
    player.move
    player.collect_stars star_generator.stars
    star_generator.generate
  end

  def draw ; end

end
```

For this scene we want to draw a player, a star generator, and the player's score. Opening the Main View (views/main.yml), you may notice only the score is defined.

```yaml
score:
  model: "metro::models::label"
  text: "Score: #{player.score}"
  x: 10
  y: 10
  z-order: 5
  color: 0xffffff00
```

That is because the player and the star generator are drawn by their models which are defined in the models directory.

**show** is the first event that the window sends to the scene. There we set the position of player to the center of the screen.

**events** is where we define all the user input events that we want to handle. This method is passed the `EventRelay` for the scene which you can prescribe keystrokes and gamepad events (on_up, on_down, on_hold) to an action.

**update** is called on every tick of the game loop. Here we update the position of the player, see if they are close enough to capture the stars, and generate any new stars.

**draw** is called after update on every tick. Though no specific drawing needs to be done as we have already registered to draw our player, star generator, and score label.