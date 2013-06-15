require "spec_helper"

describe CyberpunkMailer do
  describe "invitation" do
    let(:mail) { CyberpunkMailer.invitation }

    pending "renders the headers" do
      mail.subject.should eq("Invitation")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    pending "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
