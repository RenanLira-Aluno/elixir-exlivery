defmodule Exlivery.Oders.ItemTest do
  use ExUnit.Case

  alias Exlivery.Orders.Item

  import Exlivery.Factory

  describe "build/4" do
    test "criando item" do
      response = Item.build("Pizza", "10.00", :pizza, 1)

      expected = {:ok, build(:item)}

      assert expected == response
    end

    test "quando a categoria esta invalida, retorna um erro" do
      response = Item.build("Pizza", "10.00", :invalida, 1)

      expected = {:error, "parametros inválidos"}

      assert expected == response
    end

    test "quando for um preco invalido, retorna um erro" do
      response = Item.build("Pizza", "preco_invalido", :pizza, 1)

      expected = {:error, "preço inválido"}

      assert expected == response
    end

    test "quando for uma quantidade errada, retorna um erro" do
      response = Item.build("Pizza", "10.00", :pizza, 0)

      expected = {:error, "parametros inválidos"}

      assert expected == response
    end
  end
end
