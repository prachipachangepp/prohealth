import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/google_aotopromt_api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;


class RouteProvider with ChangeNotifier {
  String _currentRoute = '/';
  String _trimmedAddress = '';
  String _trimmedSummery = '';
  String _maskedString = '';
  String _hireDateTimeStamp = '';

  String get hireDateTimeStamp => _hireDateTimeStamp;
  String get maskedString => _maskedString;
  String get trimmedAddress => _trimmedAddress;
  String get trimmedSummery => _trimmedSummery;

  /// Tab bar private veriables HR
  int _currentTab = 0;
  int _qulificationModuleTab = 0;
  int _documentsModuleTab = 0;

  int get currentTab => _currentTab;
  int get qulificationModuleTab => _qulificationModuleTab;
  int get documentsModuleTab => _documentsModuleTab;


  String get currentRoute => _currentRoute;

  RouteProvider() {
    _loadLastRoute();
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
  /// Constant route management
  Future<void> _loadLastRoute() async {
    final prefs = await SharedPreferences.getInstance();
    _currentRoute = prefs.getString('lastRoute') ?? '/';
    notifyListeners();
  }

  /// HR profile bar Address trim
  void updateAddress(String address) {
    const int maxLength = 15;
    if (address.length > maxLength) {
      _trimmedAddress = '${address.substring(0, maxLength)}...';
    } else {
      _trimmedAddress = address;
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

  /// HR profile bar hoire date trimme
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
