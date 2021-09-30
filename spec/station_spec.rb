require 'station'

describe Station do
  let(:paddington) { Station.new(:paddington, 2) }

  it "has a name" do
    expect(paddington.name).to eq(:paddington)
  end

  it "has a zone" do
    expect(paddington.zone).to eq(2)
  end
end
