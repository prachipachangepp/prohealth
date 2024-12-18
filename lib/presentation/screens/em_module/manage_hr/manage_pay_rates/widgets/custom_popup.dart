import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import 'package:prohealth/presentation/widgets/error_popups/failed_popup.dart';
import 'package:prohealth/presentation/widgets/error_popups/four_not_four_popup.dart';

import '../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../app/services/api/managers/establishment_manager/ci_visit_manager.dart';
import '../../../../../../app/services/api/managers/establishment_manager/pay_rates_manager.dart';
import '../../../../../../data/api_data/establishment_data/company_identity/ci_visit_data.dart';
import '../../../company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import '../../../company_identity/widgets/whitelabelling/success_popup.dart';
import '../../../widgets/dialogue_template.dart';

class PayRateAddPopup extends StatefulWidget {
  //final Widget child1;
  // final Widget child2;
  final String title;
  final String serviceId;
  final int empTypeId;
  // final Future<void> Function() onPressed;
  final TextEditingController fixPayRatesController;
  final TextEditingController payRatesController;
  final TextEditingController perMilesController;
  final bool visitTypeTextActive;

  PayRateAddPopup({
    super.key,
    // required this.child1,
    //  required this.child2,
    required this.payRatesController,
    // required this.onPressed,
    required this.title,
    required this.serviceId,
    required this.empTypeId,
    required this.perMilesController, required this.visitTypeTextActive, required this.fixPayRatesController,
  });

  @override
  State<PayRateAddPopup> createState() => _PayRateAddPopupState();
}

class _PayRateAddPopupState extends State<PayRateAddPopup> {
  bool isLoading = false;
  String? docAddVisitTypeId;
  // String serviceId = "";

  // Error messages
  String? payRatesError;
  String? perMilesError;
  String? fixPayRatesError;

