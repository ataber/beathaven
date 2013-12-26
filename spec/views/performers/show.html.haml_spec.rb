require 'spec_helper'

describe "performers/show" do
  before(:each) do
    @performer = assign(:performer, stub_model(Performer))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
