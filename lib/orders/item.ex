defmodule Exlivery.Orders.Item do
  @categorias [
    :pizza,
    :hamburguer,
    :bebida,
    :prato_feito
  ]

  @keys [:nome, :preco, :categoria, :quantidade]

  @enforce_keys @keys

  defstruct @keys

  def build(nome, preco, categoria, quantidade)
      when quantidade > 0 and categoria in @categorias do
    preco
    |> Decimal.cast()
    |> case do
      {:ok, preco} ->
        {:ok,
         %__MODULE__{
           nome: nome,
           preco: preco,
           categoria: categoria,
           quantidade: quantidade
         }}

      _ ->
        {:error, "preço inválido"}
    end
  end

  def build(_nome, _preco, _categoria, _quantidade) do
    {:error, "parametros inválidos"}
  end
end
