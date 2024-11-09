import 'package:auto_mechanic/views/screen/service-detail-screen.dart';
import 'package:flutter/material.dart';

import '../dialog/admin-login-dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _serviceButton(context),
                    const SizedBox(height: 24),
                    _managerLoginButton(context),
                  ],
                ),
              ),
              _designerInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _serviceButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceDetailScreen(isAdmin: false)));
      },
      child: Container(
        width: 220,
        height: 65,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.yellow[700],
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.yellow.withOpacity(0.5), blurRadius: 10, offset: Offset(0, 6)),
            ],
            gradient: LinearGradient(colors: [Colors.yellow[700]!, Colors.orangeAccent], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Center(
          child: Text(
            'مشاهده سرویس‌های دوره‌ای',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _managerLoginButton(BuildContext context) {
    return InkWell(
      onTap: () => showAdminLoginDialog(context),
      child: Container(
        width: 220,
        height: 65,
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.yellow.withOpacity(0.5), blurRadius: 10, offset: Offset(0, 6)),
            ],
            gradient: LinearGradient(colors: [Colors.grey[800]!, Colors.black], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Center(
          child: Text(
            'ورود مدیر',
            style: TextStyle(color: Colors.yellow[700], fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _designerInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.black87, Colors.black], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        boxShadow: [
          BoxShadow(color: Colors.yellow.withOpacity(0.3), blurRadius: 15, spreadRadius: 2),
        ],
      ),
      child: Column(
        children: [
          Text('طراح: حسین طحان مفرد طاهری', style: TextStyle(color: Colors.yellow[700], fontSize: 18, fontWeight: FontWeight.bold, shadows: [Shadow(color: Colors.orangeAccent, blurRadius: 5)])),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.phone, color: Colors.yellow[700], size: 20),
              const SizedBox(width: 8),
              Text('0939-548-6064', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 8),
          Text('تمامی حقوق محفوظ است © 2024', style: TextStyle(color: Colors.grey[500], fontSize: 14, fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }
}
