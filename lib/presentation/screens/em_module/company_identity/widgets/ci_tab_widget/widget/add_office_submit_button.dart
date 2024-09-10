import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/google_aotopromt_api_manager.dart';
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
  final TextEditingController stateController;
  final TextEditingController countryController;
  final TextEditingController mobNumController;
  final TextEditingController secNumController;
  final TextEditingController OptionalController;
  final Widget checkBoxHeadOffice;
  final Widget checkBoxServices;
  final Widget pickLocationWidget;
  final Future<void> Function() onPressed;
  final GlobalKey<FormState> formKey;
  AddOfficeSumbitButton({super.key,
    required this.pickLocationWidget,
    required this.nameController,
    required this.addressController,
    required this.emailController,
    required this.mobNumController,
    required this.secNumController,
    required this.OptionalController,
    required this.onPressed,
    required this.formKey, required this.stateController, required this.countryController, required this.checkBoxHeadOffice, required this.checkBoxServices});

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

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s833,
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
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      'Add New Office',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s12,
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
                vertical: AppPadding.p20,
                horizontal: AppPadding.p15,
              ),
              child: Form(
                key: widget.formKey,
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
                            widget.checkBoxServices,
                          ],),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                            SMTextFConst(
                              controller: widget.addressController,
                              keyboardType:
                              TextInputType.streetAddress,
                              text: AppString.officeaddress,
                            ),
                            widget.checkBoxHeadOffice,
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
                            const SizedBox(height: AppSize.s9),
                            SMTextFConstPhone(
                              controller: widget.OptionalController,
                              keyboardType: TextInputType.number,
                              text: 'Alternative Phone',
                            ),
                            const SizedBox(height: AppSize.s9),
                            widget.pickLocationWidget,
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
