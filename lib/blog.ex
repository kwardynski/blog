defmodule Blog do
  use Phoenix.Component
  import Phoenix.HTML

  alias Blog.Content

  @output_dir "./output"

  def build do
    File.mkdir_p!(@output_dir)

    posts = Content.all_posts()
    render_file("index.html", index(%{posts: posts}))

    Enum.each(posts, fn post ->
      dir = Path.dirname(post.path)
      maybe_make_post_dir(dir)
      render_file(post.path, post(%{post: post}))
    end)
  end

  defp maybe_make_post_dir(dir) do
    if dir != "." do
      path = Path.join([@output_dir, dir])
      File.mkdir_p!(path)
    end
  end

  def render_file(path, rendered) do
    safe = Phoenix.HTML.Safe.to_iodata(rendered)
    output = Path.join([@output_dir, path])
    File.write!(output, safe)
  end

  def index(assigns) do
    ~H"""
    <.layout>
      <h1>The Blog</h1>
      <h2>The Posts</h2>
      <ul>
        <li :for={post <- @posts}>
          <a href={post.path}> <%= post.title %> </a>
        </li>
      </ul>
    </.layout>
    """
  end

  def post(assigns) do
    ~H"""
    <.layout>
      <%= raw @post.body %>
    </.layout>
    """
  end

  def layout(assigns) do
    ~H"""
    <html>
      <body>
        <%= render_slot(@inner_block) %>
      </body>
    </html>
    """
  end
end
