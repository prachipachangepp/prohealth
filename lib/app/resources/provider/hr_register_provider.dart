
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prohealth/app/constants/app_config.dart';
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

class HrEnrollEmployeeProvider extends ChangeNotifier{
  String? _positionError;
  String? _zoneError;
  String? _phoneError;
  String? _firstnameError;
  String? _lastnameError;
  String? _emailError;
  String? _specialityError;
  bool _isFormValid = true;
  String? _expiryTypeError;
  String _generatedURL = '';
  bool _load = false;

  String get generatedURL => _generatedURL;
  bool get load => _load;
  String? get positionError => _positionError;
  String? get zoneError => _zoneError;
  String? get phoneError => _phoneError;
  String? get firstnameError => _firstnameError;
  String? get lastnameError => _lastnameError;
  String? get emailError => _emailError;
  String? get specialityError => _specialityError;
  String? get expiryTypeError => _expiryTypeError;
  bool get isFormValid => _isFormValid;

  void loaderTrue(){
    _load = true;
    notifyListeners();
  }
  void loaderFalse(){
    _load = false;
    notifyListeners();
  }

  Future<String> generateUrlLink() async {
    final String url = '${AppConfig.deployment}/#/onBordingWelcome';
    _generatedURL = url;
    print('Generated URL: $_generatedURL');
    return url;
  }
  String? validateTextField(String value, String fieldName) {
    if (value.isEmpty) {
      _isFormValid = false;
      notifyListeners();
      return "$fieldName";
    }
    notifyListeners();
    return null;
  }

  void validateFields({required String position,  required String phone,required String speciality,
    required String firstName,required String lastName, required String email }) {
      _isFormValid = true;
      _positionError = validateTextField(position, 'Please Enter Position');
      _phoneError = validateTextField(phone, 'Please Enter Phone Number');
      _specialityError = validateTextField(speciality, 'Please Enter Speciality');
      _firstnameError = validateTextField(firstName, 'Please Enter First Name');
      _lastnameError = validateTextField(lastName, 'Please Enter Last Name');
      _emailError = validateTextField(email, 'Please Enter Email');
      //_ZoneError = _validateTextField(selectedZone!, 'Please Select Zone');
    notifyListeners();
  }
}

