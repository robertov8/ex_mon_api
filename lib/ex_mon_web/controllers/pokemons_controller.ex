defmodule ExMonWeb.PokemonsController do
  use ExMonWeb, :controller

  action_fallback ExMonWeb.FallbackController

  def show(conn, %{"name" => name}) do
    name
    |> ExMon.fetch_pokemon()
    |> render_response(conn)
  end

  defp render_response({:ok, pokemon}, conn) do
    conn
    |> put_status(:ok)
    |> json(pokemon)
  end

  defp render_response({:error, _reason} = error, _conn), do: error
end
