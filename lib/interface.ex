defmodule Interface do
  defmacro __using__(_) do
    quote do
      import Interface, only: [definterface: 2]
    end
  end

  defmacro definterface({function, _, args}, [to: {_, _, [module]}]) do
    quote do
      def unquote({function, [], args}) do
        intended_module = :"Elixir.#{unquote(module)}"
        apply(intended_module, unquote(function), unquote(args))
      end
    end
  end

  defmacro definterface({function, _, args}, [to: {:||, _, [{{_, _, [{_, _, [module]}, fun]}, _, [app, key]}, {_, _, default}]}]) do
    quote do
      def unquote({function, [], args}) do
        intended_module = apply(:"Elixir.#{unquote(module)}", unquote(fun), [unquote(app), unquote(key)])
        case intended_module do
          nil -> apply(:"Elixir.#{unquote(default |> Enum.join("."))}", unquote(function), unquote(args))
          _ -> apply(intended_module, unquote(function), unquote(args))
        end
      end
    end
  end

  defmacro definterface({function, _, args}, [to: {{:., _, [{_, _, [module]}, fun]}, _, delegate_args}]) do
    quote do
      def unquote({function, [], args}) do
        intended_module = apply(:"Elixir.#{unquote(module)}", unquote(fun), unquote(delegate_args))
        apply(intended_module, unquote(function), unquote(args))
      end
    end
  end

end
