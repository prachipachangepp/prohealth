



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import 'getx_oasis.dart';

class GreenContrainerConst extends StatelessWidget {
  final double? height;
  final Widget child;
  const GreenContrainerConst({super.key, this.height, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? AppSize.s500,
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p30, vertical: AppPadding.p15),
      decoration: BoxDecoration(
        color: ColorManager.containergreen,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),  // shadow color with opacity
            spreadRadius: 0,  // spread the shadow (optional)
            blurRadius: 5,   // blur the shadow for a soft look
            offset: Offset(0, 4), // offset in the vertical direction (bottom shadow)
          ),
        ],
        // border: Border.symmetric(vertical: BorderSide(width: 0.2,color: ColorManager.grey),horizontal: BorderSide(width: 0.2,color: ColorManager.grey),),//all(width: 1, color: Color(0xFFBCBCBC)),
       // border: Border.all(width: 1,color: ColorManager.lightGrey),//all(width: 1, color: Color(0xFFBCBCBC)),

      ),
      child: child,
    );
  }
}



class WhiteContrainerConst extends StatelessWidget {
  final double? height;
  final Widget child;
  const WhiteContrainerConst({super.key, this.height, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? AppSize.s500,
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p30, vertical: AppPadding.p15),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),  // shadow color with opacity
            spreadRadius: 0,  // spread the shadow (optional)
            blurRadius: 6,   // blur the shadow for a soft look
            offset: Offset(0, 6), // offset in the vertical direction (bottom shadow)
          ),
        ],
      ),
      child: child,
    );
  }
}





class WhiteContrainerConstwidth extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget child;
  const WhiteContrainerConstwidth({super.key, this.height, required this.child, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? AppSize.s500,
      width: width ?? AppSize.s500,
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p30, vertical: AppPadding.p15),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),  // shadow color with opacity
            spreadRadius: 0,  // spread the shadow (optional)
            blurRadius: 6,   // blur the shadow for a soft look
            offset: Offset(0, 6), // offset in the vertical direction (bottom shadow)
          ),
        ],
      ),
      child: child,
    );
  }
}




class CustomCheckBoxListTile extends StatelessWidget {
  final String title;
  final RxBool isChecked; // RxBool to manage checkbox state reactively
  final Function(bool) onChanged;

  const CustomCheckBoxListTile({
    Key? key,
    required this.title,
    required this.isChecked,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Checkbox part
        Obx(() {
          return Checkbox(
            value: isChecked.value,
            onChanged: (bool? value) {
              if (value != null) {
                onChanged(value); // Call the onChanged function passed to the widget
              }
            },
            checkColor: Colors.white, // Color of the check mark
            activeColor: Color(0xff1696C8),
            side: BorderSide(color: Color(0xff1696C8), width: 2),// Set the checkbox active color
          );
        }),
        // Text part
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            title,
            style: DocumentTypeDataStyle.customTextStyle(context), // Customize the text style as needed
           // overflow: TextOverflow.ellipsis, // Prevent text overflow
          ),
        ),
        SizedBox(width: 10,)
      ],
    );
  }
}






class CustomIconButtonEMR extends StatefulWidget {
  final String text;
  final IconData? icon;
  final Color? color;
  final Color? textColor;
  final Future<void> Function() onPressed;

  CustomIconButtonEMR({
    this.textColor,
    required this.text,
    this.icon,
    required this.onPressed,
    Key? key,  this.color,
  }) : super(key: key);

  @override
  State<CustomIconButtonEMR> createState() => _CustomIconButtonEMRState();
}


