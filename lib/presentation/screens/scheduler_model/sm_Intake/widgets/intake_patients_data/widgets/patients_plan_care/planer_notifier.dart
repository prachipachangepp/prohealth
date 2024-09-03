import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ContainerProvider with ChangeNotifier {
  List<Widget> _containers = [];

  List<Widget> get containers => _containers;

  void addContainer(Widget container) {
    _containers.add(container);
    notifyListeners();
  }
}