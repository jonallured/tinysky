module Tinysky
  class Token
    attr_reader :expires_at, :raw_value

    def initialize(raw_value)
      @raw_value = raw_value

      payload, _header = JWT.decode(raw_value, nil, false)
      @expires_at = Time.at(payload["exp"])
    end

    def expired?
      @expires_at < Time.now
    end
  end
end
