defmodule GoodEnoughGeoid.EGM96_5 do
  require Logger
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], [name: __MODULE__])
  end

  def init([]) do
    list =
      :good_enough_geoid
      |> Application.app_dir("priv")
      |> Path.join("egm96-5.csv.gz")
      |> File.stream!([:read, :compressed])
      |> CSV.decode(strip_cells: true)
      |> Enum.map(&numericize/1)

    Logger.debug "[#{__MODULE__}] heights file loaded"
    {:ok, list}
  end

  @doc """
  Gets the approximate height (in meters) of the geoid at the given latitude/longitude.
  """
  @spec height(number, number) :: Float
  def height(latitude, longitude) do
    GenServer.call(__MODULE__, {:height, latitude, longitude})
  end

  def handle_call({:height, lat, lon}, _from, list) do
    {:reply, do_height(lat, lon, list), list}
  end

  defp do_height(latitude, longitude, list) when is_float(latitude) or is_float(longitude) do
    do_height(trunc(latitude), trunc(longitude), list)
  end
  defp do_height(latitude, longitude, list) do
    list
    |> Enum.filter(fn [lt, _, _] -> lt == latitude end)
    |> Enum.filter(fn [_, ln, _] -> ln == longitude end)
    |> List.first
    |> Enum.at(2)
  end

  defp numericize([latitude, longitude, height]) do
    lat = String.to_integer(latitude)
    lon = String.to_integer(longitude)
    {hgh, _} = Float.parse(height)
    [lat, lon, hgh]
  end
end
