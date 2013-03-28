class LightBeam < Metro::UI::AnimatedSprite

  property :animation, path: "beam-of-light.png",
    dimensions: "128,128", time_per_image: 100

  property :scale, default: Scale.to(2.5,2.5)
end