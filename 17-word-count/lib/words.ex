defmodule Words do
  @regex ~r/[:!&@$%^_, ]/   # Special characters
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase
    |> String.split(@regex, trim: true)   # Remove all Special characters
    |> Enum.reduce(%{}, &map_update(&2, &1))
  end

  defp map_update(acc, x) do
    Map.update(acc, x, 1, &(&1 + 1))
  end
end
