defmodule Exlivery.Users.CreateOrUpdate do
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.User

  def call(%{nome: nome, email: email, cpf: cpf, idade: idade, endereco: endereco}) do
    with {:ok, user} <- User.build(nome, email, cpf, idade, endereco),
         :ok <- UserAgent.save(user) do
      {:ok, user.cpf}
    else
      {:error, message} -> {:error, message}
    end
  end

  def call(_), do: {:error, "parametros inválidos"}
end
