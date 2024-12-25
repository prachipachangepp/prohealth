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
          child: RichText(
            text: TextSpan(
              text: text, // Main text
              style: AllPopupHeadings.customTextStyle(context), // Main style
              children: [
                TextSpan(
                  text: ' *', // Asterisk
                  style: AllPopupHeadings.customTextStyle(context).copyWith(
                    color: ColorManager.red, // Asterisk color
                  ),
                ),
              ],
            ),
          ),
          //Text(text,style: AllPopupHeadings.customTextStyle(context),),
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
// class CustomDropdownTextField extends StatefulWidget {
//   final String? value;
//   final List<String>? items;
//   final List<DropdownMenuItem<String>>? dropDownMenuList;
//   final String? hintText;
//   final String headText;
//   final void Function(String?)? onChanged;
//   final double? width;
//   final double? height;
//   final String? initialValue;
//
//   const CustomDropdownTextField({
//     Key? key,
//     this.dropDownMenuList,
//     required this.headText,
//     this.value,
//     this.items,
//     this.onChanged,
//     this.width,
//     this.height,
//     this.initialValue,
//     this.hintText,
//   }) : super(key: key);
//
//   @override
//   _CustomDropdownTextFieldState createState() =>
//       _CustomDropdownTextFieldState();
// }
//
// class _CustomDropdownTextFieldState extends State<CustomDropdownTextField> {
//   late String? _selectedValue;
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedValue = widget.value;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 5.0,bottom: 2),
//           child: Text(widget.headText,style: AllPopupHeadings.customTextStyle(context),),
//         ),
//         SizedBox(
//           width: AppSize.s250,
//           height: AppSize.s40,
//           child: Padding(
//             padding: const EdgeInsets.all(AppPadding.p5),
//             child: DropdownButtonFormField<String>(
//               icon:
//               Padding(
//                 padding: const EdgeInsets.only(right: 5),
//                 child: Icon(Icons.arrow_drop_down_sharp, color: ColorManager.mediumgrey),
//               ),
//               value: _selectedValue,
//               items: widget.dropDownMenuList == null
//                   ? widget.items!.map((String value) {
//                 return DropdownMenuItem<String>(
//
//                   value: value,
//                   child: Text(
//                     value,
//                     style:DocumentTypeDataStyle.customTextStyle(context),
//                   ),
//                 );
//               }).toList()
//                   : widget.dropDownMenuList,
//               onChanged: (newValue) {
//                 setState(() {
//                   _selectedValue = newValue;
//                 });
//                 if (widget.onChanged != null) {
//                   widget.onChanged!(newValue);
//                 }
//               },
//               isExpanded: true,
//               decoration: InputDecoration(
//                 hoverColor: ColorManager.white,
//                 contentPadding: EdgeInsets.only(
//                     bottom: AppPadding.p3, top: AppPadding.p5, left: 4),
//                 border: OutlineInputBorder(),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: ColorManager.black),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class CustomDropdownTextField extends StatefulWidget {
  final String? value;
  final List<String>? items;
  final List<DropdownMenuItem<String>>? dropDownMenuList;
  final String? hintText;
  final String headText;
  final void Function(String?)? onChanged;
  final double? width;
  final double? height;
  final double? fontsize;
  final String? initialValue;
   final bool? isAstric;
   final IconData? icon;
   final Color? iconColor;

   CustomDropdownTextField({
    Key? key,
    this.isAstric = true,
    this.dropDownMenuList,
    required this.headText,
    this.value,
    this.items,
    this.onChanged,
    this.width,
    this.height,
    this.initialValue,
    this.hintText, this.fontsize, this.icon, this.iconColor,
  }) : super(key: key);

  @override
  _CustomDropdownTextFieldState createState() =>
      _CustomDropdownTextFieldState();
}

