import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherProvider with ChangeNotifier {
  String? get currentTemperature => _currentTemperature;
  String? get currentPlace => _currentPlace;
  String? get weatherdes => _weatherdes;
  String? get iconurl => _iconurl;
  String? get bg => _bg;
  String _currentTemperature = '';
  String _currentPlace = 'Erattupetta';
  String? _weatherdes;
  String? _iconurl;
  String? _bg;
  Future getWeather(String location) async {
    String apiKey = '5cd33d63faea455b8f541806232003';
    final url = Uri.parse(
        'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$location');
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    _iconurl = "https:" + data["current"]["condition"]["icon"];
    _currentTemperature = data['current']['temp_c'].toStringAsFixed(0);
    _currentPlace = data['location']['name'].toString();
    _weatherdes = data['current']['condition']['text'].toString();
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
