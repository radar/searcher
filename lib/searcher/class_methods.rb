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
          
          external = @config[:externals][name.to_sym]
          next unless external
          send("by_#{name}", q, external[:field])
        else
          k.where(klass.arel_table[@config[:default]].matches_any("%#{piece}%"))
        end
      end
      
      result
    end
  end
end