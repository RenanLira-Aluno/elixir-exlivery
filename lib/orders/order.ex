defmodule Exlivery.Orders.Order do
  alias Exlivery.Orders.Item
  alias Exlivery.Users.User

  @keys [:user_cpf, :endereco_entrega, :items, :preco_total]
  @enforce_keys @keys

  defstruct @keys

  def build(%User{cpf: cpf, endereco: endereco}, [%Item{} | _itens] = items) do
    {:ok,
     %__MODULE__{
       user_cpf: cpf,
       endereco_entrega: endereco,
       items: items,
       preco_total: calcula_preco_total(items)
     }}
  end

  def build(_user, _itens) do
    {:error, "parametros inválidos"}
  end

  defp calcula_preco_total(items) do
    Enum.reduce(items, Decimal.new("0.00"), fn item, acc ->
      item.preco
      |> Decimal.mult(item.quantidade)
      |> Decimal.add(acc)
    end)
  end
end
