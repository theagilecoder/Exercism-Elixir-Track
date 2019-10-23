defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) do
    cond do
      wrong_length?(a,b,c)    -> {:error, "all side lengths must be positive"}
      fail_inequality?(a,b,c) -> {:error, "side lengths violate triangle inequality"}
      a==b and b==c           -> {:ok,    :equilateral}
      a==b or b==c or a==c    -> {:ok,    :isosceles  }
      true                    -> {:ok,    :scalene    }
    end
  end

  defp wrong_length?(a, b, c) do
    Enum.any?([a, b, c], &(&1 <= 0))
  end

  defp fail_inequality?(a, b, c) do
  (a+b) <= c || (b+c) <=a || (a+c) <= b
  end
end
