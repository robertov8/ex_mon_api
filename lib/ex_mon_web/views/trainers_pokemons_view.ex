defmodule ExMonWeb.TrainersPokemonsView do
  use ExMonWeb, :view

  alias ExMon.Trainer.Pokemon

  def render("create.json", %{
        pokemon: %Pokemon{
          id: id,
          name: name,
          nickname: nickname,
          types: types,
          trainer: trainer_id,
          weight: weight,
          inserted_at: inserted_at
        }
      }) do
    %{
      message: "Pokemon created!",
      pokemon: %{
        id: id,
        name: name,
        nickname: nickname,
        types: types,
        trainer_id: trainer_id,
        weight: weight,
        inserted_at: inserted_at
      }
    }
  end

  def render("show.json", %{
        pokemon: %Pokemon{
          id: id,
          name: name,
          nickname: nickname,
          types: types,
          trainer: %{id: trainer_id, name: trainer_name},
          weight: weight,
          inserted_at: inserted_at
        }
      }) do
    %{
      pokemon: %{
        id: id,
        name: name,
        nickname: nickname,
        types: types,
        trainer_id: trainer_id,
        trainer: %{id: trainer_id, name: trainer_name},
        weight: weight,
        inserted_at: inserted_at
      }
    }
  end

  def render("update.json", %{
        pokemon: %Pokemon{
          id: id,
          name: name,
          nickname: nickname,
          types: types,
          trainer_id: trainer_id,
          weight: weight,
          inserted_at: inserted_at
        }
      }) do
    %{
      message: "Pokemon updated!",
      pokemon: %{
        id: id,
        name: name,
        nickname: nickname,
        types: types,
        trainer_id: trainer_id,
        weight: weight,
        inserted_at: inserted_at
      }
    }
  end
end
