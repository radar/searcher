require 'active_record'
require 'searcher/class_methods'

module Searcher
  def self.classes=(klass_list)
    @@classes = klass_list
  end

  def self.classes
    @@classes ||= []
  end
end

ActiveRecord::Base.extend(Searcher::ClassMethods)

