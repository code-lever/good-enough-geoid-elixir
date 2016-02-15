defmodule GoodEnoughGeoid.EGM96_5 do
  require Logger
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], [name: __MODULE__])
  end

  def init([]) do
    map =
      :good_enough_geoid
      |> Application.app_dir("priv")
      |> Path.join("egm96-5.csv.gz")
      |> File.stream!([:read, :compressed])
      |> CSV.decode(strip_cells: true)
      |> Enum.map(&numericize/1)
      |> to_tuple_keyed_map

    Logger.debug "[#{__MODULE__}] heights file loaded"
    {:ok, map}
  end

  @doc """
  Gets the approximate height (in meters) of the geoid at the given latitude/longitude.
  """
  @spec height(number, number) :: Float
  def height(latitude, longitude) do
    GenServer.call(__MODULE__, {:height, latitude, longitude})
  end

  def handle_call({:height, lat, lon}, _from, map) do
    {:reply, do_height(lat, lon, map), map}
  end

  defp do_height(latitude, longitude, map) when is_float(latitude) or is_float(longitude) do
    do_height(trunc(latitude), trunc(longitude), map)
  end
  defp do_height(latitude, longitude, map) do
    Map.get(map, {latitude, longitude})
  end

  defp numericize([latitude, longitude, height]) do
    lat = String.to_integer(latitude)
    lon = String.to_integer(longitude)
    {hgh, _} = Float.parse(height)
    [lat, lon, hgh]
  end

  defp to_tuple_keyed_map(heights) do
    heights
    |> Enum.map(fn [lat, lon, height] -> {{lat, lon}, height} end)
    |> Enum.into(%{})
  end
end
