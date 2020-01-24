defmodule AshServer.Forms.Policy do
  @moduledoc """
  Authorize a user's ability to call Forms actions.

    @param {atom} action - the function being called in the module
    @param {struct} user - the user (typically current_user) to authorize
    @param {struct} resource - the resource they are trying top modify
  """
  @behaviour Bodyguard.Policy

  # Catch all
  def authorize(_action, _user, _resource), do: true
end
