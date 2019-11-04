def insert(tree, data) do
  cond do
    data <= tree.data and tree.left == nil -> Map.put(tree, :left, new(data))
    data <= tree.data -> insert(tree.left, data)
    data > tree.data and tree.right == nil -> Map.put(tree, :right, new(data))
    data > tree.data -> insert(tree.right, data)
  end
end
