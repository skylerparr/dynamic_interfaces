defmodule Interface do
  defmacro __using__(_) do
    quote do
      import Interface, only: [definterface: 2]
    end
  end

  defmacro definterface({function, _, args}, [to: {{_, _, [{_, [_, _], [module]}, fun]}, [_], [app, key]}]) do
    quote do
      def unquote({function, [], args}) do
        intended_module = apply(:"Elixir.#{unquote(module)}", unquote(fun), [unquote(app), unquote(key)])
        apply(intended_module, unquote(function), unquote(args))
      end
    end
  end
end
