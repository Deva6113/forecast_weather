import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forecast_weather/service/api_helper.dart';
import 'package:forecast_weather/models/weekly_weather.dart';

final weeklyWeatherProvider = FutureProvider.autoDispose((ref) async {
  return ApiHelper.getWeeklyForecast();
});
