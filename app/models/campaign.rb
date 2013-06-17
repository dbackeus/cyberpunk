class Campaign
  include Mongoid::Document

  belongs_to :creator, class_name: "User"

  embeds_many :memberships

  has_and_belongs_to_many :characters

  field :name, type: String

  validates :name, presence: true, uniqueness: true

  def membership_for(user)
    memberships.detect { |membership| membership.user_id == user.id }
  end
end
