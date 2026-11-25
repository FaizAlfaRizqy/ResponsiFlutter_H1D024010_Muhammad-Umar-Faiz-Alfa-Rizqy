import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/app.dart';
import 'data/datasources/location_local_datasource.dart';
import 'data/datasources/weather_remote_datasource.dart';
import 'data/repositories/location_repository.dart';
import 'data/repositories/weather_repository.dart';
import 'features/locations/viewmodels/location_viewmodel.dart';
import 'features/weather/viewmodels/weather_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Instantiate Data Sources
  final weatherRemoteDataSource = WeatherRemoteDataSource();
  final locationLocalDataSource = LocationLocalDataSource();

  // Instantiate Repositories
  final weatherRepository = WeatherRepository(
    remoteDataSource: weatherRemoteDataSource,
  );
  final locationRepository = LocationRepository(
    remoteDataSource: weatherRemoteDataSource,
    localDataSource: locationLocalDataSource,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WeatherViewModel(
            weatherRepository: weatherRepository,
            locationRepository: locationRepository,
          )..init(),
        ),
        ChangeNotifierProvider(
          create: (_) => LocationViewModel(
            locationRepository: locationRepository,
          )..init(),
        ),
      ],
      child: const AtmosApp(),
    ),
  );
}
