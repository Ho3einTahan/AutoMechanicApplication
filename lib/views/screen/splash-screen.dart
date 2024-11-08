import 'dart:async';

import 'package:auto_mechanic/views/screen/home-screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick == 6) {
        timer.cancel();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset('images/mechanic-splash.png', height: screenHeight * 0.3, width: screenWidth * 0.8, fit: BoxFit.cover)),
          const SizedBox(height: 24),
          const Center(
            child: Text(
              'اتومکانیک حسینی فخر',
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(color: Colors.yellowAccent, blurRadius: 10, offset: Offset(2, 2))],
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'مکانیکی, جلوبندی, دیاگ, خدمات تعویض روغن',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 22,
              fontWeight: FontWeight.bold,
              shadows: [Shadow(color: Colors.yellow.withOpacity(0.5), blurRadius: 8, offset: Offset(1, 1))],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          const Text(
            'بامدیریت : محمد حسینی فخر',
            style: TextStyle(
              color: Colors.yellow,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              shadows: [Shadow(color: Colors.yellowAccent, blurRadius: 8, offset: Offset(2, 2))],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '09135727764',
            style: TextStyle(
              color: Colors.yellow,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              shadows: [Shadow(color: Colors.yellowAccent, blurRadius: 8, offset: Offset(2, 2))],
            ),
          ),
          Spacer(),
          Text('در حال بارگذاری...', textDirection: TextDirection.rtl, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18, fontWeight: FontWeight.w500)),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
