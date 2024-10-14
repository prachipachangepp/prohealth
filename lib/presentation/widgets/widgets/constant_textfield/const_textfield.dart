import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';

import '../../../../../app/resources/value_manager.dart';

///textfield constant widget
///todo prachi
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final double? width;
  final double? height;
  final double cursorHeight;
  final String text;
  //final TextStyle labelStyle;
  //final double labelFontSize;
  final Icon? suffixIcon;
  final IconData? prefixIcon;
  final FocusNode? focusNode;
  final VoidCallback? onTapSuffixIcon;
  final void Function(String)? onChanged;

  CustomTextField({
    this.width,
    this.height,
    required this.cursorHeight,
    required this.text,
    // required this.labelStyle,
    this.suffixIcon,
    this.prefixIcon,
    required this.controller,
    this.focusNode,
    //required this.labelFontSize,
    this.onTapSuffixIcon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(text,style: AllPopupHeadings.customTextStyle(context),),
        ),
        SizedBox(height: 2,),
        SizedBox(
          width: AppSize.s250,
          height: AppSize.s40,
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p5),
            child: TextFormField(
              focusNode: focusNode,
              controller: controller,
              textAlign: TextAlign.start,
              style: DocumentTypeDataStyle.customTextStyle(context),
              textAlignVertical: TextAlignVertical.center,
              cursorHeight: cursorHeight,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                    bottom: AppPadding.p3, top: AppPadding.p5, left: 4),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorManager.black),
                ),
                // labelText: labelText,
                // labelStyle:DocumentTypeDataStyle.customTextStyle(context),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p14),
                  child: suffixIcon,
                ),
              ),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

///drop down text field
///todo prachi
class CustomDropdownTextField extends StatefulWidget {
  final String? value;
  final List<String>? items;
  final List<DropdownMenuItem<String>>? dropDownMenuList;
  final String? hintText;
  final String headText;
  final void Function(String?)? onChanged;
  final double? width;
  final double? height;
  final String? initialValue;

  const CustomDropdownTextField({
    Key? key,
    this.dropDownMenuList,
    required this.headText,
    this.value,
    this.items,
    this.onChanged,
    this.width,
    this.height,
    this.initialValue,
    this.hintText,
  }) : super(key: key);

  @override
  _CustomDropdownTextFieldState createState() =>
      _CustomDropdownTextFieldState();
}

