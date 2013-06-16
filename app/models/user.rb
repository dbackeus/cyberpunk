require 'mx'

class User
  include Mongoid::Document

  devise :omniauthable, :rememberable, :trackable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(auth)
    user = where(email: auth.info.email).first_or_create

    unless user.confirmed?
      user.update_attributes!(
        provider: auth[:provider],
        uid: auth[:uid],
        name: auth.info.name,
        avatar: auth.info.image,
        skip_google_email_validation: true,
      )
    end

    user
  end

  has_many :characters, foreign_key: :creator_id, inverse_of: :creator
  has_and_belongs_to_many :player_characters, class_name: "Character", inverse_of: :players

  field :name, type: String, default: ""
  field :avatar, type: String
  field :current_campaign_id, type: Moped::BSON::ObjectId

  # Devise
  field :email, type: String, default: ""
  field :remember_created_at, type: Time
  field :sign_in_count, type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at, type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip, type: String
  field :provider, type: String
  field :uid, type: String

  attr_accessor :skip_google_email_validation

  validates_presence_of :email
  validates_uniqueness_of :email
  validate :validate_google_email, unless: lambda { email.blank? || skip_google_email_validation }

  before_destroy :destroy_memberships

  def confirmed?
    name.present?
  end

  def campaigns
    Campaign.where("memberships.user_id" => id)
  end

  def set_current_campaign(campaign)
    self.current_campaign_id = campaign.id
    return false unless save
    @campaign = campaign
  end

  def current_campaign
    return @campaign if @campaign
    if current_campaign_id.present?
      @campaign = campaigns.find(current_campaign_id)
    elsif campaigns.present?
      self.current_campaign_id = campaigns.first.id
      save
      current_campaign
    end
  rescue Mongoid::Errors::DocumentNotFound
    update_attributes(current_campaign_id: nil)
    current_campaign
  end

  private
  def validate_google_email
    domain = email.split("@").last
    unless %w[gmail.com googlemail.com].include?(domain) || MX.for_domain(domain).flatten.join[/google.com/]
      errors[:email] << "must belong to a google account"
    end
  end

  def destroy_memberships
    Campaign.where("memberships.user_id" => id).each do |campaign|
      campaign.memberships.detect { |membership| membership.user_id == id }.destroy
    end
  end
end
