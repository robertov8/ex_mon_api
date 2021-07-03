defmodule ExMon.Trainer.Show do
  alias ExMon.{Trainer, Repo}
  alias Ecto.UUID

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, uuid} -> delete(uuid)
    end
  end

  defp delete(uuid) do
    case Repo.get(Trainer, uuid) do
      nil -> {:error, "Trainer not found!"}
      trainer -> {:ok, Repo.preload(trainer, :pokemon)}
    end
  end
end
