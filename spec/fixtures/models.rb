class Ticket < ActiveRecord::Base
  has_and_belongs_to_many :tags
  belongs_to :tag
  
  search_config do
    default :description
    external :tag, :from => :tags, :field => "name"
  end
end

class Tag < ActiveRecord::Base
  has_and_belongs_to_many :tickets
end

class State < ActiveRecord::Base
  has_many :tickets
end


## seed data:

# Ticket with a description, no tag
ticket = Ticket.create(:description => "Hello world! You are awesome.")
ticket.tags << Tag.create(:name => "bug")

