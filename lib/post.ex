defmodule Blog.Post do
  @enforce_keys [:id, :author, :title, :body, :description, :tags, :date, :path]

  defstruct [:id, :author, :title, :body, :description, :tags, :date, :path]

  def build(filename, attrs, body) do
    path = Path.rootname(filename)
    id_components = id_components_from_path(path)
    html_path = path <> ".html"

    derived_attrs = [id: id_components.id, date: id_components.date, body: body, path: html_path]

    blog_attrs =
      attrs
      |> Map.to_list()
      |> Enum.concat(derived_attrs)

    struct!(__MODULE__, blog_attrs)
  end

  defp id_components_from_path(path) do
    [year, month_day_id] = path |> Path.split() |> Enum.take(-2)
    [month, day, id] = String.split(month_day_id, "-", parts: 3)
    date = Date.from_iso8601!("#{year}-#{month}-#{day}")

    %{
      id: id,
      date: date
    }
  end
end
