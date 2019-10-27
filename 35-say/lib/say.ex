defmodule Say do
  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  def in_english(number) when number not in 0..999_999_999_999, do: {:error, "number is out of range"}
  def in_english(number), do: {:ok, translate(number)}

  defp translate(0),  do: "zero"
  defp translate(1),  do: "one"
  defp translate(2),  do: "two"
  defp translate(3),  do: "three"
  defp translate(4),  do: "four"
  defp translate(5),  do: "five"
  defp translate(6),  do: "six"
  defp translate(7),  do: "seven"
  defp translate(8),  do: "eight"
  defp translate(9),  do: "nine"
  defp translate(10), do: "ten"
  defp translate(11), do: "eleven"
  defp translate(12), do: "twelve"
  defp translate(13), do: "thirteen"
  defp translate(14), do: "fourteen"
  defp translate(15), do: "fifteen"
  defp translate(16), do: "sixteen"
  defp translate(17), do: "seventeen"
  defp translate(18), do: "eighteen"
  defp translate(19), do: "nineteen"
  defp translate(20), do: "twenty"
  defp translate(30), do: "thirty"
  defp translate(40), do: "forty"
  defp translate(50), do: "fifty"
  defp translate(60), do: "sixty"
  defp translate(70), do: "seventy"
  defp translate(80), do: "eighty"
  defp translate(90), do: "ninety"
  defp translate(string) when is_binary(string), do: string  # translate("million") -> "million"

  # Handle a hundred or a thousand or a million or a billion
  defp translate(number) when rem(number, 1_000_000_000) == 0, do: "#{translate(div(number, 1_000_000_000))} billion"
  defp translate(number) when rem(number, 1_000_000) == 0,     do: "#{translate(div(number, 1_000_000))} million"
  defp translate(number) when rem(number, 1_000) == 0,         do: "#{translate(div(number, 1_000))} thousand"
  defp translate(number) when rem(number, 100) == 0,           do: "#{translate(div(number, 100))} hundred"

  # Handle 2-digit numbers
  defp translate(number) when number in 1..100 do
    tens_place(number)
    |> Enum.map_join("-", & translate(&1))
  end

  # Handle 3-digit numbers
  defp translate(number) when number in 101..1000 do
    [head | tail] = tens_place(number)
    "#{translate(head)} #{translate(Enum.sum(tail))}"
  end

  # Handle 4-or-more-digit numbers
  defp translate(number) when number > 1000 do
    breakdown(number)
    |> put_scale_words()
    |> Enum.map_join(" ", & translate(&1))

  end

  # Converts 123 into [100, 20, 3], 103 into [100, 3], 290 into [200, 90]
  defp tens_place(number) do
    Integer.digits(number)
    |> Enum.with_index(1)
    |> Enum.map(fn {num, place} -> num * floor(:math.pow(10, String.length("#{number}") - place)) end)
    |> Enum.filter(& &1 != 0)
  end

  # Breaks down numbers into four chunks of thousands
  # 1234 -> [0, 0, 1, 234], 999_999_999_999 -> [999, 999, 999, 999], 1000 -> [0, 0, 1, 0]
  defp breakdown(number) do
    str = String.pad_leading("#{number}", 12, "0")
    [ binary_part(str, 0, 3), binary_part(str, 3, 3), binary_part(str, 6, 3), binary_part(str, 9, 3) ]
    |> Enum.map(fn x -> Integer.parse(x) |> elem(0) end)
  end

  # [0, 0, 1, 234] should yield [1, "thousand", 234]
  # [0, 1, 0, 234] should yield [1, "million",  234]
  # [1, 0, 0, 234] should yield [1, "billion",  234]
  defp put_scale_words(list) do
    list = if Enum.at(list, 2) == 0, do: list, else: List.insert_at(list, 3, "thousand")
    list = if Enum.at(list, 1) == 0, do: list, else: List.insert_at(list, 2, "million")
    list = if Enum.at(list, 0) == 0, do: list, else: List.insert_at(list, 1, "billion")
    Enum.filter(list, & &1 != 0)
  end
end
