require 'searcher/config'

module Searcher
  module ClassMethods
    def search_config(&block)
      @config ||= Searcher::Config.new.instance_exec(&block)
    end
    
    def search(query)
      klass = self
      table = Table(klass.table_name)
      
      result = query.split(" ").inject(klass) do |k, piece|
        if piece.include?(":")
          external, q = piece.split(":")
          external = @config[:externals][external.to_sym]
          
          # Find the type of association we're dealing with
          association = reflect_on_association(external[:from])
          p association.methods.sort - Object.methods
          case association.macro
            when :has_and_belongs_to_many
              join_table = Table(association.table_name)
              k.joins(join_table).on(table[klass.primary_key].eq(join_table[association.primary_key_name]))
          end
          
        else
          k.where(table[@config[:default]].matches_any("%#{piece}%"))
        end
      end
      
      result
    end
  end
end