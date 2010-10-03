require 'searcher'

here = File.dirname(__FILE__)

# Connect to the test database
ActiveRecord::Base.establish_connection(:database => "searcher.sqlite3", :adapter => "sqlite3")

# Load the schema into the test database
load here + '/fixtures/schema.rb'

# Load the models
require here + '/fixtures/models'


require 'logger'
ActiveRecord::Base.logger = Logger.new("tmp/activerecord.log")