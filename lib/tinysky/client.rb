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

      response = @connection.post(CREATE_SESSION_PATH, body)

      @access_jwt = response.body["accessJwt"]
      payload, _header = JWT.decode(@access_jwt, nil, false)
      @expires_at = Time.at(payload["exp"])

      response
    end

    def create_record(text)
      create_session if expired_token?

      record = {
        "$type" => POST_LEXICON_TYPE,
        "createdAt" => DateTime.now.iso8601,
        "langs" => ["en-US"],
        "text" => text
      }

      body = {
        collection: POST_LEXICON_TYPE,
        record: record,
        repo: @credentials[:handle]
      }

      headers = {"Authorization" => "Bearer #{@access_jwt}"}

      @connection.post(CREATE_RECORD_PATH, body, headers)
    end

    private

    def expired_token?
      return true unless @expires_at

      @expires_at < Time.now
    end
  end
end
