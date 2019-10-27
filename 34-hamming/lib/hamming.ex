defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) do
    cond do
      length(strand1) != length(strand2) -> {:error, "Lists must be the same length"}
      strand1 == strand2                 -> {:ok, 0}
      true                               -> {:ok, calculate(strand1, strand2)}
    end
  end

  defp calculate([h | t1], [h | t2]), do: 0 + calculate(t1, t2)
  defp calculate([_ | t1], [_ | t2]), do: 1 + calculate(t1, t2)
  defp calculate([], []),             do: 0
end
