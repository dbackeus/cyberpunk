require 'spec_helper'

describe User do
  describe "#campaigns" do
    it "should have a list of all membership campaign" do
      campaign = create(:campaign)
      user = build(:user)
      user.campaigns.should == []
      campaign.memberships.create!(user: user)
      user.campaigns.should == [campaign]
    end
  end

  describe "#current_campaign" do
    it "uses an availible campaign and persist it if none is specified" do
      campaign = create(:campaign)
      user = campaign.memberships.first.user
      user.current_campaign.should == campaign
      user.reload.current_campaign_id.should == campaign.id
    end

    it "uses the specified one if set" do
      campaign = create(:campaign)
      user = campaign.memberships.first.user
      second_campaign = create(:campaign)
      second_campaign.memberships.create!(user: user)

      user.set_current_campaign(campaign)
      user.current_campaign.should == campaign
      user.reload.current_campaign.should == campaign

      user.set_current_campaign(second_campaign)
      user.current_campaign.should == second_campaign
      user.reload.current_campaign.should == second_campaign
    end

    it "is nil if no campaign is available" do
      create(:user).current_campaign.should == nil
    end

    it "falls back to another campaign in case current campaign is removed" do
      campaign = create(:campaign)
      user = campaign.memberships.first.user
      second_campaign = create(:campaign)
      second_campaign.memberships.create!(user: user)

      user.current_campaign.should == campaign

      campaign.destroy

      User.first.current_campaign.should == second_campaign
    end
  end
end
