require 'spec_helper'

describe CharactersController do
  let(:character) { create(:character) }

  describe "GET #show" do
    context "when not signed in" do
      before do
        get :show, id: character.id.to_s
      end

      it "should be successful" do
        response.should be_success
      end
    end
  end
end
