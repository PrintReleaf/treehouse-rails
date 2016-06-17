require 'spec_helper'

describe Treehouse::Login do
  it "raises when the id is blank" do
    expect { Treehouse::Login.new(nil, "bob@pants.com") }.to raise_exception ArgumentError, "Invalid ID"
    expect { Treehouse::Login.new("", "bob@pants.com") }.to raise_exception ArgumentError, "Invalid ID"
  end

  it "raises when the email is blank" do
    expect { Treehouse::Login.new("pants_id", nil) }.to raise_exception ArgumentError, "Invalid email"
    expect { Treehouse::Login.new("pants_id", "") }.to raise_exception ArgumentError, "Invalid email"
  end
end

