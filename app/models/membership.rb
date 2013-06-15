class Membership
  include Mongoid::Document

  embedded_in :campaign, inverse_of: :memberships
  belongs_to :user

  field :admin, type: Boolean, default: false
  field :referee, type: Boolean, default: false
  field :created_at, type: Time, default: lambda { Time.now }

  validates :user, presence: true

  validate :validate_uniqueness_of_user_in_memberships, if: :campaign

  before_destroy :validate_not_last_memberhip_of_campaign
  before_destroy :clean_up_users_current_campaign

  delegate :name, :email, :confirmed?, to: :user

  def player?
    !referee?
  end

  private
  def validate_uniqueness_of_user_in_memberships
    if campaign.memberships.many? { |m| m.user_id == user_id }
      errors[:base] << "User is already a member of the campaign #{campaign.name}."
    end
  end

  def validate_not_last_memberhip_of_campaign
    unless campaign.memberships.many?
      errors[:base] << "Can not remove the last user from the campaign #{campaign.name}."
      raise Mongoid::Errors::Validations.new(self)
    end
  end

  def clean_up_users_current_campaign
    if user.current_campaign == campaign
      user.current_campaign_id = nil
      user.save
    end
  end
end
