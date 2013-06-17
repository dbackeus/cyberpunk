module ApplicationHelper
  def articlerize(word)
    %w(a e i o u).include?(word[0].downcase) ? "an #{word}" : "a #{word}"
  end

  def die_image
    image_tag("roll.png", class: "die")
  end
end
