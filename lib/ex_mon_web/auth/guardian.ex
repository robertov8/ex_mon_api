defmodule ExMonWeb.Auth.Guardian do
  use Guardian, otp_app: :ex_mon

  alias Ecto.UUID
  alias ExMon.{Repo, Trainer}

  def subject_for_token(trainer, _claims) do
    sub = to_string(trainer.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> ExMon.fetch_trainer()
  end

  def authenticate(%{"id" => trainer_id} = params) do
    case UUID.cast(trainer_id) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, uuid} -> get_trainer(uuid, params)
    end
  end

  defp get_trainer(uuid, %{"id" => trainer_id, "password" => password}) do
    case Repo.get(Trainer, uuid) do
      nil -> {:error, trainer_id}
      trainer -> validate_password(trainer, password)
    end
  end

  defp validate_password(%Trainer{password_hash: password_hash} = trainer, password) do
    case Argon2.verify_pass(password, password_hash) do
      true -> create_token(trainer)
      false -> {:error, :unauthorized}
    end
  end

  defp create_token(trainer) do
    {:ok, token, _claims} = encode_and_sign(trainer)

    {:ok, token}
  end
end
