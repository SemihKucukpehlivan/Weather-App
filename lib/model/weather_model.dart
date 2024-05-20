class WeatherAppModel {
  final String description;
  final double temperature;
  final String cityName;

  WeatherAppModel(
      {required this.description,
      required this.temperature,
      required this.cityName});

  factory WeatherAppModel.fromJson(Map<String, dynamic> json) {
    return WeatherAppModel(
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'],
      cityName: json['name'],
    );
  }
}
