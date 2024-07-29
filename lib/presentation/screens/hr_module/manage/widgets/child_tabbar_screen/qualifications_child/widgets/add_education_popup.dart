// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:prohealth/app/resources/color.dart';
// import 'package:prohealth/app/resources/const_string.dart';
// import 'package:prohealth/app/resources/font_manager.dart';
// import 'package:prohealth/app/resources/value_manager.dart';
// import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
// import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
// import 'package:prohealth/presentation/screens/hr_module/register/taxtfield_constant.dart';
//
// class AddEducationPopup extends StatefulWidget {
//   final TextEditingController collegeUniversityController;
//   final TextEditingController phoneController;
//   final TextEditingController calenderController;
//   final TextEditingController cityController;
//   final TextEditingController degreeController;
//   final TextEditingController stateController;
//   final TextEditingController majorSubjectController;
//   final TextEditingController countryNameController;
//   final VoidCallback onpressedClose;
//   Future<void> Function() onpressedSave;
//   final String title;
//   final Widget? radioButton;
//    AddEducationPopup({super.key, required this.collegeUniversityController, required this.phoneController, required this.calenderController, required this.cityController, required this.degreeController, required this.stateController, required this.majorSubjectController, required this.countryNameController, required this.onpressedClose, required this.onpressedSave, this.radioButton, required this.title});
//
//   @override
//   State<AddEducationPopup> createState() => _AddEducationPopupState();
// }
//
// class _AddEducationPopupState extends State<AddEducationPopup> {
//   final DateTime _selectedStartDate = DateTime.now();
//   bool isLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       child: Container(
//         width: MediaQuery.of(context).size.width/1.5,
//         height: AppSize.s420,
//         decoration: BoxDecoration(
//           color: ColorManager.white,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
//                     child: Text(widget.title,style: GoogleFonts.firaSans(
//                       fontSize: FontSize.s16,
//                       fontWeight: FontWeightManager.bold,
//                       color: ColorManager.blueprime,
//                       decoration: TextDecoration.none,
//                     ),),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: const Icon(Icons.close),
//                   ),
//                 ],
//               ),
//               SizedBox(height:MediaQuery.of(context).size.height/20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   CustomTextFieldRegister(
//                     height: AppSize.s30,
//                     width: MediaQuery.of(context).size.width/6,
//                     controller: widget.collegeUniversityController,
//                     labelText: "College/University",
//                     keyboardType: TextInputType.text,
//                     padding: const EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
//                     onChanged: (value) {
//
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return AppString.enterText;
//                       }
//                       return null;
//                     },
//                   ),
//                   CustomTextFieldRegister(
//                     height: AppSize.s30,
//                     width: MediaQuery.of(context).size.width/6,
//                     controller: widget.phoneController,
//                     labelText: "Phone",
//                     keyboardType: TextInputType.text,
//                     padding: const EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
//                     onChanged: (value) {
//
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return AppString.enterText;
//                       }
//                       return null;
//                     },
//                   ),
//                   CustomTextFieldRegister(
//                     height: AppSize.s30,
//                     width: MediaQuery.of(context).size.width/6,
//                     controller: widget.calenderController,
//                     labelText: "Start Date",
//                     keyboardType: TextInputType.text,
//                     suffixIcon: Icon(Icons.calendar_month_outlined,color: ColorManager.blueprime,),
//                     padding: const EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
//                     onTap: () async{
//                       DateTime? date = await showDatePicker(
//                         context: context,
//                         initialDate: _selectedStartDate,
//                         firstDate: DateTime(1100),
//                         lastDate: DateTime(2025),
//                       );
//                       if (date != null) {
//                         String formattedDate = DateFormat('yyyy-MM-dd').format(date);
//                         widget.calenderController.text = formattedDate;
//                         //field.didChange(formattedDate);
//                       }
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return AppString.enterText;
//                       }
//                       return null;
//                     },
//                   ),
//
//                 ],
//               ),
//               SizedBox(height:MediaQuery.of(context).size.height/20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text('Graduate',style: TextStyle(
//                           fontSize: FontSize.s10
//                       ),),
//                       Row(
//                         children: [
//                           widget.radioButton!,
//                         ],
//                       ),
//                     ],
//                   ),
//                   CustomTextFieldRegister(
//                     height: AppSize.s30,
//                     width: MediaQuery.of(context).size.width/6,
//                     controller: widget.cityController,
//                     labelText: "City",
//                     keyboardType: TextInputType.text,
//                     padding: const EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
//                     onChanged: (value) {
//
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return AppString.enterText;
//                       }
//                       return null;
//                     },
//                   ),
//                   CustomTextFieldRegister(
//                     height: AppSize.s30,
//                     width: MediaQuery.of(context).size.width/6,
//                     controller: widget.degreeController,
//                     labelText: "Degree",
//                     keyboardType: TextInputType.text,
//                     padding: const EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
//                     onChanged: (value) {
//
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return AppString.enterText;
//                       }
//                       return null;
//                     },
//                   ),
//
//                 ],
//               ),
//               SizedBox(height:MediaQuery.of(context).size.height/20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   CustomTextFieldRegister(
//                     height: AppSize.s30,
//                     width: MediaQuery.of(context).size.width/6,
//                     controller: widget.stateController,
//                     labelText: "State",
//                     keyboardType: TextInputType.text,
//                     padding: const EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
//                     onChanged: (value) {
//
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return AppString.enterText;
//                       }
//                       return null;
//                     },
//                   ),
//                   CustomTextFieldRegister(
//                     height: AppSize.s30,
//                     width: MediaQuery.of(context).size.width/6,
//                     controller: widget.majorSubjectController,
//                     labelText: "Major Subject",
//                     keyboardType: TextInputType.text,
//                     padding: const EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
//                     onChanged: (value) {
//
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return AppString.enterText;
//                       }
//                       return null;
//                     },
//                   ),
//                   CustomTextFieldRegister(
//                     height: AppSize.s30,
//                     width: MediaQuery.of(context).size.width/6,
//                     controller: widget.countryNameController,
//                     labelText: "Country Name",
//                     keyboardType: TextInputType.text,
//                     padding: const EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
//                     onChanged: (value) {
//
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return AppString.enterText;
//                       }
//                       return null;
//                     },
//                   ),
//
//                 ],
//               ),
//               SizedBox(height:MediaQuery.of(context).size.height/15),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     CustomButtonTransparent(text: "Cancel", onPressed: () async{
//                       widget.onpressedClose;
//                     }),
//                     const SizedBox(width: 10,),
//                     isLoading ? SizedBox(
//                         height: 25,
//                         width: 25,
//                         child: CircularProgressIndicator(color: ColorManager.blueprime,))
//                         : CustomElevatedButton(text: "Save",onPressed: () async{
//                       setState(() {
//                         isLoading = true;
//                       });
//                       try {
//                         await widget.onpressedSave();
//                       } finally {
//                         setState(() {
//                           isLoading = false;
//                         });
//                         Navigator.pop(context);
//                         widget.countryNameController.clear();
//                         widget.degreeController.clear();
//                         widget.majorSubjectController.clear();
//                         widget.stateController.clear();
//                         widget.cityController.clear();
//                         widget.phoneController.clear();
//                         widget.countryNameController.clear();
//                         widget.collegeUniversityController.clear();
//                       }
//                     }),
//
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

