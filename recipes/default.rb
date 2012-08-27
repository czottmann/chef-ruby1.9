include_recipe "apt"
include_recipe "build-essential"

ruby_installed_check = "ruby -v | grep #{ node[:ruby][:version].gsub( '-', '' ) }"

# lucid-server, oneiric-server and precise-server don't have libreadline5-dev,
# use libreadline5. ruby 1.9.3-p194 (at least) needs libyaml-syck-perl (HJH)
%w( wget zlib1g-dev libssl-dev libffi-dev libxml2-dev libncurses5-dev libreadline5 libyaml-syck-perl ).each do |pkg|
  package pkg do
    action :install
  end
end

execute "get & unpack #{ node[:ruby][:version] }" do
  user "root"
  command "cd /usr/src && wget ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-#{ node[:ruby][:version] }.tar.bz2 && tar xjf ruby-#{ node[:ruby][:version] }.tar.bz2 && cd ruby-#{ node[:ruby][:version] }"
  not_if ruby_installed_check
end

execute "configure & make #{ node[:ruby][:version] }" do
  user "root"
  command "cd /usr/src/ruby-#{ node[:ruby][:version] } && ./configure && make && make install"
  not_if ruby_installed_check
end

%w( openssl readline ).each do |ext|
  execute "configure & make #{ node[:ruby][:version] } #{ext} support" do
    user "root"
    command "cd /usr/src/ruby-#{ node[:ruby][:version] }/ext/#{ext}/ && ruby extconf.rb && make && make install"
    not_if ruby_installed_check
  end
end

%w( ohai chef ).each do |g|
  gem_package g do
    action :install
    gem_binary('/usr/local/bin/gem')
  end
end
