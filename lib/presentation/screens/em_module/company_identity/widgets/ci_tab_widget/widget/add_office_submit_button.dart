import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
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

import '../../../../../../../app/resources/const_string.dart';
import '../../company_identity_zone/widgets/location_screen.dart';
import '../../whitelabelling/success_popup.dart';

class AddOfficeSumbitButton extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController addressController;
  final TextEditingController emailController;
  final TextEditingController mobNumController;
  final TextEditingController secNumController;
  final TextEditingController OptionalController;
  final Future<void> Function() onPressed;
  final GlobalKey<FormState> formKey;
  AddOfficeSumbitButton({super.key, required this.nameController, required this.addressController, required this.emailController, required this.mobNumController, required this.secNumController, required this.OptionalController, required this.onPressed, required this.formKey});

  @override
  State<AddOfficeSumbitButton> createState() => _AddOfficeSumbitButtonState();
}

class _AddOfficeSumbitButtonState extends State<AddOfficeSumbitButton> {



  LatLng _selectedLocation = LatLng(37.7749, -122.4194); // Default location
  String _location = 'Lat/Long not selected'; // Default text
  // void _pickLocation() async {
  //   final pickedLocation = await Navigator.of(context).push<LatLng>(
  //     MaterialPageRoute(
  //       builder: (context) => MapScreen(
  //         initialLocation: _selectedLocation,
  //         onLocationPicked: (location) {
  //           setState(() {
  //             _selectedLocation = location;
  //             _latitude = location.latitude;
  //             _longitude = location.longitude;
  //             String formatLatLong(double? latitude, double? longitude) {
  //               if (latitude != null && longitude != null) {
  //                 return 'Lat: ${latitude.toStringAsFixed(4)}, Long: ${longitude.toStringAsFixed(4)}';
  //               } else {
  //                 return 'Lat/Long not selected';
  //               }
  //             }
  //
  //            // final latlong = formatLatLong(_latitude, _longitude);
  //             //
  //             // // Create locationString
  //             // final latlong = _latitude != null && _longitude != null
  //             //     ? 'Lat: ${_latitude!.toStringAsFixed(4)}, Long: ${_longitude!.toStringAsFixed(4)}'
  //             //     : 'Lat/Long not selected';
  //
  //             print("Selected LatLong :: $latlong");
  //
  //             // Update the location in the UI directly
  //             _updateLocation(latlong);
  //           });
  //         },
  //       ),
  //     ),
  //   );
  //   }

  //   if (pickedLocation != null) {
  //     setState(() {
  //       _selectedLocation = pickedLocation;
  //       _latitude = pickedLocation.latitude;
  //       _longitude = pickedLocation.longitude;
  //     });
  //   }
  // }


  void _updateLocation(String latlong) {
    setState(() {
      _location = latlong;
      print("Updated Location: $_location"); // Check this log to see if the value updates
    });
  }


  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s390,
        height: AppSize.s500,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListView(
          children: [
            Container(
              height: AppSize.s40,
              width: AppSize.s390,
              padding: EdgeInsets.all(5),
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
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      'Add New Office',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s13,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p15,
              ),
              child: Form(
                key: widget.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 10,),
                    SMTextFConst(
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
                    SMTextFConst(
                      controller: widget.addressController,
                      keyboardType:
                      TextInputType.streetAddress,
                      text: AppString.officeaddress,
                    ),
                    const SizedBox(height: AppSize.s9),

                    DemailSMTextFConst(
                      controller: widget.emailController,
                      keyboardType:
                      TextInputType.emailAddress,
                      text: AppString.email,
                    ),

                    const SizedBox(height: AppSize.s9),
                    SMTextFConst(
                      controller: widget.mobNumController,
                      keyboardType: TextInputType.number,
                      text: 'Primary Phone',
                    ),
                    const SizedBox(height: AppSize.s9),
                    SMTextFConst(
                      controller: widget.secNumController,
                      keyboardType: TextInputType.number,
                      text: 'Secondary Phone',
                    ),
                    const SizedBox(height: AppSize.s9),
                    SMTextFConst(
                      controller: widget.OptionalController,
                      keyboardType: TextInputType.number,
                      text: 'Alternative Phone',
                    ),

                    Row(
                      children: [
                        // TextButton(
                        //   onPressed: _pickLocation,
                        //   style: TextButton.styleFrom(
                        //       backgroundColor: Colors.transparent),
                        //   child: Text(
                        //     'Pick Location',
                        //     style: GoogleFonts.firaSans(
                        //       fontSize: FontSize.s12,
                        //       fontWeight: FontWeightManager.bold,
                        //       color: ColorManager.bluelight,
                        //       //decoration: TextDecoration.none,
                        //     ),
                        //   ),
                        // ),
                        Icon(
                          Icons.location_on_outlined,
                          color: ColorManager.granitegray,
                          size: AppSize.s18,
                        ),

                      ],
                    ),

                  ],
                ),
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
                      if (widget.formKey.currentState!.validate()) {
                        await widget.onPressed();
                      } else {
                        print('Validation error');
                      }
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pop(context);
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
                      widget.nameController.clear();
                      widget.mobNumController.clear();
                      widget.addressController.clear();
                      widget.emailController.clear();
                      widget.secNumController.clear();
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
