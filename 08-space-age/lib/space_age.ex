defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """

  # Constants
  @one_earth_year 31557600 #seconds
  @orbits %{
      :earth   => @one_earth_year,
      :mercury => 0.2408467 * @one_earth_year,
      :venus   => 0.6151973 * @one_earth_year,
      :mars    => 1.8808158 * @one_earth_year,
      :jupiter => 11.862615 * @one_earth_year,
      :saturn  => 29.447498 * @one_earth_year,
      :uranus  => 84.016846 * @one_earth_year,
      :neptune => 164.79132 * @one_earth_year,
    }

  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
    seconds / @orbits[planet]
  end
end
