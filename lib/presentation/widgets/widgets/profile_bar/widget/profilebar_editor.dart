import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/widgets/constant_textfield/const_textfield.dart';

import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../../app/services/api/managers/hr_module_manager/profile_mnager.dart';
import '../../../../../data/api_data/hr_module_data/profile_editor/profile_editor.dart';

typedef BackButtonCallBack = void Function(bool val);
class ProfileEditScreen extends StatefulWidget {

  final VoidCallback onCancel;

  final int employeeId;

  ProfileEditScreen({ required this.onCancel,
    required this.employeeId,
  });

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {

  String? selectedDepartment ;
  String? selectedGender ;
  String? selectedZone ;
  String? selectedCounty ;
  String? selectedSSn ;
  String? selectedServices ;
  String? selectedEmployeType ;
  String? selectedReportingOffice ;

  TextEditingController nameController = TextEditingController();

  TextEditingController deptController = TextEditingController();

  TextEditingController empTypeController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController ageController = TextEditingController();

  TextEditingController genderController = TextEditingController();

  TextEditingController ssNController = TextEditingController();

  TextEditingController workPhoneController = TextEditingController();

  TextEditingController phoneNController = TextEditingController();

  TextEditingController personalEmailController = TextEditingController();

  TextEditingController workEmailController = TextEditingController();

  TextEditingController zoneController = TextEditingController();

  TextEditingController countyController = TextEditingController();

  TextEditingController serviceController = TextEditingController();

  TextEditingController reportingOfficeController = TextEditingController();

  TextEditingController summaryController = TextEditingController();


  @override
  void initState() {
    super.initState();
    // Initialize controllers
    nameController = TextEditingController();
    deptController = TextEditingController();
    empTypeController = TextEditingController();
    addressController = TextEditingController();
    ageController = TextEditingController();
    genderController = TextEditingController();
    ssNController = TextEditingController();
    workPhoneController = TextEditingController();
    phoneNController = TextEditingController();
    personalEmailController = TextEditingController();
    workEmailController = TextEditingController();
    zoneController = TextEditingController();
    countyController = TextEditingController();
    serviceController = TextEditingController();
    reportingOfficeController = TextEditingController();
    summaryController = TextEditingController();
  }

  @override
  void dispose() {
    // Dispose controllers
    nameController.dispose();
    deptController.dispose();
    empTypeController.dispose();
    addressController.dispose();
    ageController.dispose();
    genderController.dispose();
    ssNController.dispose();
    workPhoneController.dispose();
    phoneNController.dispose();
    personalEmailController.dispose();
    workEmailController.dispose();
    zoneController.dispose();
    countyController.dispose();
    serviceController.dispose();
    reportingOfficeController.dispose();
    summaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print("Edit Mode Cancel :::::::::::::::::::::::############");
    return FutureBuilder<ProfileEditorModal>(
      future: getEmployeePrefill(context, widget.employeeId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error fetching profile data'),
          );
        }

        if (snapshot.hasData) {
          // Populate controllers with the fetched data
          var profileData = snapshot.data!;

          nameController.text = profileData.firstName ?? '';
          deptController.text = profileData.department ?? '';
          empTypeController.text = profileData.employeType ?? '';
          addressController.text = profileData.finalAddress ?? '';
          ageController.text = profileData.dateOfBirth ?? '';
          genderController.text = profileData.gender ?? '';
          ssNController.text = profileData.SSNNbr ?? '';
          workPhoneController.text = profileData.workPhoneNbr ?? '';
          phoneNController.text = profileData.primaryPhoneNbr ?? '';
          personalEmailController.text = profileData.personalEmail ?? '';
          workEmailController.text = profileData.workEmail ?? '';
          zoneController.text = profileData.zone ?? '';
          countyController.text = profileData.county ?? '';
          serviceController.text = profileData.service ?? '';
          reportingOfficeController.text = profileData.regOfficId ?? '';
          summaryController.text = profileData.service ?? '';

          return Column(
            children: [
              Expanded(
                child: Container(
                  // height: 550,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.  withOpacity(0.5),
                        offset: Offset(0, -4),
                        // blurRadius: 8.0,
                        spreadRadius: 1.0,
                      ),
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: Offset(0, 4),
                        spreadRadius: 1.0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppString.editProfile,
                              style: EditProfile.customEditTextStyle(),) ,

                            CustomIconButton(
                              icon: Icons.upload_outlined,
                              text: AppString.photo, onPressed: () async {  },
                              // onPressed: () {} ,
                            )
                          ],),
                      ),
                      ///
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HRManageTextField(
                              controller: nameController,
                              keyboardType: TextInputType.text,
                              text: AppString.name,
                              cursorHeight: 12, labelText: AppString.name,
                              labelStyle: GoogleFonts.firaSans(
                                  fontSize: 12
                              ), labelFontSize: 12),
                             // CICCDropdown(
                  //   initialValue: selectedEmployeType,
                  //   onChange: (val) {
                  //     setState(() {
                  //       selectedEmployeType = val;
                  //       for (var service in snapshot.data!) {
                  //         if (service.serviceName == val) {
                  //           serviceId = service.serviceId;
                  //         }
                  //       }
                  //     });
                  //   },
                  //   items: [],
                  // ),
                          HRManageTextField(
                              controller: empTypeController,
                              keyboardType: TextInputType.text,
                              text: AppString.employmentType,
                              cursorHeight: 12, labelText: AppString.employmentType,
                              labelStyle: GoogleFonts.firaSans(
                                  fontSize: 12
                              ), labelFontSize: 12),
                          // HRManageDropdown(
                          //   controller: deptController,
                          //   labelText: AppString.dept,
                          //   labelStyle: GoogleFonts.firaSans(fontSize: 12),
                          //   labelFontSize: 12,
                          //   items: ['Clinical', 'Sales', 'Administration'],
                          //   onChanged: (value) {
                          //     setState(() {
                          //       selectedDepartment = value!;
                          //     });
                          //   },
                          // ),
                          HRManageTextField(
                              controller: deptController,
                              keyboardType: TextInputType.text,
                              text: AppString.dept,
                              cursorHeight: 12, labelText: AppString.dept,
                              labelStyle: GoogleFonts.firaSans(
                                  fontSize: 12
                              ), labelFontSize: 12),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HRManageTextField(
                              controller: addressController,
                              keyboardType: TextInputType.text,
                              text: AppString.address,
                              cursorHeight: 12, labelText: AppString.address,
                              labelStyle: GoogleFonts.firaSans(
                                  fontSize: 12
                              ), labelFontSize: 12),
                          HRManageTextField(
                              controller: ageController,
                              keyboardType: TextInputType.text,
                              text: AppStringMobile.age,
                              suffixIcon: Icon(Icons.calendar_month_outlined),
                              cursorHeight: 12, labelText: AppStringMobile.age,
                              labelStyle: GoogleFonts.firaSans(
                                  fontSize: 12
                              ), labelFontSize: 12),
                          // HRManageDropdown(controller: genderController,
                          //     labelText: AppString.gender,
                          //     labelStyle: GoogleFonts.firaSans(
                          //         fontSize: 12
                          //     ), labelFontSize: 12,
                          //     items: ['Male', 'Female',],
                          //   onChanged: (value) {
                          //     setState(() {
                          //       selectedGender = value!;
                          //     });
                          //   },
                          // )
                          HRManageTextField(
                              controller: genderController,
                              keyboardType: TextInputType.text,
                              text: AppStringMobile.gender,
                              suffixIcon: Icon(Icons.calendar_month_outlined),
                              cursorHeight: 12, labelText: AppStringMobile.gender,
                              labelStyle: GoogleFonts.firaSans(
                                  fontSize: 12
                              ), labelFontSize: 12),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // HRManageDropdown(controller: ssNController,
                          //     labelText: AppString.ssn,
                          //     labelStyle: GoogleFonts.firaSans(
                          //         fontSize: 12
                          //     ), labelFontSize: 12,
                          //     items: ['SSJ', 'SSNL', 'SSNM'],
                          //   onChanged: (value) {
                          //     setState(() {
                          //       selectedSSn = value!;
                          //     });
                          //   },
                          // ),
                          HRManageTextField(
                              controller: ssNController,
                              keyboardType: TextInputType.text,
                              text: AppString.ssn,
                              cursorHeight: 12, labelText: AppString.ssn,
                              labelStyle: GoogleFonts.firaSans(
                                  fontSize: 12
                              ), labelFontSize: 12),
                          HRManageTextField(
                              controller: phoneNController,
                              keyboardType: TextInputType.text,
                              text: AppString.phone_number,
                              cursorHeight: 12, labelText: AppString.phone_number,
                              labelStyle: GoogleFonts.firaSans(
                                  fontSize: 12
                              ), labelFontSize: 12),
                          HRManageTextField(
                              controller: workPhoneController,
                              keyboardType: TextInputType.text,
                              text: AppStringMobile.worNo,
                              cursorHeight: 12, labelText: AppStringMobile.worNo,
                              labelStyle: GoogleFonts.firaSans(
                                  fontSize: 12
                              ), labelFontSize: 12),

                        ],
                      ),
                      ///
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HRManageTextField(
                              controller: personalEmailController,
                              keyboardType: TextInputType.text,
                              text: AppStringMobile.perEmail,
                              cursorHeight: 12, labelText: AppStringMobile.perEmail,
                              labelStyle: GoogleFonts.firaSans(
                                  fontSize: 12
                              ), labelFontSize: 12),
                          HRManageTextField(
                              controller: workEmailController,
                              keyboardType: TextInputType.text,
                              text: AppStringMobile.worEmail,
                              cursorHeight: 12, labelText: AppStringMobile.worEmail,
                              labelStyle: GoogleFonts.firaSans(
                                  fontSize: 12
                              ), labelFontSize: 12),
                          // HRManageDropdown(controller: zoneController,
                          //     labelText: AppString.zone,
                          //     labelStyle: GoogleFonts.firaSans(
                          //         fontSize: 12
                          //     ), labelFontSize: 12,
                          //     items: ['Clinical', 'Sales','Administration'],
                          //   onChanged: (value) {
                          //     setState(() {
                          //       selectedZone = value!;
                          //     });
                          //   },
                          // )
                          ///
                          HRManageTextField(
                              controller: summaryController,
                              keyboardType: TextInputType.text,
                              text: AppStringMobile.summry,
                              cursorHeight: 12, labelText: AppStringMobile.summry,
                              labelStyle: GoogleFonts.firaSans(
                                  fontSize: 12
                              ), labelFontSize: 12),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HRManageTextField(
                              controller: countyController,
                              keyboardType: TextInputType.text,
                              text: AppString.county,
                              cursorHeight: 12, labelText: AppString.county,
                              labelStyle: GoogleFonts.firaSans(
                                  fontSize: 12
                              ), labelFontSize: 12),
                          HRManageTextField(
                              controller: serviceController,
                              keyboardType: TextInputType.text,
                              text: AppStringMobile.service,
                              cursorHeight: 12, labelText: AppStringMobile.service,
                              labelStyle: GoogleFonts.firaSans(
                                  fontSize: 12
                              ), labelFontSize: 12),
                          HRManageTextField(
                              controller: reportingOfficeController,
                              keyboardType: TextInputType.text,
                              text: AppStringMobile.repOff,
                              cursorHeight: 12, labelText: AppStringMobile.repOff,
                              labelStyle: GoogleFonts.firaSans(
                                  fontSize: 12
                              ), labelFontSize: 12),
                          // HRManageDropdown(controller: reportingOfficeController,
                          //     labelText: AppString.reportingOffice,
                          //     labelStyle: GoogleFonts.firaSans(
                          //         fontSize: 12
                          //     ), labelFontSize: 12,
                          //     items: ['Clinical', 'Sales','Administration'],
                          //   onChanged: (value) {
                          //     setState(() {
                          //       selectedReportingOffice = value!;
                          //     });
                          //   },
                          // )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 20,
                            width: 320,
                             child: Text("Coverage",   style:EditProfile.customEditTextStyle(),),
                            // color: Colors.green,
                          ),
                          Container(
                            height: 20,
                            width: 320,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: ColorManager.white,
                                width: 2, //width of border
                              ),

                            ),
                            // color: Colors.green,
                          ),
                          Container(
                            height: 55,
                            width: 320,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: ColorManager.white,
                                width: 2, //width of border
                              ),

                            ),
                            // color: Colors.green,
                          ),
                        ],
                      ),
                      ///Coverage
                      Row(
                       mainAxisAlignment: MainAxisAlignment.spaceAround ,
                        children: [
                        Container(
                          height: 55,
                          width: 320,
                          // margin: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: ColorManager.blueprime, //color of border
                              width: 2, //width of border
                            ),

                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("County :", style: EditTextFontStyle.customEditTextStyle()),
                              SizedBox(width: 5,),
                              Text("San Fransisco", style: EditTextFontStyle.customEditTextStyle()),
                              SizedBox(width: 30,),
                              Text('Zone :', style:EditTextFontStyle.customEditTextStyle()),
                              SizedBox(width: 5,),
                              Text("Zone 1", style: EditTextFontStyle.customEditTextStyle(),),
                              SizedBox(width: 5,),
                              IconButton(onPressed: (){
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(
                                          color: Colors.blue,
                                          width: 2,
                                        ),
                                      ),
                                      child: Container(
                                        width: 700,
                                        height: 300,
                                        padding: EdgeInsets.all(20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Edit Coverage',
                                              style:EditProfile.customEditTextStyle(),
                                              ),
                                            SizedBox(height: 20),

                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                                icon: Icon(Icons.edit_outlined, size: 15,
                                  color: ColorManager.mediumgrey, ),),
                            ],
                          ),

                        ),
                        Container(
                          height: 55,
                          width: 320,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: ColorManager.white,
                              width: 2, //width of border
                            ),

                          ),
                          // color: Colors.green,
                        ),
                        Container(
                          height: 55,
                          width: 320,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: ColorManager.white, //color of border
                              width: 2, //width of border
                            ),

                          ),
                          // color: Colors.green,
                        )
                      ],),
                      ///
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            height: 30,
                            width: 100,
                            onPressed: () async {

                              print("code::::::::::::::::::::::::::::::::::::code");
                              print("FirstName::::::::::::::::::::::::::::::::::::${nameController.text}");
                              print("LastName::::::::::::::::::::::::::::::::::::${deptController.text}");
                              print("DepartmentId::::::::::::::::::::::::::::::::::::1");
                              print("EmployeeTypeId::::::::::::::::::::::::::::::::::::2");
                              print("Expertise::::::::::::::::::::::::::::::::::::Expert");
                              print("CityId::::::::::::::::::::::::::::::::::::1");
                              print("CountryId::::::::::::::::::::::::::::::::::::1");
                              print("CountyId::::::::::::::::::::::::::::::::::::1");
                              print("ZoneId::::::::::::::::::::::::::::::::::::1");
                              print("SSNNbr::::::::::::::::::::::::::::::::::::${ssNController.text}");
                              print("PrimaryPhoneNbr::::::::::::::::::::::::::::::::::::${phoneNController.text}");
                              print("SecondaryPhoneNbr::::::::::::::::::::::::::::::::::::");
                              print("WorkPhoneNbr::::::::::::::::::::::::::::::::::::${workPhoneController.text}");
                              print("RegOfficId::::::::::::::::::::::::::::::::::::${reportingOfficeController.text}");
                              print("PersonalEmail::::::::::::::::::::::::::::::::::::${personalEmailController.text}");
                              print("WorkEmail::::::::::::::::::::::::::::::::::::${workEmailController.text}");
                              print("Address::::::::::::::::::::::::::::::::::::${addressController.text}");
                              print("DateOfBirth::::::::::::::::::::::::::::::::::::${ageController.text}");
                              print("EmergencyContact::::::::::::::::::::::::::::::::::::John Doe");
                              print("Coverage::::::::::::::::::::::::::::::::::::Health");
                              print("Employment::::::::::::::::::::::::::::::::::::Full Time");
                              print("Gender::::::::::::::::::::::::::::::::::::${genderController.text}");
                              print("Status::::::::::::::::::::::::::::::::::::Active");
                              print("Service::::::::::::::::::::::::::::::::::::${serviceController.text}");
                              print("ImgUrl::::::::::::::::::::::::::::::::::::");
                              print("ResumeUrl::::::::::::::::::::::::::::::::::::");
                              print("CompanyId::::::::::::::::::::::::::::::::::::1");
                              print("OnboardingStatus::::::::::::::::::::::::::::::::::::Completed");
                              print("DriverLicenceNbr::::::::::::::::::::::::::::::::::::DL123");
                              print("DateOfTermination::::::::::::::::::::::::::::::::::::");
                              print("DateOfResignation::::::::::::::::::::::::::::::::::::");
                              print("DateOfHire::::::::::::::::::::::::::::::::::::2022-01-01");
                              print("Rehirable::::::::::::::::::::::::::::::::::::Yes");
                              print("Position::::::::::::::::::::::::::::::::::::Manager");
                              print("FinalAddress::::::::::::::::::::::::::::::::::::${addressController.text}");
                              print("Type::::::::::::::::::::::::::::::::::::Full Time");
                              print("Reason::::::::::::::::::::::::::::::::::::");
                              print("FinalPayCheck::::::::::::::::::::::::::::::::::::5000");
                              print("CheckDate::::::::::::::::::::::::::::::::::::2022-01-01");
                              print("GrossPay::::::::::::::::::::::::::::::::::::10000");
                              print("NetPay::::::::::::::::::::::::::::::::::::8000");
                              print("Methods::::::::::::::::::::::::::::::::::::Bank Transfer");
                              print("Materials::::::::::::::::::::::::::::::::::::");
                              print("Race::::::::::::::::::::::::::::::::::::Asian");
                              print("Rating::::::::::::::::::::::::::::::::::::A+");
                              print("SignatureURL::::::::::::::::::::::::::::::::::::");

                              try {
                                await getEmployeeEdit(
                                  context: context,
                                  employeeId: widget.employeeId,
                                  code: profileData.code,
                                  userId: profileData.userId,
                                  firstName: nameController.text,
                                  lastName: profileData.lastName,
                                  departmentId: int.parse(deptController.text),
                                  employeeTypeId: int.parse(empTypeController.text),
                                  expertise: 'Expert',
                                  cityId: profileData.cityId,
                                  countryId: profileData.countryId,
                                  countyId: 1,
                                  zoneId: int.parse(zoneController.text),
                                  SSNNbr: ssNController.text,
                                  primaryPhoneNbr: phoneNController.text,
                                  secondryPhoneNbr: profileData.secondryPhoneNbr,
                                  workPhoneNbr: workPhoneController.text,
                                  regOfficId: profileData.regOfficId,
                                  personalEmail: personalEmailController.text,
                                  workEmail: workEmailController.text,
                                  address: addressController.text,
                                  dateOfBirth: ageController.text,
                                  emergencyContact: profileData.emergencyContact,
                                  covreage: profileData.covreage,
                                  employment: profileData.employment,
                                  gender: genderController.text,
                                  status: profileData.status,
                                  service: serviceController.text,
                                  imgurl: profileData.imgurl,
                                  resumeurl: profileData.resumeurl,
                                  // companyId: 1,
                                  onboardingStatus: profileData.onboardingStatus,
                                  driverLicenceNbr: profileData.driverLicenceNbr,
                                  dateofTermination: profileData.dateofTermination,
                                  dateofResignation: profileData.dateofResignation,
                                  dateofHire: profileData.dateofHire,
                                  rehirable: profileData.rehirable,
                                  position: profileData.position,
                                  finalAddress: addressController.text,
                                  type: profileData.type,
                                  reason: profileData.reason,
                                  finalPayCheck: profileData.finalPayCheck,
                                  checkDate: profileData.checkDate,
                                  grossPay: profileData.grossPay,
                                  netPay: profileData.netPay,
                                  methods: profileData.methods,
                                  materials: profileData.materials,
                                  race: profileData.race,
                                  rating: profileData.rating,
                                  signatureURL: profileData.signatureURL,
                                );
                                nameController.clear();
                                deptController.clear();
                                empTypeController.clear();
                                addressController.clear();
                                ageController.clear();
                               ssNController.clear();
                               phoneNController.clear();
                               workPhoneController.clear();
                               personalEmailController.clear();
                               workEmailController.clear();
                               countyController.clear();
                               serviceController.clear();
                               zoneController.clear();
                              } catch (e) {
                                print(e);
                              }
                            },
                            text: 'Save',),
                          SizedBox(width: 30,),
                          ProfileEditCancelButton(
                            height: 30,
                            width: 100,
                            text: AppString.cancel,

                            onPressed: () {
                              print("Edit Mode Cancel :::::::::::::::::::::::############");

                              widget.onCancel();

                            },
                            )
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            ],
          );
        }

        return Center(
          child: Text('No data available'),
        );
      },
    );
  }

}

