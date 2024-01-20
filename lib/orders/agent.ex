defmodule Exlivery.Orders.Agent do
  alias Exlivery.Orders.Order

  use Agent

  def start_link(_params) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%Order{} = order) do
    id = UUID.uuid4()
    Agent.update(__MODULE__, &update_state(&1, order, id))

    {:ok, id}
  end

  def get(id) do
    Agent.get(__MODULE__, &get_order(&1, id))
  end

  defp get_order(state, id) do
    state
    |> Map.get(id)
    |> case do
      nil -> {:error, "Pedido não encontrado"}
      order -> {:ok, order}
    end
  end

  defp update_state(state, %Order{} = order, id) do
    Map.put(state, id, order)
  end
end
