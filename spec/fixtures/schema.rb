ActiveRecord::Schema.define do
  self.verbose = false

  create_table :tickets, :force => true do |t|
    t.string :description
    t.integer :state_id
    t.timestamps
  end

  create_table :tags_tickets, :force => true, :id => false do |t|
    t.integer :ticket_id, :tag_id
  end

  create_table :tags, :force => true do |t|
    t.string :name
  end

  create_table :states, :force => true do |t|
    t.string :name
  end

end