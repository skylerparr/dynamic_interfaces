defmodule Foo do
  use Interface

  definterface bar(), to: Application.get_env(:foo, :bar)
end

defmodule FooImpl do
  def bar() do
    "bar"
  end
end

defmodule FooImpl2 do
  def bar() do
    "baz"
  end
end

defmodule Bar do
  use Interface

  definterface bar(), to: FooImpl
end

defmodule Baz do
  use Interface

  definterface bar(), to: Application.get_env(:foo, :bar) || FooImpl
end

defmodule InterfaceTest do
  use ExUnit.Case, async: true

  test "should delegate to module" do
    assert Bar.bar() == "bar"
  end

  test "should allow delegating to modules specified by application env" do
    Application.put_env(:foo, :bar, FooImpl)
    assert Foo.bar() == "bar"
    Application.put_env(:foo, :bar, FooImpl2)
    assert Foo.bar() == "baz"
  end

  test "should allow default implementations" do
    assert Baz.bar() == "bar"
    Application.put_env(:foo, :bar, FooImpl2)
    assert Foo.bar() == "baz"
  end

end

