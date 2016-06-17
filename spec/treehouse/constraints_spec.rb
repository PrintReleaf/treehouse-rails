require 'spec_helper'

describe Treehouse::Constraints::Constraint, "#treehouse_session" do
  it "returns the treehouse property from the request env" do
    treehouse_session = double
    env = { treehouse: treehouse_session }
    request = double(env: env)
    constraint = Treehouse::Constraints::Constraint.new
    constraint.instance_variable_set(:@request, request)
    expect(constraint.treehouse_session).to eq treehouse_session
  end
end

describe Treehouse::Constraints::Constraint, "#logged_in?" do
  it "returns true when the treehouse_session is logged in" do
    constraint = Treehouse::Constraints::Constraint.new
    treehouse_session = double
    allow(constraint).to receive(:treehouse_session).and_return(treehouse_session)
    allow(treehouse_session).to receive(:logged_in?).and_return(true)
    expect(constraint.logged_in?).to eq true
  end

  it "returns false when the treehouse_session is not logged in" do
    constraint = Treehouse::Constraints::Constraint.new
    treehouse_session = double
    allow(constraint).to receive(:treehouse_session).and_return(treehouse_session)
    allow(treehouse_session).to receive(:logged_in?).and_return(false)
    expect(constraint.logged_in?).to eq false
  end

  it "returns false when the treehouse_session is nil" do
    constraint = Treehouse::Constraints::Constraint.new
    allow(constraint).to receive(:treehouse_session).and_return(nil)
    expect(constraint.logged_in?).to eq false
  end
end

describe Treehouse::Constraints::LoggedIn, "#matches?" do
  it "returns true when logged in" do
    constraint = Treehouse::Constraints::LoggedIn.new
    allow(constraint).to receive(:logged_in?).and_return(true)
    request = double
    expect(constraint.matches?(request)).to eq true
  end

  it "returns false when not logged in" do
    constraint = Treehouse::Constraints::LoggedIn.new
    allow(constraint).to receive(:logged_in?).and_return(false)
    request = double
    expect(constraint.matches?(request)).to eq false
  end
end

describe Treehouse::Constraints::LoggedOut, "#matches?" do
  it "returns true when not logged in" do
    constraint = Treehouse::Constraints::LoggedOut.new
    allow(constraint).to receive(:logged_in?).and_return(false)
    request = double
    expect(constraint.matches?(request)).to eq true
  end

  it "returns false when logged in" do
    constraint = Treehouse::Constraints::LoggedOut.new
    allow(constraint).to receive(:logged_in?).and_return(true)
    request = double
    expect(constraint.matches?(request)).to eq false
  end
end

