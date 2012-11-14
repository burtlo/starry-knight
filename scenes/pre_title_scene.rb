class PreTitleScene < GameScene

  draws :title, :logo, :galaxy, :background_space1, :background_space2

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