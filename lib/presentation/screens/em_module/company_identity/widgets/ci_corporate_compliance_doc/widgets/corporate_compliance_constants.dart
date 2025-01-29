import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/common_resources/common_theme_const.dart';
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
                    padding: const EdgeInsets.only(left: AppPadding.p10),
                    child: Text(
                      widget.title,
                      style:  PopupBlueBarText.customTextStyle(context),
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
                        style:  DefineWorkWeekStyle.customTextStyle(context),
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
                        style:  DefineWorkWeekStyle.customTextStyle(context),
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
  final bool? isEnabled;
  final double? constraintHeight;

  const CICCDropdown({
    Key? key,
    required this.items,
    this.width,
    this.initialValue,
    String? hintText,
    this.onChange,
    this.isEnabled,
    this.constraintHeight = 250,
  }) : super(key: key);

  @override
  _CIDetailsDropdownState createState() => _CIDetailsDropdownState();
}

class _CIDetailsDropdownState extends State<CICCDropdown> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  void _showCustomDropdown() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned(
              left: offset.dx,
              top: offset.dy + size.height,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  width: widget.width ?? size.width,
                  constraints: BoxConstraints(
                    maxHeight: widget.constraintHeight!, // Limit height for scrolling
                  ),
                  child: Scrollbar(
                    child: ListView(
                      shrinkWrap: true,
                      children: widget.items.map((DropdownMenuItem<String> item) {
                        return ListTile(
                          title: Text(
                            item.value ?? '',
                            style: DocumentTypeDataStyle.customTextStyle(context),
                          ),
                          onTap: () {
                            setState(() {
                              _selectedValue = item.value;
                              widget.onChange?.call(item.value!);
                            });
                            Navigator.pop(context);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showCustomDropdown,
      child: Container(
        width: widget.width == null ? AppSize.s354 : widget.width,
        height: AppSize.s30,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
              child: Text(
                _selectedValue ?? 'Select',
                style: DocumentTypeDataStyle.customTextStyle(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
              child: Icon(Icons.arrow_drop_down),
            ),
          ],
        ),
      ),
    );
  }
}


///prajwal
class CICCDropDownExcel extends StatefulWidget {
  final double? width;
  final List<DropdownMenuItem<String>> items;
  final String? initialValue;
  final Function(String)? onChange;
  final bool? isEnabled;

  const CICCDropDownExcel({
    Key? key,
    required this.items,
    this.width,
    this.initialValue,
    this.onChange,
    String? hintText,
    this.isEnabled,
  }) : super(key: key);

  @override
  _CIDetailsDropDownState createState() => _CIDetailsDropDownState();
}

class _CIDetailsDropDownState extends State<CICCDropDownExcel> {
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
          textStyle: DocumentTypeDataStyle.customTextStyle(context),
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
        GestureDetector(
          onTap: _showCustomDropdown,
          child: Container(
            padding: EdgeInsets.only(left: AppPadding.p2),
            key: _dropdownKey,
            width: widget.width == null ? AppSize.s354 : widget.width,
            height: AppSize.s30,
            decoration: BoxDecoration(
              border: Border.all(
                  color: ColorManager.containerBorderGrey, width: AppSize.s1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                SizedBox(width: AppSize.s8),
                Expanded(
                  child: Text(
                    _selectedValue ?? '',
                    style:  DocumentTypeDataStyle.customTextStyle(context),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: AppPadding.p10),
                  child: Icon(Icons.arrow_drop_down),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

///

///edit popup
class CCScreenEditPopup extends StatefulWidget {
  final String? idOfDoc;
  final TextEditingController idOfDocController;
  final TextEditingController nameDocController;
  final TextEditingController? calenderController;
  final VoidCallback? onSavePressed;
  final Widget child;
  final Widget? child1;
  final Widget? child2;
  final double? height;
  final Widget? radioButton;
  bool? loadingDuration;
  final String title;

  CCScreenEditPopup({
    super.key,
    required this.idOfDocController,
    required this.nameDocController,
    this.onSavePressed,
    required this.child,
    this.child1,
    this.child2,
    this.idOfDoc,
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
                    padding: const EdgeInsets.only(left: 32),
                    child: Text(
                      widget.title,
                      style:  PopupBlueBarText.customTextStyle(context),
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
                vertical: AppPadding.p18,
                horizontal: AppPadding.p18,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SMTextFConst(
                    enable: false,
                    // readOnly: true,
                    controller: widget.idOfDocController,
                    keyboardType: TextInputType.text,
                    text: AppString.id_of_the_document,
                  ),
                  SizedBox(height: AppSize.s12),
                  SMTextFConst(
                    controller: widget.nameDocController,
                    keyboardType: TextInputType.text,
                    text: AppString.name_of_the_document,
                  ),
                  SizedBox(height: AppSize.s12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.type_of_the_document,
                        style: ConstTextFieldRegister.customTextStyle(context),
                      ),
                      SizedBox(height: AppSize.s5),
                      widget.child!,
                    ],
                  ),
                  SizedBox(height: AppSize.s5),
                  if (widget.child1 != null) ...[
                    Text(
                      AppString.sub_type_of_the_document,
                      style: DefineWorkWeekStyle.customTextStyle(context),
                    ),
                    SizedBox(height: AppSize.s5),
                  ],
                  widget.child1 ?? Offstage(),
                ],
              ),
            ),
            SizedBox(height: AppSize.s5),

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
  final String? selectedSubDocType;
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
      this.height,
      this.selectedSubDocType});

  @override
  State<AddOrgDocButton> createState() => _AddOrgDocButtonState();
}

class _AddOrgDocButtonState extends State<AddOrgDocButton> {
  bool _isFormValid = true;

  // Error messages for each text field
  String? _idDocError;
  String? _nameDocError;

  String? _validateTextField(String value, String fieldName) {
    if (value.isEmpty) {
      _isFormValid = false;
      return "Please Enter $fieldName";
    }
    // if (value.isEmpty) {
    //   _isFormValid = false;
    //   return "$fieldName must start with a capital letter";
    // }
    return null;
  }

  void _validateForm() {
    setState(() {
      _isFormValid = true;
      _idDocError =
          _validateTextField(widget.idDocController.text, 'ID of the Document');
      _nameDocError = _validateTextField(
          widget.nameDocController.text, 'Name of the Document');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s420,
        height: widget.height ?? AppSize.s598,
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
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style:  PopupBlueBarText.customTextStyle(context),
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
                  if (_idDocError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Text(
                        _idDocError!,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: FontSize.s14,
                        ),
                      ),
                    ),
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
                          fontSize: FontSize.s14,
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
                        style: DefineWorkWeekStyle.customTextStyle(context),
                      ),
                      SizedBox(height: AppSize.s5),
                      widget.child ?? Offstage(),
                    ],
                  ),
                  SizedBox(height: AppSize.s13),

                  /// Sub Type of the Document
                  if (widget.child1 != null) ...[
                    Text(
                      AppString.sub_type_of_the_document,
                      style: DefineWorkWeekStyle.customTextStyle(context),
                    ),
                    SizedBox(height: AppSize.s5),
                  ],
                  widget.child1 ?? Offstage(),
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
                          _validateForm(); // Validate the form on button press
                          if (_isFormValid) {
                            widget.onPressed();
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

class dummeyTextField extends StatefulWidget {
  final String labelText;
  final String? initialValue;
  final TextEditingController? controller;
  final Icon? suffixIcon;
  final FormFieldValidator<String>? validator;
  final double? width;
  final double? height;

  const dummeyTextField({
    Key? key,
    required this.labelText,
    this.initialValue,
    this.controller,
    this.suffixIcon,
    this.validator,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  _dummeyTextFieldState createState() => _dummeyTextFieldState();
}

class _dummeyTextFieldState extends State<dummeyTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.width,
        height: widget.height,
        child: TextFormField(
          textCapitalization: TextCapitalization.sentences,
          controller: _controller,
          style: TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeight.w400,
            color: ColorManager.black,
          ),
          cursorColor: ColorManager.black,
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: TextStyle(
              fontSize: FontSize.s10,
              color: ColorManager.greylight,
            ),
            border: const OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.containerBorderGrey),
            ),
            suffixIcon: widget.suffixIcon != null
                ? GestureDetector(
                    onTap: () async {
                      // Open the date picker when the calendar icon is tapped
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2101),
                      );

                      if (pickedDate != null) {
                        // Format the date and set it into the text field
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        _controller.text = formattedDate;
                      }
                    },
                    child: widget.suffixIcon,
                  )
                : null,
            // Do not show any icon if suffixIcon is null
          ),
          validator: widget.validator,
        ));
  }
}

