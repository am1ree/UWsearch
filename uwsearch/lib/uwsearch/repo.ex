defmodule Uwsearch.Repo do
  use Ecto.Repo,
    otp_app: :uwsearch,
    adapter: Ecto.Adapters.Postgres
end
