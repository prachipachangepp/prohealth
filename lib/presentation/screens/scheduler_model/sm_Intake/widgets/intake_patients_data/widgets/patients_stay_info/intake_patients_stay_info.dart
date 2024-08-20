import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/app.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/services/api/managers/sm_module_manager/patient_data/patient_data_related_party_manager.dart';
import 'package:prohealth/app/services/api/managers/sm_module_manager/patient_data/patient_data_stay_info_manager.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_info/intake_patients_info.dart';
import '../../../../../../../../app/resources/value_manager.dart';
import '../../../../../textfield_dropdown_constant/schedular_dropdown_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_withbutton_const.dart';
import '../../../../../widgets/constant_widgets/button_constant.dart';


class IntakePatientsStayInfoScreen extends StatefulWidget {
  const IntakePatientsStayInfoScreen({Key? key}) : super(key: key);

  @override
  State<IntakePatientsStayInfoScreen> createState() => _IntakePatientsStayInfoScreenState();
}

class _IntakePatientsStayInfoScreenState extends State<IntakePatientsStayInfoScreen> {

  TextEditingController ctlrMedicalRecord = TextEditingController();
  TextEditingController ctlrHospital = TextEditingController();
  TextEditingController ctlrPhone = TextEditingController();
  TextEditingController ctlrAddress = TextEditingController();
  TextEditingController ctlrCity = TextEditingController();
  TextEditingController ctlrViewZone = TextEditingController();
  TextEditingController ctlrAdmitDate = TextEditingController();
  TextEditingController ctlrDC = TextEditingController();
  TextEditingController ctlrRecentSurgery = TextEditingController();
  TextEditingController ctlrDateSurgery = TextEditingController();
  TextEditingController ctlrComment = TextEditingController();
  TextEditingController ctlrStartDate = TextEditingController();
  TextEditingController ctlrStreet = TextEditingController();
  TextEditingController ctlrSuiteApt = TextEditingController();
  TextEditingController ctlrZipCode = TextEditingController();
  TextEditingController ctlrFax = TextEditingController();

