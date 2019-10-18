defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer

  def to(1, _), do: 0
  def to(limit, factors) do
    1..limit-1
    |> Enum.map(&multiple?(&1, factors))
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.sum()
  end

  # If x a multiple of any of the factors, return x
  defp multiple?(x, factors) do
    for n <- factors, rem(x, n) == 0, do: x
  end
end
