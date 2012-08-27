maintainer        "Carlo Zottmann"
maintainer_email  "carlo@zottmann.org"
license           "WTFPL"
description       "Installs Ruby 1.9.x from source"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.mdown'))
version           "1.0"
supports          "ubuntu"

%w( apt build-essential ).each do |cb|
  depends cb
end

recipe "chef-ruby1.9", "Installs Ruby 1.9.x (default: 1.9.2) from source."