class _CustomIconButtonEMRState extends State<CustomIconButtonEMR> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SizedBox(
        height:25,
        width:25,
        child: CircularProgressIndicator( color: ColorManager.blueprime,))
        :ElevatedButton.icon(
      onPressed: () async{
        await widget.onPressed();
      },
      icon: widget.icon != null
          ? Icon(widget.icon!, color: Colors.white, size: 20)
          : const SizedBox.shrink(),
      label: Text(
          widget.text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: FontSize.s14,
              fontWeight: FontWeight.w600,
              color: widget.textColor == null ?ColorManager.white:widget.textColor)),
      style: ElevatedButton.styleFrom(
          padding:  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          backgroundColor:  widget.color == null ? ColorManager.bluebottom : widget.color,
          // shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 5
      ),
    );
  }
}





class EMRTextFConst extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
 // final String text;
  final Color textColor;
  final Icon? icon;
  final bool? readOnly;
  final VoidCallback? onChange;
  //final bool? enable;
  final Widget? prefixWidget;
  final String? Function(String?)? validator;
 // final FocusNode? focusNode;
  final double? width;
  final List<TextInputFormatter>? inputFormated;
  final bool showDatePicker;
  final Icon? suffixIcon;

  EMRTextFConst({
    Key? key,
   // this.focusNode,
    required this.controller,
    required this.keyboardType,
   // required this.text,
    this.textColor = const Color(0xff686464),
    this.icon,
    this.onChange,
    this.readOnly,
   // this.enable,
    this.validator,
    this.prefixWidget,
    this.width, this.inputFormated,
    this.showDatePicker = false, this.suffixIcon,
  }) : super(key: key);

  @override
  State<EMRTextFConst> createState() => _EMRTextFConstState();
}

class _EMRTextFConstState extends State<EMRTextFConst> {
  // late TextEditingController _controller;
  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //   );
  //   if (pickedDate != null) {
  //     widget.controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    String? errorText;
    return Padding(
      padding:  const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // RichText(
          //   text: TextSpan(
          //     text: widget.text, // Main text
          //     style: AllPopupHeadings.customTextStyle(context), // Main style
          //     children: [
          //       TextSpan(
          //         text: ' *', // Asterisk
          //         style: AllPopupHeadings.customTextStyle(context).copyWith(
          //           color: ColorManager.red, // Asterisk color
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Text(
          //   widget.text,
          //   style: AllPopupHeadings.customTextStyle(context)
          //   //ConstTextFieldStyles.customTextStyle(textColor: widget.textColor),
          // ),
          // SizedBox(
          //   width: AppSize.s5,
          // ),
          Container(
            width: widget.width ?? AppSize.s354,
            height: AppSize.s30,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFB1B1B1), width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextFormField(
             // focusNode: widget.focusNode,
              //autofocus: ,
              //enabled: widget.enable == null ? true : false,
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              //cursorHeight: 17,
              cursorColor: Colors.black,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                // suffixIcon: widget.showDatePicker
                //     ? GestureDetector(
                //   onTap: () => _selectDate(context),
                //   child: Icon(Icons.calendar_month_outlined),
                // )
                //     : widget.icon,
                prefix: widget.prefixWidget,
                prefixIcon: widget.suffixIcon,
                prefixStyle: AllHRTableData.customTextStyle(context),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(bottom:18, left: AppPadding.p15),
              ),
              style: TableSubHeading.customTextStyle(context),
              //validator: widget.validator,
              onTap: widget.onChange,
              validator: widget.validator,
              // onTap: widget.onChange,
            ),
          ),
        ],
      ),
    );
  }
}


















class CustomDropdownTextFieldEMR extends StatefulWidget {
  final String? value;
  final List<String>? items;
  final List<DropdownMenuItem<String>>? dropDownMenuList;
  final String? hintText;
 // final String headText;
  final void Function(String?)? onChanged;
  final double? width;
  final double? height;
  final FontWeight? fontwight;
  final double? fontsize;
  final String? initialValue;
  final bool? isAstric;
  final IconData? icon;
  final Color? iconColor;

  CustomDropdownTextFieldEMR({
    Key? key,
    this.isAstric = true,
    this.dropDownMenuList,
  //  required this.headText,
    this.value,
    this.items,
    this.onChanged,
    this.width,
    this.height,
    this.initialValue,
    this.hintText, this.fontsize,
    this.icon, this.iconColor, this.fontwight,
  }) : super(key: key);

