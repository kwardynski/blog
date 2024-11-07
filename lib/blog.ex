# https://fly.io/phoenix-files/crafting-your-own-static-site-generator-using-phoenix/
# https://mishka.tools/blog/build-a-static-site-in-elixir-under-5-minutes-with-phoenix-components

defmodule Blog do
  alias Blog.Post

  use NimblePublisher,
    build: Post,
    from: "./priv/posts/**/*.md",
    as: :posts,
    highlighters: [:makeup_elixir, :makeup_erlang]

  @posts Enum.sort_by(@posts, & &1, {:desc, Date})

  def all_posts, do: @posts
end
