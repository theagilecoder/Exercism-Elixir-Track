defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: list
  def convert([], _, _),                                        do: nil
  def convert(_, base_a, base_b) when base_a < 2 or base_b < 2, do: nil
  def convert(digits, base_a, base_b) do
    cond do
      Enum.any?(digits, & &1 < 0)       -> nil
      Enum.any?(digits, & &1 >= base_a) -> nil
      true ->
        digits                        # [5, 0, 1]
        |> Enum.reverse()
        |> Enum.with_index()
        |> Enum.reverse()             # [{5, 2}, {0, 1}, {1, 0}]
        |> convert_base10(base_a)
        |> Integer.digits(base_b)
    end
  end


  defp convert_base10(list, base_a) do
    list
    |> Enum.reduce(0, fn {digit, power}, acc -> acc + digit * :math.pow(base_a, power) end)
    |> round()
  end
end
