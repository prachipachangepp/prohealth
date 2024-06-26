
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';

import '../../widgets/button_constant.dart';
import '../../widgets/text_form_field_const.dart';

// class CustomPopupWidget extends StatefulWidget {
//   final TextEditingController typeController;
//   final TextEditingController abbreviationController;
//   final TextEditingController? emailController;
//   final VoidCallback onAddPressed;
//   final Color containerColor;
//   final Widget? child;
//   final Function(Color)? onColorChanged;
//
//   CustomPopupWidget({
//     required this.typeController,
//     required this.abbreviationController,
//     this.emailController,
//     required this.containerColor,
//     required this.onAddPressed,  required this.onColorChanged, this.child,
//
//   });
//
//
//
//   @override
//   State<CustomPopupWidget> createState() => _CustomPopupWidgetState();
// }
//
// class _CustomPopupWidgetState extends State<CustomPopupWidget> {
//   late List<Color> _selectedColors;
//   List<String> _selectedColorCodes = List.filled(2, '');
//   int index = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize _selectedColors with the initial color passed from the parent widget
//     _selectedColors = [widget.containerColor];
//   }
//
//   void _openColorPicker() async {
//     Color? pickedColor = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Pick a color'),
//           content: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 ColorPicker(
//                   borderColor: _selectedColors[0],
//                   onColorChanged: (Color color) {
//                     setState(() {
//                       _selectedColors[0] = color;
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop(_selectedColors[0]);
//               },
//             ),
//           ],
//         );
//       },
//     );
//
//     if (pickedColor != null) {
//       setState(() {
//         _selectedColors[0] = pickedColor;
//         // Update container color by calling the function passed from HrSalesScreen
//         widget.onColorChanged!(pickedColor);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       child: Container(
//         height: AppSize.s400,
//         width: AppSize.s350,
//         decoration: BoxDecoration(
//           color: ColorManager.white,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: Icon(Icons.close),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                   vertical: AppPadding.p3,horizontal: AppPadding.p25),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   SMTextFConst(controller: widget.typeController, keyboardType: TextInputType.text, text: 'Employee Type',),
//                   SizedBox(height: AppSize.s16,),
//                   SMTextFConst(controller: widget.abbreviationController, keyboardType: TextInputType.streetAddress, text: 'Abbreviation',),
//                   SizedBox(height: AppSize.s16,),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Type of Employee',
//                       style: GoogleFonts.firaSans(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w700,
//                         color: const Color(0xff686464),
//                         decoration: TextDecoration.none,
//                       ),),
//                       SizedBox(height: 2),
//                       widget.child!
//                     ],
//                   ),
//                   SizedBox(height: AppSize.s16,),
//                   Row(
//                     children: [
//                       Text('Color',
//                         style: GoogleFonts.firaSans(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w700,
//                           color: Color(0xff686464),
//                           decoration: TextDecoration.none,
//                         ),),
//                       SizedBox(width: AppSize.s25,),
//                       Container(
//                         padding: EdgeInsets.all(2),
//                         width: 62,
//                         height: 22,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(2),
//                           border: Border.all(width: 1, color: Color(0xffE9E9E9),
//                           ),
//                         ),
//                         child:  GestureDetector(
//                           onTap:
//                           _openColorPicker, // Call _openColorPicker directly
//                           child: Container(
//                             width: 60,
//                             height: 20,
//                             decoration: BoxDecoration(
//                               color: _selectedColors[0],
//                               border: Border.all(
//                                 width: 1,
//                                 color: _selectedColors[0],
//                               ),
//                               // GestureDetector(
//                               //   onTap: () => _openColorPicker(index),
//                               //   child: Container(
//                               //     width: 60,
//                               //     height: 20,
//                               //     decoration: BoxDecoration(
//                               //       color: _selectedColors[index],
//                               //       border: Border.all(
//                               //         width: 1,
//                               //         color: _selectedColors[index],
//                               //       ),
//                             ),
//                           ),
//                         ),
//                       )
//
//                     ],
//                   ),
//                   SizedBox(height: MediaQuery.of(context).size.width/22,),
//                   Center(
//                     child: CustomElevatedButton(
//                         width: AppSize.s105,
//                         height: AppSize.s30,
//                         text: 'Add',
//                         onPressed: widget.onAddPressed),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class CustomPopupWidget extends StatefulWidget {
  final TextEditingController typeController;
  final TextEditingController abbreviationController;
  final TextEditingController? emailController;
  final Future<void> Function() onAddPressed;
  final Color containerColor;
  final Widget? child;
  final Function(Color)? onColorChanged;
  final String title;

  CustomPopupWidget({
    required this.typeController,
    required this.abbreviationController,
    this.emailController,
    required this.containerColor,
    required this.onAddPressed,
    required this.onColorChanged,
    this.child, required this.title,
  });

  @override
  State<CustomPopupWidget> createState() => _CustomPopupWidgetState();
}

class _CustomPopupWidgetState extends State<CustomPopupWidget> {
  late List<Color> _selectedColors;
  List<String> _selectedColorCodes = List.filled(2, '');
  int index = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedColors = [widget.containerColor];
  }

  void _openColorPicker() async {
    Color? pickedColor = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pick a color'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ColorPicker(
                  borderColor: _selectedColors[0],
                  onColorChanged: (Color color) {
                    setState(() {
                      _selectedColors[0] = color;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(_selectedColors[0]);
              },
            ),
          ],
        );
      },
    );

    if (pickedColor != null) {
      setState(() {
        _selectedColors[0] = pickedColor;
        widget.onColorChanged!(pickedColor);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: AppSize.s400,
        width: AppSize.s350,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    widget.title,
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeightManager.semiBold,
                      color: ColorManager.blueprime,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p3, horizontal: AppPadding.p25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SMTextFConst(
                    controller: widget.typeController,
                    keyboardType: TextInputType.text,
                    text: 'Employee Type',
                  ),
                  SizedBox(height: AppSize.s16),
                  SMTextFConst(
                    controller: widget.abbreviationController,
                    keyboardType: TextInputType.streetAddress,
                    text: 'Abbreviation',
                  ),
                  SizedBox(height: AppSize.s16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Type of Employee',
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff686464),
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(height: 2),
                      widget.child!,
                    ],
                  ),
                  SizedBox(height: AppSize.s16),
                  Row(
                    children: [
                      Text(
                        'Color',
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff686464),
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(width: AppSize.s25),
                      Container(
                        padding: EdgeInsets.all(2),
                        width: 62,
                        height: 22,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            width: 1,
                            color: Color(0xffE9E9E9),
                          ),
                        ),
                        child: GestureDetector(
                          onTap: _openColorPicker,
                          child: Container(
                            width: 60,
                            height: 20,
                            decoration: BoxDecoration(
                              color: _selectedColors[0],
                              border: Border.all(
                                width: 1,
                                color: _selectedColors[0],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width / 22),
                  Center(
                    child: isLoading
                        ? CircularProgressIndicator( color: ColorManager.blueprime,)
                        : CustomElevatedButton(
                      width: AppSize.s105,
                      height: AppSize.s30,
                      text: 'Add',
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await widget.onAddPressed();
                        setState(() {
                          isLoading = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
