defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    valid_input = input |> Enum.filter(&valid_input?(&1))
    valid_input
    |> create_map()
    |> update_map(valid_input)
    |> print_map()
  end

  # Create map with teams as keys and values as values all init to 0
  defp create_map(input) do
    input
    |> Enum.map(& String.split(&1, ";")
    |> Enum.take(2))
    |> List.flatten()
    |> Enum.uniq()
    |> Map.new(fn x -> {x, Map.new(["MP","W","D","L","P"], &{&1, 0})} end)
  end

  defp valid_input?(input) do
    cond do
      length(String.split(input, ";")) == 3 and
        (
          "loss" in String.split(input, ";") or
          "win" in String.split(input, ";") or
          "draw" in String.split(input, ";")
        )  -> true
      true -> false
    end
  end

  # Update the map points table map
  defp update_map(map, input) do
    input
    |> Enum.map(&String.split(&1, ";") |> Enum.take(3))
    |> Enum.reduce(map, fn x, acc -> update_match(x, acc) end)
  end

  # Update the points of the two teams involved in a match
  defp update_match([team1, team2, "win"], acc) do
    acc
    |> Map.update!(team1, fn %{"D"=>d,"L"=>l,"MP"=>mp,"P"=>p,"W"=>w} -> %{"D"=>d,"L"=>l,"MP"=>mp+1,"P"=>p+3,"W"=>w+1} end)
    |> Map.update!(team2, fn %{"D"=>d,"L"=>l,"MP"=>mp,"P"=>p,"W"=>w} -> %{"D"=>d,"L"=>l+1,"MP"=>mp+1,"P"=>p,"W"=>w} end)
  end

  defp update_match([team1, team2, "loss"], acc) do
    acc
    |> Map.update!(team1, fn %{"D"=>d,"L"=>l,"MP"=>mp,"P"=>p,"W"=>w} -> %{"D"=>d,"L"=>l+1,"MP"=>mp+1,"P"=>p,"W"=>w} end)
    |> Map.update!(team2, fn %{"D"=>d,"L"=>l,"MP"=>mp,"P"=>p,"W"=>w} -> %{"D"=>d,"L"=>l,"MP"=>mp+1,"P"=>p+3,"W"=>w+1} end)
  end

  defp update_match([team1, team2, "draw"], acc) do
    acc
    |> Map.update!(team2, fn %{"D"=>d,"L"=>l,"MP"=>mp,"P"=>p,"W"=>w} -> %{"D"=>d+1,"L"=>l,"MP"=>mp+1,"P"=>p+1,"W"=>w} end)
    |> Map.update!(team1, fn %{"D"=>d,"L"=>l,"MP"=>mp,"P"=>p,"W"=>w} -> %{"D"=>d+1,"L"=>l,"MP"=>mp+1,"P"=>p+1,"W"=>w} end)
  end

  defp print_map(scores) do
    heading = "Team                           | MP |  W |  D |  L |  P\n"
    rows = scores
      |> Enum.map(fn {k, v} -> "#{String.pad_trailing(k, 31)}|  #{v["MP"]} |  #{v["W"]} |  #{v["D"]} |  #{v["L"]} |  #{v["P"]}" end)
      |> Enum.sort_by(fn x -> String.at(x,54) |> String.to_integer end, &>=/2)
      |> Enum.map_join("\n", &(&1))

    heading <> rows
  end
end
