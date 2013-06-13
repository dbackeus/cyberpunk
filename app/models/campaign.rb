class Campaign
  include Mongoid::Document

  belongs_to :creator, class_name: "User"

  embeds_many :memberships

  field :name, type: String

  validates :name, presence: true
end
