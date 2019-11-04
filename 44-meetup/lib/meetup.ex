defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday :: :monday | :tuesday | :wednesday | :thursday | :friday | :saturday | :sunday
  @type schedule :: :first | :second | :third | :fourth | :last | :teenth
  @day %{monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6, sunday: 7}

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date()
  def meetup(year, month, weekday, schedule) do
    case schedule do
      :teenth -> Date.new(year, month, 19)       |> elem(1) |> find_date(@day[weekday]) # Last date can't be > 19
      :first  -> Date.new(year, month, 7)        |> elem(1) |> find_date(@day[weekday]) # Last date can't be > 7
      :second -> Date.new(year, month, 14)       |> elem(1) |> find_date(@day[weekday]) # Last date can't be > 14
      :third  -> Date.new(year, month, 21)       |> elem(1) |> find_date(@day[weekday]) # Last date can't be > 21
      :fourth -> Date.new(year, month, 28)       |> elem(1) |> find_date(@day[weekday]) # Last date can't be > 28
      :last   -> last_date_of_month(year, month) |> elem(1) |> find_date(@day[weekday]) # Last date can't be > last date of month
    end
  end

  # Return last date of month
  defp last_date_of_month(year, month), do: Date.new(year, month, Date.days_in_month(Date.new(year, month, 1) |> elem(1)))

  # Go backwards from the date till the day is found
  defp find_date(date, day), do: if Date.day_of_week(date) == day, do: date, else: Date.add(date, -1) |> find_date(day)
end
