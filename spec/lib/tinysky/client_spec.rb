describe Tinysky::Client do
  let(:credentials) { {app_password: "shhh", handle: "tinyskygem.bsky.social"} }
  let(:mock_connection) { double(:mock_connection) }

  let(:expires_at) { Time.at(Time.now.to_i + 100) }

  let(:mock_access_jwt) do
    payload = {"exp" => expires_at.to_i}
    JWT.encode(payload, nil, "none")
  end

  let(:mock_create_session_response) do
    mock_response_body = {"accessJwt" => mock_access_jwt}
    double(:mock_create_session_response, body: mock_response_body)
  end

  before do
    expect(Tinysky).to receive(:generate_connection).and_return(mock_connection)
  end

  it "starts off empty" do
    client = Tinysky::Client.new(credentials)
    expect(client.access_jwt).to eq nil
    expect(client.expires_at).to eq nil
  end

  it "can create a session" do
    client = Tinysky::Client.new(credentials)
    expected_body = {
      identifier: credentials[:handle],
      password: credentials[:app_password]
    }
    expect(mock_connection).to receive(:post).with(
      Tinysky::Endpoints::SERVER_CREATE_SESSION, expected_body
    ).and_return(mock_create_session_response)

    client.create_session

    expect(client.access_jwt).to eq mock_access_jwt
    expect(client.expires_at).to eq expires_at
  end

  it "can create a record" do
    client = Tinysky::Client.new(credentials)
    allow(mock_connection).to receive(:post).with(
      Tinysky::Endpoints::SERVER_CREATE_SESSION,
      anything
    ).and_return(mock_create_session_response)
    client.create_session

    expected_body = {
      collection: Tinysky::Lexicon::FEED_POST,
      record: {
        "$type" => Tinysky::Lexicon::FEED_POST,
        "langs" => ["en-US"],
        "text" => "hello world!",
        "createdAt" => anything
      },
      repo: credentials[:handle]
    }
    expected_headers = {
      "Authorization" => "Bearer #{mock_access_jwt}"
    }
    expect(mock_connection).to receive(:post).with(
      Tinysky::Endpoints::REPO_CREATE_RECORD,
      expected_body,
      expected_headers
    )

    client.create_record("hello world!")
  end
end