class _CustomDropdownTextFieldState extends State<CustomDropdownTextField> {
  late String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(widget.headText,style: AllPopupHeadings.customTextStyle(context),),
        ),
        SizedBox(
          width: AppSize.s250,
          height: AppSize.s40,
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p5),
            child: DropdownButtonFormField<String>(
              icon:
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Icon(Icons.arrow_drop_down_sharp, color: ColorManager.mediumgrey),
              ),
              value: _selectedValue,
              items: widget.dropDownMenuList == null
                  ? widget.items!.map((String value) {
                return DropdownMenuItem<String>(

                  value: value,
                  child: Text(
                    value,
                    style:DocumentTypeDataStyle.customTextStyle(context),
                  ),
                );
              }).toList()
                  : widget.dropDownMenuList,
              onChanged: (newValue) {
                setState(() {
                  _selectedValue = newValue;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(newValue);
                }
              },
              isExpanded: true,
              decoration: InputDecoration(
                hoverColor: ColorManager.white,
                contentPadding: EdgeInsets.only(
                    bottom: AppPadding.p3, top: AppPadding.p5, left: 4),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorManager.black),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

///
///
class CustomTextFieldPhone extends StatelessWidget {
  final TextEditingController controller;
  final double? width;
  final double? height;
  final double cursorHeight;
  final String text;
  final Icon? suffixIcon;
  final IconData? prefixIcon;
  final FocusNode? focusNode;
  final VoidCallback? onTapSuffixIcon;
  final void Function(String)? onChanged;

  CustomTextFieldPhone({
    this.width,
    this.height,
    required this.cursorHeight,
    required this.text,
    this.suffixIcon,
    this.prefixIcon,
    required this.controller,
    this.focusNode,
    this.onTapSuffixIcon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(text,style: AllPopupHeadings.customTextStyle(context),),
        ),
        SizedBox(height: 5,),
        SizedBox(
          width: AppSize.s250,
          height: AppSize.s40,
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p5),
            child: TextFormField(
              focusNode: focusNode,
              controller: controller,
              textAlign: TextAlign.start,
              style: DocumentTypeDataStyle.customTextStyle(context),
              textAlignVertical: TextAlignVertical.center,
              cursorColor: Colors.black,
              cursorHeight: cursorHeight,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                    bottom: AppPadding.p3, top: AppPadding.p5, left: 4),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorManager.black),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p14),
                  child: suffixIcon,
                ),
              ),
              onChanged: onChanged,

              inputFormatters: [
                PhoneNumberInputFormatter(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
///
///






class CustomDropDown extends StatefulWidget {
  final String? value;
  final List<String> items;
  final String labelText;
  final String? hintText;
  final TextStyle? labelStyle;
  final double? labelFontSize;
  final void Function(String?)? onChanged;
  final double? width;
  final double? height;
  final String? initialValue;
  CustomDropDown({
    super.key,
    this.value,
    required this.items,
    required this.labelText,
    this.labelStyle,
    this.labelFontSize,
    this.onChanged,
    this.width,
    this.height,
    this.initialValue,
    this.hintText,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  late String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 354,
      height: AppSize.s40,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p5),
        child: DropdownButtonFormField<String>(
          icon:
          Icon(Icons.arrow_drop_down_sharp, color: ColorManager.blueprime),
          value: _selectedValue,
          items: widget.items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: DocumentTypeDataStyle.customTextStyle(context),
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _selectedValue = newValue;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(newValue);
            }
          },
          isExpanded: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
                bottom: AppPadding.p3, top: AppPadding.p5, left: AppPadding.p2),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.black),
            ),
            labelText: widget.labelText,
            labelStyle: widget.labelStyle?.copyWith(
                fontSize: widget.labelFontSize, color: ColorManager.mediumgrey),
          ),
        ),
      ),
    );
  }
}

///todo prachi
///Human Resource screen textField email only
class HRManageTextFieldEmail extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String text;
  final Color textColor;
  final Icon? icon;
  final bool? readOnly;
  final VoidCallback? onChange;
  final double? width;
  final double? height;
  final double cursorHeight;
  final String? labelText;
  final String? hintText;
  final TextStyle labelStyle;
  final double labelFontSize;
  final Icon? suffixIcon;
  final Widget? suffix;
  final IconData? prefixIcon;
  final FocusNode? focusNode;
  final String? errorText;

  final String? Function(String?)? validator;
  // final bool Function(String)? validator;
  final ValueChanged<String>? onChanged;

  HRManageTextFieldEmail({
    Key? key,
    required this.controller,
    required this.keyboardType,
    required this.text,
    this.textColor = const Color(0xff686464),
    this.icon,
    this.onChange,
    this.readOnly,
    this.width,
    this.height,
    required this.cursorHeight,
    this.labelText,
    required this.labelStyle,
    required this.labelFontSize,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode,
    this.errorText,
    this.onChanged,
    this.validator,
    this.suffix, this.hintText,
    // this.validator,
  }) : super(key: key);

  @override
  State<HRManageTextFieldEmail> createState() => _HRManageTextFieldEmailState();
}

class _HRManageTextFieldEmailState extends State<HRManageTextFieldEmail> {
  late bool hasError;

