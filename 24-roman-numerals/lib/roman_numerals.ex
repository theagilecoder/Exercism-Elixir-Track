defmodule RomanNumerals do
  @numerals %{
    # Helps with recursion
    0 => "",
    1 => "I",
    4 => "IV",
    5 => "V",
    9 => "IX",
    10 => "X",
    40 => "XL",
    50 => "L",
    90 => "XC",
    100 => "C",
    400 => "CD",
    500 => "D",
    900 => "CM",
    1000 => "M"
  }

  # [0,1,4,5,9,10,40,50,90,100,400,500,900,1000]
  @steps Map.keys(@numerals)

  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    cond do
      # If number is in the map, then the job is done (Recursion base case)
      number in @steps -> @numerals[number]
      # But if it isnt, Ex - 91, we find the correct step i.e. 90,
      # and join its Roman numerals i.e. "XC" with Roman of 91 - 90 i.e. 1
      true -> @numerals[correct_step(number)] <> numeral(number - correct_step(number))
    end
  end

  # Steps are special numbers where behavior of Roman numerals change
  # Ex- 90 is a step because it's not LXXXX. Rather it introduces "C" for the 1st time.
  # The correct step for a given is the largest key that is smaller than number;
  # because thats what we need to subtract from the number.
  defp correct_step(number) do
    Enum.find(Enum.reverse(@steps), &(&1 < number))
  end
end

######## Community Solution

"""
def numerals(0), do: ""
def numerals(n) when n >= 1000, do: "M" <> numerals(n-1000)
def numerals(n) when n >= 900, do: "CM" <> numerals(n-900)
def numerals(n) when n >= 500, do: "D" <> numerals(n-500)
def numerals(n) when n >= 400, do: "CD" <> numerals(n-400)
def numerals(n) when n >= 100, do: "C" <> numerals(n-100)
def numerals(n) when n >= 90, do: "XC" <> numerals(n-90)
def numerals(n) when n >= 50, do: "L" <> numerals(n-50)
def numerals(n) when n >= 40, do: "XL" <> numerals(n-40)
def numerals(n) when n >= 10, do: "X" <> numerals(n-10)
def numerals(n) when n >= 9, do: "IX" <> numerals(n-9)
def numerals(n) when n >= 5, do: "V" <> numerals(n-5)
def numerals(n) when n >= 4, do: "IV" <> numerals(n-4)
def numerals(n), do: "I" <> numerals(n-1)
"""