  @override
  _CustomDropdownTextFieldEMRState createState() => _CustomDropdownTextFieldEMRState();
}

class _CustomDropdownTextFieldEMRState extends State<CustomDropdownTextFieldEMR> {
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
        // widget.isAstric!?Padding(
        //   padding: const EdgeInsets.only(left: 5.0, bottom: 2),
        //   // child: RichText(
        //   //   text: TextSpan(
        //   //     text: widget.isAstric!?widget.headText:"", // Main text
        //   //     style: AllPopupHeadings.customTextStyle(context), // Main style
        //   //     children: [
        //   //       widget.isAstric!? TextSpan(
        //   //         text: ' *', // Asterisk
        //   //         style: AllPopupHeadings.customTextStyle(context).copyWith(
        //   //           color: ColorManager.red, // Asterisk color
        //   //         ),
        //   //       ):TextSpan(
        //   //         text: ' ', // Asterisk
        //   //       )
        //   //     ],
        //   //   ),
        //   // ),
        //   // child:Text(
        //   //   widget.headText,
        //   //   style: AllPopupHeadings.customTextStyle(context),
        //   // ),
        // )
        //     :Offstage(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: SizedBox(
            width: widget.isAstric!?AppSize.s310:widget.width,
            height: AppSize.s30,
            child: GestureDetector(
              onTap: _showDropdownDialog,
              child: Container(
                padding: const EdgeInsets.only(bottom: 3, top: 5, left: 4),
                decoration:widget.isAstric!? BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ):BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        _selectedValue ?? widget.hintText ?? 'Select',
                        style: TextStyle(
                          fontWeight:widget.fontwight ?? FontWeight.w500,
                          fontSize: widget.fontsize ?? FontSize.s12,
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





/// radio buttion
class EMRCustomRadioListTile extends StatefulWidget {
  final String value;
  final String? groupValue;
  final ValueChanged<String?> onChanged;
  final String title;

  const EMRCustomRadioListTile({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
  }) : super(key: key);

  @override
  _EMRCustomRadioListTileState createState() => _EMRCustomRadioListTileState();
}

class _EMRCustomRadioListTileState extends State<EMRCustomRadioListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      child: Row(
        children: [
          Radio<String>(
            splashRadius: 0,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            value: widget.value,
            groupValue: widget.groupValue,
            onChanged: widget.onChanged,
            activeColor: ColorManager.mediumgrey, // Set the selected color to black
          ),
          Text(
            widget.title,
            style: DocumentTypeDataStyle.customTextStyle(context),
          ),
          SizedBox(width: AppSize.s40),
        ],
      ),
    );
  }
}






// Custom class for Agree Terms Widget
// class CheckBoxConst extends StatelessWidget {
//   final String text;
//   final RxBool isChecked;// Customizable text
//
//   // Constructor with text parameter
//   const CheckBoxConst({
//     Key? key,
//     required this.text,
//     required this.isChecked,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // Access the TermsController using GetX
//     final TermsController controller = Get.find();
//
//     return Row(
//       children: [
//         // Using Theme widget to override the splash and highlight colors of the Checkbox
//         Theme(
//           data: Theme.of(context).copyWith(
//             splashColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//           ),
//           child: Obx(() {
//             return Checkbox(
//               // Customizing the active color of the checkbox (when checked)
//               activeColor: ColorManager.blueprime,
//               // The current state of the checkbox (checked or not)
//               value: isChecked.value,
//               // The function that gets called when the checkbox state changes
//               onChanged: controller.toggleCheckbox,
//             );
//           }),
//         ),
//         // The customizable text next to the checkbox
//         Text(
//           text, // Use the provided text
//           style: onlyFormDataStyle.customTextStyle(context),
//         ),
//       ],
//     );
//   }
// }
