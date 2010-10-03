module Searcher
  class Config
    def initialize
      @config = {}
    end
    
    def default(field)
      @config[:default] = field
      @config
    end
    
    def external(field, options)
      @config[:externals] ||= {}
      @config[:externals][field.to_sym] = options
      @config
    end
  end
end