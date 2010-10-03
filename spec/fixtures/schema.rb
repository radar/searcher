ActiveRecord::Schema.define do
  self.verbose = false

  create_table :tickets, :force => true do |t|
    t.string :description
    t.timestamps
  end

  create_table :tags_tickets, :force => true, :id => false do |t|
    t.integer :post_id, :tag_id
  end

  create_table :tags, :force => true do |t|
    t.string :name
  end

  create_table :state, :force => true do |t|
    t.string :name
  end

end