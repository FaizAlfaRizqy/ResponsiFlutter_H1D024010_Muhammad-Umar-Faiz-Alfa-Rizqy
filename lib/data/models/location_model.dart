class LocationModel {
  final int? id;
  final String name;
  final String region;
  final String country;
  final double latitude;
  final double longitude;
  final bool isFavorite;
  final double? currentTemp;
  final int? currentWeatherCode;

  const LocationModel({
    this.id,
    required this.name,
    required this.region,
    required this.country,
    required this.latitude,
    required this.longitude,
    this.isFavorite = false,
    this.currentTemp,
    this.currentWeatherCode,
  });

  LocationModel copyWith({
    int? id,
    String? name,
    String? region,
    String? country,
    double? latitude,
    double? longitude,
    bool? isFavorite,
    double? currentTemp,
    int? currentWeatherCode,
  }) {
    return LocationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      region: region ?? this.region,
      country: country ?? this.country,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isFavorite: isFavorite ?? this.isFavorite,
      currentTemp: currentTemp ?? this.currentTemp,
      currentWeatherCode: currentWeatherCode ?? this.currentWeatherCode,
    );
  }

  factory LocationModel.fromGeocodingJson(Map<String, dynamic> json) {
    final name = json['name'] as String? ?? '';
    final admin1 = json['admin1'] as String?;
    final country = json['country'] as String? ?? '';

    // Build region string matching Stitch: "California, United States" or "Zurich, Switzerland"
    final regionParts = <String>[];
    if (admin1 != null && admin1.isNotEmpty && admin1 != name) {
      regionParts.add(admin1);
    }
    if (country.isNotEmpty) {
      regionParts.add(country);
    }
    final region = regionParts.isEmpty ? country : regionParts.join(', ');

    return LocationModel(
      id: json['id'] as int?,
      name: name,
      region: region,
      country: country,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      isFavorite: false,
    );
  }

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] as int?,
      name: json['name'] as String? ?? '',
      region: json['region'] as String? ?? '',
      country: json['country'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      isFavorite: json['isFavorite'] as bool? ?? false,
      currentTemp: (json['currentTemp'] as num?)?.toDouble(),
      currentWeatherCode: json['currentWeatherCode'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'region': region,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'isFavorite': isFavorite,
      'currentTemp': currentTemp,
      'currentWeatherCode': currentWeatherCode,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationModel &&
          runtimeType == other.runtimeType &&
          name.toLowerCase() == other.name.toLowerCase() &&
          (latitude - other.latitude).abs() < 0.01 &&
          (longitude - other.longitude).abs() < 0.01;

  @override
  int get hashCode => name.toLowerCase().hashCode;
}
