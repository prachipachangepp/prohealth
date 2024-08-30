import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/org_doc_ccd.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';

import '../../../../../../app/resources/theme_manager.dart';

class EmpDocEditPopup extends StatefulWidget {
  final TextEditingController idDocController;
  final TextEditingController nameDocController;
  final TextEditingController calenderController;
  final Future<void> Function() onSavePredded;
  final bool? isSaving;
  String? expiryType;
  final Widget radioButton;
  final Widget child;
  final Widget child2;
  final bool? loadingDuration;
  final String title;
  bool? enable;

  EmpDocEditPopup({
    Key? key,
    this.enable,
    required this.idDocController,
    required this.nameDocController,
    required this.child,
    required this.child2,
    required this.calenderController,
    this.expiryType,
    required this.onSavePredded,
    required this.radioButton,
    this.isSaving,
    this.loadingDuration,
    required this.title,
  }) : super(key: key);

  @override
  State<EmpDocEditPopup> createState() => _EmpDocEditPopupState();
}

class _EmpDocEditPopupState extends State<EmpDocEditPopup> {
  final DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;
  String? _idError;
  String? _nameError;

  void _validateFields() {
    setState(() {
      _idError = widget.idDocController.text.isEmpty ? 'Please Enter ID of Document' : null;
      _nameError = widget.nameDocController.text.isEmpty ? 'Please Enter Name of thr Document ' : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s400,
        height: AppSize.s460,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorManager.bluebottom,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 23),
                    child: Text(
                      widget.title,
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close, color: ColorManager.white,),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SMTextFConst(
                        enable: widget.enable == false ? true : widget.enable,
                        controller: widget.idDocController,
                        keyboardType: TextInputType.text,
                        text: 'ID of the Document',
                      ),
                      if (_idError != null)
                        Text(
                          _idError!,
                          style: TextStyle(color: Colors.red, fontSize: 10),
                        ),
                    ],
                  ),
                  SizedBox(height: AppSize.s8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FirstSMTextFConst(
                        controller: widget.nameDocController,
                        keyboardType: TextInputType.text,
                        text: 'Name of the Document',
                      ),
                      if (_nameError != null)
                        Text(
                          _nameError!,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                    ],
                  ),
                  SizedBox(height: AppSize.s8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Type of the Document',
                        style: GoogleFonts.firaSans(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.mediumgrey,
                        ),
                      ),
                      SizedBox(height: 5),
                      widget.child,
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p25),
              child: widget.radioButton,
            ),
            SizedBox(height: AppSize.s10),

            Padding(
              padding: const EdgeInsets.only(
                left: AppPadding.p20,
                right: AppPadding.p20,
              ),
              child: widget.child2,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(
            //     vertical: AppPadding.p3,
            //     horizontal: AppPadding.p20,
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         'Expiry Type',
            //         style: GoogleFonts.firaSans(
            //           fontSize: FontSize.s12,
            //           fontWeight: FontWeight.w700,
            //           color: ColorManager.mediumgrey,
            //           decoration: TextDecoration.none,
            //         ),
            //       ),
            //       widget.radioButton
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(
            //     vertical: AppPadding.p3,
            //     horizontal: AppPadding.p20,
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         'Expiry Date',
            //         style: GoogleFonts.firaSans(
            //           fontSize: FontSize.s12,
            //           fontWeight: FontWeight.w700,
            //           color: ColorManager.mediumgrey,
            //           decoration: TextDecoration.none,
            //         ),
            //       ),
            //       SizedBox(height: 4),
            //       FormField<String>(
            //         builder: (FormFieldState<String> field) {
            //           return SizedBox(
            //             width: 354,
            //             height: 30,
            //             child: TextFormField(
            //               style: GoogleFonts.firaSans(
            //                 fontSize: FontSize.s12,
            //                 fontWeight: FontWeight.w700,
            //                 color: ColorManager.mediumgrey,
            //               ),
            //               controller: widget.calenderController,
            //               decoration: InputDecoration(
            //                 focusColor: ColorManager.mediumgrey,
            //                 hoverColor: ColorManager.mediumgrey,
            //                 hintText: 'mm-dd-yyyy',
            //                 hintStyle: GoogleFonts.firaSans(
            //                   fontSize: FontSize.s12,
            //                   fontWeight: FontWeight.w700,
            //                   color: ColorManager.mediumgrey,
            //                 ),
            //                 border: OutlineInputBorder(
            //                   borderRadius: BorderRadius.circular(8),
            //                   borderSide: BorderSide(
            //                       width: 1, color: ColorManager.mediumgrey),
            //                 ),
            //                 focusedBorder: OutlineInputBorder(
            //                   borderRadius: BorderRadius.circular(8),
            //                   borderSide: BorderSide(
            //                       width: 1,
            //                       color: ColorManager.mediumgrey),
            //                 ),
            //                 enabledBorder: OutlineInputBorder(
            //                   borderRadius: BorderRadius.circular(8),
            //                   borderSide: BorderSide(
            //                       width: 1,
            //                       color: ColorManager.mediumgrey),
            //                 ),
            //                 contentPadding:
            //                 EdgeInsets.symmetric(horizontal: 16),
            //                 suffixIcon: Icon(Icons.calendar_month_outlined,
            //                     color: ColorManager.blueprime),
            //                 errorText: field.errorText,
            //               ),
            //               readOnly: true,
            //               onTap: () async {
            //                 DateTime? date = await showDatePicker(
            //                   context: context,
            //                   initialDate: DateTime.now(),
            //                   firstDate: DateTime(1100),
            //                   lastDate: DateTime(2025),
            //                 );
            //                 if (date != null) {
            //                   String formattedDate =
            //                   DateFormat('MM-dd-yyyy').format(date);
            //                   widget.calenderController.text = formattedDate;
            //                   field.didChange(formattedDate);
            //                 }
            //               },
            //               validator: (value) {
            //                 if (value == null || value.isEmpty) {
            //                   return 'please select birth date';
            //                 }
            //                 return null;
            //               },
            //             ),
            //           );
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: 10),
            _isLoading
                ? SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(
                color: ColorManager.blueprime,
              ),
            )
                : Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomElevatedButton(
                  width: AppSize.s105,
                  height: AppSize.s30,
                  text: AppStringEM.submit,
                  onPressed: () async {
                    _validateFields();
                    if (_idError == null && _nameError == null) {
                      setState(() {
                        _isLoading = true;
                        Navigator.pop(context);
                      });
                      await widget.onSavePredded();
                      setState(() {
                        _isLoading = false;
                      });

                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}