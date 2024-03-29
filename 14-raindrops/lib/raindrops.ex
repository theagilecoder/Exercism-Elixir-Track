defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    raindrops = Enum.filter(1..number, &rem(number, &1) == 0)
      |> Enum.reduce("", & &2<>raindrop(&1))

    if raindrops == "", do: to_string(number), else: raindrops  
  end

  defp raindrop(factor) do
    case factor do
      3 -> "Pling"
      5 -> "Plang"
      7 -> "Plong"
      _ -> ""
    end
  end
end