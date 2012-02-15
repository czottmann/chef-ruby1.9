maintainer        "Carlo Zottmann"
maintainer_email  "carlo@zottmann.org"
license           "WTFPL"
description       "Installs Ruby 1.9.2 from source"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.mdown'))
version           "1.0"
supports          "ubuntu"

%w( apt build-essential ).each do |d|
  depends d
end

recipe            "ruby-1.9.2", "Installs Ruby 1.9.2 from source."
