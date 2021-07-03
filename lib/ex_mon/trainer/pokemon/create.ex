defmodule ExMon.Trainer.Pokemon.Create do
  alias ExMon.Repo
  alias ExMon.Pokemon
  alias ExMon.Trainer
  alias ExMon.Trainer.Pokemon, as: TrainerPokemon
  alias ExMon.PokeApi.Client

  def call(%{"name" => name} = params) do
    name
    |> Client.get_pokemon()
    |> handle_response(params)
  end

  defp handle_response({:ok, body}, params) do
    body
    |> Pokemon.build()
    |> create_pokemon(params)
  end

  defp handle_response({:error, _msg} = error, _params), do: error

  defp create_pokemon(%Pokemon{name: name, weight: weight, types: types}, %{
         "nickname" => nickname,
         "trainer_id" => trainer_id
       }) do
    params = %{
      name: name,
      weight: weight,
      types: types,
      nickname: nickname,
      trainer_id: trainer_id
    }

    params
    |> TrainerPokemon.build()
    |> handle_build()
  end

  defp handle_build({:ok, %{trainer_id: trainer_id} = pokemon}) do
    trainer_id
    |> fetch_trainer()
    |> handle_insert(pokemon)
  end

  defp handle_build({:error, _changeset} = error), do: error

  defp fetch_trainer(uuid), do: Repo.get(Trainer, uuid)

  defp handle_insert(%Trainer{}, pokemon), do: Repo.insert(pokemon)
  defp handle_insert(_result, _pokemon), do: {:error, "Invalid Trainer"}
end
