import 'package:auto_mechanic/utils/appThem.dart';
import 'package:auto_mechanic/views/screen/add-service-screen.dart';
import 'package:auto_mechanic/views/screen/home-screen.dart';
import 'package:auto_mechanic/views/screen/service-detail-screen.dart';
import 'package:auto_mechanic/views/screen/splash-screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: AppTheme(),
      title: '',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
