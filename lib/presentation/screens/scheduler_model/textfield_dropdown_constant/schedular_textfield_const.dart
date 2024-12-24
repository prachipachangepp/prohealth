import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';

import '../../../../app/resources/color.dart';


class SchedularTextField extends StatefulWidget {
  final String labelText;
  final String? initialValue;
  final TextEditingController? controller;
  //final TextInputType keyboardType;
  final Icon? suffixIcon;
  final FormFieldValidator<String>? validator;
  final double? width;
  final ValueChanged<String>? onChanged;
  bool? phoneField;
  final FocusNode? focusNode;
  final bool? enable;
  final bool showDatePicker;
  final Icon? icon;
  final Widget? prefixWidget;
  final VoidCallback? onChange;


   SchedularTextField({
    Key? key,
    this.phoneField = false,
    required this.labelText,
    this.initialValue,
    this.controller,
    this.suffixIcon, this.validator, this.width,
    this.onChanged,
     this.focusNode,
     //required this.keyboardType,
     this.icon,
     this.onChange,
     this.enable,
     this.prefixWidget,
     this.showDatePicker = false,
  }) : super(key: key);

  @override
  _SchedularTextFieldState createState() => _SchedularTextFieldState();
}

class _SchedularTextFieldState extends State<SchedularTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // _controller = widget.controller ?? TextEditingController(text: widget.initialValue);
    _controller = widget.controller ?? TextEditingController(text: widget.initialValue);

    // If onChanged is provided, listen to controller changes
    _controller.addListener(() {
      if (widget.onChanged != null) {
        widget.onChanged!(_controller.text); // Trigger the onChanged callback
      }
    });
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      widget.controller!.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding:  const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                widget.labelText,
                style: AllPopupHeadings.customTextStyle(context)
              //ConstTextFieldStyles.customTextStyle(textColor: widget.textColor),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
            width: widget.width,
            height: 30,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFB1B1B1), width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
            child: TextFormField(
              focusNode: widget.focusNode,
              autofocus: true,
              enabled: widget.enable == null ? true : false,
              controller: widget.controller,
             // keyboardType: widget.keyboardType,
              cursorHeight: 17,
              cursorColor: Colors.black,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                suffixIcon: widget.showDatePicker
                    ? GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Icon(Icons.calendar_month_outlined,color: ColorManager.blueprime,size: 18,),
                )
                    : widget.icon,
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
              inputFormatters: widget.phoneField! ? [
                PhoneNumberInputFormatter()
              ]: [],
              // onTap: widget.onChange,
            ),
            // TextFormField(
            //   textCapitalization: TextCapitalization.sentences,
            //   controller: _controller,
            //   cursorHeight: 17,
            //   style: DocumentTypeDataStyle.customTextStyle(context),
            //   cursorColor: ColorManager.black,
            //   decoration: InputDecoration(
            //     contentPadding: EdgeInsets.only(bottom:18, left: AppPadding.p15),
            //     labelText: widget.labelText,
            //     labelStyle:  DocumentTypeDataStyle.customTextStyle(context),
            //     border: const OutlineInputBorder(),
            //     focusedBorder: OutlineInputBorder(
            //       borderSide: BorderSide(color: ColorManager.containerBorderGrey),
            //     ),
            //     suffixIcon: widget.suffixIcon != null
            //         ? GestureDetector(
            //       onTap: () async {
            //         // Open the date picker when the calendar icon is tapped
            //         DateTime? pickedDate = await showDatePicker(
            //           context: context,
            //           initialDate: DateTime.now(),
            //           firstDate: DateTime(1900),
            //           lastDate: DateTime(2101),
            //         );
            //
            //         if (pickedDate != null) {
            //           // Format the date and set it into the text field
            //           String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            //           _controller.text = formattedDate;
            //         }
            //       },
            //       child: widget.suffixIcon,
            //     )
            //         : null,
            //     // Do not show any icon if suffixIcon is null
            // ),
            //   validator: widget.validator,
            //   inputFormatters: widget.phoneField! ? [
            //     PhoneNumberInputFormatter()
            //   ]: [],
            // )
                ),
          ],
        ),
      );
  }
}






