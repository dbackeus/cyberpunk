require 'spec_helper'

describe Campaign do
  describe "#name" do
    it "is unique" do
      campaign = create(:campaign)
      another_campaign = Campaign.new(name: campaign.name)
      validate(another_campaign).errors[:name].should include("is already taken")
    end
  end
end
