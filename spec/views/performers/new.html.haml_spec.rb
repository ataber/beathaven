require 'spec_helper'

describe "performers/new" do
  before(:each) do
    assign(:performer, stub_model(Performer).as_new_record)
  end

  it "renders new performer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", performers_path, "post" do
    end
  end
end
