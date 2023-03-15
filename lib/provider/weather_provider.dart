import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherProvider with ChangeNotifier {
  String? get currentTemperature => _currentTemperature;
  String? get currentPlace => _currentPlace;
  String? get weatherdes => _weatherdes;
  String? get iconname => _iconname;
  String? get bg => _bg;
  String _currentTemperature = '';
  String _currentPlace = 'Pala';
  String? _weatherdes;
  String? _iconname;
  String? _bg;
  Future getWeather(String location) async {
    String apiKey = 'b5dbe55df71688c5336483b4dc528a9a';
    final url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$apiKey&units=metric');
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    _currentTemperature = data['main']['temp'].toStringAsFixed(0);
    _currentPlace = data['name'].toString();
    _weatherdes = data['weather'][0]['description'].toString();
    DateTime currentTime = DateTime.now();
    bool _isdaytime = currentTime.hour > 6 && currentTime.hour < 18;
    notifyListeners();

  }
  Future defaultLocation() async {

    getWeather(_currentPlace);

  }

  Future updateLocation(String newlocation) async {
    await getWeather(newlocation);
    notifyListeners();
  }
}
