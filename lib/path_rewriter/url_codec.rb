module PathRewriter
  
  class UrlCodec
    
    attr_writer :base_path
    attr_writer :root_path
    
    def base_path
      @base_path ||= ""
    end
    
    def root_path
      @root_path ||= ""
    end
    
    def root_path_without_slash
      self.root_path.sub(/^\//, "")
    end
    
    def base_path_without_slash
      self.base_path.sub(/^\//, "")
    end
    
    def decode(uri)
      return uri if self.base_path.blank?
      uri = Addressable::URI.parse(uri)
      
      segments = uri.path.sub(self.root_path, '').split("/")
      segments.delete("")
      segments.unshift(self.base_path_without_slash)
      segments.unshift(self.root_path_without_slash) unless root_path.blank?
      uri.path = "/" + segments.join("/")
      
      uri.to_s
    end
    
    def encode(uri)
      return uri if self.base_path.blank?
      return uri unless uri.start_with?(self.root_path)
      uri = Addressable::URI.parse(uri)

      uri.path.sub!(self.root_path, '')
      uri.path.sub!(self.base_path, '')
      
      segments = uri.path.split("/")
      segments.unshift(self.root_path_without_slash)
      segments.delete("")
      uri.path = "/" + segments.join("/")
      
      uri.to_s
    end
  end
  
end