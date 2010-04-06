require File.expand_path("../../depends.rb", __FILE__)
GemLoader.require(:test)
GemLoader.require(:runtime, :development)

require "path_rewriter"

Spec::Runner.configure do |config|
  
end
