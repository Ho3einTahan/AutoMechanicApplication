import 'package:auto_mechanic/views/screen/add-service-screen.dart';
import 'package:flutter/material.dart';

void showAdminLoginDialog(BuildContext context) {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Container(
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.only(bottom: 12), child: Text('ورود مدیر', style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.w800))),
            SizedBox(height: 55, child: TextField(controller: _userNameController, decoration: InputDecoration(hintTextDirection: TextDirection.rtl, hintText: 'نام کاربری'))),
            SizedBox(height: 12),
            SizedBox(height: 55, child: TextField(controller: _passwordController, decoration: InputDecoration(hintTextDirection: TextDirection.rtl, hintText: 'کلمه عبور'))),
            SizedBox(height: 12),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  elevation: 0,
                  minimumSize: Size(220, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  if (_userNameController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                    if (_userNameController.text == 'admin' && _passwordController.text == '1382') {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddServiceScreen()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('نام کاربری یا رمز عبور اشتباه است.'), backgroundColor: Colors.red),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('لطفاً نام کاربری و رمز عبور را وارد کنید.'), backgroundColor: Colors.orange),
                    );
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('ورود', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
                    SizedBox(width: 8),
                    Icon(Icons.login, size: 32),
                  ],
                )),
          ],
        ),
      ),
    ),
  );
}
