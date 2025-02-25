import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forecast_weather/service/api_helper.dart';
import 'package:forecast_weather/models/weather.dart';

final weatherByCityNameProvider = FutureProvider.autoDispose
    .family<Weather, String>((ref, String cityName) async {
  return ApiHelper.getWeatherByCityName(cityName: cityName);
});
