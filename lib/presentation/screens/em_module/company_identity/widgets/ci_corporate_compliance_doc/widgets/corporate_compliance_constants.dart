import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/theme_manager.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../widgets/button_constant.dart';
import '../../../../widgets/text_form_field_const.dart';

///add popup
class CCScreensAddPopup extends StatefulWidget {
  final TextEditingController countynameController;
  final TextEditingController zipcodeController;
  VoidCallback onSavePressed;
  final Widget child;
  final Widget child1;
  final String title;
  CCScreensAddPopup(
      {super.key,
      required this.countynameController,
      required this.zipcodeController,
      required this.onSavePressed,
      required this.child,
      required this.child1,
      required this.title});

  @override
  State<CCScreensAddPopup> createState() => _CCScreensAddPopusState();
}

class _CCScreensAddPopusState extends State<CCScreensAddPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s400,
        height: AppSize.s420,
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
              height: AppSize.s40,
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
                    icon: Icon(
                      Icons.close,
                      color: ColorManager.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SMTextFConst(
                    controller: widget.countynameController,
                    keyboardType: TextInputType.text,
                    text: AppString.name_of_the_document,
                  ),
                  SizedBox(height: AppSize.s15),
                  SMTextFConst(
                    controller: widget.zipcodeController,
                    keyboardType: TextInputType.text,
                    text: AppString.id_of_the_document,
                  ),
                  SizedBox(height: AppSize.s15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.type_of_the_document,
                        style: GoogleFonts.firaSans(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.mediumgrey,
                          //decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(
                        height: AppSize.s5,
                      ),
                      widget.child
                    ],
                  ),
                  SizedBox(height: AppSize.s15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.sub_type_of_the_document,
                        style: GoogleFonts.firaSans(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.mediumgrey,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(
                        height: AppSize.s5,
                      ),
                      widget.child1
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p50),
              child: Center(
                child: CustomElevatedButton(
                  width: AppSize.s105,
                  height: AppSize.s30,
                  text: AppStringEM.add,
                  onPressed: () {
                    widget.onSavePressed();
                    Navigator.pop(context);
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

///dropdown constant
class CICCDropdown extends StatefulWidget {
  final double? width;
  final List<DropdownMenuItem<String>> items;
  final String? initialValue;
  final Function(String)? onChange;

  const CICCDropdown({
    Key? key,
    required this.items,
    this.width,
    this.initialValue,
    this.onChange, String? hintText,
  }) : super(key: key);

  @override
  _CIDetailsDropdownState createState() => _CIDetailsDropdownState();
}

class _CIDetailsDropdownState extends State<CICCDropdown> {
  String? _selectedValue;
  GlobalKey _dropdownKey = GlobalKey();
  List items = [];
  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  void _showCustomDropdown() async {
    final RenderBox renderBox =
        _dropdownKey.currentContext!.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    final result = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
          offset.dx, offset.dy + size.height, offset.dx + size.width, 0),
      items: widget.items.map((DropdownMenuItem<String> item) {
        return PopupMenuItem<String>(
          textStyle: CustomTextStylesCommon.commonStyle(
            fontWeight: FontWeightManager.medium,
            fontSize: FontSize.s12,
            color: ColorManager.mediumgrey,
          ),
          value: item.value,
          child: Container(
            width: size.width - 16,

            ///minus padding/margin
            child: Text(item.value ?? ''),
          ),
        );
      }).toList(),
      color: ColorManager.white,
    );

    if (result != null) {
      setState(() {
        _selectedValue = result;
        widget.onChange!(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          key: _dropdownKey,
          width: widget.width == null ? 354 : widget.width,
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(
                color: ColorManager.containerBorderGrey, width: AppSize.s1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              SizedBox(width: AppSize.s8),
              Expanded(
                child: Text(
                  _selectedValue ?? '',
                  style: GoogleFonts.firaSans(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.medium,
                    color: ColorManager.mediumgrey,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              GestureDetector(
                onTap: _showCustomDropdown,
                child: Icon(Icons.arrow_drop_down),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

///edit popup
class CCScreenEditPopup extends StatefulWidget {
  final int? id;
  final TextEditingController idDocController;
  final TextEditingController nameDocController;
  final TextEditingController? calenderController;
  final VoidCallback? onSavePressed;
  final Widget? child;
  final Widget? child1;
  final Widget? child2;
  final double? height;
  final Widget? radioButton;
  bool? loadingDuration;
  final String title;

  CCScreenEditPopup({
    super.key,
    required this.idDocController,
    required this.nameDocController,
    this.onSavePressed,
    this.child,
    this.child1,
    this.child2,
    this.id,
    this.radioButton,
    this.calenderController,
    this.loadingDuration,
    required this.title,
    this.height,
  });

  @override
  State<CCScreenEditPopup> createState() => _CCScreenEditPopupState();
}

class _CCScreenEditPopupState extends State<CCScreenEditPopup> {
  String? _expiryType;
  final DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s420,
        height: widget.height == null ? AppSize.s550 : widget.height,
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
              height: AppSize.s35,
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
                    icon: Icon(
                      Icons.close,
                      color: ColorManager.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SMTextFConst(
                    enable: false,
                    // readOnly: true,
                    controller: widget.idDocController,
                    keyboardType: TextInputType.text,
                    text: AppString.id_of_the_document,
                  ),
                  SizedBox(height: AppSize.s10),
                  SMTextFConst(
                    controller: widget.nameDocController,
                    keyboardType: TextInputType.text,
                    text: AppString.name_of_the_document,
                  ),
                  SizedBox(height: AppSize.s10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.type_of_the_document,
                        style: GoogleFonts.firaSans(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.mediumgrey,
                          //decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(height: AppSize.s5),
                      widget.child!,
                    ],
                  ),
                  SizedBox(height: AppSize.s12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.sub_type_of_the_document,
                        style: GoogleFonts.firaSans(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.mediumgrey,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(height: AppSize.s5),
                      widget.child1!,
                    ],
                  ),
                ],
              ),
            ),

            ///radio
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p25),
              child: widget.radioButton,
            ),
            SizedBox(height: AppSize.s10),

            Padding(
              padding: const EdgeInsets.only(
                left: AppPadding.p20,
                right: AppPadding.p20,
              ),
              child: widget.child2,
            ),
            // widget.calenderController == null ? Offstage() :
            // Padding(
            //   padding: const EdgeInsets.symmetric(
            //     vertical: AppPadding.p8,
            //     horizontal: AppPadding.p20,
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(AppString.expiry_date,
            //         style: GoogleFonts.firaSans(
            //           fontSize: FontSize.s12,
            //           fontWeight: FontWeightManager.bold,
            //           color: ColorManager.mediumgrey,
            //           decoration: TextDecoration.none,
            //         ),
            //       ),
            //       SizedBox(
            //         height: AppSize.s4,
            //       ),
            //       FormField<String>(
            //         builder: (FormFieldState<String> field) {
            //           return SizedBox(
            //             width: AppSize.s354,
            //             height: AppSize.s30,
            //             child: TextFormField(
            //               style: GoogleFonts.firaSans(
            //                 fontSize: FontSize.s12,
            //                 fontWeight: FontWeightManager.bold,
            //                 color: ColorManager.mediumgrey,
            //                 //decoration: TextDecoration.none,
            //               ),
            //               controller: widget.calenderController,
            //               decoration: InputDecoration(
            //                 focusColor: ColorManager.mediumgrey,
            //                 hoverColor: ColorManager.mediumgrey,
            //                 hintText: 'mm-dd-yyyy',
            //                 hintStyle: GoogleFonts.firaSans(
            //                   fontSize: FontSize.s12,
            //                   fontWeight: FontWeightManager.bold,
            //                   color: ColorManager.mediumgrey,
            //                   //decoration: TextDecoration.none,
            //                 ),
            //                 border: OutlineInputBorder(
            //                   borderRadius: BorderRadius.circular(8),
            //                   borderSide: BorderSide(
            //                       width: 1, color: ColorManager.mediumgrey),
            //                 ),
            //                 focusedBorder: OutlineInputBorder(
            //                   borderRadius: BorderRadius.circular(8),
            //                   borderSide: BorderSide(
            //                       width: AppSize.s1,
            //                       color: ColorManager.mediumgrey), // Set focused border color to red
            //                 ),
            //                 enabledBorder: OutlineInputBorder(
            //                   borderRadius: BorderRadius.circular(8),
            //                   borderSide: BorderSide(
            //                       width: AppSize.s1,
            //                       color: ColorManager.mediumgrey), // Set enabled border color to red
            //                 ),
            //                 contentPadding:
            //                     EdgeInsets.symmetric(horizontal: 16),
            //                 suffixIcon: Icon(Icons.calendar_month_outlined,
            //                     color: ColorManager.blueprime),
            //                 errorText: field.errorText,
            //               ),
            //               readOnly: true,
            //               onTap: () async {
            //                 DateTime? date = await showDatePicker(
            //                   context: context,
            //                   initialDate: DateTime.now(),
            //                   firstDate: DateTime(1100),
            //                   lastDate: DateTime(2026),
            //                 );
            //                 if (date != null) {
            //                   String formattedDate =
            //                       DateFormat('MM-dd-yyyy').format(date);
            //                   widget.calenderController!.text = formattedDate;
            //                   field.didChange(formattedDate);
            //                   // birthdayController.text =
            //                   // date.toLocal().toString().split(' ')[0];
            //                   // field.didChange(date.toLocal().toString().split(' ')[0]);
            //                 }
            //               },
            //               validator: (value) {
            //                 if (value == null || value.isEmpty) {
            //                   return 'Please select date';
            //                 }
            //                 return null;
            //               },
            //             ),
            //           );
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: AppSize.s20),

            ///button
            Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p10),
              child: Center(
                child: widget.loadingDuration == true
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
                        text: AppStringEM.add, //submit
                        onPressed: () {
                          widget.onSavePressed!();
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

/// add popu
class AddOrgDocButton extends StatefulWidget {
  final TextEditingController idDocController;
  final TextEditingController nameDocController;
  final TextEditingController calenderController;
  final VoidCallback onPressed;
  final double? height;
  Widget? child;
  Widget? child1;
  final String title;
  final Widget? radioButton;
  final Visibility? child2;
  final bool? loadingDuration;
  AddOrgDocButton(
      {super.key,
      required this.idDocController,
      required this.nameDocController,
      this.child,
      this.child1,
      required this.onPressed,
      required this.calenderController,
      this.radioButton,
      this.loadingDuration,
      required this.title,
      this.child2,
      this.height});

  @override
  State<AddOrgDocButton> createState() => _AddOrgDocButtonState();
}

class _AddOrgDocButtonState extends State<AddOrgDocButton> {
  bool _isFormValid = true;

  // Error messages for each text field
  String? _idDocError;
  String? _nameDocError;

  // String? _validateTextField(String value, String fieldName) {
  //   if (value.isEmpty) {
  //     _isFormValid = false;
  //     return "Please Enter $fieldName";
  //   }
  //   if (value[0] != value[0].toUpperCase()) {
  //     _isFormValid = false;
  //     return "$fieldName must start with a capital letter";
  //   }
  //   return null;
  // }
  //
  // void _validateForm() {
  //   setState(() {
  //     _isFormValid = true;
  //     _idDocError =
  //         _validateTextField(widget.idDocController.text, 'ID of the Document');
  //     _nameDocError = _validateTextField(
  //         widget.nameDocController.text, 'Name of the Document');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s420,
        height: widget.height ?? AppSize.s550,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              height: AppSize.s40,
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
                    padding: const EdgeInsets.only(left: 27),
                    child: Text(
                      "Add Doctype",
                     // widget.title,
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
                    icon: Icon(
                      Icons.close,
                      color: ColorManager.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /// ID of the Document
                  SMTextFConst(
                    controller: widget.idDocController,
                    keyboardType: TextInputType.text,
                    text: AppString.id_of_the_document,
                  ),
                  // if (_idDocError != null)
                  //   Padding(
                  //     padding: const EdgeInsets.only(top: 2.0),
                  //     child: Text(
                  //       _idDocError!,
                  //       style: TextStyle(
                  //         color: Colors.red,
                  //         fontSize: FontSize.s12,
                  //       ),
                  //     ),
                  //   ),
                  SizedBox(height: AppSize.s13),

                  /// Name of the Document
                  FirstSMTextFConst(
                    controller: widget.nameDocController,
                    keyboardType: TextInputType.text,
                    text: AppString.name_of_the_document,
                  ),
                  if (_nameDocError != null) // Display error if any
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        _nameDocError!,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: FontSize.s12,
                        ),
                      ),
                    ),
                  SizedBox(height: AppSize.s13),

                  /// Type of the Document
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.type_of_the_document,
                        style: GoogleFonts.firaSans(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.mediumgrey,
                        ),
                      ),
                      SizedBox(height: AppSize.s5),
                      widget.child ?? Offstage(),
                    ],
                  ),
                  SizedBox(height: AppSize.s13),

                  /// Sub Type of the Document
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.sub_type_of_the_document,
                        style: GoogleFonts.firaSans(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.mediumgrey,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(height: AppSize.s5),
                      widget.child1 ?? Offstage(),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSize.s10),

            /// Radio Button Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p25),
              child: widget.radioButton,
            ),
            SizedBox(height: AppSize.s10),

            Padding(
              padding: const EdgeInsets.only(
                left: AppPadding.p20,
                right: AppPadding.p20,
              ),
              child: widget.child2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p20),
              child: Center(
                child: widget.loadingDuration == true
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
                        onPressed: () {
                          // _validateForm(); // Validate the form on button press
                          // if (_isFormValid) {
                          //   widget.onPressed();
                          // }

                          widget.onPressed();
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
