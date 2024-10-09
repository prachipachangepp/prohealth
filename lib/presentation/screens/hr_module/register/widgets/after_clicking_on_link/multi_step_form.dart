import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/after_clicking_on_link/thank_you_screen.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../manage/widgets/bottom_row.dart';
import '../../../manage/widgets/top_row.dart';
import '../../taxtfield_constant.dart';
import '../dropdown_const.dart';
import 'constant_in_all.dart';
import 'form_screen/form_acknowledgements_screen.dart';
import 'form_screen/form_banking_screen.dart';
import 'form_screen/form_educaton_screen.dart';
import 'form_screen/form_employment_screen.dart';
import 'form_screen/form_general_Screen.dart';
import 'form_screen/form_health_records_screen.dart';
import 'form_screen/form_legal_documents_screen.dart';
import 'form_screen/form_licenses_screen.dart';
import 'form_screen/form_reference_screen.dart';

class MultiStepForm extends StatefulWidget {
  //final int userID;
  final int employeeID;

  const MultiStepForm({super.key, required this.employeeID, });
  @override
  _MultiStepFormState createState() => _MultiStepFormState();
}

class _MultiStepFormState extends State<MultiStepForm> {
  double textFieldWidth = 430;
  double textFieldHeight = 38;

  TextEditingController firstName = TextEditingController();

  ///
  // TextEditingController _controller = TextEditingController();
  // TextEditingController _controllerIssueDate = TextEditingController();
  // TextEditingController _controllerExpirationDate = TextEditingController();
  // Current step in the stepper
  int _currentStep = 0;

  bool isChecked = false;

  bool get isFirstStep => _currentStep == 0;

