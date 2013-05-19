Autotest.add_discovery { "rails" }
Autotest.add_discovery { "rspec2" }

Autotest.add_hook :initialize do |at|
  at.add_mapping(%r%^spec/(cdn_strategies|image_cdn_strategies|jobs|original_video_strategies|lib|rack)/.*rb$%) { |filename, _|
    filename
  }
  nil
end