  @override
  void initState() {
    super.initState();
    hasError = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 320,
      height: widget.height ?? 35,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p5),
        child: TextFormField(
          focusNode: widget.focusNode,
          controller: widget.controller,
          textAlign: TextAlign.start,
          style: TextStyle(color: widget.textColor, fontWeight: FontWeight.w500, fontSize: 10),
          textAlignVertical: TextAlignVertical.center,
          cursorColor: ColorManager.black,
          textInputAction: TextInputAction.next,
          // cursorHeight: widget.cursorHeight,
          // validator: validator,
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return 'This field cannot be empty';
          //   }
          //   return null;
          // },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
                bottom: AppPadding.p3, top: AppPadding.p5, left: AppPadding.p5),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.containerBorderGrey),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.containerBorderGrey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorManager.containerBorderGrey),
            ),
            labelText: widget.labelText,
            hintText: widget.hintText,
            labelStyle: widget.labelStyle.copyWith(
                fontSize: widget.labelFontSize, color: ColorManager.mediumgrey),
            errorText: hasError ? widget.errorText : null,
            suffixIcon: Padding(
              padding: const EdgeInsets.only(left: AppPadding.p14),
              child: widget.suffixIcon,
            ),
            suffix: Padding(
              padding: const EdgeInsets.only(left: AppPadding.p20),
              child: widget.suffix,
            ),
          ),
        ),
      ),
    );
  }
}
///

class HRManageTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String text;
  final String? hintText;
  final Color textColor;
  final Icon? icon;
  final bool? readOnly;
  final VoidCallback? onChange;
  final double? width;
  final double? height;
  final double cursorHeight;
  final String? labelText;
  final TextStyle? labelStyle;
  final double labelFontSize;
  final Icon? suffixIcon;
  final IconData? prefixIcon;
  final FocusNode? focusNode;
  final String? errorText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final bool? enabled;
  final bool showDatePicker;

  HRManageTextField({
    Key? key,
    this.enabled,
    required this.controller,
    required this.keyboardType,
    required this.text,
    this.textColor = const Color(0xff686464),
    this.icon,
    this.onChange,
    this.readOnly,
    this.width,
    this.height,
    required this.cursorHeight,
    this.labelText,
    this.labelStyle,
    required this.labelFontSize,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode,
    this.errorText,
    this.onChanged,
    this.validator,  this.showDatePicker = false,  this.hintText ,
  }) : super(key: key);

  @override
  State<HRManageTextField> createState() => _HRManageTextFieldState();
}

class _HRManageTextFieldState extends State<HRManageTextField> {
  late bool hasError;

  @override
  void initState() {
    super.initState();
    hasError = false;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      widget.controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 320,
      height: widget.height ?? 35,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextFormField(
          enabled: widget.enabled ?? true,
          focusNode: widget.focusNode,
          controller: widget.controller,
          textAlign: TextAlign.start,
          style: TextStyle(color: widget.textColor, fontWeight: FontWeight.w500, fontSize: FontSize.s12),
          textAlignVertical: TextAlignVertical.center,
          cursorColor: Colors.black,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
                bottom: 3.0,
                top: 5.0,
                left: 5.0
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            labelText: widget.labelText,
            hintText: widget.hintText,
            labelStyle: widget.labelStyle?.copyWith(
              fontSize: widget.labelFontSize,
              color: Colors.grey,
            ),
            errorText: hasError ? widget.errorText : null,
            suffixIcon: widget.showDatePicker
                ? GestureDetector(
              onTap: () => _selectDate(context),
              child: Icon(Icons.calendar_month_outlined),
            )
                : widget.suffixIcon,
          ),
          inputFormatters: [
            CapitalizeFirstLetterFormatter(),
          ],
          onChanged: widget.onChanged,
          validator: widget.validator,
        ),
      ),
    );
  }
}

///drop down User
class HRManageDropdown extends StatefulWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final Color textColor;
  final TextStyle? labelStyle;
  final double labelFontSize;
  final List<String> items;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final double? width;
  final double? height;

  HRManageDropdown({
    Key? key,
    required this.controller,
    this.labelText,
    this.labelStyle,
    required this.labelFontSize,
    required this.items,
    this.errorText,
    this.width,
    this.height,
    this.onChanged,  this.hintText,   this.textColor = const  Color(0xff686464),
  }) : super(key: key);

  @override
  State<HRManageDropdown> createState() => _HRManageDropdownState();
}

