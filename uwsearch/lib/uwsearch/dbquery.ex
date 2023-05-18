defmodule Uwsearch.Dbquery do
  alias Jason
  def db2dic() do
    {:ok, data} = File.read("lib/uwsearch/data/courses.json")
    {:ok, result} = Jason.decode(data)
    result
  end

end
