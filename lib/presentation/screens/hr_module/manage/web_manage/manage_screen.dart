import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/education_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/employeement_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/qulification_licenses_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/references_manager.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/compensation_add_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/health_record_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/other_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/equipment_child/equipment_head_tabbar.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/qualifications_child/widgets/add_education_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/qualifications_child/widgets/add_employeement_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/qualifications_child/widgets/add_licences_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/qualifications_child/widgets/add_reference_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/constant_checkbox/const_checckboxtile.dart';
import 'package:prohealth/presentation/widgets/widgets/constant_textfield/const_textfield.dart';
import '../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../app/resources/hr_resources/string_manager.dart';
import '../../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../../../widgets/widgets/profile_bar/profile_bar.dart';
import '../../../em_module/widgets/button_constant.dart';
import '../controller/controller.dart';
import '../widgets/bottom_row.dart';
import '../widgets/child_tabbar_constant.dart';
import '../widgets/child_tabbar_screen/documents_child/acknowledgements_child_tabbar.dart';
import '../widgets/child_tabbar_screen/documents_child/add_vaccination_child_tabbar.dart';
import '../widgets/child_tabbar_screen/documents_child/compensation_child_tabbar.dart';
import '../widgets/child_tabbar_screen/documents_child/other_child_tabbar.dart';
import '../widgets/child_tabbar_screen/qualifications_child/education_child_tabbar.dart';
import '../widgets/child_tabbar_screen/qualifications_child/employment_child_tabbar.dart';
import '../widgets/child_tabbar_screen/qualifications_child/licenses_child_tabbar.dart';
import '../widgets/child_tabbar_screen/qualifications_child/references_child_tabbar.dart';
import '../widgets/head_tabbar_constant.dart';
import '../widgets/child_tabbar_screen/bancking_child/banking_head_tabbar.dart';
import '../widgets/child_tabbar_screen/health_record_child/health_records_head_tabbar.dart';
import '../widgets/child_tabbar_screen/payrates_child/pay_rates_head_tabbar.dart';
import '../widgets/child_tabbar_screen/termination/termination_head_tabbar.dart';
import '../widgets/child_tabbar_screen/timeoff_child/time_off_head_tabbar.dart';
///done by saloni
class ManageScreen extends StatefulWidget {
  @override
  State<ManageScreen> createState() => _ManageScreenState();
}
class _ManageScreenState extends State<ManageScreen> {
  late CenteredTabBarChildController childController;
  late CenteredTabBarChildController childControlleOne;
  late CenteredTabBarController centeredTabBarController;
  /// Add employee
  TextEditingController positionTitleController = TextEditingController();
  TextEditingController leavingResonController = TextEditingController();
  TextEditingController startDateContoller = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController lastSupervisorNameController = TextEditingController();
  TextEditingController supervisorMobileNumber = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController employeerController = TextEditingController();
  TextEditingController emergencyMobileNumber = TextEditingController();

  /// Add Reference
   TextEditingController nameController = TextEditingController();
   TextEditingController emailController = TextEditingController();
   TextEditingController titlePositionController = TextEditingController();
   TextEditingController knowPersonController = TextEditingController();
   TextEditingController companyNameController = TextEditingController();
   TextEditingController associationLengthController = TextEditingController();
   TextEditingController mobileNumberController = TextEditingController();

  TextEditingController livensureController = TextEditingController();
  /// Add Education
   TextEditingController collegeUniversityController = TextEditingController();
   TextEditingController phoneController = TextEditingController();
   TextEditingController calenderController = TextEditingController();
   TextEditingController cityController = TextEditingController();
   TextEditingController degreeController = TextEditingController();
   TextEditingController stateController = TextEditingController();
   TextEditingController majorSubjectController = TextEditingController();
   TextEditingController countryNameController = TextEditingController();
  String expiryType = '';
  ///
  TextEditingController addressCtlr = TextEditingController();
  TextEditingController nameCtlr = TextEditingController();


  TextEditingController compensitionAddIdController = TextEditingController();
  TextEditingController compensitionAddNameController = TextEditingController();

  TextEditingController healthRecordAddIdController = TextEditingController();
  TextEditingController healthRecordAddNameController = TextEditingController();

  TextEditingController otherAddIdController = TextEditingController();
  TextEditingController otherAddNameController = TextEditingController();

  TextEditingController issueDateController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController issuingOrganizationController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController numberIDController = TextEditingController();

