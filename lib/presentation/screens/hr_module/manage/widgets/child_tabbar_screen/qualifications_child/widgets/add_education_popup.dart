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

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height/1.9, // Adjusted height to fit error messages
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    child: Text(
                      widget.title,
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s16,
                        fontWeight: FontWeightManager.bold,
                        color: ColorManager.blueprime,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFieldRegister(
                        height: AppSize.s30,
                        width: MediaQuery.of(context).size.width / 6,
                        controller: widget.collegeUniversityController,
                        labelText: "College/University",
                        keyboardType: TextInputType.text,
                        padding:
                        const EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
                        onChanged: (value) {
                          setState(() {
                            _collegeUniversityError = value.isEmpty;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppString.enterText;
                          }
                          return null;
                        },
                      ),
                      if (_collegeUniversityError)
                        const Text(
                          'Please enter some text',
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFieldRegister(
                        height: AppSize.s30,
                        width: MediaQuery.of(context).size.width / 6,
                        controller: widget.phoneController,
                        labelText: "Phone",
                        keyboardType: TextInputType.text,
                        padding:
                        const EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
                        onChanged: (value) {
                          setState(() {
                            _phoneError = value.isEmpty;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppString.enterText;
                          }
                          return null;
                        },
                      ),
                      if (_phoneError)
                        const Text(
                          'Please enter some text',
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFieldRegister(
                        height: AppSize.s30,
                        width: MediaQuery.of(context).size.width / 6,
                        controller: widget.calenderController,
                        labelText: "Start Date",
                        keyboardType: TextInputType.text,
                        suffixIcon: Icon(
                          Icons.calendar_month_outlined,
                          color: ColorManager.blueprime,
                        ),
                        padding:
                        const EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppString.enterText;
                          }
                          return null;
                        },
                      ),
                      if (_calendarError)
                        const Text(
                          'Please enter some text',
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Graduate',
                        style: TextStyle(fontSize: FontSize.s10),
                      ),
                      Row(
                        children: [
                          widget.radioButton!,
                        ],
                      ),
                      if (!_isRadioButtonSelected)
                        const Text(
                          'Please select an option',
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFieldRegister(
                        height: AppSize.s30,
                        width: MediaQuery.of(context).size.width / 6,
                        controller: widget.cityController,
                        labelText: "City",
                        keyboardType: TextInputType.text,
                        padding:
                        const EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
                        onChanged: (value) {
                          setState(() {
                            _cityError = value.isEmpty;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppString.enterText;
                          }
                          return null;
                        },
                      ),
                      if (_cityError)
                        const Text(
                          'Please enter some text',
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFieldRegister(
                        height: AppSize.s30,
                        width: MediaQuery.of(context).size.width / 6,
                        controller: widget.degreeController,
                        labelText: "Degree",
                        keyboardType: TextInputType.text,
                        padding:
                        const EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
                        onChanged: (value) {
                          setState(() {
                            _degreeError = value.isEmpty;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppString.enterText;
                          }
                          return null;
                        },
                      ),
                      if (_degreeError)
                        const Text(
                          'Please enter some text',
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFieldRegister(
                        height: AppSize.s30,
                        width: MediaQuery.of(context).size.width / 6,
                        controller: widget.stateController,
                        labelText: "State",
                        keyboardType: TextInputType.text,
                        padding:
                        const EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
                        onChanged: (value) {
                          setState(() {
                            _stateError = value.isEmpty;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppString.enterText;
                          }
                          return null;
                        },
                      ),
                      if (_stateError)
                        const Text(
                          'Please enter some text',
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFieldRegister(
                        height: AppSize.s30,
                        width: MediaQuery.of(context).size.width / 6,
                        controller: widget.majorSubjectController,
                        labelText: "Major Subject",
                        keyboardType: TextInputType.text,
                        padding:
                        const EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
                        onChanged: (value) {
                          setState(() {
                            _majorSubjectError = value.isEmpty;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppString.enterText;
                          }
                          return null;
                        },
                      ),
                      if (_majorSubjectError)
                        const Text(
                          'Please enter some text',
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFieldRegister(
                        height: AppSize.s30,
                        width: MediaQuery.of(context).size.width / 6,
                        controller: widget.countryNameController,
                        labelText: "Country Name",
                        keyboardType: TextInputType.text,
                        padding:
                        const EdgeInsets.only(bottom: AppPadding.p5, left: AppPadding.p20),
                        onChanged: (value) {
                          setState(() {
                            _countryNameError = value.isEmpty;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppString.enterText;
                          }
                          return null;
                        },
                      ),
                      if (_countryNameError)
                        const Text(
                          'Please enter some text',
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButtonTransparent(
                        text: "Cancel",
                        onPressed: () async {
                          widget.onpressedClose();
                        }),
                    const SizedBox(width: 10),
                    isLoading
                        ? SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          color: ColorManager.blueprime,
                        ))
                        : CustomElevatedButton(
                        text: "Save",
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                            _collegeUniversityError = widget.collegeUniversityController.text.isEmpty;
                            _phoneError = widget.phoneController.text.isEmpty;
                            _calendarError = widget.calenderController.text.isEmpty;
                            _cityError = widget.cityController.text.isEmpty;
                            _degreeError = widget.degreeController.text.isEmpty;
                            _stateError = widget.stateController.text.isEmpty;
                            _majorSubjectError = widget.majorSubjectController.text.isEmpty;
                            _countryNameError = widget.countryNameController.text.isEmpty;
                            _isRadioButtonSelected = widget.radioButton != null;
                          });
                          if (!_collegeUniversityError &&
                              !_phoneError &&
                              !_calendarError &&
                              !_cityError &&
                              !_degreeError &&
                              !_stateError &&
                              !_majorSubjectError &&
                              !_countryNameError &&
                              _isRadioButtonSelected) {
                            try {
                              await widget.onpressedSave();
                            } finally {
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pop(context);
                              widget.countryNameController.clear();
                              widget.degreeController.clear();
                              widget.majorSubjectController.clear();
                              widget.stateController.clear();
                              widget.cityController.clear();
                              widget.phoneController.clear();
                              widget.countryNameController.clear();
                              widget.collegeUniversityController.clear();
                            }
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
