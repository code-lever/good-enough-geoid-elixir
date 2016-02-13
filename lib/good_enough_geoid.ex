defmodule GoodEnoughGeoid do
  require Logger
  use GenServer

  def init([path]) do
    list =
      "egm96-5.csv.gz"
      |> File.stream!([:read, :compressed])
      |> CSV.decode(strip_cells: true)
      |> Enum.map(&numericize/1)

    Logger.debug "[#{__MODULE__}] heights file loaded"
    {:ok, list}
  end

  def handle_call({:height, lat, lon}, _from, list) do
    {:reply, height(lat, lon, list), list}
  end

  defp height(lat, lon, list) when is_float(lat) or is_float(lon) do
    height(trunc(lat), trunc(lon), list)
  end
  defp height(lat, lon, list) do
    list
    |> Enum.filter(fn [lt, _, _] -> lt == lat end)
    |> Enum.filter(fn [_, ln, _] -> ln == lon end)
    |> List.first
    |> Enum.at(2)
  end

  defp numericize([lat, lon, height]) do
    lat = String.to_integer(lat)
    lon = String.to_integer(lon)
    {hgh, _} = Float.parse(height)
    [lat, lon, hgh]
  end
end
