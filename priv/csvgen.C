#include <GeographicLib/Geoid.hpp>
#include <iostream>

int main() {
  GeographicLib::Geoid g("egm96-5");
  std::cout << "lat, lon, offset\n";
  for (float lat = -90.0; lat <= 90.0; lat += 1) {
    for (float lon = -180.0; lon <= 180.0; lon += 1) {
      std::cout << lat << ", " << lon << ", " << g(lat, lon) << "\n";
    }
  }
}
