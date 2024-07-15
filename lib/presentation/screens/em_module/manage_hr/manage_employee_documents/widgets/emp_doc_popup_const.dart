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

class EmpDocEditPopupDatePicker extends StatefulWidget {
  final TextEditingController idDocController;
  final TextEditingController nameDocController;
  final VoidCallback onSavePressed;
  final Widget child;
  const EmpDocEditPopupDatePicker(
      {super.key,
      required this.idDocController,
      required this.nameDocController,
      required this.onSavePressed,
      required this.child});

  @override
  State<EmpDocEditPopupDatePicker> createState() =>
      _EmpDocEditPopupDatePickerState();
}

class _EmpDocEditPopupDatePickerState extends State<EmpDocEditPopupDatePicker> {
  String? _expiryType;
  String? _errorMessage;
  TextEditingController birthdayController = TextEditingController();
  final DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s400,
        height: AppSize.s550,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SMTextFConst(
                    controller: widget.idDocController,
                    keyboardType: TextInputType.text,
                    text: 'ID of the Document',
                  ),
                  SizedBox(height: AppSize.s8),
                  SMTextFConst(
                    controller: widget.nameDocController,
                    keyboardType: TextInputType.text,
                    text: 'Name of the Document',
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
                          //decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(height: 5),
                      widget.child,
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),

