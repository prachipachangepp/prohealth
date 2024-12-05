import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/app.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/sm_module_manager/patient_data/patient_data_info_manager.dart';
import 'package:prohealth/app/services/token/token_manager.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../../app/services/api/managers/sm_module_manager/physician_info/physician_info_manager.dart';
import '../../../../../../../../data/api_data/sm_data/scheduler_create_data/create_data.dart';
import '../../../../../../../widgets/widgets/constant_textfield/const_textfield.dart';
import '../../../../../../em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_dropdown_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_withbutton_const.dart';

class IntakePatientsDatatInfo extends StatefulWidget {
  final TextEditingController ctlrSos;
  final TextEditingController ctlrMedicalRecord;
  final TextEditingController ctlrfirstName;
  final TextEditingController ctlrMI;
  final TextEditingController ctlrLastName;
  final TextEditingController ctlrSuffix;
  final TextEditingController ctlrDate;
  final TextEditingController ctlrStreet;
  final TextEditingController ctlrZipCode;
  final TextEditingController ctlrApartment;
 // final TextEditingController ctlrCity;
  final TextEditingController ctlrMajorStreet;
  final TextEditingController ctlrPrimeNo;
  final TextEditingController ctlrSecNo;
  final TextEditingController ctlrEmail;
  final TextEditingController ctlrSocialSec;
  final TextEditingController ctlrDischargeResaon;
  final TextEditingController ctlrDateOfDeath;
  final Widget childState;
  final Widget childCity;
  final Widget childReligion;
  final Widget childRace;
  final Widget childLanguage;
  final Widget childCountry;
  final Widget childMaritalStatus;
  final Widget childStatus;

  IntakePatientsDatatInfo(
      {super.key,
      required this.ctlrSos,
      required this.ctlrMedicalRecord,
      required this.ctlrfirstName,
      required this.ctlrMI,
      required this.ctlrLastName,
      required this.ctlrSuffix,
      required this.ctlrDate,
      required this.ctlrStreet,
      required this.ctlrZipCode,
      required this.ctlrApartment,
     // required this.ctlrCity,
      required this.ctlrMajorStreet,
      required this.ctlrPrimeNo,
      required this.ctlrSecNo,
      required this.ctlrEmail,
      required this.ctlrSocialSec,
      required this.ctlrDischargeResaon,
      required this.ctlrDateOfDeath,
      required this.childState,
      required this.childCity,
      required this.childReligion,
      required this.childRace,
      required this.childLanguage,

      required this.childMaritalStatus, required this.childCountry, required this.childStatus});

  @override
  State<IntakePatientsDatatInfo> createState() => _PatientInfoState();
}

class _PatientInfoState extends State<IntakePatientsDatatInfo> {
  String? status = '';

  String? statustype;
  String? selectedStatus;
  String? selectedCountry;
  String? selectedRace;
  String? selectedState;
  String? selectedcity;
  String? selectedLanguage;
  String? selectedReligion;
  String? selectedMaritalStatus;
  String? dateOfDeath;
  @override
  void initState() {
    super.initState();

    // Add a listener to the controller
    widget.ctlrDateOfDeath.addListener(() {
      String value = widget.ctlrDateOfDeath.text;

      if (value.isEmpty) {
        dateOfDeath = null;  // Set to null if empty
      } else {
        dateOfDeath = value;  // Store the value otherwise
      }
    });
  }

