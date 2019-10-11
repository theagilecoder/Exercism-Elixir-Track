defmodule Accumulate do
  @doc """
    Given a list and a function, apply the function to each list item and
    replace it with the function's return value.

    Returns a list.

    ## Examples

      iex> Accumulate.accumulate([], fn(x) -> x * 2 end)
      []

      iex> Accumulate.accumulate([1, 2, 3], fn(x) -> x * 2 end)
      [2, 4, 6]

  """

  @spec accumulate(list, (any -> any)) :: list
  def accumulate([], _), do: []             # Return empty list for empty list
  def accumulate([head | tail], fun) do     # [1,2,3] -> [1, [2,3]]
    [fun.(head) | accumulate(tail, fun)]    # accumulate([2,3], fun) gets called again
  end
end

# Another approach
# for(x <- list, do: fun.(x))