defmodule Bob do
  def hey(input) do
    cond do
      nothing?(input)     -> "Fine. Be that way!"
      question?(input) && capitalized?(input) -> "Calm down, I know what I'm doing!"
      question?(input)    -> "Sure."
      capitalized?(input) -> "Whoa, chill out!"
      true                -> "Whatever."
    end
  end
  defp nothing?(input),     do: String.trim(input) == ""
  defp question?(input),    do: String.ends_with?(input, "?")
  defp capitalized?(input), do: has_letters?(input) && String.upcase(input) == input
  defp has_letters?(input), do: String.upcase(input) != String.downcase(input)
end
