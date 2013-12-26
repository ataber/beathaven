require 'spec_helper'

describe "performers/edit" do
  before(:each) do
    @performer = assign(:performer, stub_model(Performer))
  end

  it "renders the edit performer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", performer_path(@performer), "post" do
    end
  end
end
