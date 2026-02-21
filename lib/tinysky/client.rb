module Tinysky
  class Client
    attr_reader :access_jwt, :expires_at

    def initialize(credentials)
      @credentials = credentials
      @connection = Tinysky.generate_connection

      @access_jwt = nil
      @expires_at = nil
    end

    def create_session
      body = {
        identifier: @credentials[:handle],
        password: @credentials[:app_password]
      }

      path = Tinysky::Endpoints::SERVER_CREATE_SESSION
      response = @connection.post(path, body)

      @access_jwt = response.body["accessJwt"]
      payload, _header = JWT.decode(@access_jwt, nil, false)
      @expires_at = Time.at(payload["exp"])

      response
    end

    def create_record(text)
      create_session if expired_token?

      feed_post = FeedPost.new(text)

      body = {
        collection: Tinysky::Lexicon::FEED_POST,
        record: feed_post.to_hash,
        repo: @credentials[:handle]
      }

      headers = {"Authorization" => "Bearer #{@access_jwt}"}

      path = Tinysky::Endpoints::REPO_CREATE_RECORD
      @connection.post(path, body, headers)
    end

    private

    def expired_token?
      return true unless @expires_at

      @expires_at < Time.now
    end
  end
end
