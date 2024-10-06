import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  late SharedPreferences sharedPreferences;

  Future<SharedPreferences> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  }

  // Private constructor
  SessionManager._internal();

  // The single instance of the class
  static final SessionManager _instance = SessionManager._internal();

  // Factory constructor
  factory SessionManager() {

    return _instance;
  }
}
