defmodule UwsearchWeb.PageController do
  alias ElixirLS.LanguageServer.Experimental.Protocol.Proto.Macros.Json
  use UwsearchWeb, :controller

alias ElixirLS.LanguageServer.Experimental.Protocol.Proto.Macros.Json
alias Uwsearch.Dbquery
alias Elasticlunr.IndexManager
alias Elasticlunr.{Index, Pipeline, DocumentStore}


  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def getcourses(conn, _params) do
    results = Uwsearch.Dbquery.db2dic()
    json(conn, results)
  end

  def getindices(conn, _params) do
    IO.inspect(IndexManager.get("courses_index"))
    text(conn, IndexManager.loaded_indices())
  end

  def search(conn, %{"query" => query}) do
    index = IndexManager.get("courses_index")
    result = Index.search(index, query)
    res = lookup_items_by_refs(result)
    json(conn, res)
  end

  def getbyid(conn, %{"query" => query}) do
    result = Uwsearch.JsonTable.get_item_by_id(query)
    IO.inspect(result)
    json(conn,result)
  end

  defp lookup_items_by_refs(object_list) do
    Enum.reduce(object_list, [], fn %{ref: ref}, acc ->
      case Uwsearch.JsonTable.get_item_by_id(ref) do
        nil ->
          acc
        item ->
          [item | acc]
      end
    end)
    |> Enum.reverse()
  end

  def loadindex(conn, _params) do
    index = Index.new(pipeline: Pipeline.new(Pipeline.default_runners()), name: "courses_index", ref: "courseId")
    index =
      index
      |> Index.add_field("description")
      |> Index.add_field("catalogNumber")
      |> Index.add_field("descriptionAbbreviated")
      |> Index.add_field("subjectCode")
      |> Index.add_documents(Uwsearch.Dbquery.db2dic())
    text(conn, IndexManager.save(index))
  end
end