  void _validateAndSubmit() {
    setState(() {
      payRatesError = widget.payRatesController.text.isEmpty ? 'Please enter a payrate' : null;
      perMilesError = widget.perMilesController.text.isEmpty ? 'Please enter a per mile' : null;
      fixPayRatesError = widget.fixPayRatesController.text.isEmpty ? 'Please enter a fixed rate' : null;
    });

    if (payRatesError == null && perMilesError == null && fixPayRatesError == null) {
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(

      width: AppSize.s400,
      height: AppSize.s460,
      title: widget.title,

      body: [

        Padding(
          padding: const EdgeInsets.symmetric(

            horizontal: AppPadding.p10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.visitTypeTextActive ?
                  RichText(
                    text: TextSpan(
                      text:"Type of Visit", // Main text
                      style: AllPopupHeadings.customTextStyle(context), // Main style
                      children: [
                        TextSpan(
                          text: ' *', // Asterisk
                          style: AllPopupHeadings.customTextStyle(context).copyWith(
                            color: ColorManager.red, // Asterisk color
                          ),
                        ),
                      ],
                    ),
                  )
                  // Text(
                  //   'Type of Visit',
                  //   style:  DefineWorkWeekStyle.customTextStyle(context),
                  // )
                      : Offstage(),
                  SizedBox(height: 5,),
                  //widget.child1,
                  FutureBuilder<List<VisitListDataByServiceId>>(
                    future: getVisitListByServiceId(context:context, serviceId: widget.serviceId,),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Container(
                          width:  354,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorManager.containerBorderGrey, width: AppSize.s1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding:  EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                            child: Text(
                                "",
                                //AppString.dataNotFound,
                                style: ConstTextFieldRegister.customTextStyle(context)
                            ),
                          ),
                        );
                        //   CICCDropDownExcel(
                        //   width: 354,
                        //   initialValue: 'Select',
                        //   items: [],
                        // );
                      }
                      if (snapshot.hasData &&
                          snapshot.data!.isEmpty) {
                        return Container(
                          width:  354,
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorManager.containerBorderGrey, width: AppSize.s1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding:  EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                            child: Text(
                                "No available visits!",
                                //AppString.dataNotFound,
                                style: ConstTextFieldRegister.customTextStyle(context)
                            ),
                          ),
                        );
                      }
                      if (snapshot.hasData) {
                        List<DropdownMenuItem<String>>
                        dropDownZoneList = [];
                        for (var i in snapshot.data!) {
                          dropDownZoneList.add(
                            DropdownMenuItem<String>(
                              child: Text(i.visitType),
                              value: i.visitType,
                            ),
                          );
                        }
                        return CICCDropDownExcel(
                          initialValue:
                          dropDownZoneList.isNotEmpty
                              ? dropDownZoneList[0].value
                              : null,
                          onChange: (val) {
                            for (var a in snapshot.data!) {
                              if (a.visitType == val) {
                                docAddVisitTypeId = a.visitType;
                                print('empId ${a.visitId}');
                              }
                            }
                          },
                          items: dropDownZoneList,
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  SizedBox(height: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SMTextfieldAsteric(
                        prefixWidget: Text("\$ "),
                        controller: widget.payRatesController,
                        keyboardType: TextInputType.number,
                        text: 'Payrates',
                      ),
                      if (payRatesError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            payRatesError!,
                            style:  CommonErrorMsg.customTextStyle(context),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text("Out of Zone",
                    style:  DefineWorkWeekStyle.customTextStyle(context),),
                  SizedBox(height: 20,),
                  //////////////


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SMTextfieldAsteric(
                            width: 150,
                            prefixWidget: Text("\$ "),
                            controller: widget.fixPayRatesController,
                            keyboardType: TextInputType.number,
                            text: 'Fixed Rate',
                          ),
                          if (fixPayRatesError != null)
                            Text(
                              fixPayRatesError!,
                              style:  CommonErrorMsg.customTextStyle(context),
                            ),
                        ],
                      ),

                      SizedBox(height: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SMTextfieldAsteric(
                            width: 150,
                            prefixWidget: Text("\$ "),
                            controller: widget.perMilesController,
                            keyboardType: TextInputType.number,
                            text: 'Per Mile',
                          ),
                          if (perMilesError != null)
                            Text(
                              perMilesError!,
                              style:  CommonErrorMsg.customTextStyle(context),
                            ),
                        ],
                      ),


                    ],
                  ),
                ],
              ),
            ],
          ),
        ),


      ], bottomButtons:  isLoading
        ? SizedBox(
        height: 25,
        width: 25,
        child: CircularProgressIndicator(color: ColorManager.blueprime,)
    )
        : CustomElevatedButton(
      width: AppSize.s105,
      height: AppSize.s30,
      text: AppStringEM.submit,
      onPressed: () async {
        _validateAndSubmit();
        if (payRatesError == null && perMilesError == null && fixPayRatesError == null) {
          if (docAddVisitTypeId != null) {
            try {
              int rate = int.parse(widget.payRatesController.text);
              String typeOfVisitId = docAddVisitTypeId.toString();
              int perMile = int.parse(widget.perMilesController.text);
              String serviceTypeId = widget.serviceId;
              int fixedRate = int.parse(widget.fixPayRatesController.text);
              var response = await addPayrates(
                context,
                widget.empTypeId,
                rate,
                typeOfVisitId,
                perMile,
                serviceTypeId,
                fixedRate,
              );
              if(response.statusCode == 200 || response.statusCode == 201){
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddSuccessPopup(
                      message: 'Added Successfully',
                    );
                  },
                );
              }else if(response.statusCode == 400 || response.statusCode == 404){
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const FourNotFourPopup(),
                );
              }
              else {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) => FailedPopup(text: response.message),
                );
              }

            } catch (e) {
              print("Failed to add pay rates: $e");
            }
          } else {
            print("Required data is missing.");
          }
        }
      },
    ),
    );
  }
}


