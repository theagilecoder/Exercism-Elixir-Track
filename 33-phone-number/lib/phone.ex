defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("212-555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 055-0100")
  "0000000000"

  iex> Phone.number("(212) 555-0100")
  "2125550100"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t()) :: String.t()
  def number(raw) do
    cleaned = clean(raw)   # Remove special characters
    cond do
      String.length(cleaned) <  10 or  String.match?(cleaned, ~r/[a-zA-Z]/) -> "0000000000"
      String.length(cleaned) == 10 and valid_areacode?(cleaned) and valid_excode?(cleaned) -> cleaned
      String.length(cleaned) == 11 and valid_country?(cleaned) -> String.slice(cleaned, 1..-1) |> number()
      true -> "0000000000"
    end
  end

  defp clean(raw),               do: String.replace(raw, ~r/[- ().+]/, "")
  defp valid_country?(cleaned),  do: String.first(cleaned) == "1"
  defp valid_areacode?(cleaned), do: String.at(cleaned, 0) not in ["1", "0"]
  defp valid_excode?(cleaned),   do: String.at(cleaned, 3) not in ["1", "0"]

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("212-555-0100")
  "212"

  iex> Phone.area_code("+1 (212) 555-0100")
  "212"

  iex> Phone.area_code("+1 (012) 555-0100")
  "000"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t()) :: String.t()
  def area_code(raw) do
    raw |> number() |> String.slice(0..2)
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("212-555-0100")
  "(212) 555-0100"

  iex> Phone.pretty("212-155-0100")
  "(000) 000-0000"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t()) :: String.t()
  def pretty(raw) do
    valid = number(raw)
    "(#{String.slice(valid, 0..2)}) #{String.slice(valid, 3..5)}-#{String.slice(valid, 6..9)}"
  end
end
