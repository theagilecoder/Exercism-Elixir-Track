defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    cleaned(sentence) == normalized(sentence)
  end

  # Remove hyphen and spaces
  defp cleaned(sentence) do
    String.replace(sentence, ~r/[ -]/, "")
  end

  # Remove hyphen, spaces and duplicate letters
  defp normalized(sentence) do
    sentence
    |> String.replace(~r/[ -]/, "")
    |> String.graphemes()
    |> Enum.uniq()
    |> Enum.join()
  end
end
