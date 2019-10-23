defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    str
    |> String.replace(~r/[^\(\)\[\]\{\}]/, "")  # Remove everything except brackets
    |> String.graphemes()
    |> Enum.reduce([], &match/2)
    |> case do
        [] -> true  # We will get [] if all brackets were matched
        _  -> false
      end
  end

  # Pop from stack if brackets match
  defp match(x, acc) do
    cond do
      List.last(acc) == "(" and x == ")" -> List.delete_at(acc, -1)
      List.last(acc) == "{" and x == "}" -> List.delete_at(acc, -1)
      List.last(acc) == "[" and x == "]" -> List.delete_at(acc, -1)
      true                               -> acc ++ [x]
    end
  end
end
