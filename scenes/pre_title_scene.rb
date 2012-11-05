class PreTitleScene < GameScene

  draws :title, :logo, :star, :star2, :star3, :galaxy

  animate :logo, to: { y: 147, alpha: 50 }, interval: 2.seconds do
    animate :logo, to: { alpha: 255 }, interval: 1.second do
      transition_to :title
    end
  end

  animate :title, to: { alpha: 255 }, interval: 3.seconds

  event :on_up, KbEscape do
    transition_to :title
  end

end