class _HRManageDropdownState extends State<HRManageDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 320,
      height: widget.height ?? 35,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: DropdownButtonFormField<String>(
          value: widget.controller.text.isEmpty ? null : widget.controller.text,
          items: widget.items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: TextStyle(color: widget.textColor, fontWeight: FontWeight.w500, fontSize: FontSize.s12),

                // TextStyle(
                //   fontSize: MediaQuery.of(context).size.width / 130,
                //   color: Color(0xff686464),
                // ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              widget.controller.text = value!;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(value!);
            }
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
                bottom: 3.0, left: 5.0),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            hintStyle: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: ColorManager.mediumgrey
            ),
            labelText: widget.labelText,
            hintText: widget.hintText,
            labelStyle: TextStyle(
                fontSize: widget.labelFontSize,
                fontWeight: FontWeight.w700,
                color: ColorManager.mediumgrey),

            // errorText: widget.errorText,
            // validator: validator,
          ),
        ),
      ),
    );
  }
}
///
class HRUManageDropdown extends StatefulWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final Color textColor;
  final TextStyle? labelStyle;
  final double labelFontSize;
  final List<String> items;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  HRUManageDropdown({
    Key? key,
    required this.controller,
    this.labelText,
    this.labelStyle,
    required this.labelFontSize,
    required this.items,
    this.errorText,
    this.onChanged,
    this.hintText,
    this.textColor = const Color(0xff686464),
  }) : super(key: key);

  @override
  State<HRUManageDropdown> createState() => _HRUManageDropdownState();
}

class _HRUManageDropdownState extends State<HRUManageDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 354,
      height: 30,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
            color: ColorManager.containerBorderGrey, width: AppSize.s1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonFormField<String>(
          isDense: true, // Makes the dropdown more compact
          icon: Icon(Icons.arrow_drop_down,color: ColorManager.mediumgrey,size: IconSize.I18,),
          // Default dropdown icon
          iconSize: 15, // Icon size
          value: widget.controller.text.isEmpty ? null : widget.controller.text,
          items: widget.items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                    color: widget.textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: FontSize.s12),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              widget.controller.text = value!;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(value!);
            }
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(bottom: 20),
            hintStyle:  DocumentTypeDataStyle.customTextStyle(context),)
      ),
    );
  }
}

///dropdown user saloni
// class HRUManageDropdown extends StatefulWidget {
//   final TextEditingController controller;
//    final String? labelText;
//   final String? hintText;
//   final Color textColor;
//   final TextStyle? labelStyle;
//   final double labelFontSize;
//   final List<String> items;
//   final String? errorText;
//   final ValueChanged<String>? onChanged;
//
//   HRUManageDropdown({
//     Key? key,
//     required this.controller,
//       this.labelText,
//      this.labelStyle,
//     required this.labelFontSize,
//     required this.items,
//     this.errorText,
//     this.onChanged,  this.hintText,   this.textColor = const  Color(0xff686464),
//   }) : super(key: key);
//
//   @override
//   State<HRUManageDropdown> createState() => _HRUManageDropdownState();
// }
//
// class _HRUManageDropdownState extends State<HRUManageDropdown> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width:354,
//       height:30,
//       padding: EdgeInsets.symmetric(horizontal: 10,),
//       decoration: BoxDecoration(
//         border: Border.all(
//             color: ColorManager.containerBorderGrey, width: AppSize.s1),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: DropdownButtonFormField<String>(
//
//         padding: EdgeInsets.symmetric(horizontal: 10,),
//         value: widget.controller.text.isEmpty ? null : widget.controller.text,
//         items: widget.items.map((item) {
//           return DropdownMenuItem(
//
//             value: item,
//             child: Text(
//               item,
//               style: TextStyle(color: widget.textColor, fontWeight: FontWeight.w500, fontSize: 10),
//             ),
//           );
//         }).toList(),
//         onChanged: (value) {
//           setState(() {
//             widget.controller.text = value!;
//           });
//           if (widget.onChanged != null) {
//             widget.onChanged!(value!);
//           }
//         },
//         decoration: InputDecoration(
//           border: InputBorder.none,
//           contentPadding: EdgeInsets.only(bottom: 20.0),
//           // border: OutlineInputBorder(
//           //   borderSide: BorderSide(color: Colors.black),
//           // ),
//           // focusedBorder: OutlineInputBorder(
//           //   borderSide: BorderSide(color: Colors.black),
//           // ),
//           hintStyle: TextStyle(
//             fontSize: 10,
//             fontWeight: FontWeight.w500,
//             color: ColorManager.mediumgrey
//           ),
//           // labelText: widget.labelText,
//           hintText: widget.hintText,
//           // labelStyle: TextStyle(
//           //     fontSize: widget.labelFontSize,
//           //     fontWeight: FontWeight.w700,
//           //     color: ColorManager.mediumgrey),
//
//           // errorText: widget.errorText,
//           // validator: validator,
//         ),
//       ),
//     );
//   }
// }

