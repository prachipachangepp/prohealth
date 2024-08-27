import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';

/////Schedular PopUp Textfield constant///////
class PopUpTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final String? initialValue;
  final bool isDate;
  final bool isTime;

  PopUpTextField({
    Key? key,
    required this.labelText,
    this.initialValue,
    this.isDate = false,
    this.isTime = false,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller =
        TextEditingController(text: initialValue);

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );

      if (selectedDate != null) {
        controller.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      }
    }

    Future<void> _selectTime(BuildContext context) async {
      final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        final now = DateTime.now();
        final selectedDateTime = DateTime(
          now.year,
          now.month,
          now.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        // controller.text = DateFormat('HH:mm').format(selectedDateTime);
        controller.text = DateFormat('HH:mm:ss').format(selectedDateTime) + 'Z';
      }
    }

    return SizedBox(
      height: AppSize.s30,
      child: TextFormField(
        controller: controller,
        style: GoogleFonts.firaSans(
          fontSize: FontSize.s12,
          fontWeight: FontWeightManager.regular,
          color: ColorManager.black,
        ),
        cursorColor: ColorManager.black,
        decoration: InputDecoration(
          labelText: '',
          labelStyle: GoogleFonts.firaSans(
            fontSize: FontSize.s10,
            fontWeight: FontWeightManager.regular,
            color: ColorManager.greylight,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: ColorManager.containerBorderGrey,
              width: AppSize.s1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: ColorManager.containerBorderGrey,
              width: AppSize.s1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: ColorManager.containerBorderGrey,
              width: AppSize.s1,
            ),
          ),
          suffixIcon: isDate
              ? Icon(Icons.calendar_month_outlined,
                  color: ColorManager.blueprime)
              : isTime
                  ? Icon(Icons.access_time_filled,
                      color: ColorManager.blueprime)
                  : null,
        ),
        readOnly: isDate || isTime,
        onTap: isDate
            ? () async {
                await _selectDate(context);
              }
            : isTime
                ? () async {
                    await _selectTime(context);
                  }
                : null,
      ),
    );
  }
}

class PopUpDropdown extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final String? initialValue;

  const PopUpDropdown({
    super.key,
    required this.labelText,
    this.initialValue,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s30, // DROPDOWN CONTAINER HEIGHT
      child: DropdownButtonFormField<String>(
        value: initialValue,
        style: GoogleFonts.firaSans(
          fontSize: FontSize.s10,
          fontWeight: FontWeightManager.regular,
          color: ColorManager.black,
        ),
        decoration: InputDecoration(
          labelText: 'visit',
          labelStyle: GoogleFonts.firaSans(
            fontSize: FontSize.s10,
            fontWeight: FontWeightManager.regular,
            color: ColorManager.greylight,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: ColorManager.containerBorderGrey,
              width: AppSize.s1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: ColorManager.containerBorderGrey,
              width: AppSize.s1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: ColorManager.containerBorderGrey,
              width: AppSize.s1,
            ),
          ),
        ),
        items: [initialValue ?? '']
            .map((value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ))
            .toList(),
        onChanged: (value) {},
        icon: Icon(
          Icons.arrow_drop_down,
          color: ColorManager.blueprime, // dropdown icon color
          size: FontSize.s24, // size of icon
        ),
        isDense: false, // Adjust the density of the dropdown
      ),
    );
  }
}

///////////////////////////

// class SchedularPopupTextField extends StatefulWidget {
//   final String labelText;
//   final String? initialValue;
//   final TextEditingController? controller;
//   final Icon? suffixIcon;
//   final FormFieldValidator<String>? validator;
//   final bool isDate;
//   final bool isTime;
//
//   const SchedularPopupTextField({
//     Key? key,
//     required this.labelText,
//     this.initialValue,
//     this.controller,
//     this.suffixIcon,
//     this.validator,
//     this.isDate = false,
//     this.isTime = false,
//   }) : super(key: key);
//
//   @override
//   _SchedularTextFieldPopupState createState() =>
//       _SchedularTextFieldPopupState();
// }
//
// class _SchedularTextFieldPopupState extends State<SchedularPopupTextField> {
//
//   final TextEditingController controller =
//   TextEditingController(text: initialValue);
//   // TextEditingController _controller;
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   controller = widget.controller ?? TextEditingController(text: widget.initialValue);
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//
//     // final TextEditingController controller =
//     //     TextEditingController(text: initialValue);
//
//     Future<void> _selectDate(BuildContext context) async {
//       final DateTime? selectedDate = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(2000),
//         lastDate: DateTime(2101),
//       );
//
//       if (selectedDate != null) {
//         controller.text = DateFormat('yyyy-MM-dd').format(selectedDate);
//       }
//     }
//
//     Future<void> _selectTime(BuildContext context) async {
//       final TimeOfDay? selectedTime = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.now(),
//       );
//
//       if (selectedTime != null) {
//         final now = DateTime.now();
//         final selectedDateTime = DateTime(
//           now.year,
//           now.month,
//           now.day,
//           selectedTime.hour,
//           selectedTime.minute,
//         );
//         // controller.text = DateFormat('HH:mm').format(selectedDateTime);
//         controller.text = DateFormat('HH:mm:ss').format(selectedDateTime) + 'Z';
//       }
//     }
//
//     return SizedBox(
//       height: 25.38,
//       child: TextFormField(
//         textCapitalization: TextCapitalization.sentences,
//         controller: widget.controller,
//         style: GoogleFonts.firaSans(
//           fontSize: FontSize.s12,
//           fontWeight: FontWeightManager.regular,
//           color: ColorManager.black,
//         ),
//         cursorColor: ColorManager.black,
//         decoration: InputDecoration(
//           labelText: widget.labelText,
//           labelStyle: GoogleFonts.firaSans(
//             fontSize: FontSize.s10,
//             color: ColorManager.greylight,
//           ),
//           border: const OutlineInputBorder(),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: ColorManager.containerBorderGrey),
//           ),
//           suffixIcon: widget.isDate
//               ? Icon(Icons.calendar_month_outlined,
//                   color: ColorManager.blueprime)
//               : widget.isTime
//                   ? Icon(Icons.access_time_filled,
//                       color: ColorManager.blueprime)
//                   : null,
//         ),
//         readOnly: widget.isDate || widget.isTime,
//         onTap: widget.isDate
//             ? () async {
//                 await _selectDate(context);
//               }
//             : widget.isTime
//                 ? () async {
//                     await _selectTime(context);
//                   }
//                 : null,
//
//         //   suffixIcon: widget.suffixIcon != null
//         //       ? GestureDetector(
//         //     onTap: () async {
//         //       // Open the date picker when the calendar icon is tapped
//         //       DateTime? pickedDate = await showDatePicker(
//         //         context: context,
//         //         initialDate: DateTime.now(),
//         //         firstDate: DateTime(1900),
//         //         lastDate: DateTime(2101),
//         //       );
//         //
//         //       if (pickedDate != null) {
//         //         // Format the date and set it into the text field
//         //         String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
//         //         _controller.text = formattedDate;
//         //       }
//         //     },
//         //     child: widget.suffixIcon,
//         //   )
//         //       : null,
//         //   // Do not show any icon if suffixIcon is null
//       ),
//       // validator: widget.validator,
//     );
//   }
// }