            ///radio
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expiry Type',
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.mediumgrey,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RadioListTile<String>(
                        title: Text(
                          'Not Applicable',
                          style: GoogleFonts.firaSans(
                            fontSize: FontSize.s10,
                            fontWeight: FontWeightManager.medium,
                            color: ColorManager.mediumgrey,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        value: 'type1',
                        groupValue: _expiryType,
                        onChanged: (value) {
                          setState(() {
                            _expiryType = value;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: Text(
                          'Scheduled',
                          style: GoogleFonts.firaSans(
                            fontSize: FontSize.s10,
                            fontWeight: FontWeightManager.medium,
                            color: ColorManager.mediumgrey,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        value: 'type2',
                        groupValue: _expiryType,
                        onChanged: (value) {
                          setState(() {
                            _expiryType = value;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: Text(
                          'Issuer Expiry',
                          style: GoogleFonts.firaSans(
                            fontSize: FontSize.s10,
                            fontWeight: FontWeightManager.medium,
                            color: ColorManager.mediumgrey,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        value: 'type3',
                        groupValue: _expiryType,
                        onChanged: (value) {
                          setState(() {
                            _expiryType = value;
                          });
                        },
                      ),
                    ],
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
                children: [
                  Text(
                    'Expiry Date',
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.mediumgrey,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  FormField<String>(
                    builder: (FormFieldState<String> field) {
                      return SizedBox(
                        width: 354,
                        height: 30,
                        child: TextFormField(
                          controller: birthdayController,
                          style: GoogleFonts.firaSans(
                              fontSize: FontSize.s12,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.mediumgrey),
                          decoration: InputDecoration(
                            hintText: 'mm-dd-yyyy',
                            hintStyle: GoogleFonts.firaSans(
                              fontSize: FontSize.s12,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.mediumgrey,
                              //decoration: TextDecoration.none,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(width: 1),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                            suffixIcon: Icon(
                              Icons.calendar_month_outlined,
                              color: ColorManager.blueprime,
                            ),
                            errorText: field.errorText,
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1100),
                              lastDate: DateTime(2026),
                            );
                            if (date != null) {
                              String formattedDate =
                              DateFormat('mm-dd-yyyy').format(date);
                              birthdayController.text = formattedDate;
                              field.didChange(formattedDate);
                              // birthdayController.text = DateFormat('mm-dd-yyyy')
                              //     .format(_selectedDate);
                              // field.didChange(
                              //     date.toLocal().toString().split(' ')[0]);
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please select birth date';
                            }
                            return null;
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p24),
              child: Center(
                child: CustomElevatedButton(
                  width: AppSize.s105,
                  height: AppSize.s30,
                  text: AppStringEM.submit,
                  onPressed: () {
                    widget.onSavePressed();
                    Navigator.pop(context);
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

///
class EmpDocEditPopup extends StatefulWidget {
  final TextEditingController idDocController;
  final TextEditingController nameDocController;
  final TextEditingController calenderController;
  final Future<void> Function() onSavePredded;
  final bool? isSaving;
  String? expiryType;
  final Widget radioButton;
  final Widget child;
  final int? loadingDuration;
  final String  title;
  EmpDocEditPopup(
      {super.key,
      required this.idDocController,
      required this.nameDocController,
      required this.child,
      required this.calenderController,
      this.expiryType,
      required this.onSavePredded,
      required this.radioButton, this.isSaving,   this.loadingDuration = 3, required this.title,});

  @override
  State<EmpDocEditPopup> createState() => _EmpDocEditPopupState();
}

class _EmpDocEditPopupState extends State<EmpDocEditPopup> {
  //TextEditingController calenderController = TextEditingController();
  final DateTime _selectedDate = DateTime.now();
  String? _errorMessage;
  bool _isLoading = false;

  void _handlePress() {
    setState(() {
      _isLoading = true;
    });

    widget.onSavePredded.call();
    Future.delayed(Duration(seconds: widget.loadingDuration!), () {
      setState(() {
        _isLoading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    bool isSaving = false;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s400,
        height: AppSize.s550,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              decoration:  BoxDecoration(
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
                    padding: const EdgeInsets.only(left: 10.0),
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
                    icon: Icon(Icons.close,color: ColorManager.white,),
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
                  SMTextFConst(
                    enable: false,
                    controller: widget.idDocController,
                    keyboardType: TextInputType.text,
                    text: 'ID of the Document',
                  ),
                  SizedBox(height: AppSize.s8),
                  SMTextFConst(
                    controller: widget.nameDocController,
                    keyboardType: TextInputType.text,
                    text: 'Name of the Document',
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
                          //decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(height: 5),
                      widget.child,
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),

            ///radio
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expiry Type',
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.mediumgrey,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  widget.radioButton
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
                children: [
                  Text(
                    'Expiry Date',
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.mediumgrey,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  FormField<String>(
                    builder: (FormFieldState<String> field) {
                      return SizedBox(
                        width: 354,
                        height: 30,
                        child: TextFormField(
                          style: GoogleFonts.firaSans(
                            fontSize: FontSize.s12,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.mediumgrey,
                            //decoration: TextDecoration.none,
                          ),
                          controller: widget.calenderController,
                          decoration: InputDecoration(
                            focusColor: ColorManager.mediumgrey,
                            hoverColor: ColorManager.mediumgrey,
                            hintText: 'mm-dd-yyyy',
                            hintStyle: GoogleFonts.firaSans(
                              fontSize: FontSize.s12,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.mediumgrey,
                              //decoration: TextDecoration.none,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  width: 1, color: ColorManager.mediumgrey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  width: 1,
                                  color: ColorManager
                                      .mediumgrey), // Set focused border color to red
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  width: 1,
                                  color: ColorManager
                                      .mediumgrey), // Set enabled border color to red
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                            suffixIcon: Icon(Icons.calendar_month_outlined,
                                color: ColorManager.blueprime),
                            errorText: field.errorText,
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1100),
                              lastDate: DateTime(2025),
                            );
                            if (date != null) {
                              String formattedDate =
                                  DateFormat('MM-dd-yyyy').format(date);
                              widget.calenderController.text = formattedDate;
                              field.didChange(formattedDate);
                              // birthdayController.text =
                              // date.toLocal().toString().split(' ')[0];
                              // field.didChange(date.toLocal().toString().split(' ')[0]);
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please select birth date';
                            }
                            return null;
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Spacer(),
            _isLoading
                ? SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(
                color: ColorManager.blueprime,
              ),
            )
                : Center(
              child:  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomElevatedButton(
                        width: AppSize.s105,
                        height: AppSize.s30,
                        text: AppStringEM.submit,
                        // onPressed: widget.onSavePredded
                        onPressed: () async {
                          setState(()  {
                            _isLoading = true;
                            isSaving = true;
                            Navigator.pop(context);
                          });
                          await widget.onSavePredded();
                          setState(() {
                            _isLoading = false;
                          });
                        },

                      ),
                    ),
            ),
            // if (_errorMessage != null)
            //   Padding(
            //     padding: const EdgeInsets.all(AppPadding.p8),
            //     child: Text(
            //       _errorMessage!,
            //       style: CustomTextStylesCommon.commonStyle(
            //         color: ColorManager.red,
            //         fontSize: FontSize.s14,
            //         fontWeight: FontWeightManager.bold,
            //       ),
            //     ),

          ],
        ),
      ),
    );
  }
}
