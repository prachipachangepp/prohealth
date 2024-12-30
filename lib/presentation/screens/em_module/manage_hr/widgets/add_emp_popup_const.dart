import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/dialogue_template.dart';
import '../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../widgets/button_constant.dart';
import '../../widgets/text_form_field_const.dart';

class CustomPopupWidget extends StatefulWidget {
  final TextEditingController typeController;
  final TextEditingController abbreviationController;
  final TextEditingController? emailController;
  final Future<void> Function() onAddPressed;
  final Color containerColor;
  //final Widget? child;
  final Function(Color)? onColorChanged;
  final String title;

  CustomPopupWidget({
    required this.typeController,
    required this.abbreviationController,
    this.emailController,
    required this.containerColor,
    required this.onAddPressed,
    required this.onColorChanged,
   // this.child,
    required this.title,
  });

  @override
  State<CustomPopupWidget> createState() => _CustomPopupWidgetState();
}

class _CustomPopupWidgetState extends State<CustomPopupWidget> {
  late List<Color> _selectedColors;
  List<String> _selectedColorCodes = List.filled(2, '');
  int index = 0;
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
            child: Text('Pick a Color',
              style: TextStyle(
                fontSize: FontSize.s14,
                fontWeight: FontWeight.w700,
                color: ColorManager.blueprime
              // color: isSelected ? Colors.white : Colors.black,
            ),),
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

  void _validateFields() {
    setState(() {
      _typeError = widget.typeController.text.isEmpty ? 'Please Enter Employee Type' : null;
      _abbreviationError = widget.abbreviationController.text.isEmpty ? 'Please Enter Abbreviation' : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
        height: AppSize.s370,
        width: AppSize.s350,
        body: [Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppPadding.p15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SMTextfieldAsteric(
                      controller: widget.typeController,
                      keyboardType: TextInputType.text,
                      text: 'Employee Type',

                    ),
                    if (_typeError != null)
                      Text(
                        _typeError!,
                        style: CommonErrorMsg.customTextStyle(context),
                      ),
                  ],
                ),
                SizedBox(height: AppSize.s16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CapitalSMTextFConst(
                      controller: widget.abbreviationController,
                      keyboardType: TextInputType.streetAddress,
                      text: AppStringEM.abbrevation,
                    ),
                    if (_abbreviationError != null)
                      Text(
                        _abbreviationError!,
                        style: CommonErrorMsg.customTextStyle(context),
                      ),
                  ],
                ),
                SizedBox(height: AppSize.s16),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: AppPadding.p3),
                      child: Text(
                        AppStringEM.color,
                        style: ConstTextFieldStyles.customTextStyle(textColor: ColorManager.mediumgrey),
                      ),
                    ),
                    SizedBox(width: AppSize.s25),
                    Container(
                      padding: EdgeInsets.all(2),
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
        width: AppSize.s25,
        height: AppSize.s25,
        child: CircularProgressIndicator(color: ColorManager.blueprime),
      )
          : CustomElevatedButton(
        width: AppSize.s105,
        height: AppSize.s30,
        text: 'Add',
        onPressed: () async {
          _validateFields();
          if (_typeError == null && _abbreviationError == null) {
            setState(() {
              isLoading = true;
            });
            await widget.onAddPressed();
            setState(() {
              isLoading = false;
            });
          }
        },
      ),
      title: widget.title,

    );
  }
}