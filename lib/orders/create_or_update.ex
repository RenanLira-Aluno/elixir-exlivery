defmodule Exlivery.Orders.CreateOrUpdate do
  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Item
  alias Exlivery.Orders.Order
  alias Exlivery.Users.Agent, as: UserAgent

  def call(%{cpf: cpf, items: items}) do
    with {:ok, user} <- UserAgent.get(cpf),
         {:ok, items_builded} <- build_items(items),
         {:ok, order} <- Order.build(user, items_builded) do
      OrderAgent.save(order)
    else
      {:error, message} -> {:error, message}
    end
  end

  # Private functions

  defp build_items(items) do
    builded_items = Enum.map(items, &build_item/1)

    builded_items
    |> Enum.all?(fn item -> is_struct(item) end)
    |> case do
      true -> {:ok, builded_items}
      false -> {:error, "parametros inválidos"}
    end
  end

  defp build_item(%{nome: nome, preco: preco, categoria: categoria, quantidade: quantidade}) do
    Item.build(nome, preco, categoria, quantidade)
    |> case do
      {:ok, item} -> item
      {:error, message} -> {:error, message}
    end
  end

  defp build_item(_), do: {:error, "parametros inválidos"}
end
