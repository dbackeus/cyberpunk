module ApplicationHelper
  def eb(amount)
    number_to_currency amount, unit: "eb", format: "%n%u"
  end
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

  def membership_status(membership)
    if membership.admin?
      "admin"
    elsif membership.referee?
      "referee"
    else
      "player"
    end
  end

  def button_to_function(name, function=nil, html_options={})
    onclick = "#{"#{html_options[:onclick]}; " if html_options[:onclick]}#{function};"
    tag(:input, html_options.merge(type: 'button', value: name, onclick: onclick))
  end

  def link_to_function(name, function, html_options={})
    onclick = "#{"#{html_options[:onclick]}; " if html_options[:onclick]}#{function}; return false;"
    href = html_options[:href] || '#'
    content_tag(:a, name, html_options.merge(href: href, onclick: onclick))
  end
end
