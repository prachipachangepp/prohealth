import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/font_manager.dart';

import '../../../../../../app/resources/color.dart';

///done by saloni
///button constant for circularborder with text and with/without icon
class CustomIconButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;

  const CustomIconButton({
    required this.text,
    this.icon,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon != null
          ? Icon(icon!, color: Colors.white, size: 20)
          : SizedBox.shrink(),
      label: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'FiraSans',
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        backgroundColor: Color(0xFF50B5E5),
        // shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

///button constant with white bg, colored text
class CustomButtonTransparent extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButtonTransparent({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'FiraSans',
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Color(0xFF50B5E5),
        ),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Color(0xFF50B5E5)),
        ),
      ),
    );
  }
}

class CustomeTransparentAddShift extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  const CustomeTransparentAddShift({super.key, required this.text, required this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: MediaQuery.of(context).size.height/25,
        width: MediaQuery.of(context).size.width/15,
        decoration: BoxDecoration(border: Border.all(color: ColorManager.blueprime),borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.add,color: ColorManager.blueprime, size: MediaQuery.of(context).size.width/100),
            Text(
              text,
              style: TextStyle(
                fontFamily: 'FiraSans',
                fontSize: MediaQuery.of(context).size.width/100,
                fontWeight: FontWeight.w700,
                color: ColorManager.blueprime,
              ),
            ),
          ],
        )
      ),
    );
  }
}
// ElevatedButton.icon(
// icon:icon != null
// ? Icon(icon!, color: ColorManager.blueprime, size: MediaQuery.of(context).size.width/100,)
//     : Offstage(),
// onPressed: onPressed,
// label: Text(
// text,
// style: TextStyle(
// fontFamily: 'FiraSans',
// fontSize: 12,
// fontWeight: FontWeight.w700,
// color: ColorManager.blueprime,
// ),
// ),
// style: ElevatedButton.styleFrom(
// // padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
// backgroundColor: Colors.white,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(30),
// side: BorderSide(color: Color(0xFF50B5E5)),
// ),
// ),
// ),

///custombutton size managebleimport 'package:flutter/material.dart';

// class CustomButton extends StatelessWidget {
//   final String? text;
//   final VoidCallback onPressed;
//   // final Color color;
//   final Color textColor;
//   final double borderRadius;
//   final double paddingVertical;
//   final double paddingHorizontal;
//   final double width;
//   final double height;
//   final TextStyle style;
//   final Widget? child;
//
//   const CustomButton({
//     Key? key,
//     this.text,
//     required this.onPressed,
//     // this.color = Colors.blue,
//     this.textColor = Colors.white,
//     this.borderRadius = 14.0,
//     this.paddingVertical = 12.0,
//     this.paddingHorizontal = 16.0,
//     this.width = 50,
//     //this.width = double.infinity,
//     this.height = 50.0,
//     this.style = const TextStyle(color: Colors.white),
//     this.child,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: width,
//       height: height,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Color(0xFF50B5E5),
//           foregroundColor: textColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(borderRadius),
//           ),
//           padding: EdgeInsets.symmetric(
//             vertical: paddingVertical,
//             horizontal: paddingHorizontal,
//           ),
//         ),
//         child: text != null
//             ? Text(
//                 text!,
//                 style: GoogleFonts.firaSans(
//                   fontSize: MediaQuery.of(context).size.width / 90,
//                   fontWeight: FontWeight.w700,
//                 ),
//               )
//             : child,
//       ),
//     );
//   }
// }
///
class CustomButton extends StatelessWidget {
  final String? text;
  final VoidCallback onPressed;
  final Color backgroundColor; // Added parameter for background color
  final Color textColor;
  final double borderRadius;
  final double paddingVertical;
  final double paddingHorizontal;
  final double width;
  final double height;
  final TextStyle? style;
  final Widget? child;

  const CustomButton({
    Key? key,
    this.text,
    required this.onPressed,
    this.backgroundColor = const Color(0xFF50B5E5), // Default background color
    this.textColor = Colors.white,
    this.borderRadius = 14.0,
    this.paddingVertical = 12.0,
    this.paddingHorizontal = 16.0,
    this.width = 50,
    this.height = 50.0,
    this.style,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = GoogleFonts.firaSans(
      color: textColor,
      fontSize: MediaQuery.of(context).size.width / 90,
      fontWeight: FontWeight.w700,
    );
    final mergedTextStyle = defaultTextStyle.merge(style);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 4),
            blurRadius: 3,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              backgroundColor, // Utilizing the backgroundColor parameter
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.symmetric(
            vertical: paddingVertical,
            horizontal: paddingHorizontal,
          ),
        ),
        child: text != null
            ? Text(text!, textAlign: TextAlign.center, style: mergedTextStyle)
            : child,
      ),
    );
  }
}

///CustomTitleButton
class CustomTitleButton extends StatelessWidget {
  final double height;
  final double width;
  final VoidCallback onPressed;
  final String text;
  final bool isSelected;

