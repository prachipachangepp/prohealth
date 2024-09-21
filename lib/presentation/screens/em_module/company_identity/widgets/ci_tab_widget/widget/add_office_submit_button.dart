import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/company_identrity_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/google_aotopromt_api_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/manage_details_manager.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/establishment_data/ci_manage_button/manage_details_data.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/company_identity_data_.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/constant_checkbox/const_checckboxtile.dart';

import '../../../../../../../app/resources/const_string.dart';
import '../../company_identity_zone/widgets/location_screen.dart';
import '../../whitelabelling/success_popup.dart';

class AddOfficeSumbitButton extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController addressController;
  final TextEditingController emailController;
  final TextEditingController stateController;
  final TextEditingController countryController;
  final TextEditingController mobNumController;
  final TextEditingController secNumController;
  final TextEditingController OptionalController;
  final List<ServicesMetaData> servicesList;
  //final Widget checkBoxHeadOffice;
  final Future<void> Function() onPressed;
  final GlobalKey<FormState> formKey;
  AddOfficeSumbitButton({super.key,
    required this.nameController,
    required this.addressController,
    required this.emailController,
    required this.mobNumController,
    required this.secNumController,
    required this.OptionalController,
    required this.onPressed,
    required this.formKey,
    required this.stateController,
    required this.countryController, required this.servicesList,
    // required this.checkBoxHeadOffice,
    });

  @override
  State<AddOfficeSumbitButton> createState() => _AddOfficeSumbitButtonState();
}

class _AddOfficeSumbitButtonState extends State<AddOfficeSumbitButton> {
  bool isLoading = false;

  List<String> _suggestions = [];
  @override
  void initState() {
    super.initState();
    widget.addressController.addListener(_onCountyNameChanged);
  }

