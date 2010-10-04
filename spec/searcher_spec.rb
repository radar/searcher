require 'spec_helper'

describe Searcher do
  let(:search_results) { subject }
  let(:first_result) { subject.first }
  
  context "habtm label search" do  
    subject { Ticket.search("tag:bug") }
    it "finds a ticket" do
      first_result.description.should eql("Hello world! You are awesome.")
    end
  end
  
  context "belongs_to label search" do
    subject { Ticket.search("state:Open") }
    it "finds a ticket" do
      first_result.description.should eql("Hello world! You are awesome.")
    end
  end
  
end
