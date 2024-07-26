

import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/after_clicking_on_link/widgets/container_constant.dart';

import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../../../widgets/widgets/constant_textfield/const_textfield.dart';
import '../../../../em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import '../../../add_employee/widget/mcq_widget_add-employee.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("     "),
                Text(
                  "Details",
                  style: GoogleFonts.firaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.blueprime,
                    decoration: TextDecoration.none,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff50B5E5),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // Add functionality for save and continue here
                  },
                  child: Text(
                    "Save Progress",
                    style: GoogleFonts.firaSans(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
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
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xff1696C8),
                              side: const BorderSide(color: Color(0xff1696C8)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: details.onStepCancel,
                            label: Text(
                              "Back",
                              style: GoogleFonts.firaSans(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w700,
                                //color: Colors.white,
                              ),
                            ),
                            icon: const Icon(Icons.arrow_back,  size: 16,),
                          )
                        ],
                        const SizedBox(
                          width: 20,
                        ),

                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff1696C8),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: details.onStepContinue,
                          //     (){
                          //
                          //   details.onStepContinue;
                          // },
                          label: Text(
                            isLastStep ? 'Confirm' : 'Continue',
                            style: GoogleFonts.firaSans(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          icon: const Icon(Icons.arrow_forward, size: 16,),
                        ),
                      ],
                    ),
                  ),
                  onStepTapped: (step) => setState(() => _currentStep = step),
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
            title: Text(
              'General',
              style: GoogleFonts.firaSans(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: ColorManager.grey,
                decoration: TextDecoration.none,
              ),
            ),
            content: generalForm(context: context)),
        /////////////////////////////////////////////////////////////////////////////////////////////
        Step(
          state: _currentStep <= 1 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 1,
          title: Text(
            'Employment',
            style: GoogleFonts.firaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorManager.grey,
              decoration: TextDecoration.none,
            ),
          ),
          content: Employment_screen(context: context),
        ),
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        Step(
          state: _currentStep <= 2 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 2,
          title: Text(
            'Education',
            style: GoogleFonts.firaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorManager.grey,
              decoration: TextDecoration.none,
            ),
          ),
          content: EducationScreen(context: context),
        ),
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        Step(
          state: _currentStep <= 3 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 3,
          title: Text(
            'References',
            style: GoogleFonts.firaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorManager.grey,
              decoration: TextDecoration.none,
            ),
          ),
          content: ReferencesScreen(context: context),
        ),
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        Step(
          state: _currentStep <= 4 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 4,
          title: Text(
            'Licenses',
            style: GoogleFonts.firaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorManager.grey,
              decoration: TextDecoration.none,
            ),
          ),
          content: LicensesScreen(context: context),
        ),

        ///////////////////////////////////////////////////////////////////////////
        Step(
          state: _currentStep <= 5 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 5,
          title: Text(
            'Banking',
            style: GoogleFonts.firaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorManager.grey,
              decoration: TextDecoration.none,
            ),
          ),
          content: BankingScreen(context: context),
        ),
////////////////////////////////////
        Step(
          state: _currentStep <= 6 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 6,
          title: Text(
            'Health \nRecords',
            style: GoogleFonts.firaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorManager.grey,
              decoration: TextDecoration.none,
            ),
          ),
          content: HealthRecordsScreen(context: context),
        ),
        ////////////////////////////////////
        Step(
          state: _currentStep <= 7 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 7,
          title: Text(
            'Acknowledgements',
            style: GoogleFonts.firaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorManager.grey,
              decoration: TextDecoration.none,
            ),
          ),
          content: AcknowledgementsScreen(context: context),
        ),
        ///////////////////////////////////

        Step(
          state: _currentStep <= 8 ? StepState.editing : StepState.complete,
          isActive: _currentStep >= 8,
          title: Text(
            'Legal \nDocuments',
            style: GoogleFonts.firaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorManager.grey,
              decoration: TextDecoration.none,
            ),
          ),
          content: LegalDocumentsScreen(context: context),
        )
      ];
}
