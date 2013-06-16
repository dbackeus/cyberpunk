class CyberpunkMailer < ActionMailer::Base
  default from: "noreply.cyberpunk2020@gmail.com"

  def invitation(invitor_id, campaign_id, invited_id)
    @invitor = User.find(invitor_id)
    @campaign = Campaign.find(campaign_id)
    @invited = User.find(invited_id)
    mail to: @invited.email, subject: "[Cyberpunk.net] Invitation to join campaign"
  end
end
