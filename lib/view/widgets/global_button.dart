import 'package:flutter/material.dart';
import 'package:weather_app/view/constants/text_style_const.dart';

// ignore: must_be_immutable
class MainElevatedButton extends StatelessWidget {
  String txt;
  Widget widget;
  MainElevatedButton({required this.txt, required this.widget, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 45,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => widget,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
          ),
          child: Text(
            txt,
            style: TextStyleConst.seeMoreButtonTextStyle,
          ),
        ),
      ),
    );
  }
}
