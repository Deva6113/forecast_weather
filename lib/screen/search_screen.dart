import 'package:flutter/material.dart';
import 'package:forecast_weather/constants/app_colors.dart';
import 'package:forecast_weather/view/gradient_container.dart';
import 'package:forecast_weather/constants/text_styles.dart';
import 'package:forecast_weather/utils/round_text_field.dart';
import 'package:forecast_weather/view/famous_cities_view.dart';
import 'package:forecast_weather/service/api_helper.dart'; // Import ApiHelper

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchController;
  String _weatherInfo = ''; // Display weather information
  bool _isLoading = false; // Loading state

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchWeather(String cityName) async {
    setState(() {
      _isLoading = true;
      _weatherInfo = '';
    });

    try {
      // Fetch weather using the ApiHelper
      final weather = await ApiHelper.getWeatherByCityName(cityName: cityName);

      // Extract and format the data for display
      final temperature = weather.main.temp.toStringAsFixed(1);
      final condition = weather.weather.isNotEmpty
          ? weather.weather[0].description
          : 'Unknown';
      final city = weather.name;

      setState(() {
        _weatherInfo =
            'City: $city\nTemperature: $temperature°C\nCondition: $condition';
      });
    } catch (e) {
      setState(() {
        _weatherInfo =
            'Failed to fetch weather for "$cityName". Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientContainer(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Pick Location',
              style: TextStyles.h1,
            ),
          ),
          const SizedBox(height: 20),

          const Text(
            'Find the area or city that you want to know the detailed weather info at this time',
            style: TextStyles.subtitleText,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: RoundTextField(
                  controller: _searchController,
                  //  hintText: 'Enter city name',
                ),
              ),
              const SizedBox(width: 15),
              GestureDetector(
                onTap: () {
                  if (_searchController.text.isNotEmpty) {
                    _fetchWeather(_searchController.text);
                  }
                },
                child: const LocationIcon(),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Loading Indicator
          if (_isLoading)
            const CircularProgressIndicator()
          else
            Text(
              _weatherInfo,
              style: TextStyles.subtitleText,
              textAlign: TextAlign.center,
            ),

          const SizedBox(height: 30),
          const FamousCitiesView(),
        ],
      )
    ]);
  }
}

class LocationIcon extends StatelessWidget {
  const LocationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        color: AppColors.accentBlue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(
        Icons.location_on_outlined,
        color: AppColors.grey,
      ),
    );
  }
}
