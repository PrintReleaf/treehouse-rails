require 'spec_helper'

describe Treehouse::Middleware, "#call" do
  it "adds the treehouse session to the env and calls the next app" do
    app = double
    env = {}
    session = double
    allow(app).to receive(:call)
    allow(Treehouse::Session).to receive(:new).with(env).and_return(session)
    Treehouse::Middleware.new(app).call(env)
    expect(env[:treehouse]).to eq session
    expect(app).to have_received(:call).with(env)
  end
end

