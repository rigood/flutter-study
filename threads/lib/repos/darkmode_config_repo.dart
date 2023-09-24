import 'package:shared_preferences/shared_preferences.dart';

class DarkmodeConfigRepository {
  static const String _darkmode = "darkmode";

  final SharedPreferences _preferences;

  DarkmodeConfigRepository(this._preferences);

  bool isDarkmode() {
    return _preferences.getBool(_darkmode) ?? false;
  }

  Future<void> setDarkmode(bool value) async {
    _preferences.setBool(_darkmode, value);
  }
}
