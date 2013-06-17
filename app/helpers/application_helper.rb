module ApplicationHelper
  def articlerize(word)
    %w(a e i o u).include?(word[0].downcase) ? "an #{word}" : "a #{word}"
  end

  def die_image
    image_tag("roll.png", class: "die")
  end

  def gravatar(email)
    email_hex = Digest::MD5.hexdigest(email)
    "https://www.gravatar.com/avatar/#{email_hex}?d=mm"
  end
end
