defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count([]),             do: 0
  def count([_head | tail]), do: 1 + count(tail)

  @spec reverse(list) :: list
  def  reverse(l),                do: reverse(l, [])
  defp reverse([], acc),          do: acc
  defp reverse([head|tail], acc), do: reverse(tail, [head|acc])

  @spec map(list, (any -> any)) :: list
  def map([], _f),         do: []
  def map([head|tail], f), do: [f.(head) | map(tail, f)]

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _f),         do: []
  def filter([head|tail], f), do: if f.(head), do: [head | filter(tail, f)], else: filter(tail, f)

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _f),         do: acc
  def reduce([head|tail], acc, f), do: reduce(tail, f.(head, acc), f)

  @spec append(list, list) :: list
  def append([], b),                do: b
  def append(a, []),                do: a
  def append([head | tail], b), do: [head | append(tail, b)]

  @spec concat([[any]]) :: [any]
  # def concat([]),                  do: []
  def concat(ll),                  do: concat(ll, []) |> reverse()
  def concat([], acc),             do: acc
  def concat([[]|tail], acc),      do: concat(tail, acc)
  def concat([[head]|tail], acc),  do: concat(tail, [head | acc])
  def concat([[head|t1]|t2], acc), do: concat([t1 | t2], [head | acc])
end
