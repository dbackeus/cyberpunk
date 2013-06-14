class User
  include Mongoid::Document

  devise :omniauthable, :rememberable, :trackable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(auth)
    if user = User.where(email: auth.info.email).first
      user.provider = auth.provider
      user.uid = auth.uid
      user
    else
      where(auth.slice(:provider, :uid)).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.name = auth.info.name
        user.email = auth.info.email
        user.avatar = auth.info.image
      end
    end
  end

  has_many :characters, foreign_key: :creator_id

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

  validate :validate_full_name

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
  def validate_full_name
    errors[:name] << "has to be a real first and last name" unless name.split.many?
  end
end
