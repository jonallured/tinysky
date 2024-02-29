require "faraday"
require "jwt"

require_relative "tinysky/version"
require_relative "tinysky/client"
require_relative "tinysky/token"

module Tinysky
  ROOT_URL = "https://bsky.social"

  CREATE_SESSION_PATH = "/xrpc/com.atproto.server.createSession"

  def self.connect(credentials)
    connection = generate_connection
    client = Client.new(credentials, connection)
    client.create_session
    client
  end

  def self.generate_connection
    headers = {
      "Accept" => "application/json",
      "Content-Type" => "application/json"
    }

    Faraday.new(url: ROOT_URL, headers: headers) do |f|
      f.adapter Faraday.default_adapter
      f.response :json
    end
  end
end
