require "rubygems"
gem "gem_loader", ">= 0.2.0"
require "gem_loader"


GemLoader.setup do

  scope :runtime do
    gem "actionpack", "~> 2.3.5", :require => ["action_pack", "action_view", "action_controller"]
    gem 'addressable', ">= 2.1.1", :require => "addressable/uri"
  end

  scope :optional do
  end
  
  scope :test do
    gem "rspec", ">= 1.3.0", :require => nil
  end

  scope :development => [:optional, :test]

  scope :rakefile do
    gem "rake", ">= 0.8.7"
    gem "jeweler", ">= 1.4.0"
    gem "rspec", :require => "spec/rake/spectask"
  end
end
