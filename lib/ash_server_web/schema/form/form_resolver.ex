defmodule AshServerWeb.Schema.FormResolver do
  alias AshServer.Forms
  alias AshServer.Accounts.User
  alias AppWeb.ErrorHelper

  def all(_args, _info) do
    {:ok, Forms.list_forms()}
  end

  def find(%{id: id}, _info) do
    try do
      form = Forms.get_form!(id)
      {:ok, form}
    rescue
      e -> {:error, Exception.message(e)}
    end
  end

  def find_by_user(%{id: id}, _info) do
    try do
      forms =
        User.get_form!(id)
        |> Ecto.assoc(:forms)

      {:ok, forms}
    rescue
      e -> {:error, Exception.message(e)}
    end
  end

  def create(args, _info) do
    case Forms.create_form(args) do
      {:ok, form} -> {:ok, form}
      {:error, changeset} -> ErrorHelper.format_errors(changeset)
    end
  end

  def update(%{id: id, form: form_params}, _info) do
    Forms.get_form!(id)
    |> Forms.update_form(form_params)
  end

  def delete(%{id: id}, _info) do
    try do
      Forms.get_form!(id)
      |> Forms.delete_form()
    rescue
      e -> {:error, Exception.message(e)}
    end
  end
end
