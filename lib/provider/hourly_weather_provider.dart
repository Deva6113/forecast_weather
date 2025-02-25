import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forecast_weather/service/api_helper.dart';
import 'package:forecast_weather/models/hourly_weather.dart';

final hourlyWeatherProvider = FutureProvider.autoDispose((ref) async {
  return ApiHelper.getHourlyForecast();
});