///circuler border

// class CdummeyTextField extends StatefulWidget {
//   final String labelText;
//   final String? initialValue;
//   final TextEditingController? controller;
//   final Icon? suffixIcon;
//   final FormFieldValidator<String>? validator;
//   final double? width;
//   final double? height;
//
//   const CdummeyTextField({
//     Key? key,
//     required this.labelText,
//     this.initialValue,
//     this.controller,
//     this.suffixIcon,
//     this.validator,
//     this.width,
//     this.height,
//   }) : super(key: key);
//
//   @override
//   _CdummeyTextFieldState createState() => _CdummeyTextFieldState();
// }
//
// class _CdummeyTextFieldState extends State<CdummeyTextField> {
//   late TextEditingController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller =
//         widget.controller ?? TextEditingController(text: widget.initialValue);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         width: widget.width,
//         height: widget.height,
//         child: Container(
//           decoration: BoxDecoration(
//             border: Border.all(color: Color(0xFFB1B1B1), width: 1),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: TextFormField(
//             textCapitalization: TextCapitalization.sentences,
//             controller: _controller,
//             style: GoogleFonts.firaSans(
//               fontSize: FontSize.s12,
//               fontWeight: FontWeight.w400,
//               color: ColorManager.black,
//             ),
//             cursorColor: ColorManager.black,
//             decoration: InputDecoration(
//               labelText: widget.labelText,
//               labelStyle: GoogleFonts.firaSans(
//                 fontSize: FontSize.s10,
//                 color: ColorManager.greylight,
//               ),
//               border: const OutlineInputBorder(),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: ColorManager.containerBorderGrey),
//               ),
//               suffixIcon: widget.suffixIcon != null
//                   ? GestureDetector(
//                       onTap: () async {
//                         // Open the date picker when the calendar icon is tapped
//                         DateTime? pickedDate = await showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime(1900),
//                           lastDate: DateTime(2101),
//                         );
//
//                         if (pickedDate != null) {
//                           // Format the date and set it into the text field
//                           String formattedDate =
//                               DateFormat('yyyy-MM-dd').format(pickedDate);
//                           _controller.text = formattedDate;
//                         }
//                       },
//                       child: widget.suffixIcon,
//                     )
//                   : null,
//               // Do not show any icon if suffixIcon is null
//             ),
//             validator: widget.validator,
//           ),
//         ));
//   }
// }
