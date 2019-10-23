defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare([], []), do: :equal
  def compare([], [_]), do: :sublist
  def compare([_], []), do: :superlist
  def compare(a, b) when length(a) == length(b), do: equal?(a, b)
  def compare(a, b) when length(a) <  length(b), do: sublist?(a, b)
  def compare(a, b) when length(a) >  length(b), do: superlist?(a, b)

  defp equal?(a, b) do
    if a == b, do: :equal, else: :unequal
  end

  # Performant way
  defp sublist?(a, b) do
    index = Enum.find_index(b, & &1 === hd(a))
    if index == nil do
      :unequal
    else
      sliced = Enum.slice(b, index, length(a))
      new_b = List.delete_at(b, index)
      if a == sliced, do: :sublist, else: sublist?(a, new_b)
    end
  end

  # Non Performant way
  defp superlist?(a, b) do
    if b in Enum.chunk_every(a, length(b), 1, :discard), do: :superlist, else: :unequal
  end
end
