import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'dart:convert';
import 'dart:html' as html;

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

  @override
  void initState() {
    super.initState();
    _fetchIPAddress();
   //getLocation();
   // _geolocationFuture = _getGeolocation(); // Initialize geolocation fetching
  }

  Future<void> _fetchIPAddress() async {
    try {
      final response =
          await http.get(Uri.parse('https://api.ipify.org?format=json'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _ipAddress = data['ip'];
          _isFetchingIp = false;
        });
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
    ip =_ipAddress;
  }



  // Future getLocation() async {
  //   var response = await http.get(Uri.parse("http://ip-api.com/json/${ip}"));
  //   var jsonpares = json.decode(response.body);
  //   localresponse=jsonpares;
  //   print(jsonpares);
  // }
  //
  // getDirectLocation() async{
  //   await _fetchIPAddress();getLocation();
  // }
  //
  // Future<Map<String, double>?> _getGeolocation() async {
  //   final completer = Completer<Map<String, double>>();
  //
  //   void successCallback(html.Geoposition position) {
  //     final coords = position.coords!;
  //     completer.complete({
  //       'latitude': coords.latitude?.toDouble() ?? 00,
  //       'longitude': coords.longitude?.toDouble() ?? 00,
  //     });
  //
  //
  //
  //   }
  //
  //
  //   void errorCallback(html.PositionError error) {
  //     completer.completeError('Failed to get location');
  //
  //   }
  //
  //   if (html.window.navigator.geolocation != null) {
  //     html.window.navigator.geolocation
  //         .getCurrentPosition(successCallback, errorCallback);
  //
  //   } else {
  //     completer.completeError('Geolocation is not supported');
  //   }
  //
  //   return completer.future;
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56, // AppSize.s56 or a constant value
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 120),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Text
            Text(
              '#2031ABC01BA',
              style: GoogleFonts.firaSans(
                fontSize: 12, // FontSize.s12 or a constant value
                fontWeight: FontWeight.normal,
                color: Colors.grey, // ColorManager.grey or a color constant
                decoration: TextDecoration.none,
              ),
            ),

            /// IP + Geolocation
            Row(
              children: [
                Text(
                  'Washington DC',
                  style: GoogleFonts.firaSans(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManager.darkgrey,
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(
                  width: AppSize.s10,
                ),
               // // Text("${localresponse["country"]}"),
               //  FutureBuilder<Map<String, double>?>(
               //    future: _geolocationFuture,
               //    builder: (context, geoSnapshot) {
               //      if (geoSnapshot.connectionState ==
               //          ConnectionState.waiting) {
               //        return Text(
               //          'Loading location...',
               //          style: GoogleFonts.firaSans(
               //            fontSize: 12,
               //            fontWeight: FontWeight.bold,
               //            color: Colors.grey[800],
               //            decoration: TextDecoration.none,
               //          ),
               //        );
               //      } else if (geoSnapshot.hasError) {
               //        return Text(
               //          'Error fetching location',
               //          style: GoogleFonts.firaSans(
               //            fontSize: 12,
               //            fontWeight: FontWeight.bold,
               //            color: Colors.grey[800],
               //            decoration: TextDecoration.none,
               //          ),
               //        );
               //      } else if (geoSnapshot.hasData) {
               //        final location = geoSnapshot.data!;
               //        return Text(
               //          //_location ?? 'no location',
               //        'Lat: ${location['latitude']?.toStringAsFixed(2)}, Lon: ${location['longitude']?.toStringAsFixed(2)}',
               //          style: GoogleFonts.firaSans(
               //            fontSize: 12,
               //            fontWeight: FontWeight.bold,
               //            color: Colors.grey[800],
               //            decoration: TextDecoration.none,
               //          ),
               //        );
               //      } else {
               //        return Text(
               //          'No location data',
               //          style: GoogleFonts.firaSans(
               //            fontSize: 12,
               //            fontWeight: FontWeight.bold,
               //            color: Colors.grey[800],
               //            decoration: TextDecoration.none,
               //          ),
               //        );
               //      }
               //    },
               //  ),
               //  SizedBox(width: 10), // AppSize.s10 or a constant value
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
                    width: MediaQuery.of(context).size.width / 50,
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
