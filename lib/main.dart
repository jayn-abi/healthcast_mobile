import 'package:flutter/material.dart';
import 'package:healthcast/screens/alerts_screen.dart';
import 'package:healthcast/screens/login_screen.dart';
import 'package:healthcast/screens/profile_screen.dart';
import 'package:healthcast/screens/surveillance_screen.dart';
import 'package:healthcast/screens/weather_screen.dart';
import 'package:healthcast/screens/disease_info_screen.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginScreen(),
        '/weather': (_) => const WeatherScreen(),
         '/surveillance': (_) => const SurveillanceScreen(),
         '/alerts': (_) => const AlertsScreen(),
         '/diseases': (_) => const DiseasesScreen(),
        '/profile': (_) => const ProfileScreen(),

      },
    );
  }
}
