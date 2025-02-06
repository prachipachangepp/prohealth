import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/provider/navigation_provider.dart';
import 'package:prohealth/presentation/screens/scheduler_model/widgets/constant_widgets/search_address_field.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../em_module/company_identity/widgets/ci_tab_widget/widget/add_office_submit_button.dart';

class SmLiveViewMapScreen extends StatefulWidget {
  const SmLiveViewMapScreen({super.key});

  @override
  State<SmLiveViewMapScreen> createState() => _SmLiveViewMapScreenState();
}

class _SmLiveViewMapScreenState extends State<SmLiveViewMapScreen> {
  late GoogleMapController mapController;
  BitmapDescriptor? customIcon;
   LatLng _initialPosition =  LatLng(37.7749, -122.4194); // San Francisco coordinates
  TextEditingController _searchController = TextEditingController();
  final List<double> _intensities = [0.1, 0.3, 0.6, 0.8, 1.0];
  // Set to hold the current circles
  Set<Polygon> _heatMapCircles = {};
  // Set to hold the current markers
  Set<Marker> _markers = {};
  // Add the searched marker (nullable)
  Marker? _searchedMarker;
  String _selectedView = "";

  /// Dummy Data
  // Dummy data for heatmap points with intensity
   List<LatLng> _heatMapData = [
    LatLng(37.7749, -122.4194), // Point 1
    LatLng(37.7849, -122.4294), // Point 2
    LatLng(37.7949, -122.4394), // Point 3
    LatLng(37.7649, -122.4494), // Point 4
    LatLng(37.7549, -122.4594), // Point 5
  ];
// Dummy data for zones, counties, and zip codes
  final List<LatLng> _zoneData = [
    LatLng(37.7749, -122.4194), // Example Zone 1 (San Francisco)
    LatLng(37.7849, -122.4294), // Example Zone 2
    LatLng(37.7949, -122.4394), // Example Zone 3
  ];


  final List<LatLng> _zoneDataSquare = [
    LatLng(37.7822, -122.4664), // Example Zone 1 (San Francisco)
    LatLng(37.7839, -122.4215), // Example Zone 2
    LatLng(37.7637, -122.4176), // Example Zone 3
    LatLng(37.7627, -122.4644), // Example Zone 3
  ];

  final List<LatLng> _countyData = [
    LatLng(37.7849, -122.4194), // Example County 1
    LatLng(37.7949, -122.4094), // Example County 2
  ];

  final List<LatLng> _zipCodeData = [
    LatLng(37.7749, -122.4294), // Example Zip Code 1
    LatLng(37.7649, -122.4194), // Example Zip Code 2
  ];
  final List<LatLng> _officeData = [
    LatLng(37.7749, -122.4298), // Example Zip Code 1
    LatLng(37.7649, -122.4194),
    LatLng(37.7949, -122.4094), // Example Zip Code 1
    LatLng(37.7649, -177.4194),
    LatLng(37.7949, -122.4394),
    LatLng(38.7749, -122.4245), // Example Zip Code 1
    LatLng(37.7649, -189.4184),// Example Zip Code 2
  ];
  final List<LatLng> _patientData = [
    LatLng(37.7849, -122.4194), // Example Zip Code 1
    LatLng(39.7649, -122.4193),
    LatLng(37.7949, -122.4094), // Example Zip Code 1
    LatLng(37.7649, -177.4194),
    LatLng(33.7649, -142.4198),
    LatLng(37.7949, -122.4394), // Example Zip Code 1
    LatLng(31.7649, -189.4184),// Example Zip Code 2
  ];



  // Set<Polygon> _polygons = {}; // Store polygons (squares)
  //
  // // Function to calculate the corners of a square around a point
  // List<LatLng> _calculateSquare(LatLng center, double sideLength) {
  //   double latOffset = sideLength / 2 / 111.32; // Approximate conversion to degrees
  //   double lngOffset = sideLength / 2 / (111.32 * cos(center.latitude * pi / 180));
  //
  //   return [
  //     LatLng(center.latitude + latOffset, center.longitude - lngOffset),
  //     LatLng(center.latitude + latOffset, center.longitude + lngOffset),
  //     LatLng(center.latitude - latOffset, center.longitude + lngOffset),
  //     LatLng(center.latitude - latOffset, center.longitude - lngOffset),
  //   ];
  // }


  // Function to handle tapping on the map
  // void _onTapZone(LatLng position) {
  //   setState(() {
  //     // Define square side length (e.g., 0.01 degrees)
  //     double squareSideLength = 0.01;
  //     // Calculate the square's corners
  //     List<LatLng> square = _calculateSquare(position, squareSideLength);
  //     // Add the square as a polygon
  //     _polygons.add(
  //       Polygon(
  //         polygonId: PolygonId('square-${position.latitude}-${position.longitude}'),
  //         points: square,
  //         strokeColor: Colors.blue,
  //         fillColor: Colors.grey.withOpacity(0.3),
  //         strokeWidth: 2,
  //       ),
  //     );
  //   });
  //   // Print the square corners (latitude, longitude)
  //   for (var corner in _calculateSquare(position, squareSideLength)) {
  //     print("Corner: ${corner.latitude}, ${corner.longitude}");
  //   }
  // }

// Function to generate square-shaped zones



