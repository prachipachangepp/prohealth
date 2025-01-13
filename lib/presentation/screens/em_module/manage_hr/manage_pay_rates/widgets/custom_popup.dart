import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import 'package:prohealth/presentation/widgets/error_popups/failed_popup.dart';
import 'package:prohealth/presentation/widgets/error_popups/four_not_four_popup.dart';
import 'package:provider/provider.dart';
import '../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../app/services/api/managers/establishment_manager/ci_visit_manager.dart';
import '../../../../../../app/services/api/managers/establishment_manager/pay_rates_manager.dart';
import '../../../../../../data/api_data/establishment_data/company_identity/ci_visit_data.dart';
import '../../../company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import '../../../company_identity/widgets/whitelabelling/success_popup.dart';
import '../../../widgets/dialogue_template.dart';

///added provider
class PayRatesProvider extends ChangeNotifier {
  String? payRatesError;
  String? perMilesError;
  String? fixPayRatesError;
  bool isLoading = false;
  String docAddVisitTypeId = 'Select Visit';

  void validateAndSubmit({
    required String payRates,
    required String perMiles,
    required String fixPayRates,
  }) {
    // Validate form fields
    payRatesError = payRates.isEmpty ? 'Please enter a payrate' : null;
    perMilesError = perMiles.isEmpty ? 'Please enter a per mile' : null;
    fixPayRatesError = fixPayRates.isEmpty ? 'Please enter a fixed rate' : null;

    // Check if any error exists
    if (payRatesError == null && perMilesError == null && fixPayRatesError == null) {
      // Form is valid, can proceed
    } else {
      // Show loading state if there are errors
      isLoading = true;
      notifyListeners();
      // Simulate some delay for loading (optional)
      Future.delayed(const Duration(seconds: 2), () {
        isLoading = false;
        notifyListeners();
      });
    }

    // Notify listeners for UI update
    notifyListeners();
  }
}

class PayRateAddPopup extends StatelessWidget {
  final String title;
  final String serviceId;
  final int empTypeId;
  final VoidCallback? onSave;

  final TextEditingController fixPayRatesController;
  final TextEditingController payRatesController;
  final TextEditingController perMilesController;
  final bool visitTypeTextActive;
  const PayRateAddPopup({super.key, required this.title, required this.serviceId, required this.empTypeId, required this.fixPayRatesController, required this.payRatesController, required this.perMilesController, required this.visitTypeTextActive, this.onSave});