  @override
  void dispose() {
    widget.addressController.removeListener(_onCountyNameChanged);
    super.dispose();
  }
 void _onCountyNameChanged() async {
   if (widget.addressController.text.isEmpty) {
     setState(() {
       _suggestions = [];
     });
     return;
   }

   final suggestions = await fetchSuggestions(widget.addressController.text);
   setState(() {
     _suggestions = suggestions;
   });
 }
  LatLng _selectedLocation = LatLng(37.7749, -122.4194); // Default location
  String _location = 'Lat/Long not selected'; // Default text
  double? _latitude;
  double? _longitude;
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
    print("Picked location ${pickedLocation}");

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
  List<ServiceList> selectedServices = [];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s833,
        height: AppSize.s530,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListView(
          children: [
            Container(
              height: AppSize.s40,
              width: AppSize.s390,
              decoration: BoxDecoration(
                color: ColorManager.bluebottom,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Text(
                      'Add New Office',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p20,
                horizontal: AppPadding.p15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                          FirstSMTextFConst(
                            controller: widget.nameController,
                            keyboardType: TextInputType.text,
                            text: AppStringEM.name,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return "Please Enter name";
                            //   }
                            //   if (!value.contains(RegExp(r'[0-9]'))) {
                            //     return 'Please Enter valid name';
                            //   }
                            //   return "";
                            // },
                          ),
                          const SizedBox(height: AppSize.s9),
                          DemailSMTextFConst(
                            controller: widget.emailController,
                            keyboardType:
                            TextInputType.emailAddress,
                            text: AppString.email,
                          ),
                          const SizedBox(height: AppSize.s9),
                          FirstSMTextFConst(
                            controller: widget.countryController,
                            keyboardType: TextInputType.text,
                            text: 'Country',
                          ),
                          const SizedBox(height: AppSize.s9),
                          SMTextFConstPhone(
                            controller: widget.secNumController,
                            keyboardType: TextInputType.number,
                            text: 'Secondary Phone',
                          ),
                          const SizedBox(height: AppSize.s9),
                          Text('Services',style: GoogleFonts.firaSans(
                            fontSize: FontSize.s12,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.mediumgrey,
                            decoration: TextDecoration.none,
                          )),
                            StatefulBuilder(
                              builder: (BuildContext context, void Function(void Function()) setState) {
                                return Container(
                                  height:100,
                                  width: 300,
                                  child:StatefulBuilder(
                                            builder: (BuildContext context, void Function(void Function()) setState) {
                                              return Wrap(
                                                  children:[
                                                    ...List.generate(widget.servicesList.length, (index){
                                                      String serviceID = widget.servicesList[index].serviceId;
                                                      bool isSelected = selectedServices.contains(serviceID);
                                                      return Container(
                                                          width: 150,
                                                          child: Center(
                                                            child: CheckboxTile(
                                                              title: widget.servicesList[index].serviceName,

                                                              initialValue: false,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  if (value == true) {
                                                                    selectedServices.add(
                                                                        ServiceList(
                                                                            serviceId: serviceID,
                                                                            npiNumber: "",
                                                                            medicareProviderId: "",
                                                                            hcoNumId: ""));
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
                                          ),

                                );
                              },
                            )
                        ],),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: AppSize.s7),
                          SMTextFConst(
                            controller: widget.addressController,
                            keyboardType:
                            TextInputType.streetAddress,
                            text: AppString.officeaddress,
                          ),
                          // widget.checkBoxHeadOffice,
                          const SizedBox(height: AppSize.s9),
                          FirstSMTextFConst(
                            controller: widget.stateController,
                            keyboardType: TextInputType.text,
                            text: 'State',
                          ),
                          const SizedBox(height: AppSize.s9),
                          SMTextFConstPhone(
                            controller: widget.mobNumController,
                            keyboardType: TextInputType.number,
                            text: 'Primary Phone',
                          ),
                          const SizedBox(height: AppSize.s10),
                          SMTextFConstPhone(
                            controller: widget.OptionalController,
                            keyboardType: TextInputType.number,
                            text: 'Alternative Phone',
                          ),
                          const SizedBox(height: AppSize.s10),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: _pickLocation,
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.transparent),
                                  child: Text(
                                    'Pick Location',
                                    style: GoogleFonts.firaSans(
                                      fontSize: FontSize.s12,
                                      fontWeight: FontWeight.w600,
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
                        ],)
                      ]
                    ),
                      if (_suggestions.isNotEmpty)
                        Positioned(
                          top: 50,
                          right: 50,
                          child: Container(
                            height:100,
                            width:320,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: _suggestions.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(_suggestions[index],style: GoogleFonts.firaSans(
                                    fontSize: FontSize.s12,
                                    fontWeight: FontWeight.w700,
                                    color: ColorManager.mediumgrey,
                                    decoration: TextDecoration.none,
                                  ),),
                                  onTap: () {
                                    widget.addressController.text = _suggestions[index];
                                    widget.addressController.removeListener(_onCountyNameChanged);
                                    setState(() {
                                      _suggestions.clear();
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ),]
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSize.s30),
            Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p10),
              child: Center(
                child: isLoading
                    ? SizedBox(
                  height: AppSize.s25,
                  width: AppSize.s25,
                  child: CircularProgressIndicator(
                    color: ColorManager.blueprime,
                  ),
                )
                    : CustomElevatedButton(
                  width: AppSize.s105,
                  height: AppSize.s30,
                  text: AppStringEM.add,
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      print("Selected lat long ${_selectedLocation.latitude} + ${_selectedLocation.longitude}");
                        ApiData response = await
                        addNewOffice( context:context,
                          name: widget.nameController.text,
                          address: widget.addressController.text,
                          email: widget.emailController.text,
                          primaryPhone:  widget.mobNumController.text,
                          secondaryPhone:widget.secNumController.text,
                          officeId: "",
                          lat: _selectedLocation.latitude.toString(),
                          long:_selectedLocation.longitude.toString(),
                          cityName: "",
                          stateName: widget.stateController.text,
                          country: widget.countryController.text,
                          isHeadOffice: false,
                        );

                        Navigator.pop(context);
                        if(response.statusCode == 200 || response.statusCode ==201){
                          print('Services List ${selectedServices}');
                          await addNewOfficeServices(context: context, officeId: response.officeId!,
                              serviceList: selectedServices);
                        }
                        // companyOfficeListGet(context, 1, 30).then((data) {
                        //   _companyIdentityController
                        //       .add(data);
                        // }).catchError((error) {});

                      widget.stateController.clear();
                      widget.countryController.clear();
                      widget.nameController.clear();
                      widget.mobNumController.clear();
                      widget.addressController.clear();
                      widget.emailController.clear();
                      widget.secNumController.clear();
                      widget.OptionalController.clear();

                      // if (widget.formKey.currentState!.validate()) {
                      //
                      // } else {
                      //   print('Validation error');
                      // }
                    } finally {
                      setState(() {
                        isLoading = false;
                      });

                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// //
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/app/resources/color.dart';
// import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
// import 'package:prohealth/app/resources/font_manager.dart';
// import 'package:prohealth/app/resources/value_manager.dart';
// import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
// import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
//
// import '../../../../../../../app/resources/const_string.dart';
// import '../../whitelabelling/success_popup.dart';
//
// class AddOfficeSumbitButton extends StatefulWidget {
//   final TextEditingController nameController;
//   final TextEditingController addressController;
//   final TextEditingController emailController;
//   final TextEditingController mobNumController;
//   final TextEditingController secNumController;
//   final TextEditingController OptionalController;
//   final Future<void> Function() onPressed;
//   final GlobalKey<FormState> formKey;
//
//   AddOfficeSumbitButton({
//     super.key,
//     required this.nameController,
//     required this.addressController,
//     required this.emailController,
//     required this.mobNumController,
//     required this.secNumController,
//     required this.OptionalController,
//     required this.onPressed,
//     required this.formKey,
//   });
//
//   @override
//   State<AddOfficeSumbitButton> createState() => _AddOfficeSumbitButtonState();
// }
//
// class _AddOfficeSumbitButtonState extends State<AddOfficeSumbitButton> {
//   bool isLoading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       child: Container(
//         width: AppSize.s390,
//         height: AppSize.s470,
//         decoration: BoxDecoration(
//           color: ColorManager.white,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: ListView(
//           children: [
//             Container(
//               height: AppSize.s40,
//               width: AppSize.s390,
//               padding: EdgeInsets.all(5),
//               decoration: BoxDecoration(
//                 color: ColorManager.bluebottom,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(8),
//                   topRight: Radius.circular(8),
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Add New Office',
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.firaSans(
//                       fontSize: 13,
//                       fontWeight: FontWeightManager.semiBold,
//                       color: ColorManager.white,
//                       decoration: TextDecoration.none,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: Icon(Icons.close, color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: AppPadding.p3,
//                 horizontal: AppPadding.p15,
//               ),
//               child: Form(
//                 key: widget.formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     SMTextFConst(
//                       controller: widget.nameController,
//                       keyboardType: TextInputType.text,
//                       text:AppString.name,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Please Enter a name";
//                         }
//                         if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
//                           return 'Name must contain only letters';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: AppSize.s9),
//                     SMTextFConst(
//                       controller: widget.addressController,
//                       keyboardType: TextInputType.streetAddress,
//                       text: 'Address',
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Please Enter an address";
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: AppSize.s9),
//                     SMTextFConst(
//                       controller: widget.emailController,
//                       keyboardType: TextInputType.emailAddress,
//                       text: AppString.email,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Please enter an email";
//                         }
//                         if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$").hasMatch(value)) {
//                           return "Please enter a valid email";
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: AppSize.s9),
//                     SMTextFConst(
//                       controller: widget.mobNumController,
//                       keyboardType: TextInputType.number,
//                       text: 'Primary Phone',
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Please enter a primary phone number";
//                         }
//                         if (!RegExp(r"^\d{10}$").hasMatch(value)) {
//                           return "Phone number must be 10 digits";
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: AppSize.s9),
//                     SMTextFConst(
//                       controller: widget.secNumController,
//                       keyboardType: TextInputType.number,
//                       text: 'Secondary Phone',
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Please enter a secondary phone number";
//                         }
//                         if (!RegExp(r"^\d{10}$").hasMatch(value)) {
//                           return "Phone number must be 10 digits";
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: AppSize.s9),
//                     SMTextFConst(
//                       controller: widget.OptionalController,
//                       keyboardType: TextInputType.number,
//                       text: 'Alternative Phone',
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Please enter an alternative phone number";
//                         }
//                         if (!RegExp(r"^\d{10}$").hasMatch(value)) {
//                           return "Phone number must be 10 digits";
//                         }
//                         return null;
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: AppSize.s30),
//             Padding(
//               padding: const EdgeInsets.only(bottom: AppPadding.p10),
//               child: Center(
//                 child: isLoading
//                     ? SizedBox(
//                   height:  AppSize.s25,
//                   width:  AppSize.s25,
//                   child: CircularProgressIndicator(
//                     color: ColorManager.blueprime,
//                   ),
//                 )
//                     : CustomElevatedButton(
//                   width: AppSize.s105,
//                   height: AppSize.s30,
//                   text: AppStringEM.submit,
//                   onPressed: () async {
//                     if (widget.formKey.currentState!.validate()) {
//                       setState(() {
//                         isLoading = true;
//                       });
//                       try {
//                         await widget.onPressed();
//                         Navigator.pop(context);
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             Future.delayed(Duration(seconds: 3), () {
//                               if (Navigator.of(context).canPop()) {
//                                 Navigator.of(context).pop();
//                               }
//                             });
//                             return AddSuccessPopup(
//                               message: 'Added Successfully',
//                             );
//                           },
//                         );
//                         _clearControllers();
//                       } finally {
//                         setState(() {
//                           isLoading = false;
//                         });
//                       }
//                     } else {
//                       print('Validation error');
//                     }
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _clearControllers() {
//     widget.nameController.clear();
//     widget.mobNumController.clear();
//     widget.addressController.clear();
//     widget.emailController.clear();
//     widget.secNumController.clear();
//     widget.OptionalController.clear();
//   }
// }
//