  @override
  void initState() {
    childController = CenteredTabBarChildController(
      tabs: [
        Tab(text: AppStringHr.employment),
        Tab(text: AppStringHr.education),
        Tab(text: AppStringHr.referance),
        Tab(text: AppStringHr.license),
      ],
      tabViews: [
        ///employment
        SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    margin: EdgeInsets.only(right: 40),
                    child: CustomIconButtonConst(
                        text: AppStringHr.add, icon: Icons.add, onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (BuildContext context, void Function(void Function()) setState) {
                              return AddEmployeementPopup(positionTitleController: positionTitleController, leavingResonController: leavingResonController,
                                startDateContoller: startDateContoller, endDateController: endDateController, lastSupervisorNameController: lastSupervisorNameController,
                                supervisorMobileNumber: supervisorMobileNumber, cityNameController: cityNameController, employeerController: employeerController,
                                emergencyMobileNumber: emergencyMobileNumber, onpressedClose: () {
                                  //Navigator.pop(context);
                                }, onpressedSave: () async{
                                  await addEmployeement(context,2, employeerController.text,
                                      cityNameController.text, leavingResonController.text, lastSupervisorNameController.text,
                                      supervisorMobileNumber.text, positionTitleController.text, startDateContoller.text, endDateController.text);
                                },
                                checkBoxTile: Container(
                                  width: 300,
                                    child: CheckboxTile(title: 'Currently work here',initialValue: false,onChanged: (value){
                                    },)), tite: 'Edit Employeement',
                              );
                            },
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
              EmploymentContainerConstant(),
            ],
          ),
        ),
        ///education
        SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    margin: EdgeInsets.only(right: 20),
                    child: CustomIconButtonConst(
                        text: AppStringHr.add, icon: Icons.add, onPressed: () {
                          showDialog(context: context, builder: (BuildContext context){
                            return StatefulBuilder(
                              builder: (BuildContext context, void Function(void Function()) setState) {
                                return AddEducationPopup(collegeUniversityController: collegeUniversityController,
                                  phoneController: phoneController,
                                  calenderController: calenderController, cityController: cityController,
                                  degreeController: degreeController, stateController: stateController, majorSubjectController: majorSubjectController,
                                  countryNameController: countryNameController, onpressedClose: (){
                                    Navigator.pop(context);
                                  }, onpressedSave: () async{
                                    await addEmployeeEducation(context, 2, expiryType.toString(), degreeController.text, majorSubjectController.text, cityController.text,
                                        collegeUniversityController.text, phoneController.text, stateController.text);
                                  },
                                  radioButton:Container(
                                    width: 280,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: CustomRadioListTile(
                                            value: "Yes",
                                            groupValue: expiryType.toString(),
                                            onChanged: (value) {
                                              setState(() {
                                                expiryType = value!;
                                              });
                                            },
                                            title: "Yes",
                                          ),
                                        ),
                                        Expanded(
                                          child: CustomRadioListTile(
                                            value: "No",
                                            groupValue: expiryType.toString(),
                                            onChanged: (value) {
                                              setState(() {
                                                expiryType = value!;
                                              });
                                            },
                                            title: "No",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ), title: 'Add Education',);
                              },
                            );
                          });
                    }),
                  ),
                ],
              ),
              EducationChildTabbar(),
            ],
          ),
        ),
        ///reference
        SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    margin: EdgeInsets.only(right: 20),
                    child: CustomIconButtonConst(
                        text: AppStringHr.add, icon: Icons.add, onPressed: () {
                          showDialog(context: context, builder: (BuildContext context){
                            return AddReferencePopup(nameController: nameController, emailController: emailController, titlePositionController: titlePositionController,
                              knowPersonController: knowPersonController, companyNameController: companyNameController, associationLengthController: associationLengthController, mobileNumberController: mobileNumberController,
                              onpressedClose: () {  }, onpressedSave: () async{
                              await addReferencePost(context, associationLengthController.text, 'Reference', companyNameController.text, emailController.text,
                                  5, mobileNumberController.text, nameController.text, knowPersonController.text, titlePositionController.text);
                              }, title: 'Add Reference',);
                          });

                    }),
                  ),
                ],
              ),
              SizedBox(height: 1,),
              ReferencesChildTabbar(),
            ],
          ),
        ),
        ///license
        SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 27,
                    width: 250,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.only(top: 2,bottom: 1,left: 4),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                      border: Border.all(color: Color(0xffB1B1B1)), // Black border
                      borderRadius: BorderRadius.circular(5), // Rounded corners
                    ),
                    child: DropdownButtonFormField<String>(
                      focusColor: Colors.transparent,
                      icon: Icon(Icons.arrow_drop_down_sharp,color: Color(0xff50B5E5),),
                      decoration: InputDecoration.collapsed(hintText: ''),
                      items: <String>['Select Document', 'Drivers License', 'CPR', 'Liability Insurence']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                      },
                      value: 'Select Document',style: TextStyle(color: Color(0xff686464),fontSize: 12),
                    ),
                  ),
                  Container(
                    width: 100,
                    margin: EdgeInsets.only(right: 20),
                    child: CustomIconButtonConst(
                        text: AppStringHr.add, icon: Icons.add, onPressed: () {
                          showDialog(context: context, builder: (BuildContext context){
                            return AddLicencesPopup(LivensureController: livensureController,
                              issueDateController: issueDateController, expiryDateController: expiryDateController, issuingOrganizationController: issuingOrganizationController,
                              countryController: countryController, numberIDController: numberIDController, onpressedClose: () {  }, onpressedSave: () async{
                              // await addLicensePost(context, licenseId, countryNameController.text, 0, expiryDateController.text, issueDateController.text,
                              //     licenseUrl, licensure, licenseNumber, org, documentType);
                              }, title: 'Add Licence',);
                          });
                    }),
                  ),
                ],
              ),
              SizedBox(height: 1,),
              LicensesChildTabbar(),
            ],
          ),
        ),
      ],
    );
    childControlleOne = CenteredTabBarChildController(tabs: [
      Tab(text: AppStringHr.acknowledgement),
      Tab(text: AppStringHr.compensation),
      Tab(text: AppStringHr.addVaccination),
      Tab(text: AppStringHr.others),
    ],
        tabViews: [
      ///aknowledgment
      Column(
        children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
             // width: 100,
              margin: EdgeInsets.only(right: 20),
              child: CustomIconButtonConst(
                  text: AppStringHr.addNew, icon: Icons.add, onPressed: () {
                    // showDialog(context: context, builder: (context)=> AcknowledgementsAddPopup());
              }),
            ),
          ],
        ),
          SizedBox(height: 30,),
          AcknowledgementsChildBar(),
        ],
      ),
      ///compensation
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                // width: 100,
                margin: EdgeInsets.only(right: 60),
                child: CustomIconButtonConst(
                    text: AppStringHr.addNew, icon: Icons.add, onPressed: () {
                      showDialog(context: context, builder: (BuildContext context){
                        return CompensationAddEditPopup(idController: compensitionAddIdController, nameController: compensitionAddNameController, labelName: 'Add Compensation',);
                      });
                }),
              ),
            ],
          ),
          SizedBox(height: 20,),
          CompensationChildTabbar(),
        ],
      ),
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                // width: 100,
                margin: EdgeInsets.only(right: 60),
                child: CustomIconButtonConst(
                    text: AppStringHr.addNew, icon: Icons.add, onPressed: () {
                  showDialog(context: context, builder: (BuildContext context){
                    return HealthRecordEditAddPopup(idController: healthRecordAddIdController, nameController: healthRecordAddNameController, labelName: 'Add Additional Vaccination',);
                  });

                }),
              ),
            ],
          ),
          SizedBox(height: 20,),
          AdditionalVaccinationsChildBar(),
        ],
      ),
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                // width: 100,
                margin: EdgeInsets.only(right: 60),
                child: CustomIconButtonConst(
                    text: AppStringHr.addNew, icon: Icons.add, onPressed: () {
                      showDialog(context: context, builder: (BuildContext context){
                        return OtherEditAddPopup(idController: otherAddIdController, nameController: otherAddNameController, labelName: 'Add');
                      });
                }),
              ),
            ],
          ),
          SizedBox(height: 20,),
          OtherChildTabbar(),
        ],
      ),
    ]);

    centeredTabBarController = Get.put(CenteredTabBarController(
      tabs: [
        Tab(text: AppStringHr.qualification),
        Tab(text: AppStringHr.documents),
        Tab(text: AppStringHr.bankings),
        // Tab(text: AppStringHr.healthRcord),
        // Tab(text: AppStringHr.inventory),
        Tab(text: AppStringHr.payRate),
        Tab(text: AppStringHr.termination),
        Tab(text: AppStringHr.timeOff),
      ],
      tabViews: [
        CenteredTabBarChild(childController),
        CenteredTabBarChild(childControlleOne),
        BankingHeadTabbar(),
        // HealthRecordsHeadTabbar(),
        // Column(
        //   children: [
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.end,
        //       children: [
        //         Container(
        //           // width: 100,
        //           decoration: BoxDecoration(
        //             boxShadow: [
        //               BoxShadow(
        //                 color: Colors.grey.withOpacity(0.25),
        //                 //spreadRadius: 1,
        //                 blurRadius: 4,
        //                 offset: Offset(0, 5),
        //               ),
        //             ],
        //           ),
        //           margin: EdgeInsets.only(right: 10),
        //           child: CustomIconButtonConst(
        //               text: AppStringHr.addNew,
        //               icon: Icons.add,
        //               onPressed: () {
        //                 showDialog(context: context, builder: (_) => EquipmentAddPopup());
        //               }),
        //         ),
        //       ],
        //     ),
        //     SizedBox(height: 20,),
        //     InventoryHeadTabbar(),
        //   ],
        // ),
        PayRatesHeadTabbar(),
        TerminationHeadTabbar(),
        TimeOffHeadTabbar(),
      ],
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        scrollDirection: Axis.vertical,
          children: [
        /// green blue container
       ProfileBar(),
       ///TabBar
       CenteredTabBar(),
       /// bottom row
       BottomBarRow()
      ]),
    );
  }
}
