import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:prohealth/app/resources/color.dart';

class SmLiveViewMapScreen extends StatefulWidget {
  const SmLiveViewMapScreen({super.key});

  @override
  State<SmLiveViewMapScreen> createState() => _SmLiveViewMapScreenState();
}

class _SmLiveViewMapScreenState extends State<SmLiveViewMapScreen> {
  late GoogleMapController mapController;

  final LatLng _initialPosition = const LatLng(37.7749, -122.4194); // San Francisco coordinates
  TextEditingController _searchController = TextEditingController();

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

  // Set to hold the current markers
  Set<Marker> _markers = {};

  // Add the searched marker (nullable)
  Marker? _searchedMarker;

  String _selectedView = "";

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // Function to update markers based on selected view
  void _updateMarkers() {
    Set<Marker> markers = {};

    if (_selectedView == 'Zones') {
      // Add Zone markers
      for (var zone in _zoneData) {
        markers.add(Marker(
          markerId: MarkerId('zone-${zone.latitude}-${zone.longitude}'),
          position: zone,
          infoWindow: InfoWindow(title: 'Zone'),
        ));
      }
    } else if (_selectedView == 'Counties') {
      // Add County markers
      for (var county in _countyData) {
        markers.add(Marker(
          markerId: MarkerId('county-${county.latitude}-${county.longitude}'),
          position: county,
          infoWindow: InfoWindow(title: 'County'),
        ));
      }
    } else if (_selectedView == 'Zip Codes') {
      // Add Zip Code markers
      for (var zip in _zipCodeData) {
        markers.add(Marker(
          markerId: MarkerId('zip-${zip.latitude}-${zip.longitude}'),
          position: zip,
          infoWindow: InfoWindow(title: 'Zip Code'),
        ));
      }
    }

    // Update the markers on the map
    setState(() {
      _markers = markers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 12.0,
            ),
            markers: _markers, // Use the markers set here
          ),
        ),
        Positioned(
          top: 30.0,
          left: 20.0,
          child: Row(
            children: [
              Container(
                width: 320,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) => _performSearch(),
                  decoration: InputDecoration(
                    hintText: "Search location",
                    suffixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 7),
                  ),
                ),
              ),
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
                    onPressed: () => setState(() => _selectedView = 'Offices'),
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
                    onPressed: () => setState(() => _selectedView = 'Patients'),
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
                    onPressed: () => setState(() => _selectedView = 'Heat Map'),
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

  Future<void> _performSearch() async {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      try {
        List<Location> locations = await locationFromAddress(query);
        if (locations.isNotEmpty) {
          final location = locations.first;
          mapController.animateCamera(
            CameraUpdate.newLatLngZoom(
              LatLng(location.latitude, location.longitude),
              15.0,
            ),
          );
          setState(() {
            _searchedMarker = Marker(
              markerId: MarkerId('searched-location'),
              position: LatLng(location.latitude, location.longitude),
              infoWindow: InfoWindow(title: query),
            );
            _markers.add(_searchedMarker!); // Add the searched marker to the map
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Location not found! Please try again.")),
        );
      }
    }
  }
}
