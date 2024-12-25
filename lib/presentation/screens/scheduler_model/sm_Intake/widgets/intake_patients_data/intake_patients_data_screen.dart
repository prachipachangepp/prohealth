import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/sm_module_manager/patient_data/patient_data_info_manager.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_compliance/intake_patients_compliance.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_info/intake_patients_info.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_plan_care/intake_patients_plan_care.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_related_party/intake_patients_related_party.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_stay_info/intake_patients_stay_info.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_profile_bar.dart';
import 'package:prohealth/presentation/screens/scheduler_model/widgets/constant_widgets/dropdown_constant_sm.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/services/api/managers/sm_module_manager/physician_info/physician_info_manager.dart';
import '../../../../../../app/services/token/token_manager.dart';
import '../../../../../../data/api_data/sm_data/scheduler_create_data/create_data.dart';
import '../../../textfield_dropdown_constant/schedular_dropdown_const.dart';
import '../../../textfield_dropdown_constant/schedular_textfield_const.dart';

class SmIntakePatientsScreen extends StatefulWidget {
  final Function(int) onPatientIdGenerated;
  SmIntakePatientsScreen({super.key, required this.onPatientIdGenerated});

  @override
  State<SmIntakePatientsScreen> createState() => _SmIntakePatientsScreenState();
}

class _SmIntakePatientsScreenState extends State<SmIntakePatientsScreen> {
  int selectedIndex = 0;
  bool showProfileBar = false;
  final PageController smIntakePageController = PageController();
  TextEditingController ctlrSos = TextEditingController();
  TextEditingController ctlrMedicalRecord = TextEditingController();
  TextEditingController ctlrfirstName = TextEditingController();
  TextEditingController ctlrMI = TextEditingController();
  TextEditingController ctlrLastName = TextEditingController();
  TextEditingController ctlrSuffix = TextEditingController();
  TextEditingController ctlrDate = TextEditingController();
  TextEditingController ctlrStreet = TextEditingController();
  TextEditingController ctlrZipCode = TextEditingController();
  TextEditingController ctlrApartment = TextEditingController();
  TextEditingController ctlrCity = TextEditingController();
  TextEditingController dummyCtrl = TextEditingController();

  TextEditingController ctlrMajorStreet = TextEditingController();
  TextEditingController ctlrPrimeNo = TextEditingController();
  TextEditingController ctlrSecNo = TextEditingController();
  TextEditingController ctlrEmail = TextEditingController();
  TextEditingController ctlrSocialSec = TextEditingController();

  TextEditingController ctlrDischargeResaon = TextEditingController();

