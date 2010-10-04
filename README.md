# Searcher

Searcher is a pure SQL implementation which lets you find by pre-defined labels, as well as wildcard matching queries. It should be used as a lo-fi precursor to a proper full-text search platform, such as the built-in one to PostgreSQL.

The idea of this gem came from Joost Schuur.

This gem is used in Chapter 10 of Rails 3 in Action and was crafted specifically for it. YMMV.

## Installation

This gem is only compatible with versions of Active Record that are greater than or equal to 3.0. You *are* using Active Record 3, right?

Add this gem to your _Gemfile_ (You *are* using Bundler, right?):

    gem 'searcher'
    
## Usage

To define labels for your field, use the `searcher` method inside your model like this:

    class Ticket < ActiveRecord::Base
      has_and_belongs_to_many :tags
      
      searcher do
        external :tag, :from => :tags, :field => "name"
        external :state, :from => :state, :field => "name"
      end
    end
    
To query for these labels, use the `search` class method on your model:

    Ticket.search("tag:v3.0.0 state:open")
    
Boom! There's all your tickets that have the tag v3.0.0 and are marked (state-wise) as being open.
        
## Caveats

Currently Searcher works only with `has_and_belongs_to_many` and `belongs_to` associations, as that is all that is needed in the book.
