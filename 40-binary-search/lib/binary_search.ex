defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search({}, _),        do: :not_found
  def search(numbers, key), do: Tuple.to_list(numbers) |> Enum.with_index() |> do_search(key)

  defp do_search([{key, index}], key), do: {:ok, index}
  defp do_search([{_item, _}], _key),  do: :not_found
  defp do_search(list, key) do
    {item, index} = Enum.at(list, floor(length(list)/2))
    cond do
      key == item -> {:ok, index}
      key <  item -> Enum.slice(list, 0..index - 1) |> do_search(key)
      key >  item -> Enum.slice(list, index+1..-1)  |> do_search(key)
    end
  end
end
