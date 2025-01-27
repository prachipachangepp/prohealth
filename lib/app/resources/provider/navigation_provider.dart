import 'dart:async';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/google_aotopromt_api_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/licenses_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/add_employee/clinical.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/licenses_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;


class RouteProvider with ChangeNotifier {
  String _currentRoute = '/';
  String get currentRoute => _currentRoute;

  RouteProvider() {
    _loadLastRoute();
  }

  /// Constant route management
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

  /// Navigator provider
  void navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void navigateWithData(BuildContext context, Widget Function(BuildContext) pageBuilder) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: pageBuilder),
    );
  }
}

/// HR provider
class HrManageProvider extends ChangeNotifier{

  /// Profile bar
  String _trimmedAddress = '';
  String _trimmedSummery = '';
  String _maskedString = '';
  String _hireDateTimeStamp = '';
  String _dateOfBirthStamp = '';
  OverlayEntry? _overlayEntryAddress;
  OverlayEntry? _overlayEntrySummery;
  final StreamController<Map<String, int>> _licenseStreamController =
  StreamController<Map<String, int>>.broadcast();
  Stream<Map<String, int>> get licenseStream => _licenseStreamController.stream;
  int _expiredCount = 0;
  int _upToDateCount = 0;
  int _aboutToCount = 0;

  int get expiredCount => _expiredCount;
  int get upToDateCount => _upToDateCount;
  int get aboutToCount => _aboutToCount;
  String get hireDateTimeStamp => _hireDateTimeStamp;
  String get maskedString => _maskedString;
  String get trimmedAddress => _trimmedAddress;
  String get trimmedSummery => _trimmedSummery;
  String get dateOfBirthStamp => _dateOfBirthStamp;

  /// Tab bar private veriables HR
  int _currentTab = 0;
  int _qulificationModuleTab = 0;
  int _documentsModuleTab = 0;

  int get currentTab => _currentTab;
  int get qulificationModuleTab => _qulificationModuleTab;
  int get documentsModuleTab => _documentsModuleTab;

  /// qualification employeement
  String _trimmedEmployeeAddress = '';
  String _trimmedSupervisor = '';
  bool _isOverlayVisible = false;
  OverlayEntry? _overlayEntry;
  String get trimmedEmployeeAddress => _trimmedEmployeeAddress;
  String get trimmedSupervisor => _trimmedSupervisor;

  /// qualification education
  String _trimmedDegree = '';
  String _trimmedCollege = '';
  String _trimmedMajor = '';

  String get trimmedDegree => _trimmedDegree;
  String get trimmedCollege => _trimmedCollege;
  String get trimmedMajor => _trimmedMajor;

  /// qualification reference
  String _trimmedCompanyName = '';
  String _trimmedTitle = '';
  String _trimmedReference = '';

  String get trimmedCompanyName => _trimmedCompanyName;
  String get trimmedTitle => _trimmedTitle;
  String get trimmedReference => _trimmedReference;

  /// Qualification license
  String _trimmedOrg = '';

  String get trimmedOrg => _trimmedOrg;

  /// Documents ack
  bool _fileAbove20Mb = false;
  String _fileName = '';
  dynamic _filePath;
  List<DropdownMenuItem<String>> _dropDownMenuItems = [];
  bool _load = false;
  bool _isFormSubmitted = false;
  bool _editFileAbove20Mb = false;
  bool _fileIsPicked = false;
  bool _isSubmitted = false;
  String _editFileName = '';
  dynamic _editFilePath;
  dynamic _editClinicalLicenseFilePath;
  String _editClinicalLicenseFileName = '';
  bool _clinicalFileIsPicked = false;
  List<DropdownMenuItem<String>> get dropDownMenuItems => _dropDownMenuItems;
  bool get fileAbove20Mb => _fileAbove20Mb;
  bool get isFormSubmitted => _isFormSubmitted;
  bool get isSubmitted => _isSubmitted;
  bool get load => _load;
  String get fileName => _fileName;
  bool _showExpiryDateField = false;
  bool _showAddAckExpiryDateField = false;
  bool _showAddDocExpiryDateField = false;
   DateTime? _datePicked;
  // TextEditingController

