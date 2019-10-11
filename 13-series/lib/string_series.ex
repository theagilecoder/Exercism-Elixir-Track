defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) do
    String.codepoints(s) |> substrings(size)
  end

  def substrings(_, size) when size < 1,          do: []
  def substrings(s, size) when length(s) <  size, do: []
  def substrings(s, size) when length(s) == size, do: [Enum.join(s)]
  def substrings(s = [_head | tail], size) do
    [Enum.take(s, size) |> Enum.join | substrings(tail, size)]
  end
end