  @override
  void initState() {
    // TODO: implement initState
    _loadCustomIcon();
    super.initState();
  }
  void _loadCustomIcon() async {
    // Load the custom icon
    customIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(65, 30)), // Adjust size as needed
      'images/logo.png', // Path to your image
    );
    setState(() {});
  }





  void _generateSquareZones() {
    Set<Polygon> squareZones = {};
    Set<Marker> markers = {}; // Set to store markers

    // For each zone, define a square shape and place a marker at each center point.
    for (int i = 0; i < _zoneDataSquare.length; i++) {
      LatLng center = _zoneDataSquare[i];

      // Add a marker at the center of each square zone (highlight the point)
      markers.add(
        Marker(
          markerId: MarkerId('highlighted-zone-$i'),
          position: center,
          infoWindow: InfoWindow(title: 'Zone ${i + 1}', snippet: 'Latitude: ${center.latitude}, Longitude: ${center.longitude}'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),  // Use red to highlight the points
        ),
      );

      // Define square around the point and add the polygon
      double delta = 0.01;  // Adjust this to control the size of the square
      List<LatLng> squareCoords = [
        LatLng(center.latitude + delta, center.longitude - delta), // top-left
        LatLng(center.latitude + delta, center.longitude + delta), // top-right
        LatLng(center.latitude - delta, center.longitude + delta), // bottom-right
        LatLng(center.latitude - delta, center.longitude - delta), // bottom-left
      ];

      // Add the square polygon
      squareZones.add(
        Polygon(
          polygonId: PolygonId('zone-square-$i'),
          points: squareCoords,
          strokeColor: Colors.blue,  // Blue border for square
          fillColor: Colors.blue.withOpacity(0.2),  // Light blue fill for the square
          strokeWidth: 2,
        ),
      );
    }

    setState(() {
      _heatMapCircles = squareZones;  // Set the square polygons as heatmap zones
      _markers = markers;  // Set the highlighted markers (points)
    });
  }

