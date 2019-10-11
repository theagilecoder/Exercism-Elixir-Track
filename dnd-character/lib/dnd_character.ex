defmodule DndCharacter do
  @type t :: %__MODULE__{
    strength: pos_integer(),
    dexterity: pos_integer(),
    constitution: pos_integer(),
    intelligence: pos_integer(),
    wisdom: pos_integer(),
    charisma: pos_integer(),
    hitpoints: pos_integer()
  }

  defstruct ~w[strength dexterity constitution intelligence wisdom charisma hitpoints]a

  @spec modifier(pos_integer) :: integer()
  def modifier(score) do
    floor((score - 10)/2)
  end

  @spec ability :: pos_integer()
  def ability() do
    dice_throws = [
      :rand.uniform(6),
      :rand.uniform(6),
      :rand.uniform(6),
      :rand.uniform(6),
    ]

    dice_throws -- [Enum.min(dice_throws)]
    |> Enum.sum
  end

  @spec character :: t()
  def character() do
    character1 = %{
      strength: ability(),
      constitution: ability(),
    }

    Map.put(character1, :hitpoints, 10 + character1.constitution)
  end
end
