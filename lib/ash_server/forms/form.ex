defmodule AshServer.Forms.Form do
  use Ecto.Schema
  import Ecto.Changeset
  alias AshServer.Accounts.User

  schema "forms" do
    field(:name, :string)
    field(:token, :string)
    belongs_to(:user, User)

    timestamps()
  end

  @doc false
  def changeset(form, attrs) do
    form
    |> cast(attrs, [:name, :token])
    |> validate_required([:name, :token])
  end
end
