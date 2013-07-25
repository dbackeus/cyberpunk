module CharactersHelper
  def can_edit?(character)
    return false unless user_signed_in?
    character.played_by?(current_user) || current_membership.referee? || character.creator_id == current_user.id
  end

  def sibling_form_template(form)
    fields = form.fields_for(:siblings, Sibling.new, child_index: Time.now.to_i) do |sf|
      render("sibling_form", sibling_form: sf)
    end
    escape_javascript(fields)
  end

  def abbrivated_stats
    {
      intelligence: "INT",
      reflexes: "REF",
      cool: "COOL",
      technical_ability: "TECH",
      luck: "LUCK",
      attractiveness: "ATTR",
      movement_allowance: "MA",
      empathy: "EMP",
      body_type: "BODY",
    }
  end

  def shortened_stats
    {
      technical_ability: "Tech",
      movement_allowance: "Movement",
      attractiveness: "Attractive"
    }
  end

  def clothes_options
    [
      "Biker leathers",
      "Blue jeans",
      "Corporate suits",
      "Jumpsuits",
      "Miniskirts",
      "High Fashion",
      "Cammos",
      "Normal clothes",
      "Nude",
      "Bag Lady Chic",
    ]
  end

  def hair_options
    [
      "Mohawk",
      "Long & Ratty",
      "Short & Spiked",
      "Wild & all over",
      "Bald",
      "Striped",
      "Tinted",
      "Neat short",
      "Short, curly",
      "Long, straight"
    ]
  end

  def affections_options
    [
      "Tatoos",
      "Mirrorshades",
      "Ritual scars",
      "Spiked gloves",
      "Nose rings",
      "Earrings",
      "Long fingernails",
      "Spike heeled boots",
      "Weird contact lenses",
      "Fingerless gloves"
    ]
  end

  def ethnicity_options
    {
      "Anglo-American" => %w(English),
      "African" => %w(Bantu Fante Kongo Ashanti Zulu Swahili),
      "Japanese" => %w(Japanese),
      "Korean" => %w(Korean),
      "Central European" => %w(Bulgarian Czech Polish Ukrainian Slovak),
      "Soviet" => %w(Russian),
      "Pacific Islander" => %w(Microneasian Tagalog Polynesian Malayan Sudanese Indonesian Hawaiian),
      "Chinese/Southeast Asian" => %w(Burmese Cantonese Mandarin Thai Tibetan Vietnamese),
      "Black American" => %w(English Blackfolk),
      "Hispanic American" => %w(Spanish English),
      "Central/South American" => %w(Spanish Portugese),
      "European" => %w(French German English Spanish Italian Greek Danish Dutch Norwegian Swedish Finnish)
    }
  end

  def family_ranking_options
    [
      "Corporate Executive",
      "Corporate Manager",
      "Corporate Technician",
      "Nomad Pack",
      "Pirate Fleet",
      "Gang Family",
      "Crime Lord",
      "Combat Zone Poor",
      "Urban Homeless",
      "Arcology Family",
    ]
  end

  def something_happened_to_parents_options
    [
      "Your parent(s) died in warfare",
      "Your parent(s) died in accident",
      "Your parent(s) were murdured",
      "Your parent(s) have amnesia and don't remember you",
      "You never knew your parents",
      "You parent(s) are in hiding to protect you",
      "You were left with relatives for safekeeping",
      "You grew up on the Street and never had parents",
      "Your parent(s) gave you up for adoption",
      "Your parent(s) sold you for money"
    ]
  end

  def family_tragedy_options
    [
      "Family lost everything through betrayal",
      "Family lost everything through bad management",
      "Family exile or otherwise driven from their original home/nation/corporation",
      "Family is imprisoned and you alone escaped",
      "Family vanished and you are the only remaining member",
      "Family was murdered/killed and you were the only survivor",
      "Family is involved in a longterm conspiracy, organization or association, such as a crime family or revolutionary group",
      "Your family was scattered to the winds due to misfortune",
      "Your family is cursed with a hereditary feud that has lasted for generations",
      "You are the inheritor of a family dept; you must honor this dept before moving on with your life"
    ]
  end

  def childhood_options
    [
      "Spent on the Street with on adult supervision",
      "Spent in a safe Corporate Suburbia",
      "In a Nomad Pack moving from town to town",
      "In a decaying, once upscale neighborhood",
      "In a defended corporate Zone in the central City",
      "In the heart of the Combat Zone",
      "In a small village or town far from the City",
      "In a large arcology city",
      "In a aquatic Pirate Pack",
      "On a Corporate controlled Farm or Research Facility"
    ]
  end

  def sibling_feelings_options
    [
      "Dislikes you",
      "Likes you",
      "Neutral",
      "Hero worhips you",
      "Hates you"
    ]
  end
end
