class User
  include Mongoid::Document

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  field :name, type: String, default: ""

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

  private
  def validate_full_name
    p name
    p name.split
    errors[:name] << "has to be a real first and last name" unless name.split.many?
  end
end
