defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    # My approach 
    # strand |> Enum.filter(&(&1 == nucleotide)) |> length

    # Community approach - Enum.count can take a function
    Enum.count(strand, &(&1 == nucleotide))
  end
  
  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    # My approach
    # summary = %{?A => 0, ?T => 0, ?C => 0, ?G => 0}
    # Enum.reduce(strand, summary, fn x, acc -> Map.put(acc, x, acc[x] + 1) end )

    # Community approach 1 - Use comprehension and reuse above function
    # for n <- @nucleotides, into: %{}, do: {n, count(strand, n)}

    # Community approach 2 - Use Map.new and reuse above function
    Map.new(@nucleotides, &{&1, count(strand, &1)})
  end
end
