class MembershipCreator
  include ActiveModel::Validations

  attr_accessor :campaign, :email, :invitor

  validates_presence_of :email
  validate :uniqueness_of_email_in_campaign

  def initialize(params)
    @campaign = params[:campaign]
    @invitor = params[:invitor]
    @email = params[:email]
  end

  def save
    return false unless valid?

    if user.valid?
      campaign.memberships.create!(user: user)
      CyberpunkMailer.invitation(invitor.id.to_s, campaign.id.to_s, user.id.to_s)
    else
      user.errors[:email].each { |error| errors[:email] << error }
      false
    end
  end

  def user
    @user ||= User.where(email: email).first_or_create
  end

  def persisted?
    false
  end

  def to_key
    nil
  end

  private
  def uniqueness_of_email_in_campaign
    errors[:email] << "is already invited" if campaign.memberships.collect(&:email).include?(email)
  end
end
