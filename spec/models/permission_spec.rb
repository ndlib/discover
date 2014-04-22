require 'spec_helper'

describe Permission do

  subject { described_class }

  ['jhartzle', 'jkennel', 'rfox2', 'rmalott', 'lthiel'].each do | username |
    it "returns #{username} as an admin " do
      user = double(User, username: username)
      expect(subject.new(user).is_admin?).to be_true
    end
  end


  it "returns other usernames as not an admin" do
    user = double(User, username: 'asdfasdfdsfsdf')
    expect(subject.new(user).is_admin?).to be_false
  end


end
