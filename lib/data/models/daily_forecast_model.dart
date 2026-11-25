class DailyForecastModel {
  final String date;
  final double maxTemp;
  final double minTemp;
  final int precipitationProbabilityMax;
  final int weatherCode;

  const DailyForecastModel({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.precipitationProbabilityMax,
    required this.weatherCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'maxTemp': maxTemp,
      'minTemp': minTemp,
      'precipitationProbabilityMax': precipitationProbabilityMax,
      'weatherCode': weatherCode,
    };
  }

  factory DailyForecastModel.fromJson(Map<String, dynamic> json) {
    return DailyForecastModel(
      date: json['date'] as String,
      maxTemp: (json['maxTemp'] as num).toDouble(),
      minTemp: (json['minTemp'] as num).toDouble(),
      precipitationProbabilityMax: (json['precipitationProbabilityMax'] as num).toInt(),
      weatherCode: (json['weatherCode'] as num).toInt(),
    );
  }
}
