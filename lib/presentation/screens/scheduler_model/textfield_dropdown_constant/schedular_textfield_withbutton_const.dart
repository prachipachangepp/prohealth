import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SchedularTextFieldWithButton extends StatelessWidget {
  final String labelText;
  final String? initialValue;
  final String buttonText;
  final TextEditingController? textController;


  SchedularTextFieldWithButton({
    super.key,
    required this.labelText,
    this.initialValue,
    required this.buttonText, this.textController,

  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: AppSize.s25p38,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
      Padding(
      padding:  const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              labelText,
              style: AllPopupHeadings.customTextStyle(context)
            //ConstTextFieldStyles.customTextStyle(textColor: widget.textColor),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFB1B1B1), width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextFormField(
              //focusNode: widget.focusNode,
              autofocus: true,
              //enabled: widget.enable == null ? true : false,
              controller: textController,
              // keyboardType: widget.keyboardType,
              cursorHeight: 17,
              cursorColor: Colors.black,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(bottom:18, left: AppPadding.p15),
              ),
              style: TableSubHeading.customTextStyle(context),
              //validator: widget.validator,

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
    ),
          // TextFormField(
          //   initialValue: initialValue,
          //   style: GoogleFonts.firaSans(
          //     fontSize: FontSize.s14,
          //     fontWeight: FontWeightManager.regular,
          //     color: ColorManager.black,
          //   ),
          //   cursorColor: ColorManager.black,
          //   decoration: InputDecoration(
          //     labelText: labelText,
          //     labelStyle: GoogleFonts.firaSans(
          //       fontSize: FontSize.s10,
          //       color: ColorManager.greylight,                                                      // text color
          //     ),
          //     border: const OutlineInputBorder(),
          //     enabledBorder: OutlineInputBorder(
          //       borderSide: BorderSide(color: ColorManager.containerBorderGrey),
          //     ),
          //     focusedBorder: OutlineInputBorder(
          //       borderSide: BorderSide(color: ColorManager.containerBorderGrey),
          //     ),
          //     contentPadding: EdgeInsets.only(
          //       top: 10,
          //       bottom: 10,
          //       left: 10,
          //       right: 90, // padding to make space for the button
          //     ),
          //   ),
          // ),
          Positioned(
           bottom: 2,
            right: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Container(
                height: AppSize.s20,                                  //  view zone height button
                width: AppSize.s72,
                child: ElevatedButton(
                  onPressed: () async {
                    String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=19.113284653915976, 72.86915605796655';
                    if (await canLaunchUrlString(googleMapsUrl)) {
                      await launchUrlString(googleMapsUrl);
                    } else {
                      print('Could not open the map.');
                    }
                  },
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: ColorManager.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