  @override
  Widget build(BuildContext context) {
    return Consumer<PayRatesProvider>(builder: (context, provider, child){
      return DialogueTemplate(
        width: AppSize.s400,
        height: AppSize.s460,
        title: title,
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
                    visitTypeTextActive ?
                    RichText(
                      text: TextSpan(
                        text:AppStringEM.typeVisit, // Main text
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
                        : Offstage(),
                    SizedBox(height: AppSize.s5,),
                    //widget.child1,
                    FutureBuilder<List<VisitListDataByServiceId>>(
                      future: getVisitListByServiceId(context:context, serviceId: serviceId,),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Container(
                            width: AppSize.s354,
                            height: AppSize.s30,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: ColorManager.containerBorderGrey, width: AppSize.s1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding:  EdgeInsets.symmetric(vertical: AppPadding.p5,horizontal: AppPadding.p5),
                              child: Text(
                                  provider.docAddVisitTypeId,
                                  style: ConstTextFieldRegister.customTextStyle(context)
                              ),
                            ),
                          );
                        }
                        if (snapshot.hasData && snapshot.data!.isEmpty) {
                          return Container(
                            width: AppSize.s354,
                            height: AppSize.s30,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: ColorManager.containerBorderGrey, width: AppSize.s1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding:  EdgeInsets.symmetric(vertical: AppPadding.p5,horizontal: AppPadding.p5),
                              child: Text(
                                  ErrorMessageString.noVisit,
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
                            initialValue:provider.docAddVisitTypeId,
                            onChange: (val) {
                              for (var a in snapshot.data!) {
                                if (a.visitType == val) {
                                  provider.docAddVisitTypeId = a.visitType;
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
                    SizedBox(height: AppSize.s20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SMTextfieldAsteric(
                          prefixWidget: Text("\$ "),
                          controller: payRatesController,
                          keyboardType: TextInputType.number,
                          text: AppStringEM.payrates,
                        ),
                        if (provider.payRatesError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: AppPadding.p5),
                            child: Text(
                              provider.payRatesError!,
                              style:  CommonErrorMsg.customTextStyle(context),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: AppSize.s20,),
                    Text(AppStringEM.outOfZone,
                      style:  DefineWorkWeekStyle.customTextStyle(context),),
                    SizedBox(height: AppSize.s20,),
                    //////////////


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SMTextfieldAsteric(
                              width: AppSize.s150,
                              prefixWidget: Text("\$ "),
                              controller: fixPayRatesController,
                              keyboardType: TextInputType.number,
                              text: AppStringEM.fixrate,
                            ),
                            if (provider.fixPayRatesError != null)
                              Text(
                                provider.fixPayRatesError!,
                                style:  CommonErrorMsg.customTextStyle(context),
                              ),
                          ],
                        ),

                        SizedBox(height: AppSize.s20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SMTextfieldAsteric(
                              width: AppSize.s150,
                              prefixWidget: Text("\$ "),
                              controller: perMilesController,
                              keyboardType: TextInputType.number,
                              text: AppStringEM.perMile,
                            ),
                            if (provider.perMilesError != null)
                              Text(
                                provider.perMilesError!,
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
        bottomButtons:  provider.isLoading
          ? SizedBox(
          height: AppSize.s25,
          width: AppSize.s25,
          child: CircularProgressIndicator(color: ColorManager.blueprime,)
      )
          : CustomElevatedButton(
        width: AppSize.s105,
        height: AppSize.s30,
        text: AppStringEM.submit,
        onPressed: () async {
          provider.validateAndSubmit(payRates: payRatesController.text, perMiles: perMilesController.text, fixPayRates: fixPayRatesController.text);
          if (provider.payRatesError == null && provider.perMilesError == null && provider.fixPayRatesError == null) {
            if (provider.docAddVisitTypeId != null) {
              try {
                int rate = int.parse(payRatesController.text);
                String typeOfVisitId = provider.docAddVisitTypeId.toString();
                int perMile = int.parse(perMilesController.text);
                String serviceTypeId = serviceId;
                int fixedRate = int.parse(fixPayRatesController.text);
                var response = await addPayrates(
                  context,
                  empTypeId,
                  rate,
                  typeOfVisitId,
                  perMile,
                  serviceTypeId,
                  fixedRate,
                );
                if(response.statusCode == 200 || response.statusCode == 201){
                  if (onSave != null) {
                    onSave!(); // Trigger the callback to refresh the data
                  }
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
              finally{
                if (onSave != null) {
                  onSave!(); // Trigger the callback to refresh the data
                }
              }
            } else {
              print("Required data is missing.");
            }
          }
        },
      ),
      );
    });
  }
}

///edit
class PayRatesEditProvider extends ChangeNotifier {
  bool isLoading = false;

  // Error messages
  String? payRatesError;
  String? perMilesError;
  String? perError;
  void validateAndSubmit({
    required String payRates,
    required String perMiles,
    required String fixPayRates,
    required Function onPressed,
    required BuildContext context,
    required TextEditingController payRatesController,
    required TextEditingController perMilesController,
    required TextEditingController fixPayRatesController,
  }) {
    // Validate form fields
    payRatesError = payRates.isEmpty ? 'Please enter a payrate' : null;
    perMilesError = perMiles.isEmpty ? 'Please enter a per mile' : null;
    perError = fixPayRates.isEmpty ? 'Please enter a fix rate' : null;

    // If there are no validation errors
    if (payRatesError == null && perMilesError == null && perError == null) {
      isLoading = true;
      notifyListeners();

      // Call onPressed action (this is assumed to be a function that performs an action)
      onPressed().whenComplete(() {
        isLoading = false;
        notifyListeners();

        Navigator.pop(context);
        payRatesController.clear();
        perMilesController.clear();
        fixPayRatesController.clear();

        // Show success dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AddSuccessPopup(message: 'Edit Successfully');
          },
        );
      });
    } else {
      isLoading = false;
      notifyListeners();
    }
  }
}

class PayRatesEditsPopup extends StatelessWidget {
  final Widget child1;
  final Widget child2;
  final String title;
  final Future<void> Function() onPressed;
  final TextEditingController fixPayRatesController;
  final TextEditingController payRatesController;
  final TextEditingController perMilesController;
  final bool visitTypeTextActive;

  const PayRatesEditsPopup({super.key, required this.child1, required this.child2, required this.title, required this.onPressed, required this.fixPayRatesController, required this.payRatesController, required this.perMilesController, required this.visitTypeTextActive});

  @override
  Widget build(BuildContext context) {
    return Consumer<PayRatesEditProvider>(builder: (context, provider, child){
      return DialogueTemplate(
        width: AppSize.s400,
        height: AppSize.s460,
        title: title,
        body: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    visitTypeTextActive ? Text(
                      AppStringEM.typeVisit,
                      style:  DefineWorkWeekStyle.customTextStyle(context),
                    ) : Offstage(),
                    SizedBox(height: AppSize.s5,),
                    child1,
                    SizedBox(height: AppSize.s20,),
                    SMTextfieldAsteric(
                      prefixWidget: Text("\$ "),
                      controller: payRatesController,
                      keyboardType: TextInputType.number,
                      text: AppStringEM.payrates,
                    ),
                    if (provider.perError != null)
                      Text(
                        provider.perError!,
                        style:  CommonErrorMsg.customTextStyle(context),
                      ),
                    SizedBox(height: AppSize.s17,),
                    Text(AppStringEM.outOfZone, style:  DefineWorkWeekStyle.customTextStyle(context),),
                    SizedBox(height: AppSize.s17,),
                    //////////////


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SMTextfieldAsteric(
                              width: AppSize.s150,
                              prefixWidget: Text("\$ "),
                              controller: fixPayRatesController,
                              keyboardType: TextInputType.number,
                              text: AppStringEM.fixrate,
                            ),
                            if (provider.payRatesError != null)
                              Text(
                                provider.payRatesError!,
                                style:  CommonErrorMsg.customTextStyle(context),
                              ),
                          ],
                        ),

                        SizedBox(height: AppSize.s20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SMTextfieldAsteric(
                              width: AppSize.s150,
                              prefixWidget: Text("\$ "),
                              controller: perMilesController,
                              keyboardType: TextInputType.number,
                              text: AppStringEM.perMile,
                            ),
                            if (provider.perMilesError != null)
                              Text(
                                provider.perMilesError!,
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
        bottomButtons:  provider.isLoading
            ? SizedBox(
            height: AppSize.s25,
            width: AppSize.s25,
            child: CircularProgressIndicator(color: ColorManager.blueprime,)
        )
            : CustomElevatedButton(
          width: AppSize.s105,
          height: AppSize.s30,
          text: AppStringEM.submit,
          onPressed: () async {
            //setState(() {
              provider.isLoading = true;
              provider.notifyListeners();
            //});
            provider.validateAndSubmit(payRates: payRatesController.text, perMiles: perMilesController.text, fixPayRates: fixPayRatesController.text, onPressed: onPressed, context: context, payRatesController: payRatesController, perMilesController: perMilesController, fixPayRatesController: fixPayRatesController);
          },
        ),
      );
    });
  }
}

// class PayRatesEditsPopup extends StatefulWidget {
//   final Widget child1;
//   final Widget child2;
//   final String title;
//   final Future<void> Function() onPressed;
//   final TextEditingController fixPayRatesController;
//   final TextEditingController payRatesController;
//   final TextEditingController perMilesController;
//   final bool visitTypeTextActive;
//
//   PayRatesEditsPopup({
//     super.key,
//     required this.child1,
//     required this.child2,
//     required this.payRatesController,
//     required this.onPressed,
//     required this.title,
//     required this.perMilesController, required this.visitTypeTextActive, required this.fixPayRatesController,
//   });
//
//   @override
//   State<PayRatesEditsPopup> createState() => _PayRatesEditsPopupState();
// }
//
// class _PayRatesEditsPopupState extends State<PayRatesEditsPopup> {
//   bool isLoading = false;
//
//   // Error messages
//   String? payRatesError;
//   String? perMilesError;
//   String? perError;
//
//   void _validateAndSubmit() {
//     setState(() {
//       payRatesError = widget.fixPayRatesController.text.isEmpty ? 'Please enter a fix rate' : null;
//       perMilesError = widget.perMilesController.text.isEmpty ? 'Please enter a per mile' : null;
//       perError = widget.payRatesController.text.isEmpty ? 'Please enter a payrate' : null;
//     });
//
//     if (payRatesError == null && perMilesError == null && perError == null) {
//       // If no errors, proceed with the onPressed action
//       widget.onPressed().whenComplete(() {
//         setState(() {
//           isLoading = false;
//         });
//         Navigator.pop(context);
//         widget.payRatesController.clear();
//         widget.perMilesController.clear();
//         widget.fixPayRatesController.clear();
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AddSuccessPopup(
//               message: 'Edit Successfully',
//             );
//           },
//         );
//       });
//     } else {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return DialogueTemplate(
//       width: AppSize.s400,
//       height: AppSize.s460,
//       title: widget.title,
//       body: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10,),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   widget.visitTypeTextActive ? Text(
//                     AppStringEM.typeVisit,
//                     style:  DefineWorkWeekStyle.customTextStyle(context),
//                   ) : Offstage(),
//                   SizedBox(height: AppSize.s5,),
//                   widget.child1,
//                   SizedBox(height: AppSize.s20,),
//                   SMTextfieldAsteric(
//                     prefixWidget: Text("\$ "),
//                     controller: widget.payRatesController,
//                     keyboardType: TextInputType.number,
//                     text: AppStringEM.payrates,
//                   ),
//                   if (perError != null)
//                     Text(
//                       perError!,
//                       style:  CommonErrorMsg.customTextStyle(context),
//                     ),
//                   SizedBox(height: AppSize.s17,),
//                   Text(AppStringEM.outOfZone, style:  DefineWorkWeekStyle.customTextStyle(context),),
//                   SizedBox(height: AppSize.s17,),
//                   //////////////
//
//
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SMTextfieldAsteric(
//                             width: AppSize.s150,
//                             prefixWidget: Text("\$ "),
//                             controller: widget.fixPayRatesController,
//                             keyboardType: TextInputType.number,
//                             text: AppStringEM.fixrate,
//                           ),
//                           if (payRatesError != null)
//                             Text(
//                               payRatesError!,
//                               style:  CommonErrorMsg.customTextStyle(context),
//                             ),
//                         ],
//                       ),
//
//                       SizedBox(height: AppSize.s20,),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SMTextfieldAsteric(
//                             width: AppSize.s150,
//                             prefixWidget: Text("\$ "),
//                             controller: widget.perMilesController,
//                             keyboardType: TextInputType.number,
//                             text: AppStringEM.perMile,
//                           ),
//                           if (perMilesError != null)
//                             Text(
//                               perMilesError!,
//                               style:  CommonErrorMsg.customTextStyle(context),
//                             ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//
//
//       ],
//       bottomButtons:  isLoading
//           ? SizedBox(
//           height: AppSize.s25,
//           width: AppSize.s25,
//           child: CircularProgressIndicator(color: ColorManager.blueprime,)
//       )
//           : CustomElevatedButton(
//         width: AppSize.s105,
//         height: AppSize.s30,
//         text: AppStringEM.submit,
//         onPressed: () async {
//           setState(() {
//             isLoading = true;
//           });
//           _validateAndSubmit();
//
//
//         },
//       ),
//     );
//   }
// }