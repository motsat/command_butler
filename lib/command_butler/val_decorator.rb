module CommandButler
  class ValDecorator
    def self.decoration(vals:vals)
      res = " replace vals : "
      res += vals.to_s
      res
    end
  end
end