  @override
  void dispose() {
    widget.ctlrDateOfDeath.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 80.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                  ],
                ),
              ),
              SizedBox(height: 19.5),
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                            controller: widget.ctlrSos,
                            labelText: 'SOC Date',
                                  showDatePicker:true
                          )),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: widget.ctlrMedicalRecord,
                                  labelText: 'Medical Record',
                                  initialValue: '#632654')),
                          SizedBox(width: AppSize.s35),

                          Flexible(
                             child: widget.childStatus,
                          //     child: SchedularDropdown(
                          //   labelText: AppString.status,
                          //   items: ['Option 1', 'Option 2', 'Option 3'],
                          //   onChanged: (newValue) {
                          //     setState(() {
                          //       selectedStatus = newValue;
                          //       print(selectedStatus);
                          //     });
                          //   },
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: widget.ctlrfirstName,
                                  labelText: AppString.fname,
                                  initialValue: 'Erica')),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                  controller: widget.ctlrMI,
                                  labelText: 'M.I.',
                                  initialValue: 'A')),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: widget.ctlrLastName,
                                  labelText: AppString.lname)),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: widget.ctlrSuffix,
                                  labelText: AppString.suffix)),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Status:',
                                    style: AllPopupHeadings.customTextStyle(context)),
                                SizedBox(height: 1),
                                Row(
                                  children: [
                                    CustomRadioListTile(
                                      title: 'Active',
                                      value: 'active',
                                      groupValue: statustype,
                                      onChanged: (value) {
                                        setState(() {
                                          statustype = value;
                                        });
                                      },
                                    ),
                                    CustomRadioListTile(
                                      title: 'Trainee',
                                      value: 'trainee',
                                      groupValue: statustype,
                                      onChanged: (value) {
                                        setState(() {
                                          statustype = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                  controller: widget.ctlrDate,
                                  labelText: AppString.date_of_birth,
                                  initialValue: '25-05-1999',
                                  showDatePicker:true)),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                            controller: widget.ctlrStreet,
                            labelText: AppString.street,
                          )),
                          SizedBox(width: AppSize.s35),
                          Flexible(child: widget.childState),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextFieldWithButton(
                                  textController: widget.ctlrZipCode,
                                  labelText: AppString.zip_code,
                                  buttonText: AppString.viewzone)),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                  controller: widget.ctlrApartment,
                                  labelText: 'Suite/ Apt.')),
                          SizedBox(width: AppSize.s35),
                          Flexible(child: widget.childCity),
                          SizedBox(width: 35),
                          Flexible(

                            child: widget.childCountry
                          //     child: SchedularDropdown(
                          //   labelText: AppString.country,
                          //   items: ['Option 1', 'Option 2', 'Option 3'],
                          //   onChanged: (newValue) {
                          //     setState(() {
                          //       selectedCountry = newValue;
                          //     });
                          //   },
                          // ),

                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: widget.ctlrMajorStreet,
                                  labelText: 'Major Cross Street')),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                  controller: widget.ctlrPrimeNo,
                                  labelText: AppString.primary_phone_number,
                                  phoneField:true)),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: widget.ctlrSecNo,
                                  labelText: AppString.secondary_phone_number,
                                  phoneField:true)),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: widget.ctlrEmail,
                                  labelText: AppString.email)),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: widget.ctlrSocialSec,
                                  labelText: 'Soc. sec#')),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(child: widget.childLanguage),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: widget.ctlrDischargeResaon,
                                  labelText: 'Discharge Reason')),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                            child: widget.childRace ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                            child: widget.childReligion,),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                            child: widget.childMaritalStatus ),
                          SizedBox(width: AppSize.s35),

                          Flexible(
                            child: SchedularTextField(
                              controller: widget.ctlrDateOfDeath,
                              labelText: AppString.date_of_death,
                                showDatePicker:true,
                              onChanged: (value) {
                                /// If the TextField is empty, set dateOfDeath to null
                                dateOfDeath = value.isEmpty ? null : value;
                              },
                            ),
                          ),

                          // Flexible(
                          //   child: SchedularTextField(
                          //     controller: widget.ctlrDateOfDeath,
                          //     labelText: AppString.date_of_death,
                          //     suffixIcon: Icon(
                          //       Icons.calendar_month_outlined,
                          //       color: ColorManager.blueprime,
                          //     ),
                          //     onChanged: (value) {
                          //       /// If the TextField is empty, set dateOfDeath to null
                          //       if (value.isEmpty) {
                          //         dateOfDeath = null;
                          //       } else {
                          //         /// Otherwise, store the date value
                          //         dateOfDeath = value;
                          //       }
                          //     },
                          //   ),
                          // ),
                          // Flexible(
                          //     child: SchedularTextField(
                          //         controller: widget.ctlrDateOfDeath,
                          //         labelText: AppString.date_of_death,
                          //         suffixIcon:
                          //             Icon(Icons.calendar_month_outlined,
                          //               color: ColorManager.blueprime,))),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child:
                                  Container()), // Empty container for alignment
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child:
                                  Container()), // Empty container for alignment
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 40.0),
              //   child: Container(
              //     height: AppSize.s26,
              //     width: AppSize.s102,
              //     child:
              //     ElevatedButton(
              //       onPressed: () async {
              //         final companyId = await TokenManager.getCompanyId();
              //         // String? dateOfDeath = ctlrDateOfDeath.text.isEmpty ? null : ctlrDateOfDeath.text;
              //         ApiData result = await IntakeInfoSave(
              //           context,
              //           widget.ctlrSos.text,
              //           //"2024-08-12",
              //           widget.ctlrMedicalRecord.text,
              //           selectedStatus!.toString() ?? '',
              //           // 'Pending',
              //           widget.ctlrfirstName.text,
              //           widget.ctlrLastName.text,
              //           widget.ctlrMI.text,
              //           widget.ctlrSuffix.text,
              //           widget.statusType ?? '',
              //           //"2024-08-12",
              //           widget.ctlrDate.text,
              //           widget.ctlrStreet.text,
              //           selectedState!.toString(),
              //           // "291000",//
              //           widget.ctlrZipCode.text,
              //           widget.ctlrApartment.text,
              //           selectedcity!.toString(),
              //           selectedCountry.toString() ?? '',
              //           widget.ctlrMajorStreet.text,
              //           widget.ctlrPrimeNo.text,
              //           widget.ctlrSecNo.text,
              //           widget.ctlrEmail.text,
              //           widget.ctlrSocialSec.text,
              //           selectedLanguage.toString() ?? '',
              //           widget.ctlrDischargeResaon.text,
              //           selectedRace.toString() ?? '',
              //           selectedReligion.toString() ?? '',
              //           selectedMaritalStatus.toString() ?? '',
              //           //"2024-08-12",
              //           // ctlrDateOfDeath.text,    //  :"2024-08-14T00:00:00Z",
              //           widget.ctlrDateOfDeath.text.isEmpty ? null : widget.ctlrDateOfDeath.text,
              //
              //           1,
              //           'At Land OSC',
              //           'case',
              //           'Type',
              //           companyId,
              //         );
              //
              //         if (result.success) {
              //           patientId = result.patientId!;
              //           widget.onPatientIdGenerated(patientId);
              //           widget.ctlrMedicalRecord.clear();
              //           widget.ctlrfirstName.clear();
              //           widget.ctlrLastName.clear();
              //           widget.ctlrMI.clear();
              //           widget.ctlrSuffix.clear();
              //           widget.ctlrStreet.clear();
              //           widget.ctlrZipCode.clear();
              //           widget.ctlrApartment.clear();
              //           widget.ctlrCity.clear();
              //           widget.ctlrMajorStreet.clear();
              //           widget.ctlrPrimeNo.clear();
              //           widget.ctlrSecNo.clear();
              //           widget.ctlrEmail.clear();
              //           widget.ctlrSocialSec.clear();
              //           widget.ctlrDischargeResaon.clear();
              //         } else {
              //
              //         }
              //       },
              //       child: Text(
              //         AppString.save,
              //         style: GoogleFonts.firaSans(
              //           fontSize: FontSize.s14,
              //           fontWeight: FontWeightManager.bold,
              //           color: ColorManager.white,
              //         ),
              //       ),
              //       style: ElevatedButton.styleFrom(
              //         padding: const EdgeInsets.symmetric(
              //           horizontal: 25,
              //           vertical: 10,
              //         ),
              //         backgroundColor: ColorManager.blueprime,
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(12),
              //         ),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