  String get editClinicalLicenseFileName => _editClinicalLicenseFileName;
  dynamic get editClinicalLicenseFilePath => _editClinicalLicenseFilePath;
  bool get clinicalFileIsPicked => _clinicalFileIsPicked;
  DateTime get datePicked =>_datePicked!;
  bool get showExpiryDateField => _showExpiryDateField;
  bool get showAddAckExpiryDateField => _showAddAckExpiryDateField;
  bool get showAddDocExpiryDateField => _showAddDocExpiryDateField;
  dynamic get filePath => _filePath;
  bool get editFileAbove20Mb => _editFileAbove20Mb;
  bool get fileIsPicked => _fileIsPicked;
  String get editFileName => _editFileName;
  dynamic get editFilePath => _editFilePath;

  void listenData(){
    notifyListeners();
  }
  void isFormSubmited(){
    _isFormSubmitted = true;
    notifyListeners();
  }
  void loaderTrue(){
    _load = true;
    notifyListeners();
  }
  void loaderFalse(){
    _load = false;
    notifyListeners();
  }
  void loadDropDown(List dataList){
    _dropDownMenuItems = dataList
        .map((doc) => DropdownMenuItem<String>(
      value: doc.documentName,
      child: Text(doc.documentName),
    ))
        .toList();
    notifyListeners();
  }

  /// Main Tab bar methods
  void setTab(int tabIndex) {
    _currentTab = tabIndex;
    notifyListeners();
  }

  /// Quilification tab bar
  void setQulificationModuleTab(int tabIndex) {
    _qulificationModuleTab = tabIndex;
    notifyListeners();
  }

  /// Document Tab bar
  void setDocumentsModuleTab(int tabIndex) {
    _documentsModuleTab = tabIndex;
    notifyListeners();
  }

  /// HR profile bar Address trim
  // void updateAddress(String address) {
  //   const int maxLength = 25;
  //   if (address.length > maxLength) {
  //     _trimmedAddress = '${address.substring(0, maxLength)}...';
  //   } else {
  //     _trimmedAddress = address;
  //   }
  //   notifyListeners();
  // }
  String _line1 = '';
  String _line2 = '';
  String _tooltipText = '';

  String get line1 => _line1;
  String get line2 => _line2;

  get tooltipText => _tooltipText;

  void updateAddress(String address) {
    const int line1MaxLength = 25;
    const int line2MaxLength = 20;

    if (address.length > line1MaxLength) {
      _line1 = address.substring(0, line1MaxLength);

      if (address.length > line1MaxLength + line2MaxLength) {
        _line2 = '${address.substring(line1MaxLength, line1MaxLength + line2MaxLength)}...';
        _tooltipText = address;
      } else {
        _line2 = address.substring(line1MaxLength);
        _tooltipText = address;
      }
    } else {
      _line1 = address;
      _line2 = '';
      _tooltipText = address;
    }

    notifyListeners();
  }


  /// HR profile trim summery
  void updateSummery(String symmery) {
    const int maxLength = 15;
    if (symmery.length > maxLength) {
      _trimmedSummery = '${symmery.substring(0, maxLength)}...';
    }else{
      _trimmedSummery = symmery;
    }
    notifyListeners();
  }

  /// HR profile bar maske number
  void maskString(String input, int visibleDigits) {
    int maskLength = input.length - visibleDigits;

    if (maskLength > 0) {
      String masked = '*' * maskLength;
      _maskedString = masked + input.substring(maskLength);
    } else {
      _maskedString = input;
    }
    notifyListeners();
  }

  /// HR profile bar hire date trimme
  void calculateHireDateTimeStamp(String hireDate) {
    DateTime convertedDate = DateTime.parse(hireDate);
    DateTime today = DateTime.now();
    int years = today.year - convertedDate.year;
    int months = today.month - convertedDate.month;
    int days = today.day - convertedDate.day;

    if (days < 0) {
      months--;
      int prevMonthLastDay = DateTime(today.year, today.month, 0).day;
      days += prevMonthLastDay;
    }
    if (months < 0) {
      years--;
      months += 12;
    }

    _hireDateTimeStamp = "$years yr, $months m, $days d";

    // Notify listeners about the updated result
    notifyListeners();
  }

