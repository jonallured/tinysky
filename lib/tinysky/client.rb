module Tinysky
  class Client
    attr_reader :access_token, :did, :refresh_token

    def initialize(credentials, connection)
      @credentials = credentials
      @connection = connection

      @access_token = nil
      @did = nil
      @refresh_token = nil
    end

    def create_session
      response = @connection.post(CREATE_SESSION_PATH, @credentials.to_json)

      @did = response.body["did"]
      @access_token = Token.new(response.body["accessJwt"])
      @refresh_token = Token.new(response.body["refreshJwt"])

      response
    end
  end
end
