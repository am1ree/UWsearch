defmodule Uwsearch.JsonTable do
  use GenServer

  def start_link(_args) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(state) do
    :ets.new(:json_table, [:set, :public, :named_table])
    populate_ets_table()
    {:ok, state}
  end

  defp populate_ets_table() do
    json_data = Uwsearch.Dbquery.db2dic()

    Enum.each(json_data, fn item ->
      id = item["courseId"]
      :ets.insert(:json_table, {id, item})
    end)
  end

  def get_item_by_id(id) do
    case :ets.lookup(:json_table, id) do
      [{^id, item}] -> item
      _ -> nil
    end
  end
end
