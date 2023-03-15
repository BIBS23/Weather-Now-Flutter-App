import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/home.dart';
import 'package:weather_app/provider/weather_provider.dart';


void main() {

  // Request permission to access the internet


  runApp(const
  
   MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => WeatherProvider()),
          // Add more providers here if needed
        ],
        child: const MaterialApp(
          home: HomeUi(),
        ));
  }
}