///
class PatientCustomDropDown extends StatefulWidget {
  final String? value;
  final List<String> items;
  final String labelText;
  final String? hintText;
  final TextStyle? labelStyle;
  final double? labelFontSize;
  final void Function(String?)? onChanged;
  final double? width;
  final double? height;
  final String? initialValue;
  PatientCustomDropDown({
    super.key,
    this.value,
    required this.items,
    required this.labelText,
    this.labelStyle,
    this.labelFontSize,
    this.onChanged,
    this.width,
    this.height,
    this.initialValue,
    this.hintText,
  });

  @override
  State<PatientCustomDropDown> createState() => _PatientCustomDropDownState();
}

class _PatientCustomDropDownState extends State<PatientCustomDropDown> {
  late String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: const Color(0xff686464).withOpacity(0.5),
            width: 1), // Black border
        borderRadius: BorderRadius.circular(6), // Rounded corners
      ),
      height: 31,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
      child: DropdownButtonFormField<String>(
          icon: Icon(Icons.arrow_drop_down_sharp, color: ColorManager.black),
          value: _selectedValue,
          items: widget.items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: SearchDropdownConst.customTextStyle(context),
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _selectedValue = newValue;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(newValue);
            }
          },
          style: SearchDropdownConst.customTextStyle(context),
          isExpanded: true,
          decoration: const InputDecoration.collapsed(hintText: '')),
    );
  }
}







///////////////


class CustomDropdownTextFieldpp<T> extends StatefulWidget {
  final T? value; // Changed to generic type
  final List<T>? items; // Changed to generic type
  final String Function(T)? itemLabel; // Function to get the label from the item
  final String headText;
  final void Function(T?)? onChanged;
  final double? width;
  final double? height;
  final T? initialValue;

  const CustomDropdownTextFieldpp({
    Key? key,
    required this.headText,
    this.value,
    this.items,
    required this.itemLabel,
    this.onChanged,
    this.width,
    this.height,
    this.initialValue,
  }) : super(key: key);

  @override
  _CustomDropdownTextFieldppState<T> createState() =>
      _CustomDropdownTextFieldppState<T>();
}

class _CustomDropdownTextFieldppState<T>
    extends State<CustomDropdownTextFieldpp<T>> {
  late T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue ?? widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(
            widget.headText,
            style: AllPopupHeadings.customTextStyle(context),
          ),
        ),
        SizedBox(
          width: widget.width ?? AppSize.s250,
          height: widget.height ?? AppSize.s40,
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p5),
            child: DropdownButtonFormField<T>(
              icon: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Icon(Icons.arrow_drop_down_sharp, color: ColorManager.mediumgrey),
              ),
              value: _selectedValue,
              items: _buildDropdownMenuItems(),
              onChanged: (newValue) {
                setState(() {
                  _selectedValue = newValue;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(newValue);
                }
              },
              isExpanded: true,
              decoration: InputDecoration(
                hoverColor: ColorManager.white,
                contentPadding: EdgeInsets.only(
                  bottom: AppPadding.p3,
                  top: AppPadding.p5,
                  left: 4,
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorManager.black),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Build dropdown items based on the items provided
  List<DropdownMenuItem<T>> _buildDropdownMenuItems() {
    if (widget.items == null || widget.items!.isEmpty) return [];

    return widget.items!.map((T item) {
      return DropdownMenuItem<T>(
        value: item,
        child: Text(
          widget.itemLabel!(item), // Use the itemLabel function to get the display text
          style: DocumentTypeDataStyle.customTextStyle(context),
        ),
      );
    }).toList();
  }
}
