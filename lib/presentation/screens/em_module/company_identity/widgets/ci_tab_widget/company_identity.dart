import 'dart:async';
// import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/manage_details_manager.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/establishment_data/ci_manage_button/manage_details_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/manage_button_screen.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/add_office_submit_button.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/whitelabelling_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/constant_checkbox/const_checckboxtile.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../../../../app/services/api/managers/establishment_manager/company_identrity_manager.dart';
import '../../../../../../data/api_data/establishment_data/company_identity/company_identity_data_.dart';
import '../../../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';
import '../../../../hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../../widgets/button_constant.dart';
import '../../../widgets/text_form_field_const.dart';
import '../company_identity_zone/widgets/zone_widgets_constants.dart';


class CompanyIdentity extends StatefulWidget {
  const CompanyIdentity({Key? key}) : super(key: key);

  @override
  State<CompanyIdentity> createState() => _CompanyIdentityState();
}

class _CompanyIdentityState extends State<CompanyIdentity> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobNumController = TextEditingController();
  TextEditingController secNumController = TextEditingController();
  TextEditingController OptionalController = TextEditingController();
  TextEditingController stateNameController = TextEditingController();
  TextEditingController countryNameController = TextEditingController();
  late StreamController<List<CompanyIdentityModel>> _companyIdentityController;
  final PageController _pageController = PageController();
  final _formKey = GlobalKey<FormState>();
  bool showStreamBuilder = true;
  bool showManageScreen = false;
  // bool _isSubmitting = false;
  bool showWhitelabellingScreen = false;

  void loadData() {}

  @override
  void initState() {
    super.initState();
    // currentPage = 1;
    // itemsPerPage = 30;
  }

  String selectedOfficeID = '';
  String selectedOfficeName = '';
  String selectedStateName = '';
  String selectedCountryName = '';
  int selectedCompId = 0;
  int selectedCompOfficeId = 0;
  // bool _isSubmitting = false;

  void showManageScreenFunction(
      {required String officeId, officeName, required int compId, required int companyOfficeId,required String stateName, required String countryName}) {
    setState(() {
      selectedStateName = stateName;
      selectedCountryName = countryName;
      selectedOfficeID = officeId;
      selectedOfficeName = officeName;
      selectedCompId = compId;
      selectedCompOfficeId = companyOfficeId;
      showManageScreen = true;
      showStreamBuilder = false;
      showWhitelabellingScreen = false;
    });
  }

  void showWhitelabellingScreenFunction() {
    setState(() {
      showStreamBuilder = false;
      showWhitelabellingScreen = true;
      showManageScreen = false;
    });
  }

  int currentPage = 1;
  int itemsPerPage = 10;
  final int totalPages = 5;
  bool _isHovered = false;

  void onPageNumberPressed(int page) {
    setState(() {
      currentPage = page;
    });
  }
  LatLng _selectedLocation = LatLng(37.7749, -122.4194); // Default location
  String _location = 'Lat/Long not selected'; // Default text
  double? _latitude;
  double? _longitude;
  bool isHeadOffice = false;
  void _pickLocation() async {
    final pickedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (context) => MapScreen(
          initialLocation: _selectedLocation,
          onLocationPicked: (location) {
            // Print debug information to ensure this is being called
            print('Picked location inside MapScreen: $_selectedLocation');
            _location = 'Lat: ${_selectedLocation.latitude}, Long: ${_selectedLocation.longitude}';
            setState(() {
              _latitude = location.latitude;
              _longitude = location.longitude;
              _location = 'Lat: ${_latitude!}, Long: ${_longitude!}';
              //_location = 'Lat: ${_latitude!}, Long: ${_longitude!}';
            });
          },
        ),
      ),
    );

    if (pickedLocation != null) {
      // Print debug information to ensure this is being reached
      print('Picked location from Navigator: $pickedLocation');
      setState(() {
        _selectedLocation = pickedLocation;
        _latitude = pickedLocation.latitude;
        _longitude = pickedLocation.longitude;
        _location = 'Lat: ${_latitude!.toStringAsFixed(4)}, Long: ${_longitude!.toStringAsFixed(4)}';
        //_location = 'Lat: ${_latitude!}, Long: ${_longitude!}';
      });
    } else {
      print('No location was picked.');
    }
  }

  String generateRandomString(int length) {
    const characters = 'abcdefghijklmnopqrstuvwxyz';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => characters.codeUnitAt(random.nextInt(characters.length))));
  }
  String? generatedString;
  List<String> selectedServices = [];
  @override
  Widget build(BuildContext context) {

    _companyIdentityController = StreamController<List<CompanyIdentityModel>>();
    return Column(
      children: [
        /// Render top row with buttons only if both manage and whitelabelling screens are not shown
        if (!showManageScreen && !showWhitelabellingScreen)
          Padding(
            padding: const EdgeInsets.only(right: 50.0,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  paddingVertical: 1,
                  borderRadius: 12,
                  text: 'White Labelling',
                  style: GoogleFonts.firaSans(
                    fontSize: AppSize.s12,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManager.white,
                  ),
                  width: 120,
                  height: 26,
                  onPressed: showWhitelabellingScreenFunction,
                ),
                SizedBox(width: 10,),
                CustomIconButtonConst(
                  width: 140,
                  text: 'Add New Office',
                  onPressed: () {
                    // setState((){
                    //   String generated = generateRandomString(1);
                    //   generatedString = "Office ${generated}";
                    // });
                    // print("Generated String ${generatedString}");
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                            return AddOfficeSumbitButton(
                              nameController: nameController,
                              addressController: addressController,
                              emailController: emailController,
                              stateController: stateNameController,
                              countryController: countryNameController,
                              mobNumController: mobNumController,
                              secNumController: secNumController,
                              OptionalController: OptionalController,
                              checkBoxHeadOffice:StatefulBuilder(
                                builder: (BuildContext context, void Function(void Function()) setState) {
                                  return Container(
                                      width: 300,
                                      child: CheckboxTile(
                                        title: 'Head Office',
                                        initialValue: false,
                                        onChanged: (value) {
                                          setState(() {
                                            isHeadOffice = true;
                                            print('HeadOffice ${isHeadOffice}');
                                          });
                                        },
                                      ));
                                },
                              ),
                              checkBoxServices: StatefulBuilder(

                                builder: (BuildContext context, void Function(void Function()) setState) {
                                  return Container(
                                    height:100,
                                    width: 300,
                                    child: FutureBuilder<List<ServicesData>>(
                                        future: getAllServicesData(context),
                                        builder: (context,snapshot) {
                                          if(snapshot.connectionState == ConnectionState.waiting){
                                            return SizedBox();
                                          }
                                          if(snapshot.data!.isEmpty){
                                            return Center(
                                              child: Text('No services available',
                                                style: GoogleFonts.firaSans(
                                                  fontSize: FontSize.s10,
                                                  fontWeight: FontWeightManager.medium,
                                                  color: ColorManager.mediumgrey,
                                                  //decoration: TextDecoration.none,
                                                ),),
                                            );
                                          }
                                          if(snapshot.hasData){
                                            return StatefulBuilder(
                                              builder: (BuildContext context, void Function(void Function()) setState) {
                                                return Wrap(
                                                    children:[
                                                      ...List.generate(snapshot.data!.length, (index){
                                                        String serviceID = snapshot.data![index].serviceId;
                                                        bool isSelected = selectedServices.contains(serviceID);
                                                        return Container(
                                                            width: 150,
                                                            child: Center(
                                                              child: CheckboxTile(
                                                                title: snapshot.data![index].serviceName,
                                                                initialValue: false,
                                                                onChanged: (value) {
                                                                  setState(() {
                                                                    if (value == true) {
                                                                      selectedServices.add(serviceID);
                                                                    } else {
                                                                      selectedServices.remove(serviceID);
                                                                    }
                                                                  });
                                                                  print("Service Id List ${selectedServices}");
                                                                },
                                                              ),
                                                            ));
                                                      })]
                                                );
                                              },

                                            );
                                          }else{
                                            return SizedBox();
                                          }

                                        }
                                    ),
                                  );
                                },
                              ),
                              pickLocationWidget: Row(
                                children: [
                                  TextButton(
                                    onPressed: _pickLocation,
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.transparent),
                                    child: Text(
                                      'Pick Location',
                                      style: GoogleFonts.firaSans(
                                        fontSize: FontSize.s12,
                                        fontWeight: FontWeightManager.bold,
                                        color: ColorManager.bluelight,
                                        //decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: ColorManager.granitegray,
                                    size: AppSize.s18,
                                  ),
                                  Text(
                                    _location,
                                    style: GoogleFonts.firaSans(
                                      fontSize: FontSize.s12,
                                      color: ColorManager.granitegray,
                                    ),
                                  ),

                                ],
                              ),
                              onPressed: () async{
                                ApiData response = await
                                addNewOffice( context:context,
                                  name: nameController.text,
                                  address: addressController.text,
                                  email: emailController.text,
                                  primaryPhone:  mobNumController.text,
                                  secondaryPhone:secNumController.text,
                                  officeId: "",
                                  lat: _selectedLocation.latitude.toString(),
                                  long:_selectedLocation.longitude.toString(),
                                  cityName: "",
                                  stateName: stateNameController.text,
                                  country: countryNameController.text,
                                  isHeadOffice: isHeadOffice,
                                );
                                Navigator.pop(context);
                                if(response.statusCode == 200 || response.statusCode ==201){
                                  await addNewOfficeServices(context: context, officeId: response.officeId!, serviceList: selectedServices);
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      Future.delayed(Duration(seconds: 3), () {
                                        if (Navigator.of(context).canPop()) {
                                          Navigator.of(context).pop();
                                        }
                                      });
                                      return AddSuccessPopup(
                                        message: 'Added Successfully',);
                                    },
                                  );
                                }
                                companyOfficeListGet(context, 1, 30).then((data) {
                                  _companyIdentityController
                                      .add(data);
                                }).catchError((error) {});
                              }, formKey: _formKey,);
                      },
                    );
                  },
                  icon: Icons.add,
                ),
              ],
            ),
          ),
        /// Render heading only if both manage and whitelabelling screens are not shown
        if (!showManageScreen && !showWhitelabellingScreen)
          Container(
            height: 30,
            margin: EdgeInsets.symmetric(horizontal: 50),
            decoration: BoxDecoration(
              color: ColorManager.fmediumgrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:25,right: 45),
                  child: Container(height: 20,width:150),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Sr No.",
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Office Name",
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Address",
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Actions",
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        /// Render list only if both manage and whitelabelling screens are not shown
        if (!showManageScreen && !showWhitelabellingScreen)
          Expanded(
            child: showStreamBuilder
                ? FutureBuilder(
                future: companyOfficeListGet(context, 1, 30),
                builder: (context, snap) {
                  if (snap.hasData) {
                    _companyIdentityController.add(snap.data!);
                    return StreamBuilder<List<CompanyIdentityModel>>(
                      stream: _companyIdentityController.stream,
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator(color: Colors.blue));
                        }
                        if (snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text(
                             ErrorMessageString.noOffice,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          int totalItems = snapshot.data!.length;
                          int totalPages = (totalItems / itemsPerPage).ceil();
                          List<CompanyIdentityModel> paginatedData = snapshot.data!.skip((currentPage - 1) * itemsPerPage).take(itemsPerPage).toList();
                          return Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: paginatedData.length,
                                  itemBuilder: (context, index) {
                                    int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                                    String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 5),
                                        Container(
                                          padding: const EdgeInsets.only(bottom: 5,top: 0),
                                          margin: const EdgeInsets.symmetric(horizontal: 50),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(4),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 4,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          height: 90,
                                          child: Stack(
                                            children: [
                                              snapshot.data![index].isHeadOffice?Positioned(
                                                right:0,
                                                top:0,
                                                child: Container(
                                                  height:20,
                                                  width:80,
                                                  decoration: BoxDecoration(color: ColorManager.faintOrange,
                                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),topRight:Radius.circular(4))),
                                                  child:Center(
                                                      child:Text('Head Office',
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                    color: ColorManager.white,
                                                  ),))
                                                ),
                                              ):Offstage(),
                                              Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 25,right: 45,top:10,bottom: 10),
                                                  child: StatefulBuilder(
                                                    builder: (BuildContext context, void Function(void Function()) setState) {
                                                      return InkWell(
                                                        onTap: () async{
                                                          String googleMapsUrl =
                                                              'https://www.google.com/maps/search/?api=1&query=${snapshot.data![index].lat}, ${snapshot.data![index].long}';
                                                          if (await canLaunchUrlString(googleMapsUrl)) {
                                                          await launchUrlString(googleMapsUrl);
                                                          } else {
                                                          print('Could not open the map.');
                                                          }
                                                        },
                                                        child: SizedBox(
                                                          height: 100,
                                                          width: 150,
                                                          child: GoogleMap(
                                                            initialCameraPosition: CameraPosition(
                                                              target: LatLng(double.parse(snapshot.data![index].lat), double.parse(snapshot.data![index].long)),
                                                              zoom: 15.0,
                                                            ),
                                                            markers: {
                                                               Marker(
                                                                markerId: MarkerId(''),
                                                                position: LatLng(double.parse(snapshot.data![index].lat), double.parse(snapshot.data![index].long)),
                                                              )
                                                            }, // Optional: Disable if not needed// Optional: Disable if not needed
                                                            zoomControlsEnabled: false,
                                                            mapToolbarEnabled: false,
                                                          ),
                                                        ),
                                                      );
                                                      //   Center(
                                                      //   child: InkWell(
                                                      //     onTap: () async{
                                                      //       String googleMapsUrl =
                                                      //           'https://www.google.com/maps/search/?api=1&query=${snapshot.data![index].lat}, ${snapshot.data![index].long}';
                                                      //       if (await canLaunchUrlString(googleMapsUrl)) {
                                                      //       await launchUrlString(googleMapsUrl);
                                                      //       } else {
                                                      //       print('Could not open the map.');
                                                      //       }
                                                      //     },
                                                      //     child: MouseRegion(
                                                      //       onEnter: (_) {
                                                      //         setState(() {
                                                      //           _isHovered = true;
                                                      //         });
                                                      //       },
                                                      //       onExit: (_) {
                                                      //         setState(() {
                                                      //           _isHovered = false;
                                                      //         });
                                                      //       },
                                                      //       child: Stack(
                                                      //         alignment: Alignment.center,
                                                      //         children: [
                                                      //           Container(
                                                      //             height: 100,
                                                      //             width: 100,
                                                      //             child: Image.asset(
                                                      //               "images/mapImage.png",
                                                      //               fit: BoxFit.cover,
                                                      //             ),
                                                      //           ),
                                                      //           if (_isHovered)
                                                      //             Icon(
                                                      //               Icons.map,
                                                      //               size: 20,
                                                      //               color: ColorManager.blueprime,
                                                      //             ),
                                                      //         ],
                                                      //       ),
                                                      //     ),
                                                      //   ),
                                                      // );
                                                      },
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      formattedSerialNumber,
                                                      style: GoogleFonts.firaSans(
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.w700,
                                                        color: const Color(0xff686464),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      paginatedData[index].officeName.toString(),
                                                      style: GoogleFonts.firaSans(
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.w700,
                                                        color: const Color(0xff686464),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        // Text('View Map',style:GoogleFonts.firaSans(
                                                        //   fontSize: 10,
                                                        //   fontWeight: FontWeight.w700,
                                                        //   color: const Color(0xff686464),
                                                        // ),),
                                                        // SizedBox(width:15),
                                                        Text(
                                                          paginatedData[index].address.toString(),
                                                          style: GoogleFonts.firaSans(
                                                            fontSize: 10,
                                                            fontWeight: FontWeight.w700,
                                                            color: const Color(0xff686464),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        CustomButtonTransparentSM(
                                                          text: 'Manage',
                                                          onPressed: () {
                                                            print(paginatedData[index].officeId);
                                                            showManageScreenFunction(
                                                              officeId: paginatedData[index].officeId,
                                                              officeName: paginatedData[index].officeName,
                                                              compId: paginatedData[index].companyId,
                                                              companyOfficeId: paginatedData[index].companyOfficeId,
                                                              stateName: paginatedData[index].stateName,
                                                              countryName: paginatedData[index].countryName,
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ]
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              /// Pagination Controls
                              PaginationControlsWidget(
                                currentPage: currentPage,
                                items: snapshot.data!,
                                itemsPerPage: itemsPerPage,
                                onPreviousPagePressed: () {
                                  setState(() {
                                    currentPage = currentPage > 1 ? currentPage - 1 : 1;
                                  });
                                },
                                onPageNumberPressed: (pageNumber) {
                                  setState(() {
                                    currentPage = pageNumber;
                                  });
                                },
                                onNextPagePressed: () {
                                  setState(() {
                                    currentPage = currentPage < totalPages ? currentPage + 1 : totalPages;
                                  });
                                },
                              ),
                            ],
                          );
                        }
                            return const Scaffold();
                          },
                        );
                      } else {
                        return const Center(
                            child: CircularProgressIndicator(
                            color: Colors.blue));
                      }
                    })
                : PageView(
                    controller: _pageController,
                    children: [
                      Container(
                        child: WhitelabellingScreen(officeId: selectedOfficeID,),
                      ),
                    ],
                  ),
          ),

        /// Render manage screen if showManageScreen is true
        if (showManageScreen)
          Expanded(
            child: ManageWidget(
              officeID: selectedOfficeID,
              officeName: selectedOfficeName,
              companyID: selectedCompId,
              backButtonCallBack: (bool val) {
                if (val) {
                  setState(() {
                    showWhitelabellingScreen = false;
                    showManageScreen = false;
                    showStreamBuilder = true;
                  });
                }
              }, companyOfficeId: selectedCompOfficeId, stateName: selectedStateName, countryName: selectedCountryName,
            ),
          ),

        /// Render whitelabelling screen if showWhitelabellingScreen is true
        if (showWhitelabellingScreen)
          Expanded(
            child: WhitelabellingScreen(officeId: selectedOfficeID,),
          ),

      ],
    );
  }
}
