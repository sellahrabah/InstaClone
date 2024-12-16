require 'rails_helper'

RSpec.describe "comments/show", type: :view do
  before(:each) do
    assign(:comment, Comment.create!(
      text: "Text",
      user_id: "User",
      post_id: "Post"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Text/)
    expect(rendered).to match(/User/)
    expect(rendered).to match(/Post/)
  end
end
