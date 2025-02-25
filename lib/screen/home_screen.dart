import 'package:flutter/material.dart';
import 'package:forecast_weather/constants/app_colors.dart';
import 'package:forecast_weather/screen/forecast_screen.dart';
import 'package:forecast_weather/screen/search_screen.dart';
import 'package:forecast_weather/screen/weather_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPageIndex = 0;
  final _destinations = const [
    NavigationDestination(
      icon: Icon(Icons.home_outlined, color: Colors.white),
      selectedIcon: Icon(Icons.home, color: Colors.white),
      label: '',
    ),
    NavigationDestination(
      icon: Icon(Icons.search_outlined, color: Colors.white),
      selectedIcon: Icon(Icons.search, color: Colors.white),
      label: '',
    ),
    NavigationDestination(
      icon: Icon(Icons.wb_sunny_outlined, color: Colors.white),
      selectedIcon: Icon(Icons.wb_sunny, color: Colors.white),
      label: '',
    ),
  ];
  // naming the screen name
  final _screens = [
    const WeatherScreen(),
    const SearchScreen(),
    const ForecastReportScreen(),
    //const Center(child: Text('Settings Screen')),
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: _screens[_currentPageIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: const NavigationBarThemeData(
          backgroundColor: AppColors.secondaryBlack,
        ),
        child: NavigationBar(
          destinations: _destinations,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          selectedIndex: _currentPageIndex,
          indicatorColor:
              Colors.transparent, // for touch will cause like transparent touch
          onDestinationSelected: (index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
        ),
      ),
    );
  }
}