// List of zone data (LatLng points) to highlight and draw squares around
//   final List<LatLng> _zoneDataSquare = [
//     LatLng(37.7822, -122.4664), // Example Zone 1 (San Francisco)
//     LatLng(37.7839, -122.4215), // Example Zone 2
//     LatLng(37.7637, -122.4176), // Example Zone 3
//     LatLng(37.7627, -122.4644), // Example Zone 4
//   ];






  // void _generateSquareZones() {
  //   Set<Polygon> squareZones = {};
  //
  //   // For each zone, define a square shape. Here we're assuming each zone is represented by a LatLng center and a fixed size.
  //   for (int i = 0; i < _zoneDataSquare.length; i++) {
  //    // LatLng center = _zoneDataSquare[i];
  //     // Add the polygon to the set
  //     squareZones.add(
  //       Polygon(
  //         polygonId: PolygonId('zone-square-$i'),
  //         points: _zoneDataSquare,
  //         strokeColor: Colors.blue,  // Blue border
  //         fillColor: Colors.blue.withOpacity(0.2),  // Light blue fill
  //         strokeWidth: 2,
  //       ),
  //     );
  //   }
  //
  //   setState(() {
  //     _heatMapCircles = squareZones;  // Set the squares as heatmap polygons
  //   });
  // }








  // Function to generate heatmap circles
  void _generateHeatMap() {
    Set<Polygon> circles = {};

    for (int i = 0; i < _heatMapData.length; i++) {
      circles.add(
        Polygon(
          points: _heatMapData,
          polygonId: PolygonId('heatmap-point-$i'),
          strokeColor: Colors.transparent,
          fillColor:Colors.grey.withOpacity(0.2),)
       //  Circle(
       //    circleId:,
       //    center: _heatMapData[i],
       //    radius: _intensities[i] * 700, // Adjust radius based on intensity
       //    fillColor: Colors.red.withOpacity(_intensities[i]), // Adjust opacity based on intensity
       //    strokeColor: Colors.transparent,
       //  ),
      );
    }

    setState(() {
      _heatMapCircles = circles;
    });
  }


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // Function to update markers based on selected view
  void _updateMarkers() {
    Set<Marker> markers = {};
    switch(_selectedView){
      case 'Zones':for (var zone in _zoneDataSquare) {
        markers.add(Marker(
          markerId: MarkerId('zone-${zone.latitude}-${zone.longitude}'),
          position: zone,
          infoWindow: InfoWindow(title: 'Zone'),
        ));
      }
      break;
      case 'Counties':for (var county in _countyData) {
        markers.add(Marker(
          markerId: MarkerId('county-${county.latitude}-${county.longitude}'),
          position: county,
          infoWindow: InfoWindow(title: 'County'),
        ));
      }
      break;
      case 'Zip Codes':for (var zip in _zipCodeData) {
        markers.add(Marker(
          markerId: MarkerId('zip-${zip.latitude}-${zip.longitude}'),
          position: zip,
          infoWindow: InfoWindow(title: 'Zip Code'),
        ));
      }
      break;
      case 'Offices':
        for (var office in _officeData) {
          markers.add(Marker(
            markerId: MarkerId('Offices-${office.latitude}-${office.longitude}'),
            position: office,
            infoWindow: InfoWindow(title: 'v'),
            icon:customIcon!,
          ));
        }
        break;
      case 'Patients':
        for (var patients in _patientData) {
          markers.add(Marker(
            markerId: MarkerId('patients-${patients.latitude}-${patients.longitude}'),
            position: patients,
            infoWindow: InfoWindow(title: 'patients'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          ));
        }
    }


    setState(() {
      _markers = markers;
    });
  }
  double? latitudeL;
  double? longitudeL;
  List<LatLng> _polygonCoordinates = [];
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
          final viewport = data['results'][0]['geometry']['viewport'];
          latitudeL = location['lat'];
          longitudeL = location['lng'];
          setState(() {
            _initialPosition = LatLng(latitudeL!, longitudeL!);
            _polygonCoordinates = [
              LatLng(viewport['northeast']['lat'], viewport['northeast']['lng']),
              LatLng(viewport['northeast']['lat'], viewport['southwest']['lng']),
              LatLng(viewport['southwest']['lat'], viewport['southwest']['lng']),
              LatLng(viewport['southwest']['lat'], viewport['northeast']['lng']),
            ];
          });

          // setState(() {
          //  _initialPosition = LatLng(latitudeL!, longitudeL!);
          // });
          mapController.animateCamera(
            CameraUpdate.newLatLngZoom(_initialPosition, 14),
          );
          // Notify parent widget with the latitude and longitude
          // if (onLatLngFetched != null) {
          //   onLatLngFetched!(latitudeL!, longitudeL!);
          // }

          print("Latitude: $latitudeL, Longitude: $longitudeL");
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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddressProvider(
          controller: TextEditingController(text:""), onChange: (String ) {  }),
      child: Consumer<AddressProvider>(
        builder: (context, provider, _) {

          return Stack(
            children: [
              SizedBox.expand(
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 12.0,
                  ),
                  markers: _selectedView == ''? {if (latitudeL != null && longitudeL != null)
                    Marker(
                      markerId: MarkerId(
                          'Search-${latitudeL}-${longitudeL}'),
                      position: LatLng(latitudeL!, longitudeL!),
                      infoWindow: InfoWindow(title: 'Location'),
                    ),}:_markers,

                  polygons: _selectedView == 'Heat Map'
                      ? _heatMapCircles  // Use heatmap squares
                      : _selectedView == 'Zones'
                      ? _heatMapCircles  // Add zone squares
                      : {
                    if (_polygonCoordinates.isNotEmpty)
                      Polygon(
                        polygonId: PolygonId('highlightedArea'),
                        points: _polygonCoordinates,
                        fillColor: Colors.red.withOpacity(0.3),
                        strokeColor: Colors.red,
                        strokeWidth: 2,
                      ),
                  },
                  // polygons: _selectedView == 'Heat Map' ? _heatMapCircles : {if (_polygonCoordinates.isNotEmpty)
                  //   Polygon(
                  //     polygonId: PolygonId('highlightedArea'),
                  //     points: _polygonCoordinates,
                  //     fillColor: Colors.red.withOpacity(0.3),
                  //     strokeColor: Colors.red,
                  //     strokeWidth: 2,
                  //   ),},// Use the markers set here
                ),
              ),
              Positioned(
                top: 30.0,
                left: 20.0,
                child: Row(
                  children: [
                    SearchAddressMap(
                      controller: _searchController,
                      onSubmit:(val){
                        setState(() {
                          getLatLngFromAddress(val);
                        });
                        },
                      onSuggestionSelected: (selected) {
                        print('Selected Address: $selected');
                      },
                      onChanged: (value) {
                        provider.showOverlay(context);
                        print('Address Changed: $value');
                       // Triggered on every text change
                      },),

                    SizedBox(width: 50),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            //setState(() {
                            setState(() => _selectedView = 'Zones'); // Switch view to 'Zones'
                            _generateSquareZones();  // Call function to generate square zones
                           // });
                            // setState(() => _selectedView = 'Zones');
                            // _updateMarkers(); // Update map with zone markers
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                            backgroundColor: _selectedView == 'Zones' ? Colors.blue : Colors.white,
                            foregroundColor: _selectedView == 'Zones' ? Colors.white : ColorManager.blueprime,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          child: Text('Zones'),
                        ),
                        SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            setState(() => _selectedView = 'Counties');
                            _updateMarkers(); // Update map with county markers
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                            backgroundColor: _selectedView == 'Counties' ? Colors.blue : Colors.white,
                            foregroundColor: _selectedView == 'Counties' ? Colors.white : ColorManager.blueprime,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          child: Text('Counties'),
                        ),
                        SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            setState(() => _selectedView = 'Zip Codes');
                            _updateMarkers(); // Update map with zip code markers
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                            backgroundColor: _selectedView == 'Zip Codes' ? Colors.blue : Colors.white,
                            foregroundColor: _selectedView == 'Zip Codes' ? Colors.white : ColorManager.blueprime,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          child: Text('Zip Codes'),
                        ),
                        SizedBox(width: 20,),
                        ElevatedButton(
                          onPressed: () {
                            setState(() => _selectedView = 'Offices');
                            _updateMarkers();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(6)),
                            backgroundColor: _selectedView == 'Offices' ? ColorManager.blueprime : ColorManager.white,
                            foregroundColor: _selectedView == 'Offices' ? ColorManager.white : ColorManager.mediumgrey,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.food_bank_outlined,
                                  size:17,
                                  color: _selectedView == 'Offices' ? ColorManager.white : ColorManager.mediumgrey,),
                                Text('Offices',style:TextStyle(
                                    fontSize: 14,
                                    color: _selectedView == 'Offices' ?ColorManager.white: ColorManager.tangerine,
                                    fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                        ElevatedButton(
                          onPressed: () => setState(() => _selectedView = 'Clinicians'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(6)),
                            backgroundColor: _selectedView == 'Clinicians' ? ColorManager.blueprime : ColorManager.white,
                            foregroundColor: _selectedView == 'Clinicians' ? ColorManager.white : ColorManager.mediumgrey,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          child: Text('Clinicians',style:TextStyle(
                              fontSize: 14,
                              color: _selectedView == 'Clinicians' ?ColorManager.white:ColorManager.blueKeyGraph,
                              fontWeight: FontWeight.w500)),
                        ),
                        SizedBox(width: 20,),
                        ElevatedButton(
                          onPressed: () {
                            setState(() => _selectedView = 'Patients');
                            _updateMarkers();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(6)),
                            backgroundColor: _selectedView == 'Patients' ? ColorManager.blueprime : ColorManager.white,
                            foregroundColor: _selectedView == 'Patients' ? ColorManager.white : ColorManager.mediumgrey,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.add,
                                  size:17,
                                  color: _selectedView == 'Patients' ?ColorManager.white:ColorManager.mediumgrey,),
                                Text('Patients',style:TextStyle(
                                    fontSize: 14,
                                    color: _selectedView == 'Patients' ?ColorManager.white:ColorManager.green,
                                    fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                        ElevatedButton(
                          onPressed: () {
                            setState(() => _selectedView = 'Heat Map');
                            _generateHeatMap();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(6)),
                            backgroundColor: _selectedView == 'Heat Map' ? ColorManager.blueprime : ColorManager.white,
                            foregroundColor: _selectedView == 'Heat Map' ? ColorManager.white : ColorManager.mediumgrey,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.filter_b_and_w_outlined,
                                  size:17,
                                  color:_selectedView == 'Heat Map' ? ColorManager.white:ColorManager.blueBorderText,),
                                Text('Heat Map',style:TextStyle(
                                    fontSize: 14,
                                    color: _selectedView == 'Heat Map' ? ColorManager.white:ColorManager.blueBorderText,
                                    fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        }
      ),
    );
  }
//
  Future<void> _performSearch() async {
    final query = _searchController.text.trim(); // Trim extra spaces
    if (query.isNotEmpty) {
      try {
        // Get the list of locations matching the query
        List<Location> locations = await locationFromAddress(query);

        if (locations.isNotEmpty) {
          final location = locations.first;

          // Animate the map to the searched location
          mapController?.animateCamera(
            CameraUpdate.newLatLngZoom(
              LatLng(location.latitude, location.longitude),
              15.0,
            ),
          );

          // Add the marker to the map
          setState(() {
            _searchedMarker = Marker(
              markerId: MarkerId('searched-location'),
              position: LatLng(location.latitude, location.longitude),
              infoWindow: InfoWindow(title: query),
            );
            _markers.add(_searchedMarker!);
          });
        }
      } catch (e) {
        // Show an error message if something goes wrong
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Location not found! Please try again.")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a location to search.")),
      );
    }
  }
}
