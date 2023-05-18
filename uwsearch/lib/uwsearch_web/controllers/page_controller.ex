defmodule UwsearchWeb.PageController do
  alias ElixirLS.LanguageServer.Experimental.Protocol.Proto.Macros.Json
  use UwsearchWeb, :controller

alias ElixirLS.LanguageServer.Experimental.Protocol.Proto.Macros.Json
alias Uwsearch.Dbquery

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def getcourses(conn, _parms) do
    results = Uwsearch.Dbquery.db2dic()
    json(conn, results)
  end
end
