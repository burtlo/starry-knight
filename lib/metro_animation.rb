module Metro

  #
  # The animation is an wrapper object for an array of Gosu::Images that also contains
  # the additional information on the path, height, width, and tileability.
  #
  class Animation
    # def time_per_image
    #   @time_per_image ||= 50
    # end
    # 
    # def current_time
    #   Gosu::milliseconds
    # end
    # 
    # def current_image_index(start_time,time_per_image)
    #   ((current_time - start_time) / time_per_image) % images.size
    # end
    # 
    # #
    # # @return a Gosu::Image to be displayed in a animation sequence.
    # #
    # def image(options = {})
    #   start_time = options.fetch(:start_time,current_time)
    #   time_spent_per_image = options.fetch(:image_time,time_per_image)
    #   images[current_image_index(start_time,time_spent_per_image)]
    # end

  end
end
