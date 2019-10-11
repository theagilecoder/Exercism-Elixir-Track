defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do                          # "AABBBCCCC"
    String.codepoints(string)                    # ["A", "A", "B", "B", "B", "C", "C", "C", "C"]
    |> Enum.chunk_by(& &1)                       # [["A", "A"], ["B", "B", "B"], ["C", "C", "C", "C"]]
    |> Enum.map(&"#{char_count(&1)}#{hd(&1)}")   # ["2A"] ...
    |> Enum.join                                 # "2A3B4C"
  end

  defp char_count(x) do
    cond do
      length(x) == 1 -> ""
      true -> length(x)
    end
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    Regex.replace(~r/(\d+)(.)/, string, fn _, len, char ->
        String.duplicate(char, String.to_integer(len))
      end)
  end
end