  /// HR date of birth calculate
  void calculateAge(String birthDate) {
    DateTime convertedDate = DateTime.parse(birthDate);
    DateTime today = DateTime.now();

    int years = today.year - convertedDate.year;
    int months = today.month - convertedDate.month;
    int days = today.day - convertedDate.day;

    if (days < 0) {
      months--;
      int prevMonthLastDay = DateTime(today.year, today.month, 0).day;
      days += prevMonthLastDay;
    }

    if (months < 0) {
      years--;
      months += 12;
    }
    String result = "$years yr, $months m, $days d";
    print("dobTimestamp: $_dateOfBirthStamp");
    print('Calculated Age: $result');
    _dateOfBirthStamp = result;
  }

  /// Address overlyentry
  // Show overlay
  void showOverlayAddress(BuildContext context, Offset position,String finalAddress) {
    _overlayEntryAddress = OverlayEntry(
      builder: (context) => Positioned(
        left: 300,
        top: position.dy + 15, // Adjust to position below the text
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 250,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 4, spreadRadius: 2),
              ],
            ),
            child: Text(
              finalAddress,
              style: ThemeManagerAddressPB.customTextStyle(context),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntryAddress!);
  }
  // Remove overlay
  void removeOverlayAddress() {
    _overlayEntryAddress?.remove();
    _overlayEntryAddress = null;
  }




  /// Summery overlay entry
  void showSummeryOverlay(BuildContext context, Offset position, String summery) {
    _overlayEntrySummery = OverlayEntry(
      builder: (context) => Positioned(
        right: 300,
        top: position.dy + 20, // Adjust to position below the text
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 250,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 4, spreadRadius: 2),
              ],
            ),
            child: Text(
              summery,
              style: ProfileBarTextBoldStyle.customEditTextStyle(),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context)?.insert(_overlayEntrySummery!);
  }
  void removeSummeryOverlay() {
    _overlayEntrySummery?.remove();
    _overlayEntrySummery = null;
  }

  /// Color converter
  bool isDarkColor(Color color) {
    double perceivedBrightness =
        color.red * 0.299 + color.red * 0.587 + color.blue * 0.114;
    return perceivedBrightness < 128;
  }

  /// License stream brodcast in profileBar HR
  void clearLicenseData(){
    _expiredCount = 0;
    _aboutToCount = 0;
    _upToDateCount = 0;
    notifyListeners();
  }
  void fetchLicenseData(BuildContext context, int employeeId) async {
    while (true) {
      try {
        // Fetch the data
        Map<String, List<LicensesData>> data =
        await getLicenseStatusWise(context, employeeId);

        // Extract counts
         _expiredCount = data['Expired']?.length ?? 0;
        _aboutToCount = data['About to Expire']?.length ?? 0;
         _upToDateCount = data['Upto date']?.length ?? 0;
         print('Expired county >>>> ${_expiredCount}');
        print('Expired county >>>> ${_aboutToCount}');
        print('Expired county >>>> ${_upToDateCount}');
        // Add counts to the stream
        _licenseStreamController.add({
          'Expired': expiredCount,
          'About to Expire': aboutToCount,
          'Upto date': upToDateCount,
        });
      } catch (error) {
        print("Error fetching data: $error");
        _licenseStreamController.add({
          'Expired': 0,
          'About to Expire': 0,
          'Upto date': 0,
        });
      }

      // Wait before fetching again
      await Future.delayed(const Duration(seconds: 5));
    }
  }
  void dispose() {
    _licenseStreamController.close();
    notifyListeners();
  }

  /// Qualification employeement
  void trimEmpAddress(String empAddress) {
    const int maxLength = 22;
    if (empAddress.length > maxLength) {
      _trimmedEmployeeAddress = '${empAddress.substring(0, maxLength)}...';
    }else {
      _trimmedEmployeeAddress = empAddress;
    }
    notifyListeners();
  }
  void trimSupervisor(String supervisor) {
    const int maxLength = 22;
    if (supervisor.length > maxLength) {
      _trimmedSupervisor = '${supervisor.substring(0, maxLength)}...';
    }else {
      _trimmedSupervisor = supervisor;
    }
    notifyListeners();
  }

  OverlayEntry _createOverlayEntry(BuildContext context, Offset position, String text) {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          left: position.dx,
          top: position.dy,
          child: Material(
            elevation: 8.0,
            child: Container(
              width: 150,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                  text,
                  style: ThemeManagerDarkFont.customTextStyle(context)
              ),
            ),
          ),
        );
      },
    );
  }
  // Show overlay
  void showOverlay(BuildContext context, Offset position, String text) {
    if (_isOverlayVisible) return;

    _overlayEntry = _createOverlayEntry(context, position, text);
    Overlay.of(context)?.insert(_overlayEntry!);
    _isOverlayVisible = true;
  }

  // Remove overlay
  void removeOverlay() {
    if (_overlayEntry != null && _isOverlayVisible) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _isOverlayVisible = false;
    }
  }

  /// qualification Education
  void trimDegreeString(String degree) {
    const int maxLength = 22;
    if (degree.length > maxLength) {
      _trimmedDegree = '${degree.substring(0, maxLength)}...';
    }else {
      _trimmedDegree = degree;
    }
    notifyListeners();
  }
  void trimCollegeString(String college) {
    const int maxLength = 22;
    if (college.length > maxLength) {
      _trimmedCollege = '${college.substring(0, maxLength)}...';
    }else {
      _trimmedCollege = college;
    }
    notifyListeners();
  }
  void trimMajorString(String major) {
    const int maxLength = 22;
    if (major.length > maxLength) {
      _trimmedMajor = '${major.substring(0, maxLength)}...';
    }else {
      _trimmedMajor = major;
    }
    notifyListeners();
  }

  /// Qualification reference
  void trimCompanyString(String company) {
    const int maxLength = 22;
    if (company.length > maxLength) {
      _trimmedCompanyName = '${company.substring(0, maxLength)}...';
    }else {
      _trimmedCompanyName = company;
    }
    notifyListeners();
  }
  void trimTitleString(String title) {
    const int maxLength = 22;
    if (title.length > maxLength) {
      _trimmedTitle = '${title.substring(0, maxLength)}...';
    }else {
      _trimmedTitle = title;
    }
    notifyListeners();
  }
  void trimReferenceString(String reference) {
    const int maxLength = 22;
    if (reference.length > maxLength) {
      _trimmedReference = '${reference.substring(0, maxLength)}...';
    }else {
      _trimmedReference = reference;
    }
    notifyListeners();
  }

  /// Qualification license
  void trimOrgString(String org) {
    const int maxLength = 22;
    if (org.length > maxLength) {
      _trimmedOrg = '${org.substring(0, maxLength)}...';
    }else {
      _trimmedOrg = org;
    }
    notifyListeners();
  }




  /// Documents ack
  void pickAckFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    final fileSize = result?.files.first.size; // File size in bytes
    final isAbove20MB = fileSize! > (20 * 1024 * 1024); // 20MB in bytes
    if (result != null) {
        _filePath = result.files.first.bytes;
        _fileName = result.files.first.name;
        _fileAbove20Mb = !isAbove20MB;
        notifyListeners();
    }
  }
  // Document constant edit
  void pickEditFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf']);
    final fileSize = result?.files.first.size; // File size in bytes
    final isAbove20MB = fileSize! > (20 * 1024 * 1024); // 20MB in bytes
    if (result != null) {
        _fileIsPicked = true;
        _editFilePath = result.files.first.bytes;
        _editFileName = result.files.first.name;
        _editFileAbove20Mb = !isAbove20MB;
        notifyListeners();
    }
  }
  void assignedValue(String fileName){
    _editFileName = fileName;
    notifyListeners();
  }
  void showExpDateFieldAck(){
    _showAddAckExpiryDateField = true;
    notifyListeners();
  }
  void showExpDateFieldAckFalse(){
    _showAddAckExpiryDateField = false;
    notifyListeners();
  }
  void showExpDateFieldDoc(){
    _showAddDocExpiryDateField = true;
    notifyListeners();
  }
  void showExpDateFieldDocFalse(){
    _showAddDocExpiryDateField = false;
    notifyListeners();
  }
  void clearAddedValue(){
    _showAddDocExpiryDateField = false;
    _showAddAckExpiryDateField = false;
    _editFileAbove20Mb = false;
    _isFormSubmitted = false;
    _fileAbove20Mb = false;
    _fileIsPicked = false;
    _clinicalFileIsPicked = false;
    _showExpiryDateField = false;
    _editClinicalLicenseFilePath;
    _editClinicalLicenseFileName = '';
    _editFilePath = null;
    _editFileName = '';
    _filePath = null;
    _fileName = '';
    notifyListeners();
  }

  TextEditingController _expiryDateController = TextEditingController();
  TextEditingController get expiryDateController => _expiryDateController;
  void editDocumentValue(String selectedExpiryType,String? expiryDate, TextEditingController controller){
    if (selectedExpiryType == AppConfig.issuer) {
      print('Expiry date on provider ${expiryDate}');
      DateTime dateTime =
      DateTime.parse(expiryDate ?? DateTime.now().toString());
      _showExpiryDateField = true;
      _datePicked = dateTime;
      _expiryDateController = TextEditingController(
          text: DateFormat('yyyy-MM-dd').format(dateTime));
      notifyListeners();
    }else{
      _showExpiryDateField = false;
    }
  }
  void pickDateValue(BuildContext context) async{
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1901),
      lastDate: DateTime(3101),
    );
    if (pickedDate != null) {
      newDatePicked(pickedDate);
      _expiryDateController.text =
          DateFormat('yyyy-MM-dd').format(pickedDate);
    }
    notifyListeners();
  }

  void newDatePicked(DateTime value){
    _datePicked = value;
    notifyListeners();
  }

  /// Clinical License and P license
  void pickClinicalEditFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf']);
    final fileSize = result?.files.first.size; // File size in bytes
    final isAbove20MB = fileSize! > (20 * 1024 * 1024); // 20MB in bytes
    if (result != null) {
      _clinicalFileIsPicked = true;
      _editClinicalLicenseFilePath = result.files.first.bytes;
      _editClinicalLicenseFileName = result.files.first.name;
      _editFileAbove20Mb = !isAbove20MB;
      notifyListeners();
    }
  }
  void isSumitted(){
    _isSubmitted = true;
    notifyListeners();
  }
  void getFileName(String fileName){
    _editClinicalLicenseFileName = fileName;
    notifyListeners();
  }
}

