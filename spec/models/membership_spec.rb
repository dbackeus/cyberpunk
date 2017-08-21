require "spec_helper"

describe Membership do
  it "is not deleteable if it's the last membership of its campaign" do
    campaign = create(:campaign)
    expect { campaign.memberships.first.destroy }.to raise_error(Mongoid::Errors::Validations)
    campaign.memberships.create!(user: create(:user))
    expect { campaign.memberships.first.destroy }.to_not raise_error
  end

  specify "#created_at should default to now" do
    allow(Time).to receive(:now).and_return(Time.at(0).utc)
    Membership.new.created_at.should == Time.at(0).utc
  end

  it "cleans up current campaign from users whose memberships are destroyed" do
    campaign = create(:campaign)
    user = create(:user)
    campaign.memberships.create(user: user)
    user.current_campaign.should == campaign

    campaign.memberships.last.destroy
    user.reload.current_campaign_id.should == nil
  end
end
