defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    candidates = normalized(base, candidates)
    Enum.filter(candidates, & sorted?(&1) == sorted?(base) )
  end

  # Removes words from candidates that are same as base
  defp normalized(base, candidates) do
    Enum.filter(candidates, & String.downcase(&1) != String.downcase(base) )
  end

  # Returns sorted list of letters in a word
  defp sorted?(word) do
    word |> String.downcase |> String.graphemes() |> Enum.sort
  end
end
