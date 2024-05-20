class WeatherData {
  final double temperature;
  final int humidity;
  final double windSpeed;
  final String description;

  WeatherData({
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.description,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      temperature: json['main']['temp'], // Sıcaklık zaten Celsius
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
      description: json['weather'][0]['description'],
    );
  }
}

