require "faraday"
require "jwt"

require_relative "tinysky/version"
require_relative "tinysky/client"

module Tinysky
  ROOT_URL = "https://bsky.social"

  CREATE_RECORD_PATH = "/xrpc/com.atproto.repo.createRecord"
  CREATE_SESSION_PATH = "/xrpc/com.atproto.server.createSession"

  POST_LEXICON_TYPE = "app.bsky.feed.post"

  def self.generate_connection
    Faraday.new(url: ROOT_URL) do |f|
      f.request :json
      f.response :json
    end
  end
end
