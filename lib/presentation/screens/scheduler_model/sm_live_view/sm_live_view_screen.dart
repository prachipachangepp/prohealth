import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/provider/navigation_provider.dart';
import 'package:prohealth/presentation/screens/scheduler_model/widgets/constant_widgets/search_address_field.dart';
import 'package:provider/provider.dart';

import '../../em_module/company_identity/widgets/ci_tab_widget/widget/add_office_submit_button.dart';

class SmLiveViewMapScreen extends StatefulWidget {
  const SmLiveViewMapScreen({super.key});

  @override
  State<SmLiveViewMapScreen> createState() => _SmLiveViewMapScreenState();
}

class _SmLiveViewMapScreenState extends State<SmLiveViewMapScreen> {
  late GoogleMapController mapController;
  BitmapDescriptor? customIcon;
  final LatLng _initialPosition = const LatLng(37.7749, -122.4194); // San Francisco coordinates
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
      case 'Zones':for (var zone in _zoneData) {
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

    // if (_selectedView == 'Zones') {
    //   // Add Zone markers
    //   for (var zone in _zoneData) {
    //     markers.add(Marker(
    //       markerId: MarkerId('zone-${zone.latitude}-${zone.longitude}'),
    //       position: zone,
    //       infoWindow: InfoWindow(title: 'Zone'),
    //     ));
    //   }
    // } else if (_selectedView == 'Counties') {
    //   // Add County markers
    //   for (var county in _countyData) {
    //     markers.add(Marker(
    //       markerId: MarkerId('county-${county.latitude}-${county.longitude}'),
    //       position: county,
    //       infoWindow: InfoWindow(title: 'County'),
    //     ));
    //   }
    // } else if (_selectedView == 'Zip Codes') {
    //   // Add Zip Code markers
    //   for (var zip in _zipCodeData) {
    //     markers.add(Marker(
    //       markerId: MarkerId('zip-${zip.latitude}-${zip.longitude}'),
    //       position: zip,
    //       infoWindow: InfoWindow(title: 'Zip Code'),
    //     ));
    //   }
    // }

    // Update the markers on the map
    setState(() {
      _markers = markers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddressProvider(controller: TextEditingController(text:""), onChange: (String ) {  }),
      child: Consumer<AddressProvider>(
        builder: (context, provider, _) {
          return Stack(
            children: [
              SizedBox.expand(
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: provider.latitudeL == null ?_initialPosition: LatLng(provider.latitudeL!, provider.latitudeL!),
                    zoom: 12.0,
                  ),
                  markers: _markers,
                  polygons: _selectedView == 'Heat Map' ? _heatMapCircles : {},// Use the markers set here
                ),
              ),
              Positioned(
                top: 30.0,
                left: 20.0,
                child: Row(
                  children: [
                    SearchAddressMap(
                      controller: _searchController,
                      onSubmit:(val)=> provider.getLatLngFromAddress(val),
                      onSuggestionSelected: (selected) {
                        print('Selected Address: $selected');
                      },
                      onChanged: (value) {
                        // provider.showOverlay(context);
                        print('Address Changed: $value');
                       // Triggered on every text change
                      },),
                    // Container(
                    //   width: 320,
                    //   height: 35,
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(8.0),
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.black26,
                    //         blurRadius: 5.0,
                    //       ),
                    //     ],
                    //   ),
                    //   child: TextField(
                    //     controller: _searchController,
                    //     textInputAction: TextInputAction.search,
                    //     onSubmitted: (value) => _performSearch(),
                    //     decoration: InputDecoration(
                    //       hintText: "Search location",
                    //       suffixIcon: Icon(Icons.search,),
                    //       border: InputBorder.none,
                    //       contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical:4),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(width: 50),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() => _selectedView = 'Zones');
                            _updateMarkers(); // Update map with zone markers
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                            backgroundColor: _selectedView == 'Zones' ? Colors.blue : Colors.white,
                            foregroundColor: _selectedView == 'Zones' ? Colors.white : Colors.grey,
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
                            foregroundColor: _selectedView == 'Counties' ? Colors.white : Colors.grey,
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
                            foregroundColor: _selectedView == 'Zip Codes' ? Colors.white : Colors.grey,
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

  // Future<void> _performSearch() async {
  //   final query = _searchController.text;
  //   if (query.isNotEmpty) {
  //     try {
  //       List<Location> locations = await locationFromAddress(query);
  //       if (locations.isNotEmpty) {
  //         final location = locations.first;
  //         mapController.animateCamera(
  //           CameraUpdate.newLatLngZoom(
  //             LatLng(location.latitude, location.longitude),
  //             15.0,
  //           ),
  //         );
  //         setState(() {
  //           _searchedMarker = Marker(
  //             markerId: MarkerId('searched-location'),
  //             position: LatLng(location.latitude, location.longitude),
  //             infoWindow: InfoWindow(title: query),
  //           );
  //           _markers.add(_searchedMarker!); // Add the searched marker to the map
  //         });
  //       }
  //     } catch (e) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Location not found! Please try again.")),
  //       );
  //     }
  //   }
  // }
}