class _CustomDropdownTextFieldState extends State<CustomDropdownTextField> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value ?? widget.initialValue;
  }

  void _showDropdownDialog() async {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final result = await showDialog<String>(
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
                    maxHeight: 250, // Restrict height for scroll
                  ),
                  child: Scrollbar(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.items?.length ?? widget.dropDownMenuList?.length ?? 0,
                      itemBuilder: (context, index) {
                        final item = widget.items != null
                            ? widget.items![index]
                            : widget.dropDownMenuList![index].value;
                        return ListTile(
                          title: Text(
                            item!,
                            style: DocumentTypeDataStyle.customTextStyle(context),
                          ),
                          onTap: () {
                            Navigator.of(context).pop(item);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        _selectedValue = result;
        widget.onChanged?.call(result);
      });
    }
  }

  // void _showDropdownDialog() {
  //   final RenderBox renderBox = context.findRenderObject() as RenderBox;
  //   final offset = renderBox.localToGlobal(Offset.zero);
  //   final size = renderBox.size;
  //
  //   showDialog(
  //     context: context,
  //     barrierColor: Colors.transparent,
  //     builder: (BuildContext context) {
  //       return Stack(
  //         children: [
  //           Positioned(
  //             left: offset.dx,
  //             top: offset.dy + size.height,
  //             child: Material(
  //               elevation: 4,
  //               borderRadius: BorderRadius.circular(4),
  //               child: Container(
  //                 width: widget.width ?? size.width,
  //                 constraints: BoxConstraints(
  //                   maxHeight: 250, // Limit height for scrolling
  //                 ),
  //                 child: Scrollbar(
  //                   child: ListView.builder(
  //
  //                     shrinkWrap: true,
  //                     children: widget.dropDownMenuList!.map((DropdownMenuItem<String> item) {
  //                       return ListTile(
  //                         title: Text(
  //                           item.value ?? '',
  //                           style: DocumentTypeDataStyle.customTextStyle(context),
  //                         ),
  //                         onTap: () {
  //                           setState(() {
  //                             _selectedValue = item.value;
  //                             widget.onChanged?.call(item.value!);
  //                           });
  //                           Navigator.pop(context);
  //                         },
  //                       );
  //                     }).toList(),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.isAstric!?Padding(
          padding: const EdgeInsets.only(left: 5.0, bottom: 2),
          child: RichText(
            text: TextSpan(
              text: widget.isAstric!?widget.headText:"", // Main text
              style: AllPopupHeadings.customTextStyle(context), // Main style
              children: [
                widget.isAstric!? TextSpan(
                  text: ' *', // Asterisk
                  style: AllPopupHeadings.customTextStyle(context).copyWith(
                    color: ColorManager.red, // Asterisk color
                  ),
                ):TextSpan(
                  text: ' ', // Asterisk
                )
              ],
            ),
          ),
          // Text(
          //   widget.headText,
          //   style: AllPopupHeadings.customTextStyle(context),
          // ),
        )
            :Offstage(),
        SizedBox(
          width: widget.isAstric!?AppSize.s250:widget.width,
          height: AppSize.s40,
          child: GestureDetector(
            onTap: _showDropdownDialog,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                padding: const EdgeInsets.only(bottom: 3, top: 5, left: 4),
                decoration:widget.isAstric!? BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ):BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedValue ?? widget.hintText ?? 'Select',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: widget.fontsize ?? FontSize.s13,
                        color: ColorManager.mediumgrey,
                        decoration: TextDecoration.none,
                      ) //DocumentTypeDataStyle.customTextStyle(context),
                    ),
                    Icon(widget.icon ?? Icons.arrow_drop_down_sharp, color: widget.iconColor ?? Colors.grey),
                  ],
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
          child: RichText(
            text: TextSpan(
              text: text, // Main text
              style: AllPopupHeadings.customTextStyle(context), // Main style
              children: [
                TextSpan(
                  text: ' *', // Asterisk
                  style: AllPopupHeadings.customTextStyle(context).copyWith(
                    color: ColorManager.red, // Asterisk color
                  ),
                ),
              ],
            ),
          ),
          //Text(text,style: AllPopupHeadings.customTextStyle(context),),
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



