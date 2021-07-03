defmodule ExMon.TrainerTest do
  use ExMon.DataCase

  alias ExMon.Trainer

  describe "changeset/1" do
    test "when all params are valid, return a valid changeset" do
      params = %{name: "Roberto", password: "123456"}

      response = Trainer.changeset(params)

      assert %Ecto.Changeset{
               changes: %{
                 name: "Roberto",
                 password: "123456"
               },
               errors: [],
               data: %ExMon.Trainer{},
               valid?: true
             } = response
    end

    test "when there are invalid valid, return an invalid changeset" do
      params = %{name: "Roberto", password: ""}

      response = Trainer.changeset(params)

      assert %Ecto.Changeset{
               changes: %{
                 name: "Roberto"
               },
               data: %ExMon.Trainer{},
               valid?: false
             } = response

      assert errors_on(response) == %{password: ["can't be blank"]}
    end
  end

  describe "build/1" do
    test "when all params are valid, return a trainer struct" do
      params = %{name: "Roberto", password: "123456"}

      response = Trainer.build(params)

      assert {:ok, %Trainer{name: "Roberto", password: "123456"}} = response
    end

    test "when there are invalid params, return an error" do
      params = %{name: "Roberto", password: ""}

      {:error, response} = Trainer.build(params)

      assert %Ecto.Changeset{valid?: false} = response

      assert errors_on(response) == %{password: ["can't be blank"]}
    end
  end
end
