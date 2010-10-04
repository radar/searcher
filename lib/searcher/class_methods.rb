require 'searcher/config'

module Searcher
  module ClassMethods
    def searcher(&block)
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
          
          # Find the type of association we're dealing with
          association = reflect_on_association(external[:from])
          association_table = Table(association.klass.table_name)
          case association.macro
            
            when :has_and_belongs_to_many
              join_table = Table(association.options[:join_table])
              
              jtl = table[klass.primary_key]
              jtr = join_table[association.primary_key_name]
              
              other_primary_key = association_table[association.klass.primary_key]
              association_foreign_key = join_table[association.association_foreign_key]
              
              klass.find_by_sql(table.join(join_table).on(jtl.eq(jtr)).
              join(association_table).on(other_primary_key.eq(association_foreign_key)).
              where(association_table[external[:field]].eq(q)).to_sql)
              
            when :belongs_to
              foreign_key = table[association.primary_key_name]
              other_primary_key = association_table[association.klass.primary_key]
              
              sql = table.join(association_table).on(foreign_key.eq(other_primary_key)).
              where(association_table[external[:field]].eq(q)).to_sql
              
              klass.find_by_sql(table.join(association_table).on(foreign_key.eq(other_primary_key)).
              where(association_table[external[:field]].eq(q)).to_sql) 
          end
          
        else
          k.where(table[@config[:default]].matches_any("%#{piece}%"))
        end
      end
      
      result
    end
  end
end