class CustomDropdownTextFieldwidh extends StatefulWidget
{
  final String? value;
  final List<String>? items;
  final List<DropdownMenuItem<String>>? dropDownMenuList;
  final String? hintText;

  final void Function(String?)? onChanged;
  final double? width;
  final double? widthone;
  final double? height;
  final String? initialValue;

  const CustomDropdownTextFieldwidh({
    Key? key,
    this.dropDownMenuList,

    this.value,
    this.items,
    this.onChanged,
    this.width,
    this.widthone,
    this.height,
    this.initialValue,
    this.hintText,
  }) : super(key: key);

  @override
  _CustomDropdownTextFieldwidhState createState() =>
      _CustomDropdownTextFieldwidhState();
}

class _CustomDropdownTextFieldwidhState extends State<CustomDropdownTextFieldwidh> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value ?? widget.initialValue;
  }

  void _showDropdownDialog() async {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final result = await showDialog<String>(
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
                    maxHeight: 250, // Restrict height for scroll
                  ),
                  child: Scrollbar(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.items?.length ?? widget.dropDownMenuList?.length ?? 0,
                      itemBuilder: (context, index) {
                        final item = widget.items != null
                            ? widget.items![index]
                            : widget.dropDownMenuList![index].value;
                        return ListTile(
                          title: Text(
                            item!,
                            style: DocumentTypeDataStyle.customTextStyle(context),
                          ),
                          onTap: () {
                            Navigator.of(context).pop(item);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        _selectedValue = result;
        widget.onChanged?.call(result);
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
         // width: widget.widthone,
          height:widget.height ?? AppSize.s30,
          child: GestureDetector(
            onTap: _showDropdownDialog,
            child: Container(
             padding: const EdgeInsets.only(bottom: 3, top: 5, left: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedValue ?? widget.hintText ?? 'Select',
                    style: DocumentTypeDataStyle.customTextStyle(context),
                  ),
                  Icon(Icons.arrow_drop_down_sharp, color: Colors.grey),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

///
class CustomDropdownEMDashboard extends StatefulWidget {
  final String? value;
  final List<String>? items;
  final List<DropdownMenuItem<String>>? dropDownMenuList;
  final String? hintText;

  final void Function(String?)? onChanged;
  final double? width;
  final double? widthone;
  final double? height;
  final String? initialValue;
  const CustomDropdownEMDashboard({
    Key? key,
    this.dropDownMenuList,

    this.value,
    this.items,
    this.onChanged,
    this.width,
    this.widthone,
    this.height,
    this.initialValue,
    this.hintText,
  }) : super(key: key);

  @override
  State<CustomDropdownEMDashboard> createState() => _CustomDropdownEMDashboardState();
}

class _CustomDropdownEMDashboardState extends State<CustomDropdownEMDashboard> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value ?? widget.initialValue;
  }

  void _showDropdownDialog() async {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final result = await showDialog<String>(
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
                    maxHeight: 250, // Restrict height for scroll
                  ),
                  child: Scrollbar(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.items?.length ?? widget.dropDownMenuList?.length ?? 0,
                      itemBuilder: (context, index) {
                        final item = widget.items != null
                            ? widget.items![index]
                            : widget.dropDownMenuList![index].value;
                        return ListTile(
                          title: Text(
                            item!,
                            style: DocumentTypeDataStyle.customTextStyle(context),
                          ),
                          onTap: () {
                            Navigator.of(context).pop(item);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        _selectedValue = result;
        widget.onChanged?.call(result);
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          // width: widget.widthone,
          height:widget.height ?? AppSize.s25,
          child: GestureDetector(
            onTap: _showDropdownDialog,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p5),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFC9C9C9), width: 0.86),
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.transparent, // Ensure opacity 0 effect
                ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedValue ?? widget.hintText ?? 'Select',
                    style: DocumentTypeDataStyle.customTextStyle(context),
                  ),
                  Icon(Icons.arrow_drop_down_sharp, color: Colors.grey),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}





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
// class HRManageTextFieldEmail extends StatefulWidget {
//   final TextEditingController controller;
//   final TextInputType keyboardType;
//   final String text;
//   final Color textColor;
//   final Icon? icon;
//   final bool? readOnly;
//   final VoidCallback? onChange;
//   final double? width;
//   final double? height;
//   final double cursorHeight;
//   final String? labelText;
//   final String? hintText;
//   final TextStyle labelStyle;
//   final double labelFontSize;
//   final Icon? suffixIcon;
//   final Widget? suffix;
//   final IconData? prefixIcon;
//   final FocusNode? focusNode;
//   final String? errorText;
//
//   final String? Function(String?)? validator;
//   // final bool Function(String)? validator;
//   final ValueChanged<String>? onChanged;
//
//   HRManageTextFieldEmail({
//     Key? key,
//     required this.controller,
//     required this.keyboardType,
//     required this.text,
//     this.textColor = const Color(0xff686464),
//     this.icon,
//     this.onChange,
//     this.readOnly,
//     this.width,
//     this.height,
//     required this.cursorHeight,
//     this.labelText,
//     required this.labelStyle,
//     required this.labelFontSize,
//     this.suffixIcon,
//     this.prefixIcon,
//     this.focusNode,
//     this.errorText,
//     this.onChanged,
//     this.validator,
//     this.suffix, this.hintText,
//     // this.validator,
//   }) : super(key: key);
//
//   @override
//   State<HRManageTextFieldEmail> createState() => _HRManageTextFieldEmailState();
// }
//
// class _HRManageTextFieldEmailState extends State<HRManageTextFieldEmail> {
//   late bool hasError;
//
//   @override
//   void initState() {
//     super.initState();
//     hasError = false;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: widget.width ?? 320,
//       height: widget.height ?? 35,
//       child: Padding(
//         padding: const EdgeInsets.all(AppPadding.p5),
//         child: TextFormField(
//           focusNode: widget.focusNode,
//           controller: widget.controller,
//           textAlign: TextAlign.start,
//           style: TextStyle(color: widget.textColor, fontWeight: FontWeight.w500, fontSize: 10),
//           textAlignVertical: TextAlignVertical.center,
//           cursorColor: ColorManager.black,
//           textInputAction: TextInputAction.next,
//           // cursorHeight: widget.cursorHeight,
//           // validator: validator,
//           // validator: (value) {
//           //   if (value == null || value.isEmpty) {
//           //     return 'This field cannot be empty';
//           //   }
//           //   return null;
//           // },
//           decoration: InputDecoration(
//             contentPadding: EdgeInsets.only(
//                 bottom: AppPadding.p3, top: AppPadding.p5, left: AppPadding.p5),
//             border: OutlineInputBorder(
//               borderSide: BorderSide(color: ColorManager.containerBorderGrey),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: ColorManager.containerBorderGrey),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: ColorManager.containerBorderGrey),
//             ),
//             labelText: widget.labelText,
//             hintText: widget.hintText,
//             labelStyle: widget.labelStyle.copyWith(
//                 fontSize: widget.labelFontSize, color: ColorManager.mediumgrey),
//             errorText: hasError ? widget.errorText : null,
//             suffixIcon: Padding(
//               padding: const EdgeInsets.only(left: AppPadding.p14),
//               child: widget.suffixIcon,
//             ),
//             suffix: Padding(
//               padding: const EdgeInsets.only(left: AppPadding.p20),
//               child: widget.suffix,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// ///
///
// class HRManageTextField extends StatefulWidget {
//   final TextEditingController controller;
//   final TextInputType keyboardType;
//   final String text;
//   final String? hintText;
//   final Color textColor;
//   final Icon? icon;
//   final bool? readOnly;
//   final VoidCallback? onChange;
//   final double? width;
//   final double? height;
//   final double cursorHeight;
//   final String? labelText;
//   final TextStyle? labelStyle;
//   final double labelFontSize;
//   final Icon? suffixIcon;
//   final IconData? prefixIcon;
//   final FocusNode? focusNode;
//   final String? errorText;
//   final String? Function(String?)? validator;
//   final ValueChanged<String>? onChanged;
//   final bool? enabled;
//   final bool showDatePicker;
//
//   HRManageTextField({
//     Key? key,
//     this.enabled,
//     required this.controller,
//     required this.keyboardType,
//     required this.text,
//     this.textColor = const Color(0xff686464),
//     this.icon,
//     this.onChange,
//     this.readOnly,
//     this.width,
//     this.height,
//     required this.cursorHeight,
//     this.labelText,
//     this.labelStyle,
//     required this.labelFontSize,
//     this.suffixIcon,
//     this.prefixIcon,
//     this.focusNode,
//     this.errorText,
//     this.onChanged,
//     this.validator,  this.showDatePicker = false,  this.hintText ,
//   }) : super(key: key);
//
//   @override
//   State<HRManageTextField> createState() => _HRManageTextFieldState();
// }
//
// class _HRManageTextFieldState extends State<HRManageTextField> {
//   late bool hasError;
//
//   @override
//   void initState() {
//     super.initState();
//     hasError = false;
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );
//     if (pickedDate != null) {
//       widget.controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: widget.width ?? 320,
//       height: widget.height ?? 35,
//       child: Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: TextFormField(
//           enabled: widget.enabled ?? true,
//           focusNode: widget.focusNode,
//           controller: widget.controller,
//           textAlign: TextAlign.start,
//           style: TextStyle(color: widget.textColor, fontWeight: FontWeight.w500, fontSize: FontSize.s12),
//           textAlignVertical: TextAlignVertical.center,
//           cursorColor: Colors.black,
//           textInputAction: TextInputAction.next,
//           decoration: InputDecoration(
//             contentPadding: EdgeInsets.only(
//                 bottom: 3.0,
//                 top: 5.0,
//                 left: 5.0
//             ),
//             border: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey),
//             ),
//             labelText: widget.labelText,
//             hintText: widget.hintText,
//             labelStyle: widget.labelStyle?.copyWith(
//               fontSize: widget.labelFontSize,
//               color: Colors.grey,
//             ),
//             errorText: hasError ? widget.errorText : null,
//             suffixIcon: widget.showDatePicker
//                 ? GestureDetector(
//               onTap: () => _selectDate(context),
//               child: Icon(Icons.calendar_month_outlined),
//             )
//                 : widget.suffixIcon,
//           ),
//           inputFormatters: [
//             CapitalizeFirstLetterFormatter(),
//           ],
//           onChanged: widget.onChanged,
//           validator: widget.validator,
//         ),
//       ),
//     );
//   }
// }

///drop down User
// class HRManageDropdown extends StatefulWidget {
//   final TextEditingController controller;
//   final String? labelText;
//   final String? hintText;
//   final Color textColor;
//   final TextStyle? labelStyle;
//   final double labelFontSize;
//   final List<String> items;
//   final String? errorText;
//   final ValueChanged<String>? onChanged;
//   final double? width;
//   final double? height;
//
//   HRManageDropdown({
//     Key? key,
//     required this.controller,
//     this.labelText,
//     this.labelStyle,
//     required this.labelFontSize,
//     required this.items,
//     this.errorText,
//     this.width,
//     this.height,
//     this.onChanged,  this.hintText,   this.textColor = const  Color(0xff686464),
//   }) : super(key: key);
//
//   @override
//   State<HRManageDropdown> createState() => _HRManageDropdownState();
// }
//
// class _HRManageDropdownState extends State<HRManageDropdown> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: widget.width ?? 320,
//       height: widget.height ?? 35,
//       child: Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: DropdownButtonFormField<String>(
//           value: widget.controller.text.isEmpty ? null : widget.controller.text,
//           items: widget.items.map((item) {
//             return DropdownMenuItem(
//               value: item,
//               child: Text(
//                 item,
//                 style: TextStyle(color: widget.textColor, fontWeight: FontWeight.w500, fontSize: FontSize.s12),
//
//                 // TextStyle(
//                 //   fontSize: MediaQuery.of(context).size.width / 130,
//                 //   color: Color(0xff686464),
//                 // ),
//               ),
//             );
//           }).toList(),
//           onChanged: (value) {
//             setState(() {
//               widget.controller.text = value!;
//             });
//             if (widget.onChanged != null) {
//               widget.onChanged!(value!);
//             }
//           },
//           decoration: InputDecoration(
//             contentPadding: EdgeInsets.only(
//                 bottom: 3.0, left: 5.0),
//             border: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.black),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.black),
//             ),
//             hintStyle: TextStyle(
//                 fontSize: 10,
//                 fontWeight: FontWeight.w500,
//                 color: ColorManager.mediumgrey
//             ),
//             labelText: widget.labelText,
//             hintText: widget.hintText,
//             labelStyle: TextStyle(
//                 fontSize: widget.labelFontSize,
//                 fontWeight: FontWeight.w700,
//                 color: ColorManager.mediumgrey),
//
//             // errorText: widget.errorText,
//             // validator: validator,
//           ),
//         ),
//       ),
//     );
//   }
// }
///
// class HRUManageDropdown extends StatefulWidget {
//   final TextEditingController controller;
//   final String? labelText;
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
//     this.labelText,
//     this.labelStyle,
//     required this.labelFontSize,
//     required this.items,
//     this.errorText,
//     this.onChanged,
//     this.hintText,
//     this.textColor = const Color(0xff686464),
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
//       width: 354,
//       height: 30,
//       padding: EdgeInsets.symmetric(horizontal: 10),
//       decoration: BoxDecoration(
//         border: Border.all(
//             color: ColorManager.containerBorderGrey, width: AppSize.s1),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: DropdownButtonFormField<String>(
//           isDense: true, // Makes the dropdown more compact
//           icon: Icon(Icons.arrow_drop_down,color: ColorManager.mediumgrey,size: IconSize.I18,),
//           // Default dropdown icon
//           style: TableSubHeading.customTextStyle(context),
//           iconSize: 15, // Icon size
//           value: widget.controller.text.isEmpty ? null : widget.controller.text,
//           items: widget.items.map((item) {
//             return DropdownMenuItem(
//               value: item,
//               child: Text(
//                 item,
//                 style: TableSubHeading.customTextStyle(context),
//               ),
//             );
//           }).toList(),
//           onChanged: (value) {
//             setState(() {
//               widget.controller.text = value!;
//             });
//             if (widget.onChanged != null) {
//               widget.onChanged!(value!);
//             }
//           },
//           decoration: InputDecoration(
//             border: InputBorder.none,
//             contentPadding: EdgeInsets.only(bottom: 20),
//             hintStyle:  TableSubHeading.customTextStyle(context),)
//       ),
//     );
//   }
// }

class HRUManageDropdown extends StatefulWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final Color textColor;
 // final TextStyle? labelStyle;
  final double labelFontSize;
  final List<String> items;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  HRUManageDropdown({
    Key? key,
    required this.controller,
    this.labelText,
    //this.labelStyle,
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
  final GlobalKey _dropdownKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  bool _isDropdownOpen = false;

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    final RenderBox renderBox = _dropdownKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: _closeDropdown,
          child: Stack(
            children: [
              Positioned(
                left: offset.dx,
                top: offset.dy + size.height,
                width: size.width,
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    //color: Colors.white,
                    constraints: BoxConstraints(
                      maxHeight: 200, // Show scroll for more than 5 items
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: widget.items.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            widget.items[index],
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.s13,
                              color: ColorManager.mediumgrey,
                              decoration: TextDecoration.none,
                            ),
                            //style:TableSubHeading.customTextStyle(context),
                          ),
                          onTap: () {
                            setState(() {
                              widget.controller.text = widget.items[index];
                              _closeDropdown();
                            });
                            if (widget.onChanged != null) {
                              widget.onChanged!(widget.items[index]);
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    Overlay.of(context)?.insert(_overlayEntry!);
    setState(() {
      _isDropdownOpen = true;
    });
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isDropdownOpen = false;
    });
  }

  @override
  void dispose() {
    _closeDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleDropdown,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.labelText != null)
            Text(
              widget.labelText!,
            //  style: widget.labelStyle ?? TextStyle(fontSize: widget.labelFontSize),
               style:TableSubHeading.customTextStyle(context),
            ),
          Container(
            key: _dropdownKey,
            width: 354,
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.controller.text.isEmpty ? widget.hintText ?? '' : widget.controller.text,
                  style: TableSubHeading.customTextStyle(context),
                ),
                Icon(Icons.arrow_drop_down, color: Colors.grey),
              ],
            ),
          ),
          if (widget.errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                widget.errorText!,
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
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

///clinical ropdown
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
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
      child: DropdownButtonFormField<String>(
          icon: Icon(Icons.arrow_drop_down_sharp, color: ColorManager.mediumgrey,),
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







/////////////

///dont delete it is perfectly fine working dropdown code
// class PatientCustomDropDown extends StatefulWidget {
//   final String? value;
//   final List<String> items;
//   final String labelText;
//   final String? hintText;
//  // final TextStyle? labelStyle;
//   final double? labelFontSize;
//   final void Function(String?)? onChanged;
//   final double? width;
//   final double? height;
//   final String? initialValue;
//
//   const PatientCustomDropDown({
//     super.key,
//     this.value,
//     required this.items,
//     required this.labelText,
//    // this.labelStyle,
//     this.labelFontSize,
//     this.onChanged,
//     this.width,
//     this.height,
//     this.initialValue,
//     this.hintText,
//   });
//
//   @override
//   State<PatientCustomDropDown> createState() => _PatientCustomDropDownState();
// }
//
// class _PatientCustomDropDownState extends State<PatientCustomDropDown> {
//   late String? _selectedValue;
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedValue = widget.value;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<String>(
//         value: _selectedValue,
//         hint: Text(
//           widget.hintText ?? '',
//           style: SearchDropdownConst.customTextStyle(context),
//         ),
//         items: widget.items.map((String value) {
//           return DropdownMenuItem<String>(
//             value: value,
//             child: Text(
//               value,
//               style: SearchDropdownConst.customTextStyle(context),
//             ),
//           );
//         }).toList(),
//         onChanged: (newValue) {
//           setState(() {
//             _selectedValue = newValue;
//           });
//           if (widget.onChanged != null) {
//             widget.onChanged!(newValue);
//           }
//         },
//         buttonStyleData: ButtonStyleData(
//           height: widget.height ?? 30,
//           width: widget.width ?? 170,
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             border: Border.all(
//               color: const Color(0xff686464).withOpacity(0.5),
//               width: 1,
//             ),
//             borderRadius: BorderRadius.circular(6),
//           )
//         ),
//         iconStyleData: IconStyleData(
//           icon: Icon(
//             Icons.arrow_drop_down_sharp,
//             color: ColorManager.mediumgrey,
//           ),
//           iconSize: 24,
//         ),
//         dropdownStyleData: DropdownStyleData(
//           maxHeight: 200,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(6),
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }
//




///
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
