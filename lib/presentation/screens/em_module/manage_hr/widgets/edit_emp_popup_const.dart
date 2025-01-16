import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/dialogue_template.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../widgets/button_constant.dart';
import '../../widgets/text_form_field_const.dart';

class EditPopupController extends GetxController {
  Rx<Color> containerColor = Colors.red.obs;

  void updateColor(Color newColor) {
    containerColor.value = newColor;
  }
}
class EditPopupWidget extends StatefulWidget {
  final int? id;
  final TextEditingController typeController;
  final TextEditingController shorthandController;
  final TextEditingController? emailController;
  final Future<void> Function() onSavePressed;
  final Color containerColor;
  // final Widget child;
  final Function(Color)? onColorChanged;
  final String title;

  EditPopupWidget({
    required this.typeController,
    required this.shorthandController,
    this.emailController,
    required this.containerColor,
    required this.onSavePressed,
    this.onColorChanged,
    this.id,
    //required this.child,
    required this.title,
  });

  @override
  State<EditPopupWidget> createState() => _EditPopupWidgetState();
}

class _EditPopupWidgetState extends State<EditPopupWidget> {
  int index = 0;
  List<String> _selectedColorCodes = List.filled(2, '');
  late List<Color> _selectedColors;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  String? _typeError;
  String? _abbreviationError;

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
          title: Padding(
            padding: const EdgeInsets.only(left: AppPadding.p20),
            child: Text(
              'Pick a Color',
              style: TextStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.blueprime
              ),
            ),
          ),
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

  // Method to validate 'Type'
  void _validateType() {
    setState(() {
      _typeError = widget.typeController.text.isEmpty ? 'Please Enter Employee Type' : null;
    });
  }

  // Method to validate 'Abbreviation'
  void _validateAbbreviation() {
    setState(() {
      _abbreviationError = widget.shorthandController.text.isEmpty ? 'Please Enter Abbreviation' : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
      height: 370,
      width: AppSize.s350,
      title: widget.title,
      body: [Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p15),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // TextField for 'Type'
              SMTextfieldAsteric(
                controller: widget.typeController,
                keyboardType: TextInputType.text,
                text: 'Type',
                onChange: () {
                  _validateType(); // Validate as user types
                  if (_typeError != null) {
                    setState(() {
                      _typeError = null; // Hide error message as user starts typing
                    });
                  }
                },
              ),
              _typeError != null
                  ? Text(
                _typeError!,
                style: CommonErrorMsg.customTextStyle(context),
              )
                  : SizedBox(height: AppSize.s12),
              SizedBox(
                height: AppSize.s5,
              ),

              // TextField for 'Abbreviation'
              CapitalSMTextFConst(
                controller: widget.shorthandController,
                keyboardType: TextInputType.streetAddress,
                text: 'Abbreviation',
                onChange: () {
                  _validateAbbreviation(); // Validate as user types
                  if (_abbreviationError != null) {
                    setState(() {
                      _abbreviationError = null; // Hide error message as user starts typing
                    });
                  }
                },
              ),
              _abbreviationError != null
                  ? Text(
                _abbreviationError!,
                style: CommonErrorMsg.customTextStyle(context),
              )
                  : SizedBox(height: AppSize.s12),
              SizedBox(
                height: AppSize.s5,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 1.0),
                    child: Text(
                      'Color',
                      style: ConstTextFieldStyles.customTextStyle(textColor: ColorManager.mediumgrey),
                    ),
                  ),
                  SizedBox(width: AppSize.s25),
                  Container(
                    padding: EdgeInsets.all(AppPadding.p2),
                    width: AppSize.s62,
                    height: AppSize.s22,
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
                        width: AppSize.s60,
                        height: AppSize.s20,
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
            ],
          ),
        ),
      ),],
      bottomButtons: isLoading
          ? SizedBox(
        height: AppSize.s25,
        width: AppSize.s25,
        child: CircularProgressIndicator(color: ColorManager.blueprime),
      )
          : CustomElevatedButton(
        width: AppSize.s105,
        height: AppSize.s30,
        text: AppStringEM.save,
        onPressed: () async {
          // Validate fields before saving
          _validateType();
          _validateAbbreviation();

          if (_typeError == null && _abbreviationError == null) {
            setState(() {
              isLoading = true;
            });
            await widget.onSavePressed();
            setState(() {
              isLoading = false;
            });
          }
        },
      ),
    );
  }
}

