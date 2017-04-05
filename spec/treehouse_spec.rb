require 'spec_helper'

describe Treehouse, ".configure" do
  it "yields the configuration" do
    Treehouse.configure do |config|
      config.url = "http://pants.com"
    end

    expect(Treehouse.configuration.url).to eq "http://pants.com"
  end
end

describe Treehouse, ".cookie" do
  it "returns its cookie when it is configured" do
    Treehouse.configure(cookie: "pants_cookie")
    expect(Treehouse.cookie).to eq "pants_cookie"
  end

  it "raises when the cookie is nil" do
    Treehouse.configure(cookie: nil)
    expect { Treehouse.cookie }.to raise_exception /not configured/i
  end
end

describe Treehouse, ".dummy?" do
  it "returns true when in dummy mode" do
    Treehouse.configure(dummy: true)
    expect(Treehouse.dummy?).to eq true
  end

  it "returns false when not in dummy mode" do
    Treehouse.configure(dummy: false)
    expect(Treehouse.dummy?).to eq false
  end

  it "returns false by default" do
    Treehouse.configure(dummy: nil)
    expect(Treehouse.dummy?).to eq false
  end
end

describe Treehouse, ".key" do
  it "returns its key when it is configured" do
    Treehouse.configure(key: "pants_key")
    expect(Treehouse.key).to eq "pants_key"
  end

  it "raises when the key is nil" do
    Treehouse.configure(key: nil)
    expect { Treehouse.key }.to raise_exception /not configured/i
  end
end

describe Treehouse, ".url" do
  it "returns its url when it is configured" do
    Treehouse.configure(url: "http://pants.com")
    expect(Treehouse.url).to eq "http://pants.com"
  end

  it "raises when the url is nil" do
    Treehouse.configure(url: nil)
    expect { Treehouse.url }.to raise_exception /not configured/i
  end
end

describe Treehouse, ".login_url" do
  it "returns a login url with the `site` parameter" do
    Treehouse.configure(url: "http://pants.com")
    expect(Treehouse.login_url("http://trousers.com/shorts")).to eq "http://pants.com/login?site=http://trousers.com/shorts"
  end
end

