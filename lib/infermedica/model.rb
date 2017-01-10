module Infermedica

  # = Model
  # Common methods used by other classes

  module Model

    # Common way to initialize an object from an Hash

    def initialize(h)
      h.keys.each do |k|
        instance_variable_set(:"@#{k}", h[k])
      end
    end
  end
end
