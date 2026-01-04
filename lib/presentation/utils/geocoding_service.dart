import 'package:geocoding/geocoding.dart';

class GeocodingService {
  static Future<String?> resolveCityCountry(double lat, double lon) async {
    if (lat < -90 || lat > 90 || lon < -180 || lon > 180) {
      return null;
    }

    try {
      final placemarks = await placemarkFromCoordinates(lat, lon);
      if (placemarks.isEmpty) return null;

      final p = placemarks.first;
      final city = p.subAdministrativeArea?.isNotEmpty == true
          ? p.subAdministrativeArea
          : p.locality;

      final country = p.country;

      if (city == null || city.isEmpty) return null;

      return country != null && country.isNotEmpty ? '$city, $country' : city;
    } catch (_) {
      return null;
    }
  }
}
