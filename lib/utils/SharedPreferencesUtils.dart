import 'package:shared_preferences/shared_preferences.dart';

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

Future<bool> spGetBool() async {
  final SharedPreferences prefs = await _prefs;
  return (prefs.getBool('isLogin') ?? false);
}

Future<bool> spPutBool(bool bool) async {
  final SharedPreferences prefs = await _prefs;
  return (prefs.setBool('isLogin', bool));
}
