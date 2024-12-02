import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _location = 'Kothrud';
  String _greeting = 'Good Afternoon';

  String get location => _location;
  String get greeting => _greeting;

  void updateLocation(String newLocation) {
    _location = newLocation;
    notifyListeners();
  }

  void updateGreeting(String newGreeting) {
    _greeting = newGreeting;
    notifyListeners();
  }
}
