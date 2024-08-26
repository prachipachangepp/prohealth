// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:prohealth/app/resources/color.dart';
// import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
// import 'package:prohealth/app/resources/font_manager.dart';
// import 'package:prohealth/app/resources/value_manager.dart';
// import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
// import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
//
// class AddHolidayPopup extends StatefulWidget {
//   final TextEditingController controller;
//   final TextEditingController calenderDateController;
//   final Future<void> Function() onPressed; // Changed to Future<void> for async operations
//  final String title;
//   const AddHolidayPopup({
//     super.key,
//     required this.controller,
//     required this.calenderDateController,
//     required this.onPressed, required this.title,
//   });
//
//   @override
//   State<AddHolidayPopup> createState() => _AddHolidayPopupState();
// }
//
// class _AddHolidayPopupState extends State<AddHolidayPopup> {
//   String? _expiryType;
//   final DateTime _selectedDate = DateTime.now();
//   bool isLoading = false; // Added loading state
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       child: Container(
//         width: AppSize.s400,
//         height: AppSize.s250,
//         decoration: BoxDecoration(
//           color: ColorManager.white,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//         color: ColorManager.bluebottom,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(8),
//             topRight: Radius.circular(8),
//           ),
//         ),
//           height: 40,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10.0),
//                     child: Text(
//                     widget.title,
//                       style: GoogleFonts.firaSans(
//                         fontSize: FontSize.s12,
//                         fontWeight: FontWeightManager.semiBold,
//                         color: ColorManager.white,
//                         decoration: TextDecoration.none,
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: Icon(Icons.close,color: ColorManager.white,),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: AppPadding.p3,
//                 horizontal: AppPadding.p20,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   SMTextFConst(
//                     controller: widget.controller,
//                     keyboardType: TextInputType.text,
//                     text: 'Holiday Name',
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20,),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: AppPadding.p3,
//                 horizontal: AppPadding.p20,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Holiday Date',
//                     style: GoogleFonts.firaSans(
//                       fontSize: FontSize.s12,
//                       fontWeight: FontWeight.w700,
//                       color: ColorManager.mediumgrey,
//                       decoration: TextDecoration.none,
//                     ),
//                   ),
//                   FormField<String>(
//                     builder: (FormFieldState<String> field) {
//                       return SizedBox(
//                         width: 354,
//                         height: 30,
//                         child: TextFormField(
//                           controller: widget.calenderDateController,
//                           style: GoogleFonts.firaSans(
//                             fontSize: FontSize.s12,
//                             fontWeight: FontWeight.w700,
//                             color: ColorManager.mediumgrey,
//                           ),
//                           decoration: InputDecoration(
//                             hintText: 'mm-dd-yyyy',
//                             hintStyle: GoogleFonts.firaSans(
//                               fontSize: FontSize.s12,
//                               fontWeight: FontWeight.w700,
//                               color: ColorManager.mediumgrey,
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide(width: 1),
//                             ),
//                             contentPadding: EdgeInsets.symmetric(horizontal: 16),
//                             suffixIcon: Icon(Icons.calendar_month_outlined, color: ColorManager.blueprime,),
//                             errorText: field.errorText,
//                           ),
//                           readOnly: true,
//                           onTap: () async {
//                             DateTime? date = await showDatePicker(
//                               context: context,
//                               initialDate: _selectedDate,
//                               firstDate: DateTime(1100),
//                               lastDate: DateTime(2025),
//                             );
//                             if (date != null) {
//                               String formattedDate = DateFormat('yyyy-MM-dd').format(date);
//                               widget.calenderDateController.text = formattedDate;
//                               field.didChange(formattedDate);
//                             }
//                           },
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please select date';
//                             }
//                             return null;
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             Spacer(),
//             Padding(
//               padding: const EdgeInsets.only(bottom: AppPadding.p24),
//               child: Center(
//                 child: isLoading
//                     ? CircularProgressIndicator( color: ColorManager.blueprime,)
//                     : CustomElevatedButton(
//                   width: AppSize.s105,
//                   height: AppSize.s30,
//                   text: AppStringEM.add,
//                   onPressed: () async {
//                     setState(() {
//                       isLoading = true;
//                     });
//                     try {
//                       await widget.onPressed();
//                     } finally {
//                       setState(() {
//                         isLoading = false;
//                       });
//                       Navigator.pop(context);
//                       widget.calenderDateController.clear();
//                       widget.controller.clear();
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
// }





/////////////////////////////after validation/////////////////


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';

class AddHolidayPopup extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController calenderDateController;
  final Future<void> Function() onPressed;
  final String title;

  const AddHolidayPopup({
    super.key,
    required this.controller,
    required this.calenderDateController,
    required this.onPressed,
    required this.title,
  });

  @override
  State<AddHolidayPopup> createState() => _AddHolidayPopupState();
}

class _AddHolidayPopupState extends State<AddHolidayPopup> {
  final _formKey = GlobalKey<FormState>();
  final DateTime _selectedDate = DateTime.now();
  bool isLoading = false;
  String? holidayNameError;
  String? holidayDateError;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s400,
        height: AppSize.s250,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorManager.bluebottom,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      widget.title,
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
                    icon: Icon(Icons.close, color: ColorManager.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FirstSMTextFConst(
                      controller: widget.controller,
                      keyboardType: TextInputType.text,
                      text: 'Holiday Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          setState(() {
                            holidayNameError = 'Please enter some text';

                          });
                          return null;
                        }
                        setState(() {
                          holidayNameError = null;
                        });
                        return null;
                      },
                    ),
                    if (holidayNameError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          holidayNameError!,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: FontSize.s12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    SizedBox(height: 20),
                    Text(
                      'Holiday Date',
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.mediumgrey,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(
                      width: 354,
                      height: 30,
                      child: TextFormField(
                        controller: widget.calenderDateController,
                        style: GoogleFonts.firaSans(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.mediumgrey,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.fmediumgrey, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.fmediumgrey, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: 'mm-dd-yyyy',
                          hintStyle: GoogleFonts.firaSans(
                            fontSize: FontSize.s12,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.mediumgrey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(width: 1),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          suffixIcon: Icon(Icons.calendar_month_outlined, color: ColorManager.blueprime),
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? date = await showDatePicker(
                            context: context,
                            initialDate: _selectedDate,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2101),
                          );
                          if (date != null) {
                            String formattedDate = DateFormat('yyyy-MM-dd').format(date);
                            widget.calenderDateController.text = formattedDate;
                            setState(() {
                              holidayDateError = null;
                            });
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            setState(() {
                              holidayDateError = 'Please select a holiday date';
                            });
                            return null;
                          }
                          setState(() {
                            holidayDateError = null;
                          });
                          return null;
                        },
                      ),
                    ),
                    if (holidayDateError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          holidayDateError!,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: FontSize.s12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p24),
              child: Center(
                child: isLoading
                    ? CircularProgressIndicator(color: ColorManager.blueprime)
                    : CustomElevatedButton(
                  width: AppSize.s105,
                  height: AppSize.s30,
                  text: "Add holiday",
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      setState(() {
                        isLoading = true;
                        Navigator.pop(context);
                      });
                      try {
                        await widget.onPressed();
                      } finally {
                        setState(() {
                          isLoading = false;
                        });
                        // Navigator.pop(context);
                        // widget.calenderDateController.clear();
                        // widget.controller.clear();
                      }
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







