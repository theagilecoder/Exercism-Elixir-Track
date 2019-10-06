defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  
  # My approach
  # Convert string to charlist and map over each char
  def rotate(text, shift) do
    text
    |> to_charlist
    |> Enum.map(&detect_case(&1, rem(shift, 26)))
    |> to_string
  end

  # Detect case of char
  defp detect_case(char, shift) do
    cond do
      char in 65..90  -> handle_uppercase(char, shift)
      char in 97..122 -> handle_lowercase(char, shift)
      true            -> char
    end
  end

  # Rotate uppercase char
  defp handle_uppercase(char, shift) do
    cond do
      (char + shift) <= 90 -> char + shift
      (char + shift) >  90 -> 64 + char + shift - 90
    end
  end

  # Rotate lowercase char
  defp handle_lowercase(char, shift) do
    cond do
      (char + shift) <= 122 -> char + shift
      (char + shift) >  122 -> 96 + char + shift - 122
    end  
  end

  # Community Approach 1 - A better way to rotate chars
  defp rotate_char(char, shift) do
    cond do
      char in ?A..?Z -> rem(char - ?A + shift, 26) + ?A
      char in ?a..?z -> rem(char - ?a + shift, 26) + ?a
      true           -> char
    end
  end

  # Community Approach 2 - Using Comprehension
  def rotate(text, shift) do
    for <<char <- text>>, into: "", do: <<do_rotate(char, shift)>>
  end

end
