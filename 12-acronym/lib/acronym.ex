defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do               
    string                                        # "AppBob-cat"
    |> String.replace(~r/[A-Z]/, " \\0")          # " App Bob-cat"
    |> String.split([" ", "-", ","], trim: true)  # ["App", "Bob", "cat"]
    |> Enum.map(&String.first/1)                  # ["A", "B", "c"]
    |> List.to_string                             # "ABc"
    |> String.upcase                              # "ABC"
  end
end