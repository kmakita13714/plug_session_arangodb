defmodule PlugSessionArangodbTest do
  use ExUnit.Case
  doctest PlugSessionArangodb

  test "greets the world" do
    assert PlugSessionArangodb.hello() == :world
  end
end
