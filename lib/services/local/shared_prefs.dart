// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPrefsOnboarding {
//   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//   final String keySeenOnboard = 'seen_onboard';

//   Future<bool?> getSeenOnboard() async {
//     SharedPreferences prefs = await _prefs;
//     return prefs.getBool(keySeenOnboard);
//   }

//   Future<void> saveSeenOnboard(bool seen) async {
//     SharedPreferences prefs = await _prefs;
//     prefs.setBool(keySeenOnboard, seen);
//   }
// }
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsOnboarding {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final String keySeenOnboard = 'seen_onboard';

  Future<bool?> getSeenOnboard() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getBool(keySeenOnboard);
  }

  Future<void> saveSeenOnboard(bool seen) async {
    SharedPreferences prefs = await _prefs;
    prefs.setBool(keySeenOnboard, seen);
  }
}
