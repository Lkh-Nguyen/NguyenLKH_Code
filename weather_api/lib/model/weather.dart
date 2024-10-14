class WeatherModel {
  final double lon;
  final double lat;
  final String mainWeather;
  final String description;
  final String icon;
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int seaLevel;
  final double windSpeed;
  final int clouds;
  final String cityName;
  final String country;

  WeatherModel({
    required this.lon,
    required this.lat,
    required this.mainWeather,
    required this.description,
    required this.icon,
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.windSpeed,
    required this.clouds,
    required this.cityName,
    required this.country,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      lon: json['coord']['lon'],
      lat: json['coord']['lat'],
      mainWeather: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      temp: json['main']['temp'],
      feelsLike: json['main']['feels_like'],
      tempMin: json['main']['temp_min'],
      tempMax: json['main']['temp_max'],
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      seaLevel: json['main']['sea_level'],
      windSpeed: json['wind']['speed'],
      clouds: json['clouds']['all'],
      cityName: json['name'],
      country: json['sys']['country'],
    );
  }

  // Chuyển nhiệt độ từ Kelvin sang Celsius
  double get tempInCelsius => temp - 273.15;
  double get tempMinInCelsius => tempMin - 273.15;
  double get tempMaxInCelsius => tempMax - 273.15;
}
