defmodule ExMon.Trainer.CreateTest do
  use ExMon.DataCase

  alias ExMon.{Repo, Trainer}
  alias Trainer.Create

  describe "call/1" do
    test "when all params are valid, create a trainer" do
      params = %{name: "Roberto", password: "123456"}

      count_before = Repo.aggregate(Trainer, :count)

      response = Create.call(params)

      count_after = Repo.aggregate(Trainer, :count)

      assert {:ok, %Trainer{name: "Roberto"}} = response
      assert count_after > count_before
    end

    test "when there are invalid params, returns the error" do
      params = %{name: "Roberto", password: ""}

      response = Create.call(params)

      assert {:error, changeset} = response
      assert errors_on(changeset) == %{password: ["can't be blank"]}
    end
  end
end
