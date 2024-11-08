import 'package:shared_preferences/shared_preferences.dart';

class MyPreferences {
  SharedPreferences? prefInstance;
  static final MyPreferences _instance = MyPreferences._internal();

  MyPreferences._internal();

  factory MyPreferences() => _instance;

  Future<SharedPreferences> getInstance() async {
    if (prefInstance != null) return prefInstance!;
    return await SharedPreferences.getInstance();
  }

  static Future<void> storeUserName(String userName) async {
    final instance = await MyPreferences().getInstance();
    instance.setString('userName', userName) ?? '';
  }

  static Future<void> storePassword(String password) async {
    final instance = await MyPreferences().getInstance();
    instance.setString('password', password) ?? '';
  }

  static Future<String> reStoreUserName() async {
    final instance = await MyPreferences().getInstance();
    return await instance.getString('userName') ?? '';
  }

  static Future<String> reStorePassword() async {
    final instance = await MyPreferences().getInstance();
    return await instance.getString('password') ?? '';
  }
}
