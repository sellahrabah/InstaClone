require 'rails_helper'

RSpec.describe "comments/index", type: :view do
  before(:each) do
    assign(:comments, [
      Comment.create!(
        text: "Text",
        user_id: "User",
        post_id: "Post"
      ),
      Comment.create!(
        text: "Text",
        user_id: "User",
        post_id: "Post"
      )
    ])
  end

  it "renders a list of comments" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Text".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("User".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Post".to_s), count: 2
  end
end
