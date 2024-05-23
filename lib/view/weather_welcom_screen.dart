import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/view/constants/text_style_const.dart';
import 'package:weather_app/view/weather_main_screen.dart';

class WeatherScreen extends StatelessWidget {
  WeatherScreen({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/earth.png",
            fit: BoxFit.cover,
            opacity: const AlwaysStoppedAnimation<double>(0.7),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16) +
                const EdgeInsets.only(top: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Title
                _buildTitle(context),
                //TextField
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(3, 5),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: "Enter City",
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Get City Button
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                    onPressed: () {
                      final city = _controller.text;
                      Provider.of<WeatherProvider>(context, listen: false)
                          .setCity(city);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WeatherMainScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent),
                    child: const Text("Get City",
                        style: TextStyleConst.getCityButtonLabelTextStyle),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("WELCOME", style: TextStyleConst.welcomeLabelTextStyle),
          Text("to", style: TextStyleConst.toLabelTextStyle),
          Text("WEATHER APP", style: TextStyleConst.weatherAppLabelTextStyle),
          SizedBox(height: 25),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
