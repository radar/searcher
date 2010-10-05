require 'searcher/config'

module Searcher
  module ClassMethods
    def searcher(&block)
      Searcher.classes << self unless Searcher.classes.include?(self)
      @config ||= Searcher::Config.new.instance_exec(&block)
    end
    
    def search(query)
      klass = self

      result = query.split(" ").inject(klass) do |k, piece|
        if piece.include?(":")
          name, q = piece.split(":")
          label = @config[:labels][name.to_sym]
          next unless label
          send("by_#{name}", q, label[:field])
        end
      end
      
      result || klass.all
    end
  end
end