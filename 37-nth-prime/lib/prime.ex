defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count > 0, do: find(1, 2, count) # 1 (st) prime no. is 2 so we send 1 along with 2

  defp find(counter, candidate, count) do
    cond do
      counter == count and prime?(candidate)  -> candidate   # Recursion base case
      counter != count and prime?(candidate)  -> find(counter+1, candidate+1, count)
      true -> find(counter, candidate+1, count)
    end
  end

  defp prime?(2), do: true
  defp prime?(n), do: Enum.all?(2..n-1, &rem(n,&1) != 0)

  #####Using Streams####
  # def nth (count) do
  #   Stream.iterate(2, &(&1+1) )
  #   |> Stream.filter(&prime?/1)
  #   |> Enum.take(count)
  #   |> List.last
  # end
end
