require 'active_record'
require 'searcher/class_methods'

module Searcher
  # Your code goes here...
end

ActiveRecord::Base.extend(Searcher::ClassMethods)
