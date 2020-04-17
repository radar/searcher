require 'spec_helper'

describe Searcher do
  let(:search_results) { subject }
  let(:first_result) { subject.first }

  context "habtm label search" do
    subject { Ticket.search("tag:bug") }
    it "finds a ticket" do
      expect(first_result.description).to eq("Hello world! You are awesome.")
    end
  end

  context "belongs_to label search" do
    subject { Ticket.search("state:Open") }
    it "finds a ticket" do
      expect(first_result.description).to eq("Hello world! You are awesome.")
    end
  end

  context "combined search" do
    subject { Ticket.search("tag:bug state:Open") }
    it "finds a ticket" do
      expect(first_result.description).to eq("Hello world! You are awesome.")
    end
  end

  context "no tickets with tag feature" do
    subject { Ticket.search("tag:feature state:Open") }
    it "finds a ticket" do
      expect(first_result).to be_nil
    end
  end

  context "undefined label search" do
    subject { Ticket.search("undefined:true") }
    it "returns all the records" do
      expect(search_results).to eq(Ticket.all)
    end
  end
end
