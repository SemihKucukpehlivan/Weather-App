class WeatherData {
  final double temperature;
  final int humidity;
  final double windSpeed;
  final String description;
  final String? icon; // Yeni eklenen ikon alanı

  WeatherData({
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.description,
    required this.icon, // Yeni eklenen ikon alanı
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      temperature: json['main']['temp'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }
}
