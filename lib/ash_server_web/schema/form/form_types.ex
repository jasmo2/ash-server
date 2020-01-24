defmodule AshServerWeb.Schema.FormTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: App.Repo

  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias AshServerWeb.Schema.FormResolver

  @desc "A form"
  object :form do
    field(:id, :id)
    field(:name, :string)
    field(:token, :string)
    field(:user, :user, resolve: dataloader(Forms))
  end

  input_object :update_form_params do
    field(:name, :string)
    field(:token, :string)
    field(:user_id, :id)
  end

  object :form_queries do
    @desc "A single form"
    field :form, non_null(:form) do
      arg(:id, non_null(:id))
      resolve(&FormResolver.find/2)
    end

    @desc "A list of forms"
    field :forms, list_of(:form) do
      resolve(&FormResolver.all/2)
    end
  end

  object :form_mutations do
    @desc "Create a form"
    field :create_form, :form do
      arg(:name, :string)
      arg(:token, :string)
      arg(:user_id, :id)

      resolve(&FormResolver.create/2)
    end

    @desc "Update a form"
    field :update_form, :form do
      arg(:id, non_null(:id))
      arg(:form, :update_form_params)

      resolve(&FormResolver.update/2)
    end

    @desc "Delete a form"
    field :delete_form, :form do
      arg(:id, non_null(:id))

      resolve(&FormResolver.delete/2)
    end
  end
end