// class _EditPopupWidgetState extends State<EditPopupWidget> {
//   int index = 0;
//   List<String> _selectedColorCodes = List.filled(2, '');
//   late List<Color> _selectedColors;
//   bool isLoading = false;
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedColors = [widget.containerColor];
//   }
//
//   void _openColorPicker() async {
//     Color? pickedColor = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Padding(
//             padding: const EdgeInsets.only(left: AppPadding.p20),
//             child: Text('Pick a Color',style: TextStyle(
//                 fontSize: FontSize.s14,
//                 fontWeight:FontWeight.w700,
//                 color: ColorManager.blueprime
//               // color: isSelected ? Colors.white : Colors.black,
//             ),),
//           ),
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
//         widget.onColorChanged!(pickedColor);
//       });
//     }
//   }
//   String? _typeError;
//   String? _abbreviationError;
//   void _validateFields() {
//     setState(() {
//       _typeError = widget.typeController.text.isEmpty ? 'Please Enter Employee Type' : null;
//       _abbreviationError = widget.shorthandController.text.isEmpty ? 'Please Enter Abbreviation' : null;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DialogueTemplate(
//       height: 370,
//       width: AppSize.s350,
//       title: widget.title,
//       body: [Padding(
//         padding: const EdgeInsets.symmetric(
//             horizontal: AppPadding.p15),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SMTextfieldAsteric(
//                 controller: widget.typeController,
//                 keyboardType: TextInputType.text,
//                 text: 'Type',
//               ),
//               _typeError != null ?
//               Text(
//                 _typeError!,
//                 style: CommonErrorMsg.customTextStyle(context),
//               ): SizedBox(height: AppSize.s12,),
//               SizedBox(
//                 height: AppSize.s5,
//               ),
//               CapitalSMTextFConst(
//                 controller: widget.shorthandController,
//                 keyboardType: TextInputType.streetAddress,
//                 text: 'Abbreviation',
//               ),
//               _abbreviationError != null ?
//               Text(
//                 _abbreviationError!,
//                 style: CommonErrorMsg.customTextStyle(context),
//               ): SizedBox(height: AppSize.s12,),
//               SizedBox(
//                 height: AppSize.s5,
//               ),
//               Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 1.0),
//                     child: Text(
//                       'Color',
//                       style: ConstTextFieldStyles.customTextStyle(textColor: ColorManager.mediumgrey),
//                     ),
//                   ),
//                   SizedBox(width: AppSize.s25),
//                   Container(
//                     padding: EdgeInsets.all(AppPadding.p2),
//                     width: AppSize.s62,
//                     height: AppSize.s22,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(2),
//                       border: Border.all(
//                         width: 1,
//                         color: Color(0xffE9E9E9),
//                       ),
//                     ),
//                     child: GestureDetector(
//                       onTap: _openColorPicker,
//                       child: Container(
//                         width: AppSize.s60,
//                         height: AppSize.s20,
//                         decoration: BoxDecoration(
//                           color: _selectedColors[0],
//                           border: Border.all(
//                             width: 1,
//                             color: _selectedColors[0],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//
//             ],
//           ),
//         ),
//       ),],
//       bottomButtons:  isLoading
//           ? SizedBox(
//           height: AppSize.s25,width: AppSize.s25,
//           child: CircularProgressIndicator( color: ColorManager.blueprime,))
//           : CustomElevatedButton(
//         width: AppSize.s105,
//         height: AppSize.s30,
//         text: AppStringEM.save,
//         onPressed: () async {
//           _validateFields();
//           if (_typeError == null && _abbreviationError == null) {
//             setState(() {
//               isLoading = true;
//             });
//             await widget.onSavePressed();
//             setState(() {
//               isLoading = false;
//             });
//           }
//         },
//       ),
//     );
//   }
// }
