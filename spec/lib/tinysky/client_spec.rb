describe Tinysky::Client do
  let(:credentials) { {identifier: "tinyskygem.bsky.social", password: "shhh"} }
  let(:mock_connection) { double(:mock_connection) }

  it "starts off empty" do
    client = Tinysky::Client.new(credentials, mock_connection)
    expect(client.did).to eq nil
    expect(client.access_token).to eq nil
    expect(client.refresh_token).to eq nil
  end

  it "can create a session" do
    payload = {"exp" => 123}
    mock_access_jwt = JWT.encode(payload, nil, "none")
    mock_refresh_jwt = JWT.encode(payload, nil, "none")
    mock_response_body = {
      "did" => "did:plc:abc123",
      "accessJwt" => mock_access_jwt,
      "refreshJwt" => mock_refresh_jwt
    }
    mock_create_session_response = double(:mock_create_session_response, body: mock_response_body)
    expect(mock_connection).to receive(:post).with(
      Tinysky::CREATE_SESSION_PATH,
      credentials.to_json
    ).and_return(mock_create_session_response)
    client = Tinysky::Client.new(credentials, mock_connection)
    client.create_session
    expect(client.did).to eq "did:plc:abc123"
    expect(client.access_token.raw_value).to eq mock_access_jwt
    expect(client.refresh_token.raw_value).to eq mock_refresh_jwt
  end
end
