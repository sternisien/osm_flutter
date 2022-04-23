import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

/// Classe permettant de récupérer des données depuis internet
class FetchDataService {
  static FetchDataService? _dataService;

  static FetchDataService? getInstance() {
    _dataService ??= FetchDataService();
    return _dataService;
  }

  Future<LatLng?> getCoordinatesFromSearchLocation(String value) async {
    String baseUrl = "nominatim.openstreetmap.org";
    String path = "/search";
    // Await the http get response, then decode the json-formatted response.
    double lat = 0.0;
    double lon = 0.0;
    var response = await http.get(
      Uri.https(
        baseUrl,
        path,
        {
          'q': '$value',
          'format': 'json',
          'polygon_geojson': '1',
          'addressdetails': '1'
        },
      ),
    );

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
      lat = double.parse(jsonResponse[0]["lat"]);
      lon = double.parse(jsonResponse[0]["lon"]);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }

    return LatLng(lat, lon);
  }
}
