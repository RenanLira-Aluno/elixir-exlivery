defmodule Exlivery.Factory do
  use ExMachina
  alias Exlivery.Users.User

  def user_factory do
    %User{
      nome: "João",
      email: "joao@email.com",
      cpf: "123456789",
      idade: 18,
      endereco: "Rua dos Bobos, 0"
    }
  end
end
