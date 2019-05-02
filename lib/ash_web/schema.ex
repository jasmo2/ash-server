defmodule AshWeb.Schema do
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)
  import_types(AshWeb.Schema.GenericTypes)
  import_types(AshWeb.Schema.UserTypes)
  import_types(AshWeb.Schema.PostTypes)

  # """
  # Queries
  # """
  query do
    import_fields(:user_queries)
    import_fields(:post_queries)
  end

  # """
  # Mutations
  # """
  mutation do
    import_fields(:user_mutations)
    import_fields(:post_mutations)
  end

  # """
  # Subscriptions
  # """
  # subscription do
  #   import_fields :thing_subscriptions
  # end


  # def middleware(middleware, _field, %Absinthe.Type.Object{identifier: identifier})
  #     when identifier in [:query, :subscription, :mutation] do
  #   [AshWeb.AuthMiddleware | middleware]
  # end
  # def middleware(middleware, _field, _object) do
  #   middleware
  # end
end
