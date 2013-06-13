class User
  include Mongoid::Document

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :characters, foreign_key: :creator_id

  field :name, type: String, default: ""
  field :current_campaign_id, type: Moped::BSON::ObjectId

  # Devise
  field :email, type: String, default: ""
  field :encrypted_password, type: String, default: ""
  field :reset_password_token, type: String
  field :reset_password_sent_at, type: Time
  field :remember_created_at, type: Time
  field :sign_in_count, type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at, type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip, type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable
  
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
