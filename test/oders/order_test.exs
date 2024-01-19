defmodule Exlivery.Oders.OrderTest do
  use ExUnit.Case

  alias Exlivery.Orders.Order

  import Exlivery.Factory

  describe "build/2" do
    test "quando todos os parametros são validos, retorna um pedido" do
      user = build(:user)
      itens = build_list(2, :item)

      response = Order.build(user, itens)

      expected = {:ok, build(:order)}

      assert expected == response
    end

    test "quando o pedido não tem itens, retorna um erro" do
      user = build(:user)
      itens = []

      response = Order.build(user, itens)

      expected = {:error, "parametros inválidos"}

      assert expected == response
    end
  end
end
