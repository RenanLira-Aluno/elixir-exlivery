defmodule Exlivery.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.CreateOrUpdate

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "quando todos os parametros são validos, retorna um user" do
      params = %{
        nome: "Renan",
        endereco: "Rua 1",
        email: "renan@email.com",
        cpf: "12345678901",
        idade: 20
      }

      expected = {:ok, "12345678901"}

      user =
        params
        |> CreateOrUpdate.call()

      assert user == expected
    end

    test "quando idade é menor que 18, retorna um error" do
      params = %{
        nome: "Renan",
        endereco: "Rua 1",
        email: "renan@email.com",
        cpf: "12345678901",
        idade: 15
      }

      expected = {:error, "Idade inválida"}

      user =
        params
        |> CreateOrUpdate.call()

      assert user == expected
    end

    test "quando algum parametro está errado, retorna um error" do
      params = %{
        nome: "Renan",
        endereco: "Rua 1",
        email: "renan@email.com",
        idade: 19
      }

      expected = {:error, "parametros inválidos"}

      user =
        params
        |> CreateOrUpdate.call()

      assert user == expected
    end
  end
end
