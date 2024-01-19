defmodule Exlivery.Users.UserTest do
  use ExUnit.Case

  alias Exlivery.Users.User

  import Exlivery.Factory

  describe "build/5" do
    test "criando usuario" do
      response = User.build("João", "joao@email.com", "123456789", 18, "Rua dos Bobos, 0")

      expected = build(:user)

      assert {:ok, expected} == response
    end

    test "parametros inválidos" do
      response = User.build("João", "joao@email.com", "123456789", 1, "Rua dos Bobos, 0")

      assert {:error, _msg} = response
    end
  end
end
