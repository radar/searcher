require 'searcher/config'

module Searcher
  module ClassMethods
    def searcher(&block)
      Searcher.classes << self
      @config ||= Searcher::Config.new.instance_exec(&block)
    end
    
    def search(query)
      klass = self
      table = Table(klass.table_name)
      
      result = query.split(" ").inject(klass) do |k, piece|
        if piece.include?(":")
          external, q = piece.split(":")
          external = @config[:externals][external.to_sym]
          next unless external
          send("by_#{external[:field]}", q)
              
              
          #   when :belongs_to
          #     foreign_key = table[association.primary_key_name]
          #     other_primary_key = association_table[association.klass.primary_key]
          #     
          #     sql = table.join(association_table).on(foreign_key.eq(other_primary_key)).
          #     where(association_table[external[:field]].eq(q)).to_sql
          #     
          #     klass.find_by_sql(table.join(association_table).on(foreign_key.eq(other_primary_key)).
          #     where(association_table[external[:field]].eq(q)).to_sql) 
          # end
          
        else
          k.where(table[@config[:default]].matches_any("%#{piece}%"))
        end
      end
      
      result
    end
  end
end