class EditProfile {
  static TextStyle customEditTextStyle() {
    return GoogleFonts.firaSans(
      fontSize: FontSize.s12,
      fontWeight: FontWeight.w700,
          // : FontWeight.w500,
      color: ColorManager.blueprime,
      // decoration: TextDecoration.none,
    );
  }
}
class EditTextFontStyle{
  static TextStyle customEditTextStyle() {
    return GoogleFonts.firaSans(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: ColorManager.mediumgrey,
    );
  }
}

class ProfileEditCancelButton extends StatelessWidget {
  final String? text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double paddingVertical;
  final double paddingHorizontal;
  final double width;
  final double height;
  final TextStyle? style;
  final Widget? child;
   ProfileEditCancelButton({
     Key? key,
     this.text,
     required this.onPressed,
     this.backgroundColor = const Color(0xFF50B5E5),
     this.textColor = const Color(0xFF50B5E5),
     this.borderRadius = 14.0,
     this.paddingVertical = 12.0,
     this.paddingHorizontal = 16.0,
     this.width = 50,
     this.height = 50.0,
     this.style,
     this.child,
});

  // bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = GoogleFonts.firaSans(
      color: textColor,
      fontSize: 12,
      fontWeight: FontWeightManager.bold,
    );
    final mergedTextStyle = defaultTextStyle.merge(style);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          const BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 4),
            blurRadius: 3,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          backgroundColor: ColorManager.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Color(0xFF50B5E5)),
          ),
        ),
        child: Text(text!, textAlign: TextAlign.center, style: mergedTextStyle)
      ),
    );
  }
}
