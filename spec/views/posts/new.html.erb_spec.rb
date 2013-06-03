require 'spec_helper'

describe "posts/new" do
  before(:each) do
    assign(:post, stub_model(Post,
      :slug => "MyString",
      :title => "MyString",
      :content => "MyText",
      :user => nil
    ).as_new_record)
  end

  it "renders new post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", posts_path, "post" do
      assert_select "input#post_slug[name=?]", "post[slug]"
      assert_select "input#post_title[name=?]", "post[title]"
      assert_select "textarea#post_content[name=?]", "post[content]"
      assert_select "input#post_user[name=?]", "post[user]"
    end
  end
end
