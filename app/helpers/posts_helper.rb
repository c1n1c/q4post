module PostsHelper
  def post_synopsys(post)
    # @see ActionView::Helpers::TextHelper#truncate
    truncate(post.content, :length => 50, :separator => ' ')
  end
end