  CustomTitleButton({
    required this.height,
    required this.width,
    required this.onPressed,
    required this.text,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: height,
          width: width,
          alignment: Alignment.center,
          decoration: isSelected
              ? BoxDecoration(
            color: ColorManager.blueprime,
            borderRadius: BorderRadius.circular(8),
          )
              : null,
          child: Text(
            text,
            style: GoogleFonts.firaSans(
              fontSize: MediaQuery.of(context).size.width / 120,
              fontWeight: FontWeight.w700,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

///sm desktop
// class CustomTitleButton extends StatelessWidget {
//   final String? text;
//   final VoidCallback onPressed;
//   // final Color color;
//   final Color textColor;
//   final double borderRadius;
//   final double paddingVertical;
//   final double paddingHorizontal;
//   final double width;
//   final double height;
//   final TextStyle style;
//   final Widget? child;
//   final bool isSelected;
//
//   const CustomTitleButton({
//     Key? key,
//     this.text,
//     required this.onPressed,
//     // this.color = Colors.blue,
//     this.textColor = Colors.white,
//     this.borderRadius = 8.0,
//     this.paddingVertical = 10.0,
//     this.paddingHorizontal = 16.0,
//     this.width = 50,
//     //this.width = double.infinity,
//     this.height = 50.0,
//     this.style = const TextStyle(color: Colors.white),
//     this.child,
//     required this.isSelected,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: width,
//       height: height,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: isSelected ? Color(0xFF50B5E5) : Colors.white,
//           foregroundColor: textColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(borderRadius),
//           ),
//           padding: EdgeInsets.symmetric(
//             vertical: paddingVertical,
//             horizontal: paddingHorizontal,
//           ),
//         ),
//         child: text != null
//             ? Text(
//                 text!,
//                 style: GoogleFonts.firaSans(
//                   fontSize: MediaQuery.of(context).size.width / 120,
//                   fontWeight: FontWeight.w700,
//                   color: isSelected ? Colors.white : Colors.black,
//                 ),
//               )
//             : child,
//       ),
//     );
//   }
// }

///CustomDropdownButton
/// sm desktop
// class CustomDropdownButton extends StatelessWidget {
//   final List<String> items;
//   final String? selectedItem;
//   final ValueChanged<String?>? onChanged;
//   final double borderRadius;
//   final double paddingVertical;
//   final double paddingHorizontal;
//   final double width;
//   final double height;
//
//   const CustomDropdownButton({
//     Key? key,
//     required this.items,
//     this.selectedItem,
//     this.onChanged,
//     this.borderRadius = 8.0,
//     this.paddingVertical = 11.0,
//     this.paddingHorizontal = 16.0,
//     this.width = 40,
//     this.height = 40.0,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       elevation: 4,
//       borderRadius: BorderRadius.circular(borderRadius),
//       child: Container(
//         width: width,
//         height: height,
//         decoration: BoxDecoration(
//           color: ColorManager.blueprime,
//           borderRadius: BorderRadius.circular(borderRadius),
//         ),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<String>(
//             value: selectedItem,
//             onChanged: onChanged,
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 13,
//               // MediaQuery.of(context).size.width / 10,
//               fontWeight: FontWeight.w700,
//             ),
//             dropdownColor: ColorManager.white,
//
//             /// Background color for dropdown
//             borderRadius: BorderRadius.circular(borderRadius),
//             icon: Icon(Icons.arrow_drop_down, color: Colors.black),
//             iconSize: 20.0,
//             isExpanded: true,
//             items: items.map((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                     vertical: paddingVertical,
//                     horizontal: paddingHorizontal,
//                   ),
//                   child: Text(
//                     value,
//                     style: TextStyle(
//                       color: Color(0xff686464),
//                      // fontSize: MediaQuery.of(context).size.width / 120,
//                       fontSize: 12,
//                     ), // Text color
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }

class CustomDropdownButton extends StatelessWidget {
  final List<String> items;
  final String? selectedItem;
  final ValueChanged<String?>? onChanged;
  final double borderRadius;
  final double paddingVertical;
  final double paddingHorizontal;
  final double width;
  final double height;

  const CustomDropdownButton({
    Key? key,
    required this.items,
    this.selectedItem,
    this.onChanged,
    this.borderRadius = 8.0,
    this.paddingVertical = 11.0,
    this.paddingHorizontal = 16.0,
    this.width = 40,
    this.height = 40.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: ColorManager.blueprime,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedItem,
            onChanged: onChanged,
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
            dropdownColor: ColorManager.white,
            borderRadius: BorderRadius.circular(borderRadius),
            icon: Icon(Icons.arrow_drop_down, color: Colors.white),
            iconSize: 20.0,
            isExpanded: true,
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                enabled: value != 'Select a module', // Disable the heading item
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: paddingVertical,
                    horizontal: paddingHorizontal,
                  ),
                  child: Text(
                    value,
                    style: TextStyle(
                        // color: ColorManager.mediumgrey,
                        //value == 'Select a module' ? ColorManager.mediumgrey : Color(0xff686464),
                        color: value == selectedItem
                            ? ColorManager.white
                            : ColorManager.mediumgrey,
                        fontSize: 12,
                        fontWeight: FontWeightManager.bold),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

///
