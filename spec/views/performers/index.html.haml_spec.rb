require 'spec_helper'

describe "performers/index" do
  before(:each) do
    assign(:performers, [
      stub_model(Performer),
      stub_model(Performer)
    ])
  end

  it "renders a list of performers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
