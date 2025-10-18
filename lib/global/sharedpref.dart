import 'package:shared_preferences/shared_preferences.dart';

class Sharedpref {
  late SharedPreferences prefs;

  setup() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future saveAuthToken(String token) async {
    await prefs.setString('auth_token', token);
  }

  String? getAuthToken() {
    return prefs.getString('auth_token');
  }

  Future removeAuthToken() async {
    await prefs.remove('auth_token');
  }
}
