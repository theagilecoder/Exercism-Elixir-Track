defmodule Words do
  @regex ~r/[:!&@$%^_, ]/   # Special characters
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> normalize()
    |> split_words()
    |> word_count()
  end

  # Normalize the given sentence
  defp normalize(sentence) do
    String.downcase(sentence)
  end

  # Split sentence into a list of words, removing special characters
  defp split_words(sentence) do
    String.split(sentence, @regex, trim: true)
  end

  # Create the expected map of word-counts
  defp word_count(wordlist) do
    Enum.reduce(wordlist, %{}, &map_update(&2, &1))
  end

  # Update map of word count
  defp map_update(acc, x) do
    Map.update(acc, x, 1, &(&1 + 1))
  end
end
