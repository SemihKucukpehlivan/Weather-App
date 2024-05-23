
# Weather App

The app allows users to access weather information for cities around the world. Provides real-time weather updates, forecasts and more.

A Flutter Application To Discover The Weather Using [WeatherAPI](https://openweathermap.org/)

 <img src="https://github.com/SemihKucukpehlivan/Weather-App/assets/94116102/08e2e450-e1cf-46b4-b343-ed2e3d8aed0f" alt="Screenshot 1716424012" width="200">  <img src="https://github.com/SemihKucukpehlivan/Weather-App/assets/94116102/ee1c115c-d2e0-41e2-b86a-934aa4fbfc7d" alt="Screenshot 1716424592" width="200"> <img src="https://github.com/SemihKucukpehlivan/Weather-App/assets/94116102/26ebfb2f-2208-42af-a186-9a18be3d16f2" alt="Screenshot_1716429256" width="200">  <img src="https://github.com/SemihKucukpehlivan/Weather-App/assets/94116102/d69b3428-09d9-4ee5-9693-e39d6731f63d" alt="Screenshot 1716424571" width="200"> 


## Dependencies
- [intl](https://pub.dev/packages/intl) - Contains code to deal with date and number formatting and parsing.
- [provider](https://pub.dev/packages/provider) - A popular package used for state management in Flutter applications. It is used to flow data through the widget tree and rebuilds widgets when changes occur.
- [weather](https://pub.dev/packages/weather) - A Flutter package used to retrieve weather data.


## Getting Started
1. Get your API key by creating an account at [WeatherAPI](https://openweathermap.org/).
2. Clone the repository

   ```sh
   git clone git@github.com:SemihKucukpehlivan/Weather-App.git
   ```
3. Install all the packages by running
   ```sh
   flutter pub get
   ```
4. Navigate to **lib/service/weather_service.dart** and paste your API key to the apiKey variable
   ```dart
   static const apiKey = 'YOUR API KEY';
   ```
5. Run the App
   ```dart
   flutter run
   ```
---
