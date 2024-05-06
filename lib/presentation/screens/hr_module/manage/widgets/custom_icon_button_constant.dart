import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../app/resources/color.dart';

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
        shadowColor: Colors.grey,
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
  final TextStyle style;
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
    this.style = const TextStyle(color: Colors.white),
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor, // Utilizing the backgroundColor parameter
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
            ? Text(
          text!,
          style: GoogleFonts.firaSans(
            fontSize: MediaQuery.of(context).size.width / 90,
            fontWeight: FontWeight.w700,
          ),
        )
            : child,
      ),
    );
  }
}


///CustomTitleButton
///sm desktop
class CustomTitleButton extends StatelessWidget {
  final String? text;
  final VoidCallback onPressed;
  // final Color color;
  final Color textColor;
  final double borderRadius;
  final double paddingVertical;
  final double paddingHorizontal;
  final double width;
  final double height;
  final TextStyle style;
  final Widget? child;
  final bool isSelected;

  const CustomTitleButton({
    Key? key,
    this.text,
    required this.onPressed,
    // this.color = Colors.blue,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    this.paddingVertical = 10.0,
    this.paddingHorizontal = 16.0,
    this.width = 50,
    //this.width = double.infinity,
    this.height = 50.0,
    this.style = const TextStyle(color: Colors.white),
    this.child,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? Color(0xFF50B5E5) : Colors.white,
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
              ? Text(
                  text!,
                  style: GoogleFonts.firaSans(
                    fontSize: MediaQuery.of(context).size.width / 120,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                )
              : child,
        ),
      ),
    );
  }
}

///CustomDropdownButton
/// sm desktop
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
    this.paddingVertical = 12.0,
    this.paddingHorizontal = 16.0,
    this.width = 50,
    this.height = 50.0,
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
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width / 120,
              fontWeight: FontWeight.w700,
            ),
            dropdownColor: ColorManager.blueprime, // Background color for dropdown
            borderRadius: BorderRadius.circular(borderRadius),
            icon: Icon(Icons.arrow_drop_down, color: Colors.white),
            iconSize: 24.0,
            isExpanded: true,
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: paddingVertical,
                    horizontal: paddingHorizontal,
                  ),
                  child: Text(
                    value,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width / 120,
                    ), // Text color
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