  bool get isLastStep => _currentStep == steps().length - 1;
  bool isCompleted = false;
  // String? _selectedCountry;
  // String? _selectedClinician;
  // String? _selectedSpeciality;
  // String? _selectedDegree;
  // bool _passwordVisible = false;
  // String? _selectedType;
  // String? _selectedType1;
// Navigator.push(context, MaterialPageRoute(builder: (context)=>MultiStepForm()));
  @override
  Widget build(BuildContext context) {
    return
      isCompleted
          ? OnBoardingThankYou()
          :
      Scaffold(
        backgroundColor: Colors.white,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: TopRowConstant(),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Details",
                    style: FormHeading.customTextStyle(context),
                  ),
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: const Color(0xff50B5E5),
                  //     foregroundColor: Colors.white,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //   ),
                  //   onPressed: () {},
                  //   child: Text(
                  //     "Save Progress",
                  //     style: GoogleFonts.firaSans(
                  //       fontSize: 14.0,
                  //       fontWeight: FontWeight.w700,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            const SizedBox(
              height: AppSize.s5,
            ),
            Container(
              // height: MediaQuery.of(context).size.height / 4,
              // width: MediaQuery.of(context).size.width / 1.1,
              // color: Colors.yellow,
              child: Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent
                    ),
                    child: Stepper(
                      physics: const ScrollPhysics(),
                      type: StepperType.horizontal,
                      steps: steps(),
                      currentStep: _currentStep,
                      onStepContinue: () {
                        if (isLastStep) {
                          setState(() => isCompleted = true);
                        } else {
                          setState(() => _currentStep += 1);
                        }
                      },
                      onStepCancel: isFirstStep
                          ? null
                          : () => setState(() => _currentStep -= 1),
                      controlsBuilder: (context, details) => Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (!isFirstStep) ...[
                              const SizedBox(
                                width: 20,
                              ),
                              // ElevatedButton.icon(
                              //   style: ElevatedButton.styleFrom(
                              //     backgroundColor: Colors.white,
                              //     foregroundColor: const Color(0xff1696C8),
                              //     side: const BorderSide(color: Color(0xff1696C8)),
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(8),
                              //     ),
                              //   ),
                              //   onPressed: details.onStepCancel,
                              //   label: Text(
                              //     "Back",
                              //     style: GoogleFonts.firaSans(
                              //       fontSize: 12.0,
                              //       fontWeight: FontWeight.w700,
                              //       //color: Colors.white,
                              //     ),
                              //   ),
                              //   icon: const Icon(Icons.arrow_back,  size: 16,),
                              // )
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: ColorManager.black,
                                    size: 20,
                                  ),
                                ),
                                onTap: details.onStepCancel,
                              )
                            ],
                            const SizedBox(
                              width: 20,
                            ),

                            InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: ColorManager.bluelight,
                                    size: 20,
                                  ),
                                ),
                                onTap:()async{
                                  isLastStep ? Navigator.push(context, MaterialPageRoute(builder: (_)=>OnBoardingThankYou())): details.onStepContinue!();
                                }
                            ),



                            // Container(
                            //   height: 30,
                            //   width: 140,
                            //   child: CustomIconButton(
                            //     icon: Icons.arrow_forward_rounded,
                            //     text: isLastStep ? 'Submit' : 'Continue',
                            //     onPressed: () async{
                            //       //details.onStepContinue!();
                            //       isLastStep ? Navigator.push(context, MaterialPageRoute(builder: (_)=>OnBoardingThankYou())): details.onStepContinue!();
                            //     },
                            //   ),
                            // ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                      onStepTapped: (step) =>
                          setState(() => _currentStep = step),
                    ),
                  ),
                ),
              ),
            ),
            // const Row(
            //   children: [BottomBarRow()],
            // )
          ],
        ),
        bottomNavigationBar: BottomBarRow(),
      );
  }

  List<Step> steps() => [
    Step(
      state: _currentStep <= 0 ? StepState.editing : StepState.complete,
      isActive: _currentStep >= 0,
      title: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Text(
          'General',
          style: formNameText.customTextStyle(context),
        ),
      ),
      content: generalForm(context: context, employeeID: widget.employeeID, ),
    ),
    Step(
      state: _currentStep <= 1 ? StepState.editing : StepState.complete,
      isActive: _currentStep >= 1,
      title: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Text(
          'Employment',
          style:  formNameText.customTextStyle(context),
        ),
      ),
      content: Employment_screen(context: context, employeeID: widget.employeeID,),
    ),
    Step(
      state: _currentStep <= 2 ? StepState.editing : StepState.complete,
      isActive: _currentStep >= 2,
      title: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Text(
          'Education',
          style:  formNameText.customTextStyle(context),
        ),
      ),
      content: EducationScreen(context: context, employeeID: widget.employeeID),
    ),
    Step(
      state: _currentStep <= 3 ? StepState.editing : StepState.complete,
      isActive: _currentStep >= 3,
      title: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Text(
          'References',
          style:  formNameText.customTextStyle(context),
        ),
      ),
      content: ReferencesScreen(context: context, employeeID: widget.employeeID),
    ),
    Step(
      state: _currentStep <= 4 ? StepState.editing : StepState.complete,
      isActive: _currentStep >= 4,
      title: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Text(
          'Licenses',
          style: formNameText.customTextStyle(context),
        ),
      ),
      content: LicensesScreen(context: context, employeeID: widget.employeeID),
    ),
    Step(
      state: _currentStep <= 5 ? StepState.editing : StepState.complete,
      isActive: _currentStep >= 5,
      title: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Text(
          'Banking',
          style:  formNameText.customTextStyle(context),
        ),
      ),
      content: BankingScreen(context: context, employeeID: widget.employeeID),
    ),
    Step(
      state: _currentStep <= 6 ? StepState.editing : StepState.complete,
      isActive: _currentStep >= 6,
      title: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Text(
          'Health \nRecords',
          style: formNameText.customTextStyle(context),
        ),
      ),
      content: HealthRecordsScreen(context: context, employeeID: widget.employeeID,),
    ),
    Step(
      state: _currentStep <= 7 ? StepState.editing : StepState.complete,
      isActive: _currentStep >= 7,
      title: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Text(
          'Acknowledgements',
          style: formNameText.customTextStyle(context),
        ),
      ),
      content: AcknowledgementsScreen(context: context, employeeID: widget.employeeID,),
    ),
    Step(
      state: _currentStep <= 8 ? StepState.editing : StepState.complete,
      isActive: _currentStep >= 8,
      title: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Text(
          'Legal \nDocuments',
          style:  formNameText.customTextStyle(context),
        ),
      ),
      content: LegalDocumentsScreen(context: context, employeeID: widget.employeeID,),
    ),
  ];

