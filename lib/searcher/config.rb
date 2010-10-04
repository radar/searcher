module Searcher
  class Config
    def initialize
      @config = {}
    end
    
    def default(field)
      @config[:default] = field
      @config
    end
    
    def label(field, options)
      @config[:labels] ||= {}
      @config[:labels][field.to_sym] = options
      @config
    end
  end
end