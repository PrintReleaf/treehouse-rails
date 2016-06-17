require 'spec_helper'

describe Treehouse::Session, "#current_login" do
  let(:env) { double }
  let(:login) { double }
  let(:session) { Treehouse::Session.new(env) }

  before do
    allow(session).to receive(:login_id).and_return("pants_id")
    allow(session).to receive(:login_email).and_return("pants_email")
    allow(Treehouse::Login).to receive(:new).with("pants_id", "pants_email").and_return(login)
  end

  it "returns a Treehouse::Login for the login_id and login_email" do
    expect(session.current_login).to eq login
  end

  it "returns nil when the login_id is blank" do
    allow(session).to receive(:login_id).and_return(nil)
    expect(session.current_login).to eq nil
    allow(session).to receive(:login_id).and_return("")
    expect(session.current_login).to eq nil
  end

  it "returns nil when the login_email is blank" do
    allow(session).to receive(:login_email).and_return(nil)
    expect(session.current_login).to eq nil
    allow(session).to receive(:login_email).and_return("")
    expect(session.current_login).to eq nil
  end

  it "returns a dummy login when dummy is enabled" do
    allow(Treehouse).to receive(:dummy?).and_return(true)
    dummy_login = double
    allow(Treehouse::Login).to receive(:dummy).and_return(dummy_login)
    expect(session.current_login).to eq dummy_login
  end
end

describe Treehouse::Session, "#logged_in?" do
  let(:env) { double }
  let(:session) { Treehouse::Session.new(env) }

  it "returns true when the current_login is not nil" do
    login = double
    allow(session).to receive(:current_login).and_return(login)
    expect(session.logged_in?).to eq true
  end

  it "returns false when the current_login is nil" do
    allow(session).to receive(:current_login).and_return(nil)
    expect(session.logged_in?).to eq false
  end
end

describe Treehouse::Session, "#login_id" do
  let(:env) { double }
  let(:session) { Treehouse::Session.new(env) }

  it "returns the treehouse_login_id key from the cookie" do
    allow(session).to receive(:cookie).and_return({"treehouse_login_id" => "pants_id"})
    expect(session.login_id).to eq "pants_id"
  end
end

describe Treehouse::Session, "#login_email" do
  let(:env) { double }
  let(:session) { Treehouse::Session.new(env) }

  it "returns the treehouse_login_email key from the cookie" do
    allow(session).to receive(:cookie).and_return({"treehouse_login_email" => "pants_email"})
    expect(session.login_email).to eq "pants_email"
  end
end

describe Treehouse::Session, "#cookie" do
  let(:env) { double }
  let(:session) { Treehouse::Session.new(env) }
  let(:cookies) {{ "_pants_cookie_key" => "pants_encrypted_cookie" }}
  let(:key_generator) { double }

  before do
    allow(session).to receive(:cookies).and_return(cookies)
    allow(Treehouse).to receive(:key).and_return("pants_secret_key")
    allow(Treehouse).to receive(:cookie).and_return("_pants_cookie_key")
    allow(ActiveSupport::KeyGenerator).to receive(:new).with("pants_secret_key", iterations: 1000).and_return(key_generator)
  end

  context "when the cookie exists" do
    it "returns the cookie hash" do
      cookie_jar = {
        "_pants_cookie_key" => {
          "treehouse_login_id" => "pants_id",
          "treehouse_login_email" => "pants_email"
        }
      }

      allow(ActionDispatch::Cookies::EncryptedCookieJar).to receive(:new).with(
        { "_pants_cookie_key" => "pants_encrypted_cookie" },
        key_generator,
        { encrypted_cookie_salt: 'encrypted cookie', encrypted_signed_cookie_salt: 'signed encrypted cookie', serializer: :json }
      ).and_return(cookie_jar)

      expect(session.cookie).to eq({ "treehouse_login_id" => "pants_id", "treehouse_login_email" => "pants_email" })
    end
  end

  context "when the cookie does not exist" do
    it "returns an empty hash" do
      cookie_jar = {}

      allow(ActionDispatch::Cookies::EncryptedCookieJar).to receive(:new).with(
        { "_pants_cookie_key" => "pants_encrypted_cookie" },
        key_generator,
        { encrypted_cookie_salt: 'encrypted cookie', encrypted_signed_cookie_salt: 'signed encrypted cookie', serializer: :json }
      ).and_return(cookie_jar)

      expect(session.cookie).to eq({})
    end
  end
end

describe Treehouse::Session, "#cookies" do
  let(:env) { double }
  let(:session) { Treehouse::Session.new(env) }

  it "returns a cookie jar for the env" do
    cookie_jar = double
    request = double(cookie_jar: cookie_jar)
    allow(ActionDispatch::Request).to receive(:new).with(env).and_return(request)
    expect(session.cookies).to eq cookie_jar
  end
end

