import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveContainers(List<String> containerData) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('containers', containerData);
}

Future<List<String>> loadContainers() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('containers') ?? [];
}