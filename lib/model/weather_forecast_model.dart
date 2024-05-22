class WeatherForecast {
  final DateTime date;
  final double temperature;
  final String description;
  final String? icon;

  WeatherForecast(
      {required this.date,
      required this.temperature,
      required this.icon,
      required this.description});

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      date: DateTime.parse(json['dt_txt']),
      temperature: json['main']['temp'],
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }
}
