defmodule Exlivery.Orders.Report do
  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Item
  alias Exlivery.Orders.Order

  def create(filename \\ "report.csv") do
    File.write(filename, build_order_list())
  end

  defp build_order_list() do
    OrderAgent.get()
    |> Map.values()
    |> Enum.map(&order_to_string/1)
  end

  defp order_to_string(%Order{
         items: items,
         preco_total: preco_total,
         user_cpf: cpf
       }) do
    itens_string =
      items
      |> Enum.reduce([], &item_to_string/2)

    "#{cpf},[#{itens_string}],#{preco_total}\n"
  end

  defp item_to_string(%Item{preco: preco, categoria: categoria, quantidade: quantidade}, acc) do
    ["#{preco},#{categoria},#{quantidade}," | acc]
  end
end
