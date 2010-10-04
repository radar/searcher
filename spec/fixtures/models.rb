class Ticket < ActiveRecord::Base
  has_and_belongs_to_many :tags
  belongs_to :state
  
  searcher do
    external :tag, :from => :tags, :field => "name"
    external :state, :from => :state, :field => "name"
  end
end

class Tag < ActiveRecord::Base
  has_and_belongs_to_many :tickets
end

class State < ActiveRecord::Base
  has_many :tickets
end

#############
### SEEDS ###
#############

# Ticket with a description, tag and state.
ticket = Ticket.create(:description => "Hello world! You are awesome.")
ticket.tags << Tag.create(:name => "bug")
ticket.state = State.create(:name => "Open")
ticket.save!