class AddressProvider with ChangeNotifier{
  final TextEditingController controller;
  final Function(String)? onChange;
  final Function(double, double)? onLatLngFetched;// Callback for text changes
  List<String> _suggestions = [];
  OverlayEntry? _overlayEntry;
  AddressProvider({required this.controller, required this.onChange,this.onLatLngFetched}){
    controller.addListener(_onAddressChanged);// Load route when the provider is initialized
  }
  // Latitude and longitude variables
  double? latitudeL;
  double? longitudeL;
  /// google map
  // LatLng? markerPosition;
  // GoogleMapController? mapController;
  // // Dummy data for zones, counties, and zip codes
  // final List<LatLng> _zoneData = [
  //   LatLng(37.7749, -122.4194), // Example Zone 1 (San Francisco)
  //   LatLng(37.7849, -122.4294), // Example Zone 2
  //   LatLng(37.7949, -122.4394), // Example Zone 3
  // ];
  //
  // final List<LatLng> _countyData = [
  //   LatLng(37.7849, -122.4194), // Example County 1
  //   LatLng(37.7949, -122.4094), // Example County 2
  // ];
  //
  // final List<LatLng> _zipCodeData = [
  //   LatLng(37.7749, -122.4294), // Example Zip Code 1
  //   LatLng(37.7649, -122.4194), // Example Zip Code 2
  // ];
  //
  // void updateMarker(String address,String selectedValue) async {
  //   Set<Marker> markers = {};
  //
  //   if (selectedValue == 'Zones') {
  //     // Add Zone markers
  //     for (var zone in _zoneData) {
  //       markers.add(Marker(
  //         markerId: MarkerId('zone-${zone.latitude}-${zone.longitude}'),
  //         position: zone,
  //         infoWindow: InfoWindow(title: 'Zone'),
  //       ));
  //     }
  //   } else if (selectedValue == 'Counties') {
  //     // Add County markers
  //     for (var county in _countyData) {
  //       markers.add(Marker(
  //         markerId: MarkerId('county-${county.latitude}-${county.longitude}'),
  //         position: county,
  //         infoWindow: InfoWindow(title: 'County'),
  //       ));
  //     }
  //   } else if (selectedValue == 'Zip Codes') {
  //     // Add Zip Code markers
  //     for (var zip in _zipCodeData) {
  //       markers.add(Marker(
  //         markerId: MarkerId('zip-${zip.latitude}-${zip.longitude}'),
  //         position: zip,
  //         infoWindow: InfoWindow(title: 'Zip Code'),
  //       ));
  //     }
  //   } else {
  //     try {
  //       List<Location> locations = await locationFromAddress(address);
  //       if (locations.isNotEmpty) {
  //         markerPosition =
  //             LatLng(locations.first.latitude, locations.first.longitude);
  //
  //         // Move the camera to the new marker position
  //         mapController?.animateCamera(
  //             CameraUpdate.newLatLngZoom(markerPosition!, 14));
  //
  //         notifyListeners();
  //       }
  //     } catch (e) {
  //       print("Error fetching coordinates: $e");
  //     }
  //   }
  //   // Update the markers on the map
  //   notifyListeners();
  //   //_markers = markers;
  //
  //
  //
  // }
  // void setMapController(GoogleMapController controller) {
  //   mapController = controller;
  // }
  /// Address

