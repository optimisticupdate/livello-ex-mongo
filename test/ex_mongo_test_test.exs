defmodule ExMongoTestTest do
  use ExUnit.Case
  doctest ExMongoTest

  test "greets the world" do
    assert ExMongoTest.hello() == :world
  end
end
