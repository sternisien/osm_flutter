import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:training_widget/services/fetch_data_service.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

void main() {
  FetchDataService? _fetchDataService = FetchDataService.getInstance();
  const String baseUrl = "nominatim.openstreetmap.org";
  const String path = "/search";
  const String location = "Paris";

  String getLatLng() {
    return "[{\"place_id\":286324666,\"licence\":\"Data©OpenStreetMapcontributors,ODbL1.0.https://osm.org/copyright\",\"boundingbox\":[\"32.787302909518\",\"33.107302909518\",\"-96.960720656316\",\"-96.640720656316\"],\"lat\":\"32.94730290951796\",\"lon\":\"-96.8007206563158\",\"display_name\":\"Dallas,DallasCounty,Texas,75254,UnitedStates\",\"place_rank\":21,\"category\":\"place\",\"type\":\"postcode\",\"importance\":0.445,\"address\":{\"city\":\"Dallas\",\"county\":\"DallasCounty\",\"state\":\"Texas\",\"ISO3166-2-lvl4\":\"US-TX\",\"postcode\":\"75254\",\"country\":\"UnitedStates\",\"country_code\":\"us\"}}]";
  }

  test('String.split() splits the string on the delimiter', () {
    when(http.get(Uri.https(
      baseUrl,
      path,
      {
        'q': 'Paris',
        'format': 'json',
        'polygon_geojson': '1',
        'addressdetails': '1'
      },
    ))).thenAnswer((_) => Future.value(http.Response(getLatLng(), 200)));

    _fetchDataService!
        .getCoordinatesFromSearchLocation(location)
        .then((value) => print(value));
  });
}
