require 'spec_helper'

describe WeaponsController do
  let(:campaign) { create(:campaign) }
  let(:user) { campaign.memberships.first.user }
  let(:character) { create(:character, creator: user) }
  let(:blueprint) { WeaponBlueprint.create!(attributes_for(:weapon_blueprint)) }

  before { sign_in user }

  describe "POST create.js" do
    before do
      post :create, format: :js, character_id: character.id, item: { blueprint_id: blueprint.id, cost: 200 }
    end

    it "should description" do
      response.status.should == 200
    end
  end
end
