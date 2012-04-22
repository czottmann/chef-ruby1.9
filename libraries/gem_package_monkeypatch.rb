def patch_gem_package
  ::Chef::Resource::GemPackage.class_eval do
    def initialize(name, run_context=nil)
      super
      @resource_name = :gem_package
      self.gem_binary('/usr/local/bin/gem')
    end
  end
end
