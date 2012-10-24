class PreTitleScene < Metro::Scene

  draws :title, :logo, :star, :star2, :star3

  animate actor: :logo, to: { y: 80, alpha: 50 }, interval: 120 do
    animate actor: :logo, to: { alpha: 255 }, interval: 40 do
      transition_to :title
    end
  end

  animate actor: :title, to: { alpha: 255 }, interval: 160

  event :on_up, Gosu::KbEscape do
    transition_to :title
  end

  def update ; end

  def draw ; end

end