defmodule Exlivery.Users.AgentTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent, as: UserAgent

  import Exlivery.Factory

  describe "save/1" do
    test "Salvar um usuario" do
      UserAgent.start_link(%{})

      user = build(:user)

      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})

      user = build(:user)

      {:ok, user: user}
    end

    test "quando um usuario é encontrado, retorna um usuario", %{user: user} do
      UserAgent.save(user)

      assert UserAgent.get(user.cpf) == {:ok, user}
    end

    test "quando um usuario nâo é encontrado, retorna um error", %{user: user} do
      assert UserAgent.get(user.cpf) == {:error, "Usuário não encontrado"}
    end
  end
end
