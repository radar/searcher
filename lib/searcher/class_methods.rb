require 'searcher/config'

module Searcher
  module ClassMethods
    def searcher(&block)
      Searcher.classes << self unless Searcher.classes.include?(self)
      @config = Searcher::Config.new.instance_exec(&block)
      table = arel_table
      @config[:labels].each do |name, config|
        association = reflect_on_association(config[:from])
        association_table = association.klass.arel_table
        if [:has_and_belongs_to_many, :belongs_to].include?(association.macro)
          scope = lambda { |q, field| joins(config[:from]).where(association_table[field].eq(q)) }
          self.scope "by_#{name}", scope
        end
      end
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
