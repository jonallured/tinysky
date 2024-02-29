describe Tinysky::Token do
  it "retains the raw value and decodes the exp claim" do
    future = Time.at(Time.now.to_i + 1000)
    payload = {"exp" => future.to_i}
    raw_value = JWT.encode(payload, nil, "none")
    token = Tinysky::Token.new(raw_value)
    expect(token.raw_value).to eq raw_value
    expect(token.expires_at).to eq future
    expect(token.expired?).to eq false
  end

  it "knows when it has expired" do
    future = Time.at(Time.now.to_i - 1000)
    payload = {"exp" => future.to_i}
    raw_value = JWT.encode(payload, nil, "none")
    token = Tinysky::Token.new(raw_value)
    expect(token.expired?).to eq true
  end
end
