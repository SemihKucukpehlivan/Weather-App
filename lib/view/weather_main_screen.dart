import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/service/weather_service.dart';
import 'package:weather_app/view/constants/text_style_const.dart';
import 'package:weather_app/view/helper/string_helper.dart';
import 'package:weather_app/view/weather_deatils_screen.dart';
import 'package:weather_app/view/widgets/background.dart';
import 'package:weather_app/view/widgets/blur_card.dart';
import 'package:weather_app/view/widgets/global_button.dart';
import 'package:weather_app/view/widgets/weather_icon.dart';

class WeatherMainScreen extends StatefulWidget {
  const WeatherMainScreen({super.key});

  @override
  State<WeatherMainScreen> createState() => _WeatherMainScreenState();
}

class _WeatherMainScreenState extends State<WeatherMainScreen> {
  @override
  void initState() {
    super.initState();
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
    WeatherAppService().fetchWeather(context, weatherProvider.city!);
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final city = weatherProvider.city;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<WeatherProvider>(
        builder: (context, provider, _) {
          if (provider.weatherData == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final weatherData = provider.weatherData;
            return Stack(
              children: [
                BackgroundWidget(weatherData: weatherData),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // City Name
                        Text(city!, style: TextStyleConst.cityLabelTextStyle),
                        // Weather Icon, Temperature, Description
                        Center(
                          child: Column(
                            children: [
                              WeatherIconWidget(
                                iconUrl: '${weatherData!.icon}',
                                iconWidth:
                                    MediaQuery.of(context).size.width * 0.60,
                              ),
                              Text(
                                ' ${weatherData.temperature.truncate()}°',
                                style: TextStyleConst.temperatureLabelTextStyle,
                              ),
                              Text(
                                  StringHelper.capitalizeFirstLetters(
                                      weatherData.description),
                                  style:
                                      TextStyleConst.descriptionLabelTextStyle),
                              const SizedBox(height: 20),

                              //Humidity and Wind speed
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  BlurCard(
                                      content: Text(
                                        'Nem\n ${weatherData.humidity}%',
                                        style: TextStyleConst.blurCardTextStyle,
                                      ),
                                      image: "nem.png"),
                                  BlurCard(
                                    content: Text(
                                      'Rüzgar Hızı\n  ${weatherData.windSpeed} m/s',
                                      style: TextStyleConst.blurCardTextStyle,
                                    ),
                                    image: "wind.png",
                                  ),
                                ],
                              ),
                              // See more button
                              MainElevatedButton(
                                txt: "See More",
                                widget: WeatherDetailsScreen(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
