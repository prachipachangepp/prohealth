import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_geocoding_api/google_geocoding_api.dart';
import 'package:http/http.dart' as http;
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/screen_route_name.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/ci_org_doc_manager.dart';
import 'package:prohealth/app/services/token/token_manager.dart';
import 'package:prohealth/presentation/screens/login_module/login/login_screen.dart';
import 'package:provider/provider.dart';

import '../../../../app/resources/color.dart';
import '../../../../app/resources/font_manager.dart';
import '../../../../app/resources/provider/navigation_provider.dart';
import '../../../../app/resources/theme_manager.dart';
import '../../../../app/resources/value_manager.dart';
import '../../../widgets/widgets/login_screen/widgets/child_container_constant_login.dart';
import '../../scheduler_model/widgets/responsive_screen_sm.dart';

class HomeScreenWeb extends StatefulWidget {
  const HomeScreenWeb({super.key});

  @override
  State<HomeScreenWeb> createState() => _HomeScreenWebState();
}

class _HomeScreenWebState extends State<HomeScreenWeb> {
  late Future<String> _stateFuture;
  @override
  void initState() {
    super.initState();
    _fetchIPAddress();
    _stateFuture = getCurrentLocation();
    //getLocation();
    // _geolocationFuture = _getGeolocation(); // Initialize geolocation fetching
  }

  String? _ipAddress;
  String? _location;

  bool _isFetchingIp = true;
  String? _city;
  String? _country;
  Future<void> _fetchIPAddress() async {
    try {
      // Fetch the IP address first
      final ipResponse =
          await http.get(Uri.parse('https://api.ipify.org?format=json'));
      if (ipResponse.statusCode == 200) {
        final ipData = jsonDecode(ipResponse.body);
        _ipAddress = ipData['ip'];

        // Use the IP address to fetch city and country information
        final locationResponse =
            await http.get(Uri.parse('http://ip-api.com/json/$_ipAddress'));
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
        desiredAccuracy: LocationAccuracy.high);

    print('Current location: ${position.latitude}, ${position.longitude}');

    // Get the address from the current position
    print('Position : ${position}');
    return await getStateFromLatLng(position.latitude, position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ///bg image
          Container(
              width: double.maxFinite,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: SvgPicture.asset(
                          'images/menu_vector.svg',
                          height: MediaQuery.of(context).size.height / 1.28,
                          // width: MediaQuery.of(context).size.width / 1,
                        ),
                      ),
                    ],
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: SvgPicture.asset('images/vector1.svg',
                              height: MediaQuery.of(context).size.height / 1.5,
                              width: MediaQuery.of(context).size.width),
                        ),
                      ]),
                ],
              )),
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 9, sigmaY: 5),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff000000).withOpacity(0.045),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(1, 4),
                        ),
                      ],
                      color: ColorManager.white.withOpacity(0.35),
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    child: ScrollConfiguration(
                      behavior:
                          const ScrollBehavior().copyWith(overscroll: false),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppPadding.p20),
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Select a Module',
                                      textAlign: TextAlign.center,
                                      style: CustomTextStylesCommon.commonStyle(
                                        fontSize: FontSize.s14,
                                        fontWeight: FontWeight.w600,
                                        color: ColorManager.darkgrey,
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          TokenManager.removeAccessToken();
                                          Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              LoginScreen.routeName,
                                              (route) => false);
                                          // Navigator.pushNamedAndRemoveUntil(
                                          //     context, '/', (route) => false);
                                        },
                                        icon: const Icon(Icons.logout),
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      visualDensity: VisualDensity.compact,
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Administration',
                                        textAlign: TextAlign.center,
                                        style: MenuScreenHeadStyle.menuHead(context),
                                      ),
                                      // SizedBox(
                                      //   height: 10,
                                      // ),
                                      Row(
                                        children: [
                                          const ResponsiveContainer(
                                            'Referral Resource Manager',
                                            AssetImage("images/r_r_m.png"),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                25,
                                          ),
                                          InkWell(
                                              onTap: () {
                                                documentTypeGet(context);
                                                Provider.of<RouteProvider>(
                                                        context,
                                                        listen: false)
                                                    .setRoute(
                                                        RouteStrings.emDesktop);
                                                // Navigate to the detail page
                                                Navigator.pushNamed(context,
                                                    RouteStrings.emDesktop);
                                              },
                                              child: const ResponsiveContainer(
                                                'Establishment Manager',
                                                AssetImage("images/e_m.png"),
                                              )),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                25,
                                          ),
                                          InkWell(
                                              onTap: () {
                                                Provider.of<RouteProvider>(
                                                        context,
                                                        listen: false)
                                                    .setRoute(
                                                        RouteStrings.hrDesktop);

                                                // Navigate to the detail page
                                                Navigator.pushNamed(context,
                                                    RouteStrings.hrDesktop);
                                              },
                                              child: const ResponsiveContainer(
                                                'Human Resource Manager',
                                                AssetImage("images/h_r_m.png"),
                                              )),
                                        ],
                                      ),
                                    ],
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Business',
                                        textAlign: TextAlign.center,
                                        style: MenuScreenHeadStyle.menuHead(
                                            context),
                                      ),
                                      Row(
                                        children: [
                                          const ResponsiveContainer(
                                            'Business Intelligence & Reports',
                                            AssetImage("images/b_i_r.png"),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                25,
                                          ),
                                          const ResponsiveContainer(
                                            'Finance',
                                            AssetImage("images/finance.png"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Patient Related',
                                        textAlign: TextAlign.center,
                                        style: MenuScreenHeadStyle.menuHead(
                                            context),
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                documentTypeGet(context);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ResponsiveScreenSM()));
                                              },
                                              child: const ResponsiveContainer(
                                                'Intake & Scheduler',
                                                AssetImage("images/i_s.png"),
                                              )),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                25,
                                          ),
                                          const ResponsiveContainer(
                                            'Rehab',
                                            AssetImage("images/rehab.png"),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                25,
                                          ),
                                          const ResponsiveContainer(
                                            'Home Care',
                                            AssetImage("images/h_c.png"),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                25,
                                          ),
                                          const ResponsiveContainer(
                                            'Home Health EMR',
                                            AssetImage("images/h_h_emr.png"),
                                          ),
                                        ],
                                      ),
                                      const ResponsiveContainer(
                                        'Hospice EMR',
                                        AssetImage("images/h_emr.png"),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                    )),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: AppSize.s15, right: AppSize.s15, bottom: AppSize.s15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '--',
                    style:TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Row(
                    children: [
                      _city != null
                          ? Text(
                              '${_country} (${_city})',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[800],
                                decoration: TextDecoration.none,
                              ),
                            )
                          : Text(
                              '--',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[800],
                                decoration: TextDecoration.none,
                              ),
                            ),
                      SizedBox(
                        width: 50,
                      ),

                      _isFetchingIp
                          ? Text(
                              'Loading IP...',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                                decoration: TextDecoration.none,
                              ),
                            )
                          : Text(
                              _ipAddress ?? '--',
                              style:TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                                decoration: TextDecoration.none,
                              ),
                            ),

                      // Text(
                      //   '198.168.1.231',
                      //   style: GoogleFonts.firaSans(
                      //     fontSize: 12,
                      //     fontWeight: FontWeight.w400,
                      //     color: Colors.black,
                      //     decoration: TextDecoration.none,
                      //   ),
                      // ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset('images/powered_logo.png',
                          width: AppSize.s20, height: AppSize.s20),
                      Text(
                        'Powered by',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 90,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
