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
    test "quando um usuario é encontrado, retorna um usuario" do
      UserAgent.start_link(%{})

      user = build(:user)

      UserAgent.save(user)

      assert UserAgent.get(user.cpf) == {:ok, user}
    end

    test "quando um usuario nâo é encontrado, retorna um error" do
      UserAgent.start_link(%{})

      user = build(:user)

      assert UserAgent.get(user.cpf) == {:error, "Usuário não encontrado"}
    end
  end
end
