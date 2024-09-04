import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'dart:convert';
import 'package:google_geocoding_api/google_geocoding_api.dart';
import 'package:http/http.dart' as http;

//
//
// class BottomBarRow extends StatefulWidget {
//   const BottomBarRow({super.key});
//
//   @override
//   _BottomBarRowState createState() => _BottomBarRowState();
// }
//
// class _BottomBarRowState extends State<BottomBarRow> {
//   String? _ipAddress;
//   bool _isFetchingIp = true;
//   Future<Map<String, String>?>? _geolocationFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchIPAddress();
//     //_fetchLocationData();
//    // _geolocationFuture = _getGeolocation(); // Initialize geolocation fetching
//   }
//
//   Future<void> _fetchIPAddress() async {
//     try {
//       final response =
//       await http.get(Uri.parse('https://api.ipify.org?format=json'));
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         setState(() {
//           _ipAddress = data['ip'];
//           _isFetchingIp = false;
//         });
//       } else {
//         print('Failed to load IP address');
//         setState(() {
//           _isFetchingIp = false;
//         });
//       }
//     } catch (e) {
//       print('Error: $e');
//       setState(() {
//         _isFetchingIp = false;
//       });
//     }
//   }
//
//
//
//
//
//
//
//   // Future<Map<String, String>?> _getGeolocation() async {
//   //   final completer = Completer<Map<String, String>>();
//   //
//   //   void successCallback(html.Geoposition position) async {
//   //     final coords = position.coords!;
//   //     final latitude = coords.latitude!.toDouble();
//   //     final longitude = coords.longitude!.toDouble();
//   //
//   //     // Use your chosen reverse geocoding API here
//   //     final apiKey = 'AIzaSyCw6mXOPCtbKn5i0bWcAcnfXCkb0y5G7Lg'; // Replace with your API key
//   //     final reverseGeocodeUrl = Uri.parse(
//   //         'https://api.opencagedata.com/geocode/v1/json?q=$latitude+$longitude&key=$apiKey'
//   //     );
//   //
//   //     try {
//   //       final response = await http.get(reverseGeocodeUrl);
//   //       if (response.statusCode == 200) {
//   //         final data = jsonDecode(response.body);
//   //         final results = data['results'] as List;
//   //         if (results.isNotEmpty) {
//   //           final firstResult = results[0];
//   //           final country = firstResult['components']['country'] ?? 'Unknown country';
//   //           final state = firstResult['components']['state'] ?? 'Unknown state';
//   //           completer.complete({'country': country, 'state': state});
//   //         } else {
//   //           completer.complete({'country': 'Unknown country', 'state': 'Unknown state'});
//   //         }
//   //       } else {
//   //         completer.completeError('Failed to fetch location details');
//   //       }
//   //     } catch (e) {
//   //       completer.completeError('Error: $e');
//   //     }
//   //   }
//   //
//   //   void errorCallback(html.PositionError error) {
//   //     completer.completeError('Failed to get location');
//   //   }
//   //
//   //   if (html.window.navigator.geolocation != null) {
//   //     html.window.navigator.geolocation
//   //         .getCurrentPosition(successCallback, errorCallback
//   //     ); // Correct usage with options
//   //   } else {
//   //     completer.completeError('Geolocation is not supported');
//   //   }
//   //
//   //   return completer.future;
//   // }
//
//
//
//   // Future<Map<String, String>?> _getGeolocation() async {
//   //   final completer = Completer<Map<String, String>>();
//   //
//   //   void successCallback(html.Geoposition position) async {
//   //     final coords = position.coords!;
//   //     final latitude = coords.latitude!.toDouble() ;
//   //     final longitude = coords.longitude!.toDouble();
//   //
//   //     // Use your chosen reverse geocoding API here
//   //     final apiKey = 'AIzaSyCw6mXOPCtbKn5i0bWcAcnfXCkb0y5G7Lg'; // Replace with your API key
//   //     final reverseGeocodeUrl = Uri.parse(
//   //         'https://api.opencagedata.com/geocode/v1/json?q=$latitude+$longitude&key=$apiKey'
//   //     );
//   //
//   //     try {
//   //       final response = await http.get(reverseGeocodeUrl);
//   //       if (response.statusCode == 200) {
//   //         final data = jsonDecode(response.body);
//   //         final results = data['results'] as List;
//   //         if (results.isNotEmpty) {
//   //           final firstResult = results[0];
//   //           final country = firstResult['components']['country'] ?? 'Unknown country';
//   //           final state = firstResult['components']['state'] ?? 'Unknown state';
//   //           completer.complete({'country': country, 'state': state});
//   //         } else {
//   //           completer.complete({'country': 'Unknown country', 'state': 'Unknown state'});
//   //         }
//   //       } else {
//   //         completer.completeError('Failed to fetch location details');
//   //       }
//   //     } catch (e) {
//   //       completer.completeError('Error: $e');
//   //     }
//   //   }
//   //
//   //   void errorCallback(html.PositionError error) {
//   //     completer.completeError('Failed to get location');
//   //   }
//   //
//   //   if (html.window.navigator.geolocation != null) {
//   //     html.window.navigator.geolocation
//   //         .getCurrentPosition(successCallback, errorCallback);
//   //   } else {
//   //     completer.completeError('Geolocation is not supported');
//   //   }
//   //
//   //   return completer.future;
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 56, // AppSize.s56 or a constant value
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//             horizontal: MediaQuery.of(context).size.width / 120),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             /// Text
//             Text(
//               '#2031ABC01BA',
//               style: GoogleFonts.firaSans(
//                 fontSize: 12, // FontSize.s12 or a constant value
//                 fontWeight: FontWeight.normal,
//                 color: Colors.grey, // ColorManager.grey or a color constant
//                 decoration: TextDecoration.none,
//               ),
//             ),
//
//             /// IP + Geolocation
//             Row(
//               children: [
//             // Text(
//             // ' $_country'+"  $_state",
//             //   style: GoogleFonts.firaSans(
//             //     fontSize: 12,
//             //     fontWeight: FontWeight.bold,
//             //     color: Colors.grey[800],
//             //     decoration: TextDecoration.none,
//             //   ),
//             // ),
//
//
//                 // FutureBuilder<Map<String, String>?>(
//                 //   future: _geolocationFuture,
//                 //   builder: (context, geoSnapshot) {
//                 //     if (geoSnapshot.connectionState ==
//                 //         ConnectionState.waiting) {
//                 //       return Text(
//                 //         'Loading location...',
//                 //         style: GoogleFonts.firaSans(
//                 //           fontSize: 12,
//                 //           fontWeight: FontWeight.bold,
//                 //           color: Colors.grey[800],
//                 //           decoration: TextDecoration.none,
//                 //         ),
//                 //       );
//                 //     } else if (geoSnapshot.hasError) {
//                 //       return Text(
//                 //         'Error fetching location',
//                 //         style: GoogleFonts.firaSans(
//                 //           fontSize: 12,
//                 //           fontWeight: FontWeight.bold,
//                 //           color: Colors.grey[800],
//                 //           decoration: TextDecoration.none,
//                 //         ),
//                 //       );
//                 //     } else if (geoSnapshot.hasData) {
//                 //       final location = geoSnapshot.data!;
//                 //       return Text(
//                 //         'Country: ${location['country']}, State: ${location['state']}',
//                 //         style: GoogleFonts.firaSans(
//                 //           fontSize: 12,
//                 //           fontWeight: FontWeight.bold,
//                 //           color: Colors.grey[800],
//                 //           decoration: TextDecoration.none,
//                 //         ),
//                 //       );
//                 //     } else {
//                 //       return Text(
//                 //         'No location data',
//                 //         style: GoogleFonts.firaSans(
//                 //           fontSize: 12,
//                 //           fontWeight: FontWeight.bold,
//                 //           color: Colors.grey[800],
//                 //           decoration: TextDecoration.none,
//                 //         ),
//                 //       );
//                 //     }
//                 //   },
//                 // ),
//                 SizedBox(width: 10), // AppSize.s10 or a constant value
//                 _isFetchingIp
//                     ? Text(
//                   'Loading IP...',
//                   style: GoogleFonts.firaSans(
//                     fontSize: 12,
//                     fontWeight: FontWeight.normal,
//                     color: Colors.grey,
//                     decoration: TextDecoration.none,
//                   ),
//                 )
//                     : Text(
//                   _ipAddress ?? 'No IP',
//                   style: GoogleFonts.firaSans(
//                     fontSize: 12,
//                     fontWeight: FontWeight.normal,
//                     color: Colors.grey,
//                     decoration: TextDecoration.none,
//                   ),
//                 ),
//               ],
//             ),
//
//             /// Logo
//             Padding(
//               padding: const EdgeInsets.only(bottom: 7),
//               child: Column(
//                 children: [
//                   Image.asset(
//                     'images/powered_logo.png',
//                     width: MediaQuery.of(context).size.width / 50,
//                   ),
//                   Text(
//                     'Powered by',
//                     style: GoogleFonts.firaSans(
//                       fontSize: 12,
//                       fontWeight: FontWeight.normal,
//                       color: Colors.grey,
//                       decoration: TextDecoration.none,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//

class BottomBarRow extends StatefulWidget {
  const BottomBarRow({super.key});

  @override
  _BottomBarRowState createState() => _BottomBarRowState();
}

class _BottomBarRowState extends State<BottomBarRow> {

 var  ip ;
 var localresponse;
  String? _ipAddress;
  String? _location;

  bool _isFetchingIp = true;
  Future<Map<String, double>?>? _geolocationFuture;
 late Future<String> _stateFuture;

  @override
  void initState() {
    super.initState();
    _fetchIPAddress();
    _stateFuture = getCurrentLocation();
    //getCurrentLocation();
    // getLocation();
   // _geolocationFuture = _getGeolocation(); // Initialize geolocation fetching
  }
String? _city;
  String? _country;
 Future<void> _fetchIPAddress() async {
   try {
     // Fetch the IP address first
     final ipResponse = await http.get(Uri.parse('https://api.ipify.org?format=json'));
     if (ipResponse.statusCode == 200) {
       final ipData = jsonDecode(ipResponse.body);
       _ipAddress = ipData['ip'];

       // Use the IP address to fetch city and country information
       final locationResponse = await http.get(Uri.parse('http://ip-api.com/json/$_ipAddress'));
       if (locationResponse.statusCode == 200) {
         final locationData = jsonDecode(locationResponse.body);

         setState(() {
           _city = locationData['city'];
           _country = locationData['country'];
           _isFetchingIp = false;
         });
         print('Fetched city and country ${_country} + ${_city}');
       } else {
         print('Failed to load location data');
         setState(() {
           _isFetchingIp = false;
         });
       }
     } else {
       print('Failed to load IP address');
       setState(() {
         _isFetchingIp = false;
       });
     }
   } catch (e) {
     print('Error: $e');
     setState(() {
       _isFetchingIp = false;
     });
   }
 }




 Future getLocation() async {
    var response = await http.get(Uri.parse("http://ip-api.com/json/${ip}"));
    var jsonpares = json.decode(response.body);
    localresponse=jsonpares;
    print(jsonpares);
  }

  getDirectLocation() async{
    await _fetchIPAddress();getLocation();
  }

  /// Fetch live geo Location
 Future<String> getStateFromLatLng(double latitude, double longitude) async {
   try {
     // Initialize the GoogleGeocodingApi with the API key
     final googleGeocodingApi = GoogleGeocodingApi(AppConfig.googleApiKey);

     // Perform reverse geocoding
     final geocodingResponse = await googleGeocodingApi.reverse(
       "${latitude.toString()}, ${longitude.toString()}",
     );

     if (geocodingResponse != null && geocodingResponse.results.isNotEmpty) {
       for (var result in geocodingResponse.results) {
         for (var component in result.addressComponents) {
           if (component.types.contains('administrative_area_level_2')) {
             print('Name : ${component.longName}');
             return component.longName; // State name
           }
         }
       }
       return 'State not found in the response.';
     } else {
       return 'No address found for the provided coordinates.';
     }
   } catch (e) {
     print('Error occurred while fetching the state: $e');
     return 'Error: ${e.toString()}';
   }
 }
 Future<String> getCurrentLocation() async {
   bool serviceEnabled;
   LocationPermission permission;

   serviceEnabled = await Geolocator.isLocationServiceEnabled();
   if (!serviceEnabled) {
     return Future.error('Location services are disabled.');
   }

   permission = await Geolocator.checkPermission();
   if (permission == LocationPermission.denied) {
     permission = await Geolocator.requestPermission();
     if (permission == LocationPermission.denied) {
       return Future.error('Location permissions are denied');
     }
   }

   if (permission == LocationPermission.deniedForever) {
     return Future.error(
         'Location permissions are permanently denied, we cannot request permissions.');
   }

   // Get the current position
   Position position = await Geolocator.getCurrentPosition(
       desiredAccuracy: LocationAccuracy.high
   );

   print('Current location: ${position.latitude}, ${position.longitude}');

   // Get the address from the current position
   print('Position : ${position}');
   return await getStateFromLatLng(position.latitude,position.longitude);
 }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56, // AppSize.s56 or a constant value
      // color: Colors.green,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 120),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Text
            Text(
              '--',
              style: GoogleFonts.firaSans(
                fontSize: 12, // FontSize.s12 or a constant value
                fontWeight: FontWeight.normal,
                color: Colors.grey, // ColorManager.grey or a color constant
                decoration: TextDecoration.none,
              ),
            ),

            /// IP + Geolocation
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _city != null ? Text(
            '${_country} (${_city})',
              style: GoogleFonts.firaSans(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
                decoration: TextDecoration.none,
              ),
            ) : Text(
        'No location data',
        style: GoogleFonts.firaSans(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
          decoration: TextDecoration.none,
        ),
      ),
                // FutureBuilder(
                //   future: _stateFuture,
                //   builder: (context, geoSnapshot) {
                //     if (geoSnapshot.connectionState ==
                //         ConnectionState.waiting) {
                //       return Text(
                //         'Loading location...',
                //         style: GoogleFonts.firaSans(
                //           fontSize: 12,
                //           fontWeight: FontWeight.bold,
                //           color: Colors.grey[800],
                //           decoration: TextDecoration.none,
                //         ),
                //       );
                //     }  if (geoSnapshot.hasError) {
                //       return Text(
                //         'Error fetching location',
                //         style: GoogleFonts.firaSans(
                //           fontSize: 12,
                //           fontWeight: FontWeight.bold,
                //           color: Colors.grey[800],
                //           decoration: TextDecoration.none,
                //         ),
                //       );
                //     }  if (geoSnapshot.hasData) {
                //       // final location = geoSnapshot.data!;
                //       return Text(
                //         geoSnapshot.data ?? 'No location data',
                //         style: GoogleFonts.firaSans(
                //           fontSize: 12,
                //           fontWeight: FontWeight.bold,
                //           color: Colors.grey[800],
                //           decoration: TextDecoration.none,
                //         ),
                //       );
                //     } else {
                //       return Text(
                //         'No location data',
                //         style: GoogleFonts.firaSans(
                //           fontSize: 12,
                //           fontWeight: FontWeight.bold,
                //           color: Colors.grey[800],
                //           decoration: TextDecoration.none,
                //         ),
                //       );
                //     }
                //   },
                // ),
                SizedBox(
                  width: AppSize.s20,
                ),
                _isFetchingIp
                    ? Text(
                        'Loading IP...',
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                          decoration: TextDecoration.none,
                        ),
                      )
                    : Text(
                        _ipAddress ?? 'No IP',
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                          decoration: TextDecoration.none,
                        ),
                      ),
              ],
            ),

            /// Logo
            Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: Column(
                children: [
                  Image.asset(
                    'images/powered_logo.png',
                    width: MediaQuery.of(context).size.width / 60,
                  ),
                  Text(
                    'Powered by',
                    style: GoogleFonts.firaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
////////////////////////////////////////////////////////////////////////////////
//
// class BottomBarRow extends StatefulWidget {
//   const BottomBarRow({super.key});
//
//   @override
//   _BottomBarRowState createState() => _BottomBarRowState();
// }
//
// class _BottomBarRowState extends State<BottomBarRow> {
//   String? _ipAddress;
//   bool _isFetchingIp = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchIPAddress();
//   }
//
//   Future<void> _fetchIPAddress() async {
//     try {
//       final response = await http.get(Uri.parse('https://api.ipify.org?format=json'));
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         setState(() {
//           _ipAddress = data['ip'];
//           _isFetchingIp = false;
//         });
//       } else {
//         print('Failed to load IP address');
//         setState(() {
//           _isFetchingIp = false;
//         });
//       }
//     } catch (e) {
//       print('Error: $e');
//       setState(() {
//         _isFetchingIp = false;
//       });
//     }
//   }
//
//
//
//   Future<Map<String, double>?> getGeolocation() async {
//     final completer = Completer<Map<String, double>>();
//
//     final onSuccess = (html.Position position) {
//       final coords = position.coords;
//       completer.complete({
//         'latitude': coords.latitude,
//         'longitude': coords.longitude,
//       });
//     };
//
//     final onError = (html.PositionError error) {
//       completer.completeError('Failed to get location');
//     };
//
//     if (html.window.navigator.geolocation != null) {
//       html.window.navigator.geolocation.getCurrentPosition(onSuccess, onError);
//     } else {
//       completer.completeError('Geolocation is not supported');
//     }
//
//     return completer.future;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 56, // AppSize.s56 or a constant value
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 120),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             /// Text
//             Text(
//               '#2031ABC01BA',
//               style: GoogleFonts.firaSans(
//                 fontSize: 12, // FontSize.s12 or a constant value
//                 fontWeight: FontWeight.normal,
//                 color: Colors.grey, // ColorManager.grey or a color constant
//                 decoration: TextDecoration.none,
//               ),
//             ),
//
//             /// Text + IP + Geolocation
//             Row(
//               children: [
//                 FutureBuilder<Map<String, double>?>(
//                   future: getGeolocation(),
//                   builder: (context, geoSnapshot) {
//                     if (geoSnapshot.connectionState == ConnectionState.waiting) {
//                       return Text(
//                         'Loading location...',
//                         style: GoogleFonts.firaSans(
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey[800],
//                           decoration: TextDecoration.none,
//                         ),
//                       );
//                     } else if (geoSnapshot.hasError) {
//                       return Text(
//                         'Error fetching location',
//                         style: GoogleFonts.firaSans(
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey[800],
//                           decoration: TextDecoration.none,
//                         ),
//                       );
//                     } else if (geoSnapshot.hasData) {
//                       final location = geoSnapshot.data!;
//                       return Text(
//                         'Lat: ${location['latitude']?.toStringAsFixed(2)}, Lon: ${location['longitude']?.toStringAsFixed(2)}',
//                         style: GoogleFonts.firaSans(
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey[800],
//                           decoration: TextDecoration.none,
//                         ),
//                       );
//                     } else {
//                       return Text(
//                         'No location data',
//                         style: GoogleFonts.firaSans(
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey[800],
//                           decoration: TextDecoration.none,
//                         ),
//                       );
//                     }
//                   },
//                 ),
//                 SizedBox(width: 10), // AppSize.s10 or a constant value
//                 _isFetchingIp
//                     ? Text(
//                   'Loading IP...',
//                   style: GoogleFonts.firaSans(
//                     fontSize: 12,
//                     fontWeight: FontWeight.normal,
//                     color: Colors.grey,
//                     decoration: TextDecoration.none,
//                   ),
//                 )
//                     : Text(
//                   _ipAddress ?? 'No IP',
//                   style: GoogleFonts.firaSans(
//                     fontSize: 12,
//                     fontWeight: FontWeight.normal,
//                     color: Colors.grey,
//                     decoration: TextDecoration.none,
//                   ),
//                 ),
//               ],
//             ),
//
//             /// Logo
//             Padding(
//               padding: const EdgeInsets.only(bottom: 7),
//               child: Column(
//                 children: [
//                   Image.asset(
//                     'images/powered_logo.png',
//                     width: MediaQuery.of(context).size.width / 50,
//                   ),
//                   Text(
//                     'Powered by',
//                     style: GoogleFonts.firaSans(
//                       fontSize: 12,
//                       fontWeight: FontWeight.normal,
//                       color: Colors.grey,
//                       decoration: TextDecoration.none,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//

//
// class BottomBarRow extends StatelessWidget {
//   const BottomBarRow({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: AppSize.s56,
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//             horizontal: MediaQuery.of(context).size.width / 120),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             ///text
//             Text('#2031ABC01BA',
//                 style: GoogleFonts.firaSans(
//                   fontSize: FontSize.s12,
//                   fontWeight: FontWeightManager.regular,
//                   color: ColorManager.grey,
//                   decoration: TextDecoration.none,
//                 )),
//
//             ///text + address
//             Row(
//               children: [
//                 Text(
//                   'Washington DC',
//                   style: GoogleFonts.firaSans(
//                     fontSize: FontSize.s12,
//                     fontWeight: FontWeightManager.bold,
//                     color: ColorManager.darkgrey,
//                     decoration: TextDecoration.none,
//                   ),
//                 ),
//                 SizedBox(
//                   width: AppSize.s10,
//                 ),
//                 Text(
//                   '198.168.1.231',
//                   style: GoogleFonts.firaSans(
//                     fontSize: FontSize.s12,
//                     fontWeight: FontWeightManager.regular,
//                     color: ColorManager.grey,
//                     decoration: TextDecoration.none,
//                   ),
//                 ),
//               ],
//             ),
//
//             ///logo
//             Padding(
//               padding: const EdgeInsets.only(bottom: 7),
//               child: Column(
//                 //mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     'images/powered_logo.png',
//                     //  height: 27,
//                     width: MediaQuery.of(context).size.width / 50,
//                   ),
//                   Text(
//                     'Powered by',
//                     style: GoogleFonts.firaSans(
//                       fontSize: FontSize.s12,
//                       fontWeight: FontWeightManager.regular,
//                       color: ColorManager.grey,
//                       decoration: TextDecoration.none,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
