module PathRewriter
  class Rails
    class << self
      attr_accessor :codec

      def enable
        self.install
        self.codec = PathRewriter::UrlCodec.new
        yield self
      end
    
      def install
        ActionController::Base::optimise_named_routes = false
        
        ActionController::Routing::Routes.class_eval do
          def call_with_rewrite(orig)
            env = orig.dup
            begin
              puts PathRewriter::Rails.codec
              env["REQUEST_URI"] = PathRewriter::Rails.codec.decode(env["REQUEST_URI"])
              call_without_rewrite(env)
            rescue ActionController::NotImplemented, ActionController::MethodNotAllowed, ActionController::RoutingError
              call_without_rewrite(orig)
            end
          end
          alias_method_chain :call, :rewrite
        end
        
        [ ActionController::Base, ActionView::Base ].each do |klass|
          klass.class_eval do
            def url_for_with_rewrite(*args)
              url = url_for_without_rewrite(*args)
              PathRewriter::Rails.codec.encode(url)
            end
            alias_method_chain :url_for, :rewrite
          end
        end
      end
    end
  end
  
end