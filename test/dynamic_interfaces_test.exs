defmodule DynamicInterfacesTest do
  use ExUnit.Case
  doctest DynamicInterfaces

  test "greets the world" do
    assert DynamicInterfaces.hello() == :world
  end
end
