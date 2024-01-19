defmodule Exlivery.Factory do
  use ExMachina
  alias Exlivery.Users.User
  alias Exlivery.Orders.{Item, Order}

  def user_factory do
    %User{
      nome: "João",
      email: "joao@email.com",
      cpf: "123456789",
      idade: 18,
      endereco: "Rua dos Bobos, 0"
    }
  end

  def item_factory do
    %Item{
      nome: "Pizza",
      categoria: :pizza,
      preco: Decimal.new("10.00"),
      quantidade: 1
    }
  end

  def order_factory do
    %Order{
      user_cpf: "123456789",
      endereco_entrega: "Rua dos Bobos, 0",
      items: [
        %Item{
          nome: "Pizza",
          preco: Decimal.new("10.00"),
          categoria: :pizza,
          quantidade: 1
        },
        %Item{
          nome: "Pizza",
          preco: Decimal.new("10.00"),
          categoria: :pizza,
          quantidade: 1
        }
      ],
      preco_total: Decimal.new("20.00")
    }
  end
end