  List<String> get suggestions => _suggestions;

  void disposeProvider() {
    controller.removeListener(_onAddressChanged);
    removeOverlay();
  }

  Future<void> _onAddressChanged() async {
    final query = controller.text;

    // Notify parent via onChanged callback
    if (onChange != null) onChange!(query);

    if (query.isEmpty) {
      _suggestions = [];
      removeOverlay();
      notifyListeners();
      return;
    }

    final suggestions = await fetchSuggestions(query);
    if (suggestions.isNotEmpty && suggestions[0] != query) {
      _suggestions = suggestions;
      notifyListeners();
      //showOverlay();
    } else {
      _suggestions = [];
      removeOverlay();
    }
    notifyListeners();
  }

  // Getters for latitude and longitude
  double? get latitude => latitudeL;
  double? get longitude => longitudeL;
  /// Method to fetch latitude and longitude from the selected address
  Future<void> getLatLngFromAddress(String address) async {
    final String apiKey = AppConfig.googleApiKey; // Replace with your API key.
    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?address=${Uri.encodeComponent(address)}&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK' && data['results'].isNotEmpty) {
          final location = data['results'][0]['geometry']['location'];
          latitudeL = location['lat'];
          longitudeL = location['lng'];
          notifyListeners();

          // Notify parent widget with the latitude and longitude
          if (onLatLngFetched != null) {
            onLatLngFetched!(latitudeL!, longitudeL!);
          }
          notifyListeners();
          print("Latitude: $latitude, Longitude: $longitude");
          print('Get location lat: $latitudeL and long: $longitudeL');
        } else {
          print("No coordinates found for this address.");
        }
      } else {
        print("Failed to fetch coordinates: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching lat/lng: $e");
    }
  }
  // Future<void> getLatLngFromAddress(String address) async {
  //   try {
  //     List<Location> locations = await locationFromAddress(address);
  //     if (locations.isNotEmpty) {
  //       double latitude = locations.first.latitude;
  //       double longitude = locations.first.longitude;
  //
  //       // Notify parent widget with the latitude and longitude
  //       if (onLatLngFetched != null) {
  //         onLatLngFetched!(latitude, longitude);
  //       }
  //
  //       print("Latitude: $latitude, Longitude: $longitude");
  //     } else {
  //       print("No coordinates found for this address.");
  //     }
  //   } catch (e) {
  //     print("Error fetching lat/lng: $e");
  //   }
  // }
  void showOverlay(BuildContext context) {
    removeOverlay(); // Remove existing overlay before showing new one

    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: removeOverlay,
            child: Container(
              color: Colors.transparent, // Make this transparent so it's invisible
            ),
          ),
          Positioned(
            left: position.dx,
            top: position.dy + renderBox.size.height,
            width: renderBox.size.width,
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: _suggestions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_suggestions[index]),
                      onTap: () {
                        controller.text = _suggestions[index];
                        removeOverlay();
                        notifyListeners();
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  void removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
}