  TextEditingController ctlrDateOfDeath = TextEditingController();
  String? statusType;
  void selectButton(int index) {
    setState(() {
      selectedIndex = index;
    });

    smIntakePageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void toggleProfileBar() {
    setState(() {
      showProfileBar = true;
    });
  }

  // Function to validate text fields
  bool _validateInputs() {
    return ctlrMedicalRecord.text.isNotEmpty &&
        ctlrfirstName.text.isNotEmpty &&
        ctlrLastName.text.isNotEmpty &&
        ctlrMI.text.isNotEmpty &&
        ctlrSuffix.text.isNotEmpty &&
        ctlrStreet.text.isNotEmpty &&
        ctlrZipCode.text.isNotEmpty &&
        ctlrCity.text.isNotEmpty &&
        ctlrEmail.text.isNotEmpty &&
        ctlrSocialSec.text.isNotEmpty &&
        ctlrDischargeResaon.text.isNotEmpty;
  }

// Function to show an error message
  void _showErrorMessage(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Please fill out all required fields.'),
      backgroundColor: ColorManager.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  int patientId = 1;

  String? statustype;
  String? selectedStatus;
  String? selectedCountry;
  String? selectedRace;
  String? selectedState;
  String? selectedcity;
  String? selectedLanguage;
  String? selectedReligion;
  String? selectedMaritalStatus;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showProfileBar) IntakeProfileBar(),
        SizedBox(height: AppSize.s15),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Container(
            width: MediaQuery.of(context).size.width /2.455,
            height: AppSize.s30,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  offset: Offset(0, 4),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ],
              color: ColorManager.blueprime,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  child: Container(
                    height: AppSize.s30,
                    width: MediaQuery.of(context).size.width / 10,
                    padding: EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: selectedIndex == 0 ? Colors.white : null,
                    ),
                    child: Text(
                      'Info',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                        color: selectedIndex == 0
                            ? ColorManager.mediumgrey
                            : Colors.white,
                      ),
                    ),
                  ),
                  onTap: () => selectButton(0),
                ),
                InkWell(
                  child: Container(
                    height: AppSize.s30,
                    width: MediaQuery.of(context).size.width / 10,
                    padding: EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: selectedIndex == 1 ? ColorManager.white : null,
                    ),
                    child: Text(
                      'Compliance',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                        color: patientId == 0
                            ? ColorManager.fmediumgrey
                            :( selectedIndex == 1
                            ? ColorManager.mediumgrey
                            : ColorManager.white),
                      ),
                    ),
                  ),
                  onTap: patientId != 0 ? () => selectButton(1) : null,
                ),
                // InkWell(
                //   child: Container(
                //     height: AppSize.s30,
                //     width: MediaQuery.of(context).size.width / 10,
                //     padding: EdgeInsets.symmetric(vertical: 6),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(20),
                //       color: selectedIndex == 2 ? ColorManager.white : null,
                //     ),
                //     child: Text(
                //       'Plan of Care',
                //       textAlign: TextAlign.center,
                //       style: GoogleFonts.firaSans(
                //         fontSize: FontSize.s14,
                //         fontWeight: FontWeightManager.semiBold,
                //         color: patientId == 0
                //             ? ColorManager.fmediumgrey
                //             :( selectedIndex == 2
                //             ? ColorManager.mediumgrey
                //             : Colors.white),
                //       ),
                //     ),
                //   ),
                //   onTap: patientId != 0 ? () => selectButton(2) : null,
                // ),
                InkWell(
                  child: Container(
                    height: AppSize.s30,
                    width: MediaQuery.of(context).size.width / 9.5,
                    padding: EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: selectedIndex == 3 ? ColorManager.white : null,
                    ),
                    child: Text(
                      'Related Parties',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                        color: patientId == 0
                            ? ColorManager.fmediumgrey
                            :(selectedIndex == 3
                            ? ColorManager.mediumgrey
                            : ColorManager.white),
                      ),
                    ),
                  ),
                  onTap: patientId != 0 ? () => selectButton(3) : null,
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  child: Container(
                    height: AppSize.s30,
                    width: MediaQuery.of(context).size.width / 9.8,
                    padding: EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: selectedIndex == 4 ? ColorManager.white : null,
                    ),
                    child: Text(
                      'Stay Info',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.semiBold,
                        color:patientId == 0
                            ? ColorManager.fmediumgrey
                            :( selectedIndex == 4
                            ? ColorManager.mediumgrey
                            : Colors.white),
                      ),
                    ),
                  ),
                  onTap: patientId != 0 ? () => selectButton(4) : null,
                ),
              ],
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width / 5),
          if (selectedIndex == 0)
            //
            Padding(
              padding: const EdgeInsets.only(right: 40.0),
              child: Container(
                height: AppSize.s26,
                width: AppSize.s102,
                child:
                ElevatedButton(
                  onPressed: () async {
                    final companyId = await TokenManager.getCompanyId();
                    // String? dateOfDeath = ctlrDateOfDeath.text.isEmpty ? null : ctlrDateOfDeath.text;
                    ApiData result = await IntakeInfoSave(
                      context,
                      ctlrSos.text,
                      //"2024-08-12",
                      ctlrMedicalRecord.text,
                      selectedStatus!.toString() ?? '',
                      // 'Pending',
                      ctlrfirstName.text,
                      ctlrLastName.text,
                      ctlrMI.text,
                      ctlrSuffix.text,
                      statusType ?? '',
                      //"2024-08-12",
                      ctlrDate.text,
                      ctlrStreet.text,
                      selectedState!.toString(),
                     // "291000",//
                      ctlrZipCode.text,
                      ctlrApartment.text,
                      selectedcity!.toString(),
                      selectedCountry.toString() ?? '',
                      ctlrMajorStreet.text,
                      ctlrPrimeNo.text,
                      ctlrSecNo.text,
                      ctlrEmail.text,
                      ctlrSocialSec.text,
                      selectedLanguage.toString() ?? '',
                      ctlrDischargeResaon.text,
                      selectedRace.toString() ?? '',
                      selectedReligion.toString() ?? '',
                      selectedMaritalStatus.toString() ?? '',
                      //"2024-08-12",
                      // ctlrDateOfDeath.text,    //  :"2024-08-14T00:00:00Z",
                      ctlrDateOfDeath.text.isEmpty ? null : ctlrDateOfDeath.text,

                      1,
                      'At Land OSC',
                      'case',
                      'Type',
                      companyId,
                    );
                    print('${ctlrDateOfDeath.text}');
                    print('${ctlrSos.text}');
                    print('${ctlrDate.text}');

                    print('${ctlrLastName.text}');
                    print('${ctlrfirstName.text}');
                    print('${ctlrMedicalRecord.text}');
                    print('${statusType}');
                    print('${ctlrSuffix.text}');
                    print('${ctlrMI.text}');
                    print('${ctlrZipCode.text}');
                    print('${selectedState}');
                    print('${ctlrStreet.text}');

                    print('${selectedCountry}');
                    print('${selectedcity}');
                    print('${ctlrApartment.text}');

                    print('${ctlrSecNo.text}');
                    print('${ctlrPrimeNo.text}');
                    print('${ctlrMajorStreet.text}');

                    print('${ctlrSocialSec.text}');
                    print('${ctlrEmail.text}');

                    print('${selectedRace.toString()}');
                    print('${selectedLanguage.toString()}');
                    print('${selectedMaritalStatus.toString()}');
                    print('${selectedReligion.toString()}');
                    print('${ctlrDischargeResaon.text}');
                    print('===========');
                    if (result.success) {
                      patientId = result.patientId!;
                      widget.onPatientIdGenerated(patientId);
                      ctlrMedicalRecord.clear();
                      ctlrfirstName.clear();
                      ctlrLastName.clear();
                      ctlrMI.clear();
                      ctlrSuffix.clear();
                      ctlrStreet.clear();
                      ctlrZipCode.clear();
                      ctlrApartment.clear();
                      ctlrCity.clear();
                      ctlrMajorStreet.clear();
                      ctlrPrimeNo.clear();
                      ctlrSecNo.clear();
                      ctlrEmail.clear();
                      ctlrSocialSec.clear();
                      ctlrDischargeResaon.clear();
                    } else {

                    }
                  },
                  child: Text(
                    AppString.save,
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.bold,
                      color: ColorManager.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 10,
                    ),
                    backgroundColor: ColorManager.blueprime,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(right: 40.0),
              child: SizedBox(width: AppSize.s80),
            ),
        ]),
        const SizedBox(height: AppSize.s10),
        Expanded(
          flex: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: PageView(
              controller: smIntakePageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                IntakePatientsDatatInfo(
                  ctlrSos: ctlrSos,
                  ctlrMedicalRecord: ctlrMedicalRecord,
                  ctlrfirstName: ctlrfirstName,
                  ctlrMI: ctlrMI,
                  ctlrLastName: ctlrLastName,
                  ctlrSuffix: ctlrSuffix,
                  ctlrDate: ctlrDate,
                  ctlrStreet: ctlrStreet,
                  ctlrZipCode: ctlrZipCode,
                  ctlrApartment: ctlrApartment,
                  // ctlrCity: ctlrCity,
                  ctlrMajorStreet: ctlrMajorStreet,
                  ctlrPrimeNo: ctlrPrimeNo,
                  ctlrSecNo: ctlrSecNo,
                  ctlrEmail: ctlrEmail,
                  ctlrSocialSec: ctlrSocialSec,
                  ctlrDischargeResaon: ctlrDischargeResaon,
                  ctlrDateOfDeath: ctlrDateOfDeath,
                  // childStatus:  FutureBuilder<List<PatientStatusData>>(
                  //   future: StatusChange(context),  // Call your API method here
                  //   builder: (BuildContext context, AsyncSnapshot<List<PatientStatusData>> snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       return const CircularProgressIndicator();  // Show loading indicator while waiting
                  //     } else if (snapshot.hasError) {
                  //       return Text('Error: ${snapshot.error}');  // Show error if there's an issue
                  //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  //       return const Text('No Data Available');  // Show message if no data
                  //     } else {
                  //       // Data is available, map it to dropdown items
                  //       List<String> statusOptions = snapshot.data!.map((statusData) {
                  //         return statusData.patientStatus;  // Use patientStatus for the dropdown item label
                  //       }).toList();
                  //
                  //       return Flexible(
                  //         child: SchedularDropdown(
                  //           labelText: AppString.status,  // Your dropdown label
                  //           items: statusOptions,  // Populate dropdown with API data
                  //           onChanged: (newValue) {
                  //             setState(() {
                  //               selectedStatus = newValue;
                  //               print(selectedStatus);
                  //             });
                  //           },
                  //         ),
                  //       );
                  //     }
                  //   },
                  // ),
                  childStatus:
                  FutureBuilder<List<PatientStatusData>>(
                    future: StatusChange(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SchedularTextField(
                          controller: dummyCtrl,
                          labelText: 'Status',

                        );
                      }
                      // if (snapshot.hasData) {
                      //   List<PatientStatusData> statusList = snapshot.data!;
                      //   return DropdownButtonFormField<PatientStatusData>(
                      //     decoration: InputDecoration(
                      //       labelText: 'Status',
                      //       labelStyle: GoogleFonts.firaSans(
                      //         fontSize: 10.0,
                      //         fontWeight: FontWeight.w400,
                      //         color: ColorManager.greylight,
                      //       ),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(color: ColorManager.containerBorderGrey),
                      //       ),
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(4.0),
                      //         borderSide: const BorderSide(color: Colors.grey),
                      //       ),
                      //       contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                      //     ),
                      //     value: statusList.isNotEmpty ? statusList.first : null,
                      //     icon: Icon(Icons.arrow_drop_down, color: ColorManager.blueprime),
                      //     iconSize: 24,
                      //     elevation: 16,
                      //     style: GoogleFonts.firaSans(
                      //       fontSize: 10.0,
                      //       fontWeight: FontWeight.w400,
                      //       color: const Color(0xff686464),
                      //     ),
                      //     onChanged: (newValue) {
                      //       for (var a in snapshot.data!) {
                      //         if (a.patientStatus == newValue) {
                      //           selectedState = a.patientStatus!;
                      //           //country = a
                      //           // int? docType = a.companyOfficeID;
                      //         }
                      //       }
                      //     },
                      //     // onChanged: (newValue) {
                      //     //   if (newValue != null) {
                      //     //     controller.text = newValue.patientStatus!;
                      //     //     // Additional logic for selected value if needed
                      //     //   }
                      //     // },
                      //     items: statusList.map((PatientStatusData status) {
                      //       return DropdownMenuItem<PatientStatusData>(
                      //         value: status,
                      //         child: Text(
                      //           status.patientStatus!,
                      //           style: GoogleFonts.firaSans(
                      //             fontSize: 12,
                      //             color: Color(0xff575757),
                      //             fontWeight: FontWeight.w400,
                      //           ),
                      //         ),
                      //       );
                      //     }).toList(),
                      //   );
                      if (snapshot.hasData) {
                        List<DropdownMenuItem<String>> dropDownList = [];
                        for (var i in snapshot.data!) {
                          dropDownList.add(DropdownMenuItem<String>(
                            child: Text(i.patientStatus!),
                            value: i.patientStatus,
                          ));
                        }
                        // List<String> statusList = [];
                        // for (var i in snapshot.data!) {
                        //   statusList.add(i.patientStatus);
                        // }

                        return CustomDropdownTextFieldsm(headText: 'Status',dropDownMenuList: dropDownList,
                            onChanged: (newValue) {
                              for (var a in snapshot.data!) {
                                if (a.patientStatus == newValue) {
                                  selectedStatus = a.patientStatus!;
                                  //country = a
                                  // int? docType = a.companyOfficeID;
                                }
                              }
                            });

                      } else {
                        return const Offstage();
                      }
                    },
                  ),
                      ///
                  // FutureBuilder<List<PatientStatusData>>(
                  //   future: StatusChange(context),
                  //   builder: (BuildContext context, AsyncSnapshot<List<PatientStatusData>> snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       return SchedularTextField(
                  //         width: 350,
                  //         controller: dummyCtrl,
                  //         labelText: 'Status',
                  //         suffixIcon: Icon(
                  //           Icons.arrow_drop_down,
                  //           color: ColorManager.blueprime,
                  //         ),
                  //       );
                  //     } else if (snapshot.hasError) {
                  //       return Text('Error: ${snapshot.error}');
                  //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  //       return const Text('No Data Available');
                  //     } else {
                  //
                  //       List<String> statusOptions = snapshot.data!.map((statusData) {
                  //         return statusData.patientStatus;
                  //       }).toList();
                  //
                  //       return DropdownButtonFormField<String>(
                  //         decoration: InputDecoration(
                  //           labelText: 'Status',
                  //           labelStyle: GoogleFonts.firaSans(
                  //             fontSize: 10.0,
                  //             fontWeight: FontWeight.w400,
                  //             color: ColorManager.greylight,
                  //           ),
                  //           focusedBorder: OutlineInputBorder(
                  //             borderSide: BorderSide(color: ColorManager.containerBorderGrey),
                  //           ),
                  //           border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(4.0),
                  //             borderSide: const BorderSide(color: Colors.grey),
                  //           ),
                  //           contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  //         ),
                  //         value: selectedStatus,
                  //         icon: Icon(
                  //           Icons.arrow_drop_down,
                  //           color: ColorManager.blueprime,
                  //         ),
                  //         iconSize: 24,
                  //         elevation: 16,
                  //         style: GoogleFonts.firaSans(
                  //           fontSize: 10.0,
                  //           fontWeight: FontWeight.w400,
                  //           color: const Color(0xff686464),
                  //         ),
                  //         onChanged: (newValue) {
                  //           setState(() {
                  //             selectedStatus = newValue;
                  //             print(selectedStatus);
                  //           });
                  //         },
                  //         items: statusOptions.map((String value) {
                  //           return DropdownMenuItem<String>(
                  //             value: value,
                  //             child: Text(
                  //               value,
                  //               style: GoogleFonts.firaSans(
                  //                 fontSize: 12,
                  //                 color: Color(0xff575757),
                  //                 fontWeight: FontWeight.w400,
                  //               ),
                  //             ),
                  //           );
                  //         }).toList(),
                  //       );
                  //     }
                  //   },
                  // ),
///
                // FutureBuilder<List<PatientStatusData>>(
                  //   future: StatusChange(context), // Call your API method here
                  //   builder: (BuildContext context, AsyncSnapshot<List<PatientStatusData>> snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       return SchedularTextField(
                  //         width: 350,
                  //         controller: dummyCtrl,
                  //         labelText: 'Status',
                  //         suffixIcon: Icon(Icons.arrow_drop_down,
                  //           color: ColorManager
                  //               .blueprime,),); // Show loading indicator while waiting
                  //     } if (snapshot.hasData){
                  //       // Data is available, map it to dropdown items
                  //       List<String> statusOptions = snapshot.data!.map((statusData) {
                  //         return statusData.patientStatus; // Use patientStatus for the dropdown item label
                  //       }).toList();
                  //       return DropdownButtonFormField<String>(
                  //         decoration: InputDecoration(
                  //           labelText: 'Status',
                  //           labelStyle: GoogleFonts.firaSans(
                  //             fontSize: 10.0,
                  //             fontWeight: FontWeight.w400,
                  //             color: ColorManager.greylight,
                  //           ),
                  //           focusedBorder: OutlineInputBorder(
                  //             borderSide: BorderSide(color: ColorManager.containerBorderGrey),
                  //           ),
                  //           border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(4.0),
                  //             borderSide: const BorderSide(color: Colors.grey),
                  //           ),
                  //           contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  //         ),
                  //         value: selectedStatus,
                  //         icon: Icon(
                  //           Icons.arrow_drop_down,
                  //           color: ColorManager.blueprime,
                  //         ),
                  //         iconSize: 24,
                  //         elevation: 16,
                  //         style: GoogleFonts.firaSans(
                  //           fontSize: 10.0,
                  //           fontWeight: FontWeight.w400,
                  //           color: const Color(0xff686464),
                  //         ),
                  //         onChanged: (newValue) {
                  //           setState(() {
                  //             selectedStatus = newValue;
                  //             print(selectedStatus);
                  //           });
                  //         },
                  //         items: statusOptions.map((String value) {
                  //           return DropdownMenuItem<String>(
                  //             value: value,
                  //             child: Text(
                  //               value,
                  //               style: GoogleFonts.firaSans(
                  //                 fontSize: 12,
                  //                 color: Color(0xff575757),
                  //                 fontWeight: FontWeight.w400,
                  //               ),
                  //             ),
                  //           );
                  //         }).toList(),
                  //       );
                  //     } else {
                  //       return const Offstage();
                  //     }
                  //   },
                  // ),

                  childState: FutureBuilder<List<StateData>>(
                    future: getStateDropDown(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return SchedularTextField(
                          width: 350,
                          controller: dummyCtrl,
                          labelText: 'State');
                      }
                      if (snapshot.hasData) {
                        List<DropdownMenuItem<String>> dropDownList = [];
                        for (var i in snapshot.data!) {
                          dropDownList.add(DropdownMenuItem<String>(
                            child: Text(i.name!),
                            value: i.name,
                          ));
                        }

                        return CustomDropdownTextFieldsm(headText: 'State',dropDownMenuList: dropDownList,
                            onChanged: (newValue) {
                              for (var a in snapshot.data!) {
                                if (a.name == newValue) {
                                  selectedState = a.name!;
                                  //country = a
                                  // int? docType = a.companyOfficeID;
                                }
                              }
                            });

                      } else {
                        return const Offstage();
                      }
                    },
                  ),
                  childCountry: FutureBuilder<List<CountryData>>(
                    future: getCountryDropDown(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return SchedularTextField(
                          controller: dummyCtrl,
                          labelText: 'County');
                      }
                      if (snapshot.hasData) {
                        List<DropdownMenuItem<String>> dropDownList = [];
                        for (var i in snapshot.data!) {
                          dropDownList.add(DropdownMenuItem<String>(
                            child: Text(i.name!),
                            value: i.name,
                          ));
                        }

                        return CustomDropdownTextFieldsm(headText: 'Country',dropDownMenuList: dropDownList,
                            onChanged: (newValue) {
                              for (var a in snapshot.data!) {
                                if (a.name == newValue) {
                                  selectedCountry = a.name!;
                                  //country = a
                                  // int? docType = a.companyOfficeID;
                                }
                              }
                            });
                      } else {
                        return const Offstage();
                      }
                    },
                  ),
                  childReligion:FutureBuilder<List<ReligionData>>(
                    future: getReligionDropDown(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return SchedularTextField(
                          width: 500,
                          controller: dummyCtrl,
                          labelText: 'Religion',
                          );
                      }
                      if (snapshot.hasData) {
                        List<DropdownMenuItem<String>> dropDownList = [];
                        for (var i in snapshot.data!) {
                          dropDownList.add(DropdownMenuItem<String>(
                            child: Text(i.religion!),
                            value: i.religion,
                          ));
                        }

                        return CustomDropdownTextFieldsm(headText: 'Religion',dropDownMenuList: dropDownList,
                            onChanged: (newValue) {
                              for (var a in snapshot.data!) {
                                if (a.religion == newValue) {
                                  selectedReligion = a.religion!;
                                  //country = a
                                  // int? docType = a.companyOfficeID;
                                }
                              }
                            });

                      } else {
                        return const Offstage();
                      }
                    },
                  ),
                  childCity:  FutureBuilder<List<CityData>>(
                    future: getCityDropDown(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return SchedularTextField(
                          width: 400,
                          controller: dummyCtrl,
                          labelText: 'City',
                         );
                      }
                      if (snapshot.hasData) {
                        List<DropdownMenuItem<String>> dropDownList = [];
                        for (var i in snapshot.data!) {
                          dropDownList.add(DropdownMenuItem<String>(
                            child: Text(i.cityName!),
                            value: i.cityName,
                          ));
                        }

                        return CustomDropdownTextFieldsm(headText: 'City',dropDownMenuList: dropDownList,
                            onChanged: (newValue) {
                              for (var a in snapshot.data!) {
                                if (a.cityName == newValue) {
                                  selectedcity = a.cityName!;
                                  //country = a
                                  // int? docType = a.companyOfficeID;
                                }
                              }
                            });
                      } else {
                        return const Offstage();
                      }
                    },
                  ),
                  childRace:FutureBuilder<List<RaceData>>(
                    future: getRaceDropDown(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return SchedularTextField(
                          controller: dummyCtrl,
                          labelText: 'Race');
                      }
                      if (snapshot.hasData) {
                        List<DropdownMenuItem<String>> dropDownList = [];
                        for (var i in snapshot.data!) {
                          dropDownList.add(DropdownMenuItem<String>(
                            child: Text(i.race!),
                            value: i.race,
                          ));
                        }

                        return CustomDropdownTextFieldsm(headText: 'Race  / Ethnicity',dropDownMenuList: dropDownList,
                            onChanged: (newValue) {
                              for (var a in snapshot.data!) {
                                if (a.race == newValue) {
                                  selectedRace = a.race!;
                                  //country = a
                                  // int? docType = a.companyOfficeID;
                                }
                              }
                            });
                      } else {
                        return const Offstage();
                      }
                    },
                  ),
                  childLanguage:  FutureBuilder<List<LanguageSpokenData>>(
                    future: getlanguageSpokenDropDown(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return SchedularTextField(
                          controller: dummyCtrl,
                          labelText: 'Language Spoken',
                          );
                      }
                      if (snapshot.hasData) {
                        List<DropdownMenuItem<String>> dropDownList = [];
                        for (var i in snapshot.data!) {
                          dropDownList.add(DropdownMenuItem<String>(
                            child: Text(i.languageSpoken!),
                            value: i.languageSpoken,
                          ));
                        }

                        return CustomDropdownTextFieldsm(headText: 'Language Spoken',dropDownMenuList: dropDownList,
                            onChanged: (newValue) {
                              for (var a in snapshot.data!) {
                                if (a.languageSpoken == newValue) {
                                  selectedLanguage = a.languageSpoken!;
                                  //country = a
                                  // int? docType = a.companyOfficeID;
                                }
                              }
                            });
                      } else {
                        return const Offstage();
                      }
                    },
                  ),
                  childMaritalStatus: FutureBuilder<List<MetrialStatusData>>(
                    future: getMaritalStatusDropDown(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return SchedularTextField(
                          controller: dummyCtrl,
                          labelText: 'Marital Status',
                          );
                      }
                      if (snapshot.hasData) {
                        List<DropdownMenuItem<String>> dropDownList = [];
                        for (var i in snapshot.data!) {
                          dropDownList.add(DropdownMenuItem<String>(
                            child: Text(i.maritalStatus),
                            value: i.maritalStatus,
                          ));
                        }

                        return CustomDropdownTextFieldsm(headText: 'Marital Status',dropDownMenuList: dropDownList,
                            onChanged: (newValue) {
                              for (var a in snapshot.data!) {
                                if (a.maritalStatus == newValue) {
                                  selectedMaritalStatus =
                                  a.maritalStatus!;
                                  //country = a
                                  // int? docType = a.companyOfficeID;
                                }
                              }
                            });
                      } else {
                        return const Offstage();
                      }
                    },
                  ),
                ),
                IntakePComplianceScreen(patientId: patientId),
                // IntakePlanCareScreen(patientId: patientId,),
                IntakeRelatedPartiesScreen(patientId: patientId,),
                IntakePatientsStayInfoScreen(patientId: patientId,),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
