include_recipe "apt"
include_recipe "build-essential"

%w( wget zlib1g-dev libssl-dev libffi-dev ).each do |pkg|
  package pkg do
    action :install
  end
end

execute "get, unpack #{ node[:ruby][:version] }" do
  user "root"
  command "cd /usr/src && wget ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-#{ node[:ruby][:version] }.tar.bz2 && tar xjf ruby-#{ node[:ruby][:version] }.tar.bz2 && cd ruby-#{ node[:ruby][:version] }"
end

execute "configure & make #{ node[:ruby][:version] }" do
  user "root"
  command "cd /usr/src/ruby-#{ node[:ruby][:version] } && ./configure && make && make install"
end

execute "configure & make #{ node[:ruby][:version] }'s openssl support" do
  user "root"
  command "cd /usr/src/ruby-#{ node[:ruby][:version] }/ext/openssl/ && ruby extconf.rb && make && make install"
end

gem_package "ohai" do
  action :install
end

gem_package "chef" do
  action :install
end
