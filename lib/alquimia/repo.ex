defmodule Alquimia.Repo do
  use Ecto.Repo,
    otp_app: :alquimia,
    adapter: Ecto.Adapters.Postgres
end