// blueprime
//   List<Step> steps() => [
//         Step(
//             state: _currentStep <= 0 ? StepState.editing : StepState.complete,
//             isActive: _currentStep >= 0,
//             title: Text(
//               'General',
//               style: GoogleFonts.firaSans(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//                 color: ColorManager.grey,
//                 decoration: TextDecoration.none,
//               ),
//             ),
//             content: generalForm(context: context)),
//
//         Step(
//           state: _currentStep <= 1 ? StepState.editing : StepState.complete,
//           isActive: _currentStep >= 1,
//           title: Text(
//             'Employment',
//             style: GoogleFonts.firaSans(
//               fontSize: 12,
//               fontWeight: FontWeight.w400,
//               color: ColorManager.grey,
//               decoration: TextDecoration.none,
//             ),
//           ),
//           content: Employment_screen(context: context),
//         ),
//         ///
//         Step(
//           state: _currentStep <= 2 ? StepState.editing : StepState.complete,
//           isActive: _currentStep >= 2,
//           title: Text(
//             'Education',
//             style: GoogleFonts.firaSans(
//               fontSize: 12,
//               fontWeight: FontWeight.w400,
//               color: ColorManager.grey,
//               decoration: TextDecoration.none,
//             ),
//           ),
//           content: EducationScreen(context: context),
//         ),
//         ///
//         Step(
//           state: _currentStep <= 3 ? StepState.editing : StepState.complete,
//           isActive: _currentStep >= 3,
//           title: Text(
//             'References',
//             style: GoogleFonts.firaSans(
//               fontSize: 12,
//               fontWeight: FontWeight.w400,
//               color: ColorManager.grey,
//               decoration: TextDecoration.none,
//             ),
//           ),
//           content: ReferencesScreen(context: context),
//         ),
//         ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//         Step(
//           state: _currentStep <= 4 ? StepState.editing : StepState.complete,
//           isActive: _currentStep >= 4,
//           title: Text(
//             'Licenses',
//             style: GoogleFonts.firaSans(
//               fontSize: 12,
//               fontWeight: FontWeight.w400,
//               color: ColorManager.grey,
//               decoration: TextDecoration.none,
//             ),
//           ),
//           content: LicensesScreen(context: context),
//         ),
//
//         ///
//         Step(
//           state: _currentStep <= 5 ? StepState.editing : StepState.complete,
//           isActive: _currentStep >= 5,
//           title: Text(
//             'Banking',
//             style: GoogleFonts.firaSans(
//               fontSize: 12,
//               fontWeight: FontWeight.w400,
//               color: ColorManager.grey,
//               decoration: TextDecoration.none,
//             ),
//           ),
//           content: BankingScreen(context: context),
//         ),
// ///
//         Step(
//           state: _currentStep <= 6 ? StepState.editing : StepState.complete,
//           isActive: _currentStep >= 6,
//           title: Text(
//             'Health \nRecords',
//             style: GoogleFonts.firaSans(
//               fontSize: 12,
//               fontWeight: FontWeight.w400,
//               color: ColorManager.grey,
//               decoration: TextDecoration.none,
//             ),
//           ),
//           content: HealthRecordsScreen(context: context),
//         ),
//         ////////////////////////////////////
//         Step(
//           state: _currentStep <= 7 ? StepState.editing : StepState.complete,
//           isActive: _currentStep >= 7,
//           title: Text(
//             'Acknowledgements',
//             style: GoogleFonts.firaSans(
//               fontSize: 12,
//               fontWeight: FontWeight.w400,
//               color: ColorManager.grey,
//               decoration: TextDecoration.none,
//             ),
//           ),
//           content: AcknowledgementsScreen(context: context),
//         ),
//         ///
//
//         Step(
//           state: _currentStep <= 8 ? StepState.editing : StepState.complete,
//           isActive: _currentStep >= 8,
//           title: Text(
//             'Legal \nDocuments',
//             style: GoogleFonts.firaSans(
//               fontSize: 12,
//               fontWeight: FontWeight.w400,
//               color: ColorManager.grey,
//               decoration: TextDecoration.none,
//             ),
//           ),
//           content: LegalDocumentsScreen(context: context),
//         )
//       ];
}
//
// ElevatedButton.icon(
//   style: ElevatedButton.styleFrom(
//     backgroundColor: const Color(0xff1696C8),
//     foregroundColor: Colors.white,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(8),
//     ),
//   ),
//   onPressed: details.onStepContinue,
//   //     (){
//   //
//   //   details.onStepContinue;
//   // },
//   label: Text(
//     isLastStep ? 'Confirm' : 'Continue',
//     style: GoogleFonts.firaSans(
//       fontSize: 12.0,
//       fontWeight: FontWeight.w700,
//       color: Colors.white,
//     ),
//   ),
//   icon: const Icon(Icons.arrow_forward, size: 16,),
// ),
