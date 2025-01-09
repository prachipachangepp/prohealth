
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/register_manager/main_register_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/register_data/main_register_screen_data.dart';

class HrRegisterProvider extends ChangeNotifier {
  String _selectedValue = 'Sort';
  bool _load = false;
  bool get load => _load;
  String get selectedValue => _selectedValue;

   List<RegisterDataCompID> _allData = [];
  List<RegisterDataCompID> get allData => _allData;
  //final registerController = ValueNotifier<List<RegisterDataCompID>>([]);

  final StreamController<List<RegisterDataCompID>> _registerController = StreamController.broadcast();
  Stream<List<RegisterDataCompID>> get registerStream  => _registerController.stream;


  void loaderTrue(){
    _load = true;
    notifyListeners();
  }
  void loaderFalse(){
    _load = false;
    notifyListeners();
  }
  /// Main fetch data
  Future<void> fetchData(BuildContext context,[String? value]) async {
    //_isLoading = true;
    //notifyListeners();
    if(value == 'Sort'){
      _selectedValue = 'Sort';
      notifyListeners();
    }

    try {
      List<RegisterDataCompID> data = await GetRegisterByCompId(context);
      _allData = data;
      _registerController.add(data);
    } catch (error) {
      // Handle error
      debugPrint('Error fetching data: $error');
    } finally {
      //_isLoading = false;
      notifyListeners();
    }
  }

  /// Sort data status wise
  void updateSelectedValue(String newValue) {
    _selectedValue = newValue;
    filterData();
    notifyListeners();
  }

  void filterData() {
    String selectedStatus = _selectedValue.trim().toLowerCase();

    if (selectedStatus == 'Sort') {
      _registerController.add(allData);
    } else {
      List<RegisterDataCompID> filteredData = allData.where((data) {
        String dataStatus = data.status.trim().toLowerCase();
        return dataStatus == selectedStatus;
      }).toList();
      _registerController.add(filteredData);
    }
  }


}