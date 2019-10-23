defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()

  # Community Approach

  @vowels ~r/^[aeiou].*$/
  @xy ~r/^[xy][^aeiou].*$/
  @consonants ~r/^([^aeiou]+)(.*)$/
  @qu ~r/^([^aeiou]?qu)(.*)$/
  @consonant_y ~r/^([^aeiou])(y)$/
  @consonants_y ~r/^([^aeiouy]+)(y.*)$/
  
  def translate(phrase) do
    phrase
    |> String.split(" ")
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  defp translate_word(word) do
    cond do
      word =~ @consonant_y -> Regex.replace(@consonant_y, word, "\\2\\1ay")
      word =~ @consonants_y -> Regex.replace(@consonants_y, word, "\\2\\1ay")
      word =~ @qu -> Regex.replace(@qu, word, "\\2\\1ay")
      word =~ @vowels -> word <> "ay"
      word =~ @xy -> word <> "ay"
      word =~ @consonants -> Regex.replace(@consonants, word, "\\2\\1ay")
      true -> word
    end
  end
end
