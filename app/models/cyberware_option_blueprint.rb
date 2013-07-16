class CyberwareOptionBlueprint < ItemBlueprint
  include Mongoid::Document

  field :surgery_level, type: String # N(egligible) M(inor) MA(jor) CR(itical)
  field :hl, type: String # humanity loss
  field :size, type: Integer, default: 1 # reduce option limit by the size
end
