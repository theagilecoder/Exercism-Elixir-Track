defmodule IsbnVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> ISBNVerifier.isbn?("3-598-21507-X")
      true

      iex> ISBNVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    cond do
      valid_format?(isbn) and valid_check?(isbn)-> true
      true -> false
    end
  end

  defp valid_format?(isbn), do: isbn |> String.replace(~r/-/, "") |> String.match?(~r/^[\d]{9}[\dX]{1}$/)
  defp valid_check?(isbn) do
    isbn = isbn |> String.replace(~r/-/, "")

    x1  = String.at(isbn, 0) |> String.to_integer()
    x2  = String.at(isbn, 1) |> String.to_integer()
    x3  = String.at(isbn, 2) |> String.to_integer()
    x4  = String.at(isbn, 3) |> String.to_integer()
    x5  = String.at(isbn, 4) |> String.to_integer()
    x6  = String.at(isbn, 5) |> String.to_integer()
    x7  = String.at(isbn, 6) |> String.to_integer()
    x8  = String.at(isbn, 7) |> String.to_integer()
    x9  = String.at(isbn, 8) |> String.to_integer()
    x10 = if String.at(isbn, 9) == "X", do: 10, else: String.at(isbn, 9) |> String.to_integer()

    rem((x1 * 10 + x2 * 9 + x3 * 8 + x4 * 7 + x5 * 6 + x6 * 5 + x7 * 4 + x8 * 3 + x9 * 2 + x10 * 1), 11) == 0
  end
end
