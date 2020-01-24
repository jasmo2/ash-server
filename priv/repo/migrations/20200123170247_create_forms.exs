defmodule AshServer.Repo.Migrations.CreateForms do
  use Ecto.Migration

  def change do
    create table(:forms) do
      add :name, :string
      add :token, :string
      add :user_id, references(:users, on_delete: :nilify_all)

      timestamps()
    end

    create index(:forms, [:user_id])
  end
end
