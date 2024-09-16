import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RouteProvider with ChangeNotifier {
  String _currentRoute = '/';

  String get currentRoute => _currentRoute;

  RouteProvider() {
    _loadLastRoute(); // Load route when the provider is initialized
  }

  Future<void> _loadLastRoute() async {
    final prefs = await SharedPreferences.getInstance();
    _currentRoute = prefs.getString('lastRoute') ?? '/';
    notifyListeners();
  }

  Future<void> setRoute(String route) async {
    _currentRoute = route;
    notifyListeners();
    print("route set to $route");

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastRoute', route); // Persist the route
  }
}
