defmodule Exlivery.Users.Agent do
  alias Exlivery.Users.User

  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%User{} = user) do
    Agent.update(__MODULE__, &update_state(&1, user))
  end

  def get(cpf) do
    Agent.get(__MODULE__, &get_user(&1, cpf))
  end

  defp update_state(state, %User{cpf: cpf} = user) do
    Map.put(state, cpf, user)
  end

  defp get_user(state, cpf) do
    state
    |> Map.get(cpf)
    |> case do
      nil -> {:error, "Usuário não encontrado"}
      user -> {:ok, user}
    end
  end
end
