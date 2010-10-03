require 'spec_helper'

describe Searcher do
  let(:search_results) { subject }
  let(:first_result) { subject.first }
  
  context "default field" do
    subject { Ticket.search("Hello") }
  
    it "first result" do
      first_result.description.should eql("Hello world! You are awesome.")
    end
  end
  
  context "label search" do  
    subject { Ticket.search("tag:bug") }
    it "has_and_belongs_to_many" do
      first_result.description.should eql("Hello world! You are awesome.")
    end
  end
end
