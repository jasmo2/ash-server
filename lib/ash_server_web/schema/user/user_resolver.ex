defmodule AshServerWeb.Schema.UserResolver do
  alias AshServer.Accounts
  alias AshServerWeb.ErrorHelper

  def all(args, _info) do
    {:ok, Accounts.list_users(args)}
  end

  def find(%{id: id}, _info) do
    try do
      user = Accounts.get_user!(id)
      {:ok, user}
    rescue
      e -> {:error, Exception.message(e)}
    end
  end

  def find(args, _info) do
    try do
      case Accounts.get_user_by(args) do
        nil -> {:error, "Can't find a user with given parameters"}
        user -> {:ok, user}
      end
    rescue
      e -> {:error, Exception.message(e)}
    end
  end

  def create(args, _info) do
    case Accounts.create_user(args) do
      {:ok, user} -> {:ok, user}
      {:error, changeset} -> ErrorHelper.format_errors(changeset)
    end
  end

  def update(%{id: id, user: user_params}, _info) do
    Accounts.get_user!(id)
    |> Accounts.update_user(user_params)
  end

  def delete(%{id: id}, _info) do
    try do
      Accounts.get_user!(id)
      |> Accounts.delete_user()
    rescue
      e -> {:error, Exception.message(e)}
    end
  end
end
