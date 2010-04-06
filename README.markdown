## Usage

create path_rewriter.rb at `config/initializers/` and append:

	PathRewriter::Rails.enable do |p|
	  p.codec.base_path = Settings.base_path
	  p.codec.root_path = ActionController::Base.relative_url_root
	end