import 'package:flutter/material.dart';
import '../../locations/views/search_locations_view.dart';
import '../../weather/views/weather_dashboard_view.dart';
import '../widgets/atmos_bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _navigateToSearch() {
    setState(() {
      _currentIndex = 1;
    });
  }

  void _navigateToHome() {
    setState(() {
      _currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          WeatherDashboardView(
            onNavigateToSearch: _navigateToSearch,
          ),
          SearchLocationsView(
            onBackToDashboard: _navigateToHome,
          ),
        ],
      ),
      bottomNavigationBar: AtmosBottomNavBar(
        currentIndex: _currentIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}
