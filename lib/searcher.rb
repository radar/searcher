require 'active_record'
require 'searcher/class_methods'

module Searcher
  mattr_accessor :classes
  def self.classes
    @classes ||= []
  end
end

ActiveRecord::Base.extend(Searcher::ClassMethods)

ActiveSupport.on_load(:after_initialize) do
  p Searcher.classes
  # @externals].each do |name, config|
  #     association = reflect_on_association(config[:from])
  #     association_table = Table(association.klass.table_name)
  #     case association.macro
  #       when :has_and_belongs_to_many
  #         join_table = Table(association.options[:join_table])
  #   
  #         jtl = table[klass.primary_key]
  #         jtr = join_table[association.primary_key_name]
  #   
  #         other_primary_key = association_table[association.klass.primary_key]
  #         association_foreign_key = join_table[association.association_foreign_key]
  #   
  #         self.send(:scope, "by_#{config[:field]}", lambda { |q| join(join_table).on(jtl.eq(jtr)).
  #         join(association_table).on(other_primary_key.eq(association_foreign_key)).
  #         where(association_table[external[:field]].eq(q)) })
  #     end
  #   end
end