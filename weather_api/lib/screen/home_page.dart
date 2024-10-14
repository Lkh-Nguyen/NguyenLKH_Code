import 'package:flutter/material.dart';
import 'package:weather_api/service/http_service.dart';

import '../model/weather.dart';
import '../model/weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<WeatherModel> weatherData;
  late WeatherModel weather;


  String selectedCity = "Hanoi"; // Thành phố mặc định
  final List<String> cities = ["Hanoi", "Hue", "Danang", "Dalat"]; // Danh sách các thành phố


  @override
  void initState() {
    super.initState();
    fetchWeatherData(selectedCity);
  }

  Future<void> fetchWeatherData(String location) async {
    weatherData = HttpService.fetchWeather(location);
    weather = await weatherData;
    setState(() { });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(103, 107, 208, 1),
      body: FutureBuilder<WeatherModel>(
        future: weatherData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Thêm Dropdown để chọn thành phố
                  DropdownButton<String>(
                    value: selectedCity,
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                    dropdownColor: Colors.deepPurpleAccent,
                    items: cities.map((String city) {
                      return DropdownMenuItem<String>(
                        value: city,
                        child: Text(city, style: const TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                    onChanged: (String? newCity) {
                      if (newCity != null) {
                        setState(() {
                          selectedCity = newCity;
                          fetchWeatherData(selectedCity); // Cập nhật thời tiết khi thay đổi thành phố
                        });
                      }
                    },
                  ),

                  const SizedBox(height: 50),
                  Text(
                    weather.cityName,
                    style: const TextStyle( color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${weather.tempInCelsius.toStringAsFixed(2)}°C',
                    style: const TextStyle( color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    weather.description,
                    style: const TextStyle( color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Monday 30, September 2024\n${TimeOfDay.now().format(context)}',
                    style: const TextStyle(fontSize: 18,  color: Colors.white,),
                    textAlign: TextAlign.center,
                  ),
                  const Icon(
                    Icons.wb_cloudy, // Bạn có thể thêm icon tùy theo weather.icon
                    size: 300,
                    color: Colors.white,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(103, 58, 183, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildInfoItem(Colors.white, Icons.wind_power, 'Wind',
                                '${weather.windSpeed} km/h'),
                            _buildInfoItem(Colors.white, Icons.sunny, 'Max',
                                '${weather.tempMaxInCelsius.toStringAsFixed(2)}°C'),
                            _buildInfoItem(Colors.white, Icons.wind_power, 'Min',
                                '${weather.tempMinInCelsius.toStringAsFixed(2)}°C'),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          height: 2,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildInfoItem(Colors.orange, Icons.water_drop,
                                'Humidity', '${weather.humidity}%'),
                            _buildInfoItem(Colors.orange, Icons.wordpress, 'Pressure',
                                '${weather.pressure} hPa'),
                            _buildInfoItem(Colors.orange, Icons.leaderboard_rounded,
                                'Sea Level', '${weather.seaLevel} m'),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildInfoItem(
      Color iconColor, IconData icon, String title, String value) {
    return Column(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 30,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
              fontSize: 16,
              color: Colors.white),
        ),
      ],
    );
  }
}
