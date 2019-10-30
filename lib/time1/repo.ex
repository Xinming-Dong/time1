defmodule Time1.Repo do
  use Ecto.Repo,
    otp_app: :time1,
    adapter: Ecto.Adapters.Postgres
end
