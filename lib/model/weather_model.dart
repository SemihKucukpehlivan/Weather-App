class WeatherData {
  final double temperature;
  final int humidity;
  final double windSpeed;
  final String description;
  final double? feelsLike;
  final String? main;
  final String? icon;

  WeatherData({
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.description,
    required this.feelsLike,
    required this.main,
    required this.icon,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      temperature: json['main']['temp'],
      feelsLike: json['main']['temp'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
      description: json['weather'][0]['description'],
      main: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'],
    );
  }

  // İkonu belirleyen metot
  String get localIcon {
    switch (icon) {
      case '01d':
        return 'assets/icons/günesli.png';
      case '04d':
        return 'assets/icons/bulutlu.png';
      case '03n':
        return 'assets/icons/03n.png';
      // Diğer durumları buraya ekleyin
      default:
        return 'assets/icons/default.png';
    }
  }
}
