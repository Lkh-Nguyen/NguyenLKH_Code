import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/weather.dart';

class HttpService{

  static Future<WeatherModel> fetchWeather(String location) async {
    final response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$location&appid=83fdae2c3732d325ff317c91cffb9881"));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}