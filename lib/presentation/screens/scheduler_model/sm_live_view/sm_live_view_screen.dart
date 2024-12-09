import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
// import 'page.dart';

class SmLiveViewMapScreen extends StatefulWidget {
  const SmLiveViewMapScreen({super.key});

  @override
  State<SmLiveViewMapScreen> createState() => _SmLiveViewMapScreenState();
}

class _SmLiveViewMapScreenState extends State<SmLiveViewMapScreen> {
  late GoogleMapController mapController;

  final LatLng _initialPosition = const LatLng(37.7749, -122.4194); // San Francisco coordinates
  TextEditingController _searchController = TextEditingController();
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  // void _performSearch() {
  //   // Example: Perform search logic here
  //   final query = _searchController.text;
  //   if (query.isNotEmpty) {
  //     // Use Geocoding API to convert the search term into a location (not shown here)
  //     print("Searching for: $query");
  //   }
  // }
  Marker? _searchedMarker;
  Future<void> _performSearch() async {
    final query = _searchController.text;

    if (query.isNotEmpty) {
      try {
        // Convert address to coordinates using geocoding
        List<Location> locations = await locationFromAddress(query);

        if (locations.isNotEmpty) {
          final location = locations.first;

          // Move the map to the searched location
          mapController.animateCamera(
            CameraUpdate.newLatLngZoom(
              LatLng(location.latitude, location.longitude),
              15.0,
            ),
          );

          // Add a marker at the searched location
          setState(() {
            _searchedMarker = Marker(
              markerId: MarkerId('searched-location'),
              position: LatLng(location.latitude, location.longitude),
              infoWindow: InfoWindow(title: query),
            );
          });
        }
      } catch (e) {
        // Show error if the location is not found
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Location not found! Please try again.")),
        );
      }
    }
  }
  String _selectedView ="";
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
            markers: _searchedMarker != null ? {_searchedMarker!} : {},
          ),
        ),
        Positioned(
          top: 30.0,
          left: 20.0,
          child: Row(
            children: [
              Container(
                width:320,
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
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 15.0,vertical:7),
                  ),
                ),
              ),
              SizedBox(width: 50,),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => setState(() => _selectedView = 'Zones'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(6)),
                      backgroundColor: _selectedView == 'Zones' ? ColorManager.blueprime : ColorManager.white,
                      foregroundColor: _selectedView == 'Zones' ? ColorManager.white : ColorManager.mediumgrey,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    child: Text('Zones'),
                  ),
                  SizedBox(width: 20,),
                  ElevatedButton(
                    onPressed: () => setState(() => _selectedView = 'Counties'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(6)),
                      backgroundColor: _selectedView == 'Counties' ? ColorManager.blueprime : ColorManager.white,
                      foregroundColor: _selectedView == 'Counties' ? ColorManager.white : ColorManager.mediumgrey,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    child: Text('Counties'),
                  ),
                  SizedBox(width: 20,),
                  ElevatedButton(
                    onPressed: () => setState(() => _selectedView = 'Zip Codes'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(6)),
                      backgroundColor: _selectedView == 'Zip Codes' ? ColorManager.blueprime : ColorManager.white,
                      foregroundColor: _selectedView == 'Zip Codes' ? ColorManager.white : ColorManager.mediumgrey,
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
                    child: Text('Offices'),
                  ),
                ],
              )

            ],
          ),
        ),
      ],
    );
  }
}
