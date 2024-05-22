class WeatherForecast {
  final DateTime date;
  final double temperature;
  final String description;

  WeatherForecast(
      {required this.date,
      required this.temperature,
      required this.description});

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      date: DateTime.parse(json['dt_txt']),
      temperature: json['main']['temp'],
      description: json['weather'][0]['description'],
    );
  }
}
