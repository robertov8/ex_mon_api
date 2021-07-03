defmodule ExMon.Pokemon.Get do
  alias ExMon.PokeApi.Client
  alias ExMon.Pokemon

  def call(name) do
    name
    |> Client.get_pokemon()
    |> handle_response()
  end

  def handle_response({:ok, body}), do: {:ok, Pokemon.build(body)}
  def handle_response({:error, _reason} = error), do: error
end