////////////////////////after validation///////////////////////////////


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/register/taxtfield_constant.dart';

class AddEducationPopup extends StatefulWidget {
  final TextEditingController collegeUniversityController;
  final TextEditingController phoneController;
  final TextEditingController calenderController;
  final TextEditingController cityController;
  final TextEditingController degreeController;
  final TextEditingController stateController;
  final TextEditingController majorSubjectController;
  final TextEditingController countryNameController;
  final VoidCallback onpressedClose;
  final Future<void> Function() onpressedSave;
  final String title;
  final Widget? radioButton;

  AddEducationPopup({
    super.key,
    required this.collegeUniversityController,
    required this.phoneController,
    required this.calenderController,
    required this.cityController,
    required this.degreeController,
    required this.stateController,
    required this.majorSubjectController,
    required this.countryNameController,
    required this.onpressedClose,
    required this.onpressedSave,
    this.radioButton,
    required this.title,
  });

  @override
  State<AddEducationPopup> createState() => _AddEducationPopupState();
}

class _AddEducationPopupState extends State<AddEducationPopup> {
  final DateTime _selectedStartDate = DateTime.now();
  bool isLoading = false;

  // Error states
  bool _collegeUniversityError = false;
  bool _phoneError = false;
  bool _calendarError = false;
  bool _cityError = false;
  bool _degreeError = false;
  bool _stateError = false;
  bool _majorSubjectError = false;
  bool _countryNameError = false;
  bool _isRadioButtonSelected = false;
  bool _radioButtonError = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 360,
        width: 932,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              height: 41,
              decoration: BoxDecoration(
                color: Color(0xff50B5E5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: Text(
                      widget.title,
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s16,
                        fontWeight: FontWeightManager.bold,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller: widget.collegeUniversityController,
                              labelText: "College/University",
                              errorText: _collegeUniversityError ? 'Please enter College/University Name' : null,
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: _buildTextField(
                              controller: widget.phoneController,
                              labelText: "Phone",
                              errorText: _phoneError ? 'Please enter valid phone number' : null,
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: _buildTextField(
                              controller: widget.calenderController,
                              labelText: "Start Date",
                              errorText: _calendarError ? 'Please Enter Start Date' : null,
                              suffixIcon: Icon(Icons.calendar_month_outlined, color: ColorManager.blueprime),
                              onTap: () async {
                                DateTime? date = await showDatePicker(
                                  context: context,
                                  initialDate: _selectedStartDate,
                                  firstDate: DateTime(1100),
                                  lastDate: DateTime(2025),
                                );
                                if (date != null) {
                                  String formattedDate = DateFormat('yyyy-MM-dd').format(date);
                                  widget.calenderController.text = formattedDate;
                                  setState(() {
                                    _calendarError = formattedDate.isEmpty;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Graduate', style: TextStyle(fontSize: FontSize.s10)),
                                widget.radioButton ?? SizedBox.shrink(),
                                if (_radioButtonError)
                                  Text('Please select an option', style: TextStyle(color: Colors.red, fontSize: 10)),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: _buildTextField(
                              controller: widget.cityController,
                              labelText: "City",
                              errorText: _cityError ? 'Please Enter City' : null,
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: _buildTextField(
                              controller: widget.degreeController,
                              labelText: "Degree",
                              errorText: _degreeError ? 'Please Enter Degree' : null,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller: widget.stateController,
                              labelText: "State",
                              errorText: _stateError ? 'Please Enter State' : null,
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: _buildTextField(
                              controller: widget.majorSubjectController,
                              labelText: "Major Subject",
                              errorText: _majorSubjectError ? 'Please Enter Major Subject' : null,
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: _buildTextField(
                              controller: widget.countryNameController,
                              labelText: "Country Name",
                              errorText: _countryNameError ? 'Please Enter Country Name' : null,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomButtonTransparent(
                            text: "Cancel",
                            onPressed: widget.onpressedClose,
                          ),
                          SizedBox(width: 10),
                          isLoading
                              ? SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              color: ColorManager.blueprime,
                            ),
                          )
                              : CustomElevatedButton(
                            text: "Save",
                            onPressed: _handleSave,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    String? errorText,
    Widget? suffixIcon,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFieldRegister(
          height: AppSize.s30,
          controller: controller,
          labelText: labelText,
          keyboardType: TextInputType.phone,
          padding: EdgeInsets.only(bottom: AppPadding.p5, left: 10),
          suffixIcon: suffixIcon,
          onTap: onTap,
          onChanged: (value) {
            setState(() {
              // Update error state based on the field
              if (labelText == "College/University") _collegeUniversityError = value.isEmpty;
              if (labelText == "Phone") {
                _phoneError = value.isEmpty || value.length != 10 || int.tryParse(value) == null;
              }
              if (labelText == "City") _cityError = value.isEmpty;
              //if (labelText == "Degree") _degreeError = value.isEmpty;
              if (labelText == "State") _stateError = value.isEmpty;
              if (labelText == "Major Subject") _majorSubjectError = value.isEmpty;
              if (labelText == "Country Name") _countryNameError = value.isEmpty;
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppString.enterText;
            }
            if (labelText == "Phone" && (value.length != 10 || int.tryParse(value) == null)) {
              return 'Please enter a valid 10-digit phone number';
            }
            return null;
          },
        ),
        if (errorText != null)
          Padding(
            padding: EdgeInsets.only(left: 10, top: 5),
            child: Text(
              errorText,
              style: TextStyle(color: Colors.red, fontSize: 10),
            ),
          ),
      ],
    );
  }

  void _handleSave() async {
    setState(() {
      isLoading = true;
      _collegeUniversityError = widget.collegeUniversityController.text.isEmpty;
      _phoneError = widget.phoneController.text.isEmpty ||
          widget.phoneController.text.length != 10 ||
          int.tryParse(widget.phoneController.text) == null;
      _calendarError = widget.calenderController.text.isEmpty;
      _cityError = widget.cityController.text.isEmpty;
      _degreeError = widget.degreeController.text.isEmpty;
      _stateError = widget.stateController.text.isEmpty;
      _majorSubjectError = widget.majorSubjectController.text.isEmpty;
      _countryNameError = widget.countryNameController.text.isEmpty;
      //_radioButtonError = !_isRadioButtonSelected;
    });

    if (!_collegeUniversityError &&
        !_phoneError &&
        !_calendarError &&
        !_cityError &&
        !_stateError &&
        !_majorSubjectError &&
        !_countryNameError &&
        !_radioButtonError) {
      try {
        await widget.onpressedSave();
      } finally {
        setState(() {
          isLoading = false;
        });
        Navigator.pop(context);
        _clearControllers();
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _clearControllers() {
    widget.countryNameController.clear();
    widget.degreeController.clear();
    widget.majorSubjectController.clear();
    widget.stateController.clear();
    widget.cityController.clear();
    widget.phoneController.clear();
    widget.collegeUniversityController.clear();
    widget.calenderController.clear();
  }
}
