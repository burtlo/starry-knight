module CP
  class Vec2
    def self.parse(value)
      new *value.to_s.split(",",2).map(&:to_f)
    end
  end
end
