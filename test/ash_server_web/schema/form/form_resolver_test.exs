defmodule AshServerWeb.FormResolverTest do
  use AshServerWeb.ConnCase
  import AshServer.FormFactory

  describe "form resolver" do
    test "lists all forms", %{conn: conn} do
      forms = insert_list(3, :form)

      query = """
        {
          forms {
            id
          }
        }
      """

      response = post_gql(conn, %{query: query})

      assert response["data"]["forms"] == to_id_array(forms)
    end

    test "finds a form by id", %{conn: conn} do
      form = insert(:form)

      query = """
        {
          form(id: #{form.id}) {
            id
            name
            token
          }
        }
      """

      response = post_gql(conn, %{query: query})

      assert response["data"]["form"] == %{
        "id" => to_string(form.id),
        "name" => form.name,
        "token" => form.token,
      }
    end

  test "errors when looking for a nonexistent form by id", %{conn: conn} do
      query = """
        {
          form(id: "doesnt exist") {
            id
          }
        }
      """

      response = post_gql(conn, %{query: query})

      assert response["data"] == nil
      assert response["errors"]
    end

    test "creates a new form", %{conn: conn} do
      form_params = params_for(:form, %{
        name: "some name",
        token: "some token",
      })

      query = """
        mutation {
          createForm(
            name: #{inspect form_params.name},
            token: #{inspect form_params.token},
          ) {
            name
            token
          }
        }
      """

      response = post_gql(conn, %{query: query})

      assert response["data"]["createForm"] == %{
        "name" => form_params.name,
        "token" => form_params.token,
      }
    end

    test "updates a form", %{conn: conn} do
      form = insert(:form)

      query = """
        mutation UpdateForm($id: ID!, $form: UpdateFormParams!) {
          updateForm(id:$id, form:$form) {
            id
            name
            token
          }
        }
      """

      variables = %{
        id: form.id,
        form: %{
          name: "some updated name",
          token: "some updated token",
        }
      }

      response = post_gql(conn, %{query: query, variables: variables})

      assert response["data"]["updateForm"] == %{
        "id" => to_string(form.id), 
        "name" => variables.form.name,
        "token" => variables.form.token,
      }
    end
  end

  test "deletes a form", %{conn: conn} do
    form = insert(:form)

    query = """
      mutation {
        deleteForm(id: #{form.id}) {
          id
        }
      }
    """

    response = post_gql(conn, %{query: query})

    assert response["data"]["deleteForm"] == %{
      "id" => to_string(form.id)
    }
  end
end
