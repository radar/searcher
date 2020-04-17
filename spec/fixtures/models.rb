class Tag < ActiveRecord::Base
  has_and_belongs_to_many :tickets
end

class State < ActiveRecord::Base
  has_many :tickets
end

class Ticket < ActiveRecord::Base
  has_and_belongs_to_many :tags
  belongs_to :state

  searcher do
    label :tag, :from => :tags, :field => "name"
    label :state, :from => :state, :field => "name"
  end
end

#############
### SEEDS ###
#############

# Ticket with a description, tag and state.
ticket = Ticket.create(:description => "Hello world! You are awesome.")
ticket.tags << Tag.create(:name => "bug")
ticket.tags << Tag.create(:name => "visual regression")
ticket.state = State.create(:name => "Open")
ticket.save!
