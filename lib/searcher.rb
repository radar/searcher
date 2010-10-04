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
  Searcher.classes.each do |klass|
    table = Table(klass.table_name)
    klass.searcher[:labels].each do |name, config|
      association = klass.reflect_on_association(config[:from])
      association_table = Table(association.klass.table_name)
      if [:has_and_belongs_to_many, :belongs_to].include?(association.macro)
        scope = lambda { |q, field| klass.joins(config[:from]).where(association_table[field].eq(q)) }
        klass.scope "by_#{name}", scope
      end
    end
  end
end