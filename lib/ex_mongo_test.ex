defmodule ExMongoTest do
  @moduledoc """
  Documentation for `ExMongoTest`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ExMongoTest.hello()
      :world

  """
  def list_users do
    Mongo.find(:mongo, "users", %{})
  end

  def list_alerts do
    org_id = BSON.ObjectId.decode!("5cddce9a51cbb2002d636741")
    {time_in_microseconds, ret_val} = :timer.tc(fn ->
      Mongo.count_documents(:mongo, "alerts", %{
        orgId: org_id,
        type: %{ "$in" => [
          "HighTemp",
          "LowTemp",
          "KioskOffline",
          "TabletDisconn",
          "TabletMqttDisconn",
          "DoorOpen",
          "DoorLeftOpenRefill",
          "UnauthAccess",
          "ScalesOffline",
          "NoProductsBought",
          "InvalidScaleWeight"]
        }
      }
    )
    end)

    {ret_val, time_in_microseconds / 1_000}
  end

  def search_alerts do
    {time_in_microseconds, ret_val} = :timer.tc(fn ->
      Mongo.aggregate(:mongo, "alerts", [
        %{
          "$match": %{
            orgId: %{ "$in" => [ BSON.ObjectId.decode!("5cddce9a51cbb2002d636741") ]},
            type: %{ "$in" => [
              "HighTemp",
              "LowTemp",
              "KioskOffline",
              "TabletDisconn",
              "TabletMqttDisconn",
              "DoorOpen",
              "DoorLeftOpenRefill",
              "UnauthAccess",
              "ScalesOffline",
              "NoProductsBought",
              "InvalidScaleWeight"]
            },
            startDate: %{
              "$gte" => to_date_time("2021-07-31T22:00:00.000Z"),
              "$lte" => to_date_time("2022-08-17T23:56:06.273Z")
            }
          }
        },
        %{
          "$sort": %{
            startDate: -1
          }
        },
        %{
          "$group": %{
            _id: nil,
            count: %{
              "$sum": 1
            }
          }
        },
        %{ "$project": %{ _id: 0 } }
      ])
    end)

    {ret_val, time_in_microseconds / 1_000}
  end

  defp to_date_time(string) do
    case DateTime.from_iso8601(string) do
      {:ok, date_time, _offset} -> date_time
      error -> error
    end
  end
end
