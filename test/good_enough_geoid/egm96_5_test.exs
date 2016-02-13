defmodule GoodEnoughGeoid.EGM96_5Test do
  use ExUnit.Case
  doctest GoodEnoughGeoid.EGM96_5
  alias GoodEnoughGeoid.EGM96_5

  [
    [-25.1241, 56.0012, 1.3003],
    [76.0312, -14.1121, 41.4182],
    [1.111, 2.222, 16.1566],
  ]
  |> Enum.each(fn [lat, lon, expected] ->
    @lat lat
    @lon lon
    @expected expected
    test "height(#{@lat}, #{@lon}) is around #{@expected}" do
      assert_in_delta @expected, EGM96_5.height(@lat, @lon), 0.5
    end
  end)
end
