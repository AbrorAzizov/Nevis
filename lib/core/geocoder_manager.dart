import 'package:yandex_geocoder/yandex_geocoder.dart';

class GeocoderManager {
  final YandexGeocoder _geocoder;

  GeocoderManager(this._geocoder);

  Future<GeocodeResponse?> getGeocodeFromPoint(double lat, double lon,
      {Lang lang = Lang.ru}) async {
    try {
      return (await _geocoder.getGeocode(
        ReverseGeocodeRequest(
            pointGeocode: (lat: lat, lon: lon),
            lang: lang,
            kind: KindRequest.house),
      ));
    } catch (e) {
      print('Ошибка при обратном геокодировании: $e');
      return null;
    }
  }

  Future<GeocodeResponse?> getGeocodeFromAddress(String address,
      {Lang lang = Lang.ru}) async {
    try {
      return (await _geocoder.getGeocode(DirectGeocodeRequest(
          addressGeocode: address, lang: lang, kind: KindRequest.house)));
    } catch (e) {
      print('Ошибка при прямом геокодировании: $e');
      return null;
    }
  }
}
