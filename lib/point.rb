module Metro
  module Units

    class Point
      def to_vec2
        CP::Vec2.new x, y
      end
    end

  end
end