  String? selectedFacility;
  String? selectedState;
  String? selectedStatus;
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
                    Text(AppString.status_completed,
                      style: GoogleFonts.firaSans(
                          decoration: TextDecoration.none,
                          fontSize: AppSize.s12,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.greenDark
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width/80),
                    Container(
                      height: 30,
                      width: 130,
                      child: SchedularIconButtonConst(
                        text: 'Add Stay Info',
                        icon: Icons.add,
                        onPressed: () async {
                         await  InfoStayPatientData(context,
                             1,
                             selectedFacility ?? "",
                             ctlrMedicalRecord.text,
                             selectedStatus ?? "",
                             ctlrHospital.text,
                             ctlrPhone.text,
                             ctlrAddress.text,
                             ctlrCity.text,
                             selectedState ?? "",
                             ctlrZipCode.text,
                             "2024-08-17T17:18:58.618Z",
                             "2024-08-17T17:18:58.618Z",
                             ctlrRecentSurgery.text,
                             ctlrDateSurgery.text,
                             ctlrComment.text,
                             "2024-08-17T17:18:58.618Z",
                             "2024-08-17T17:18:58.618Z",
                             ctlrStreet.text,
                             ctlrSuiteApt.text,
                             ctlrCity.text,
                             selectedState ?? "",
                             ctlrZipCode.text,
                             ctlrPhone.text,
                             ctlrFax.text
                             );
                        },),
                      )
                   ],
                 ),
               ),
              SizedBox(height: 19.5),
              Container(
                // height: 423,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Last Inpatient Stay Information',
                          style: GoogleFonts.firaSans(
                            fontSize: AppSize.s12,
                            color: ColorManager.granitegray,
                            fontWeight: FontWeightManager.semiBold,)),
                      SizedBox(height: AppSize.s20),
                      _buildInpatientStaySection(),
                      SizedBox(height: AppSize.s30),
                      Text('Location of Care',
                          style: GoogleFonts.firaSans(
                            fontSize: AppSize.s12,
                            color: ColorManager.granitegray,
                            fontWeight: FontWeightManager.semiBold,)),
                      SizedBox(height: AppSize.s20),
                      _buildLocationOfCareSection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInpatientStaySection() {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
                child: SchedularDropdown(
                    labelText: 'Facility',
                    items: ['Option 1', 'Option 2', 'Option 3'],
                    onChanged: (newValue) {
                  setState(() {
                    selectedFacility = newValue;
                  });
                },)
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularTextField(
                  controller: ctlrMedicalRecord,
                    labelText: 'Medical Record #')
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularDropdown(
                    labelText: AppString.status,
                    items: ['Option 1', 'Option 2', 'Option 3'],  onChanged: (newValue) {
                  setState(() {
                    selectedStatus = newValue;
                  });
                },
                    )
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularTextField(
                  controller: ctlrHospital,
                    labelText: 'Hospital')
            ),
          ],
        ),
        SizedBox(height: AppSize.s16),
        Row(
          children: [
            Flexible(
                child: SchedularTextField(
                  controller: ctlrPhone,
                    labelText: 'Phone')
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularTextField(
                  controller: ctlrAddress,
                    labelText: AppString.address)
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularTextField(
                  controller: ctlrCity,
                    labelText:  AppString.city)
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularDropdown(
                    labelText:  AppString.state,
                    items: ['Option 1', 'Option 2', 'Option 3'],  onChanged: (newValue) {
                  setState(() {
                    selectedState = newValue;
                  });
                },)
            ),
          ],
        ),
        SizedBox(height: AppSize.s16),
        Row(
          children: [
            Flexible(child: SchedularTextFieldWithButton(
              controller: ctlrViewZone,
              labelText: AppString.zip_code,
              initialValue: '2656845121',
              buttonText: 'View Zone',
            )),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularTextField(
                  controller: ctlrAdmitDate,
                    labelText: 'Admit Date',
                    )
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularTextField(
                  controller: ctlrDC,
                    labelText: 'D/C',
                   )
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularTextField(
                  controller: ctlrRecentSurgery,
                    labelText: 'Recent Surgery/ Procedure'
                )
            ),
          ],
        ),
        SizedBox(height: AppSize.s16),
        Row(
          children: [
            Flexible(
                child: SchedularTextField(
                  controller: ctlrDateSurgery,
                    labelText: 'Date of Surgery/ Procedure',
                 )
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularTextField(
                  controller: ctlrComment,
                    labelText: AppString.comments
                )
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: Container()),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: Container()),
          ],
        )
      ],
    );
  }

  Widget _buildLocationOfCareSection() {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
                child: SchedularTextField(
                  controller: ctlrStartDate ,
                    labelText: AppString.startdate,

                )
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularTextField(
                    labelText: AppString.enddate,
                    suffixIcon: Icon(Icons.calendar_month_outlined),
                    // isDate: true
                )
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularTextField(
                  controller: ctlrStreet,
                    labelText: 'Street'
                )
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularTextField(
                  controller: ctlrSuiteApt,
                    labelText: 'Suite/ Apt#'
                )
            ),
          ],
        ),
        SizedBox(height: AppSize.s20),
        Row(
          children: [
            Flexible(
                child: SchedularTextField(
                  controller: ctlrCity,
                    labelText: AppString.city
                )
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularDropdown(
                    labelText: AppString.state,
                    items: ['Option 1', 'Option 2', 'Option 3'],
                  onChanged: (newValue) {
                  setState(() {
                    selectedState = newValue;
                  });
                },
                )
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularTextFieldWithButton(
                  controller: ctlrZipCode,
                  labelText: AppString.zip_code,
                  initialValue: '2656845121',
                  buttonText: 'View Zone',
                )
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: SchedularTextField(
                    labelText: AppString.phone
                )
            ),
          ],
        ),
        SizedBox(height: AppSize.s16),
        Row(
          children: [
            Flexible(
                child: SchedularTextField(
                  controller: ctlrFax,
                    labelText: 'Fax'
                )
            ),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: Container()),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: Container()),
            SizedBox(width: AppSize.s35),
            Flexible(
                child: Container()),
          ],
        )
      ],
    );
  }
}