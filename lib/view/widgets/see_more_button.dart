import 'package:flutter/material.dart';
import 'package:weather_app/view/constants/text_style_const.dart';
import 'package:weather_app/view/see_more_screen.dart';

class SeeMoreButton extends StatelessWidget {
  const SeeMoreButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 45,
        child: ElevatedButton(
          onPressed: () {
            print("Daha fazla tıklandı");
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => WeatherSeeMoreScreen(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
          ),
          child: const Text(
            "Daha Fazla",
            style: TextStyleConst.seeMoreButtonTextStyle,
          ),
        ),
      ),
    );
  }
}
