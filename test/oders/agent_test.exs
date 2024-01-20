defmodule Exlivery.Oders.AgentTest do
  use ExUnit.Case

  alias Exlivery.Orders.Agent, as: OrderAgent

  import Exlivery.Factory

  describe "save/1" do
    test "salvar um pedido" do
      OrderAgent.start_link(%{})

      order = build(:order)

      assert {:ok, _id} = OrderAgent.save(order)
    end
  end

  describe "get/1" do
    setup %{} do
      OrderAgent.start_link(%{})

      order = build(:order)

      {:ok, order: order}
    end

    test "dado um id valido, retorna uma order", %{order: order} do
      {:ok, id} =
        order
        |> OrderAgent.save()

      assert OrderAgent.get(id) == {:ok, order}
    end

    test "quando um id não é valido, retorna um error" do
      
    end
  end
end
