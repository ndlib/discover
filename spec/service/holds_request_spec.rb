require 'spec_helper'


describe HoldsRequest do

  subject { described_class.new(controller, record) }

  let(:controller) { double(ApplicationController, session: {}, params: { username: 'username' })}
  let(:record) { double(DiscoveryRecord, id: 'id') }

  it "saves the data from step1" do
    subject.add_step1({ volume: 'volume' })
    expect(controller.session).to eq({"id-username"=>{:volume=>"volume"}})
  end


  it "saves the data from step2" do
    subject.add_step2({ library: 'library' })
    expect(controller.session).to eq({"id-username"=>{:library=>"library"}})
  end


  it "saves the data from step3" do
    subject.add_step3({ pickup_location: 'pickup_location' })
    expect(controller.session).to eq({"id-username"=>{:pickup_location=>"pickup_location"}})
  end


  it "saves the data from step4" do
    subject.add_step4({ cancel_date: 'cancel_date' })
    expect(controller.session).to eq({"id-username"=>{:cancel_date=>"cancel_date"}})
  end

end
