class PreTitleScene < Metro::Scene

  draws :title, :logo, :star, :star2, :star3

  def show
    move_and_fade_in_logo
    title_fade_in
  end

  def events(e)
    e.on_up Gosu::KbEscape do
      transition_to :title
    end
  end

  def update ; end

  def draw ; end

  def move_and_fade_in_logo
    final_x, final_y = Metro::Game.center

    move_with_partial_fade = Metro::ImplicitAnimation.new actor: logo,
      to: { y: 80, alpha: 50 },
      interval: 120,
      context: self

    move_with_partial_fade.on_complete do

      full_fade_in = Metro::ImplicitAnimation.new actor: logo,
        to: { alpha: 255 },
        interval: 40,
        context: self

      full_fade_in.on_complete do
        transition_to :title
      end

      enqueue full_fade_in
    end

    enqueue move_with_partial_fade
  end

  def title_fade_in
    enqueue Metro::ImplicitAnimation.new actor: title,
      to: { alpha: 255 }, interval: 200
  end

end