///edit
class PayRatesEditsPopup extends StatefulWidget {
  final Widget child1;
  final Widget child2;
  final String title;
  final Future<void> Function() onPressed;
  final TextEditingController fixPayRatesController;
  final TextEditingController payRatesController;
  final TextEditingController perMilesController;
  final bool visitTypeTextActive;

  PayRatesEditsPopup({
    super.key,
    required this.child1,
    required this.child2,
    required this.payRatesController,
    required this.onPressed,
    required this.title,
    required this.perMilesController, required this.visitTypeTextActive, required this.fixPayRatesController,
  });

  @override
  State<PayRatesEditsPopup> createState() => _PayRatesEditsPopupState();
}

class _PayRatesEditsPopupState extends State<PayRatesEditsPopup> {
  bool isLoading = false;

  // Error messages
  String? payRatesError;
  String? perMilesError;
  String? perError;

  void _validateAndSubmit() {
    setState(() {
      payRatesError = widget.fixPayRatesController.text.isEmpty ? 'Please enter a fix rate' : null;
      perMilesError = widget.perMilesController.text.isEmpty ? 'Please enter a per mile' : null;
      perError = widget.payRatesController.text.isEmpty ? 'Please enter a payrate' : null;
    });

    if (payRatesError == null && perMilesError == null && perError == null) {
      // If no errors, proceed with the onPressed action
      widget.onPressed().whenComplete(() {
        setState(() {
          isLoading = false;
        });
        Navigator.pop(context);
        widget.payRatesController.clear();
        widget.perMilesController.clear();
        widget.fixPayRatesController.clear();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AddSuccessPopup(
              message: 'Edit Successfully',
            );
          },
        );
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(

      width: AppSize.s400,
      height: AppSize.s460,
      title: widget.title,

      body: [

        Padding(
          padding: const EdgeInsets.symmetric(

            horizontal: AppPadding.p10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.visitTypeTextActive ? Text(
                    'Type of Visit',
                    style:  DefineWorkWeekStyle.customTextStyle(context),
                  ) : Offstage(),
                  SizedBox(height: 5,),
                  widget.child1,
                  SizedBox(height: 20,),
                  SMTextfieldAsteric(
                    prefixWidget: Text("\$ "),
                    controller: widget.payRatesController,
                    keyboardType: TextInputType.number,
                    text: 'Payrates',
                  ),
                  if (perError != null)
                    Text(
                      perError!,
                      style:  CommonErrorMsg.customTextStyle(context),
                    ),
                  SizedBox(height: 17,),
                  Text("Out of Zone", style:  DefineWorkWeekStyle.customTextStyle(context),),
                  SizedBox(height: 17,),
                  //////////////


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SMTextfieldAsteric(
                            width: 150,
                            prefixWidget: Text("\$ "),
                            controller: widget.fixPayRatesController,
                            keyboardType: TextInputType.number,
                            text: 'Fixed Rate',
                          ),
                          if (payRatesError != null)
                            Text(
                              payRatesError!,
                              style:  CommonErrorMsg.customTextStyle(context),
                            ),
                        ],
                      ),

                      SizedBox(height: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SMTextfieldAsteric(
                            width: 150,
                            prefixWidget: Text("\$ "),
                            controller: widget.perMilesController,
                            keyboardType: TextInputType.number,
                            text: 'Per Mile',
                          ),
                          if (perMilesError != null)
                            Text(
                              perMilesError!,
                              style:  CommonErrorMsg.customTextStyle(context),
                            ),
                        ],
                      ),


                    ],
                  ),
                ],
              ),
            ],
          ),
        ),


      ],
      bottomButtons:  isLoading
          ? SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(color: ColorManager.blueprime,)
      )
          : CustomElevatedButton(
        width: AppSize.s105,
        height: AppSize.s30,
        text: AppStringEM.submit,
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          _validateAndSubmit();


        },
      ),
    );
  }
}