class BackgroundSpace < Metro::UI::AnimatedSprite

  property :animation, path: "space.png",
    dimensions: "256,256", tileable: true, time_per_image: 50

end