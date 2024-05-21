import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/view/weather_main_screen.dart';

class WeatherScreen extends StatelessWidget {
  WeatherScreen({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Enter city'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
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
              child: const Text("Get City"),
            ),
          ],
        ),
      ),
    );
  }
}
