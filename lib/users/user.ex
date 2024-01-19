defmodule Exlivery.Users.User do
  @keys [:nome, :email, :cpf, :idade, :endereco]
  @enforce_keys @keys

  defstruct @keys

  def build(nome, email, cpf, idade, endereco) when idade >= 18 and is_bitstring(cpf) do
    {:ok,
     %__MODULE__{
       nome: nome,
       endereco: endereco,
       email: email,
       cpf: cpf,
       idade: idade
     }}
  end

  def build(_nome, _email, _cpf, _idade, _endereco) do
    {:error, "Idade inválida"}
  end
end
