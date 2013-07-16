# Cyberware
# =========

# ## Neuralware Processor
# - Options
# ## Cyberoptic
# - 4 Options per eye
# ## Cyberaudio
# - Options
# ## Cyberlimb (arm)
# - 4 Options
# ## Cyberlimb (leg)
# - 3 Options
# ## Audio
# - Options


class CyberwareBlueprint < ItemBlueprint
  include Mongoid::Document

  field :surgery_level, type: String # N(egligible) M(inor) MA(jor) CR(itical)
  field :hl, type: String # humanity loss
  field :option_categories, type: Array, default: []
  field :option_limit, type: Integer # 4
end
