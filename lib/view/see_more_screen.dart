import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/view/constants/text_style_const.dart';
import 'package:weather_app/view/helper/string_helper.dart';
import 'package:weather_app/view/widgets/background.dart';
import 'package:weather_app/view/widgets/weather_icon.dart';

class WeatherSeeMoreScreen extends StatefulWidget {
  const WeatherSeeMoreScreen({super.key});

  @override
  State<WeatherSeeMoreScreen> createState() => _WeatherSeeMoreScreenState();
}

class _WeatherSeeMoreScreenState extends State<WeatherSeeMoreScreen> {
  @override
  void initState() {
    super.initState();
    // Verileri yüklemek için fetchWeather metodunu çağırıyoruz.
    Future.microtask(() =>
        Provider.of<WeatherProvider>(context, listen: false).fetchWeather());
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final city = weatherProvider.city;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<WeatherProvider>(builder: (context, provider, _) {
        if (provider.weatherData == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final weatherData = provider.weatherData;
          return Stack(
            children: [
              BackgroundWidget(weatherData: weatherData),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 35),
                child: Column(
                  children: [
                    // Weather Icon, name, description, temperature
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: WheaterCard(weatherData, context, city),
                    ),
                    const SizedBox(height: 20),
                    // Details
                    Expanded(
                      child: weatherDetails(city, weatherData),
                    ),
                    const SizedBox(height: 20),
                    // Information
                    const SizedBox(height: 8),
                    ForecastList(weatherProvider),
                  ],
                ),
              ),
            ],
          );
        }
      }),
    );
  }

  Padding weatherDetails(String? city, WeatherData? weatherData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          _buildInformationWidget(
            weatherData,
            '${weatherData!.windSpeed} km/h',
            "Rüzgar",
            Icons.wind_power_outlined,
          ),
          const SizedBox(
            height: 8,
          ),
          _buildInformationWidget(
            weatherData,
            '${weatherData.humidity} %',
            "Nem",
            Icons.water_drop,
          ),
        ],
      ),
    );
  }

  Expanded _buildInformationWidget(
      WeatherData? weatherData, String value, String title, IconData icon) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24), color: Colors.white38),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 50,
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    Text(
                      title,
                      style: TextStyleConst.informationLabelTextStyle,
                    ),
                    Text(
                      value,
                      style: TextStyleConst.informationValueLabelTextStyle,
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }

  Container WheaterCard(
      WeatherData? weatherData, BuildContext context, String? city) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        color: Colors.white38,
      ),
      child: Row(
        children: [
          WeatherIconWidget(
            iconUrl: '${weatherData!.icon}',
            iconWidth: MediaQuery.of(context).size.width * 0.50,
          ),
          Column(
            children: [
              Text(
                ' ${weatherData.temperature.truncate()}°',
                style: TextStyleConst.temperatureLabelTextStyle2,
              ),
              Text(
                  StringHelper.capitalizeFirstLetters(
                    (city!),
                  ),
                  style: TextStyleConst.cityNameLabelTextStyle),
              Text(
                  StringHelper.capitalizeFirstLetters(
                    (weatherData.description),
                  ),
                  style: TextStyleConst.descriptionLabelTextStyle2),
            ],
          ),
        ],
      ),
    );
  }

  Expanded ForecastList(
    WeatherProvider weatherProvider,
  ) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherProvider.weatherList.length,
        itemBuilder: (context, index) {
          final weather = weatherProvider.weatherList[index];
          final formattedDate = formatDate(weather.date);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.29,
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.circular(34),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      formattedDate,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${weather.temperature}°C',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    StringHelper.capitalizeFirstLetters(weather.description),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String formatDate(DateTime date) {
    String day = date.day
        .toString()
        .padLeft(2, '0'); // Gün değeri, iki haneli olacak şekilde
    String month = date.month
        .toString()
        .padLeft(2, '0'); // Ay değeri, iki haneli olacak şekilde
    return '$day-$month';
  }
}
