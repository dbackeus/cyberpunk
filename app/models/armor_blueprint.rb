class ArmorBlueprint < ItemBlueprint
  include Mongoid::Document

  field :type, type: String, default: "soft" # soft or hard
  field :ev, type: Integer, default: 0 # encumberance value
  field :hsp, type: Integer, default: 0 # stopping power (head)
  field :tsp, type: Integer, default: 0 # stopping power (torso)
  field :lasp, type: Integer, default: 0 # stopping power (left arm)
  field :rasp, type: Integer, default: 0 # stopping power (right arm)
  field :llsp, type: Integer, default: 0 # stopping power (left leg)
  field :rlsp, type: Integer, default: 0 # stopping power (right leg)
  field :rsp, type: Integer, default: 0 # radiation stopping power
end
