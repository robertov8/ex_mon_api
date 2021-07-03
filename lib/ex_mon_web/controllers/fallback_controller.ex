defmodule ExMonWeb.FallbackController do
  use ExMonWeb, :controller

  action_fallback ExMonWeb.FallbackController

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ExMonWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
