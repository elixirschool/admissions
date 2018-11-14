defmodule Admissions.Repo do
  use Ecto.Repo,
    otp_app: :admissions,
    adapter: Ecto.Adapters.Postgres
end
