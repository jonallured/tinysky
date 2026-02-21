require "faraday"
require "jwt"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.setup

module Tinysky
  ROOT_URL = "https://bsky.social"

  def self.generate_connection
    Faraday.new(url: ROOT_URL) do |f|
      f.request :json
      f.response :json
    end
  end
end
