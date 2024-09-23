import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/company_identrity_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/pay_rates_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/progress_form_manager/form_general_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/register/offer_letter_screen.dart';
import 'package:prohealth/presentation/widgets/widgets/constant_textfield/const_textfield.dart';

import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../../app/services/api/managers/establishment_manager/all_from_hr_manager.dart';
import '../../../../../app/services/api/managers/establishment_manager/manage_details_manager.dart';
import '../../../../../app/services/api/managers/establishment_manager/zone_manager.dart';
import '../../../../../app/services/api/managers/hr_module_manager/profile_mnager.dart';
import '../../../../../app/services/api/managers/hr_module_manager/register_manager/register_manager.dart';
import '../../../../../data/api_data/api_data.dart';
import '../../../../../data/api_data/establishment_data/all_from_hr/all_from_hr_data.dart';
import '../../../../../data/api_data/establishment_data/ci_manage_button/manage_details_data.dart';
import '../../../../../data/api_data/establishment_data/company_identity/company_identity_data_.dart';
import '../../../../../data/api_data/establishment_data/pay_rates/pay_rates_finance_data.dart';
import '../../../../../data/api_data/establishment_data/zone/zone_model_data.dart';
import '../../../../../data/api_data/hr_module_data/profile_editor/profile_editor.dart';



class ProfileEditScreen extends StatefulWidget {
  final VoidCallback onCancel;

  final int employeeId;

  ProfileEditScreen({
    required this.onCancel,
    required this.employeeId,
  });

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  String? selectedDepartment;
  String? selectedGender;
  String? selectedZone;
  String? selectedCounty;
  String? selectedSSn;
  String? selectedServices;
  String? selectedEmployeType;
  String? selectedReportingOffice;
  DateTime? selectedDate;
  List<DropdownMenuItem<String>> dropDownList = [];
  int selectedZoneId = 0;
  int selectedCountyId = 0;
  int selectedCityId = 0;
  String reportingOfficeId ='';
  Map<String, bool> checkedZipCodes = {};
  Map<String, bool> checkedCityName = {};
  List<String> selectedZipCodes = [];
  List<String> selectedCityName = [];
  String selectedZipCodesString = '';
  var deptId = 1;
  int? firstDept;
  String? selectedDeptName;
  int? selectedDeptId;
  // String? selectedCounty;
  String? selectedServiceName;
  String? serviceId;
  final StreamController<List<ZipcodeByCountyIdAndZoneIdData>>
      _countyStreamController =
      StreamController<List<ZipcodeByCountyIdAndZoneIdData>>.broadcast();
  TextEditingController dummyCtrl = TextEditingController();

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
  List<DropdownMenuItem<String>> countyDropDownList = [];
  List<DropdownMenuItem<String>> zoneDropDownList = [];
  String selectedCovrageCounty = "Select County";
  String selectedCovrageZone = "Select Zone";


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
    selectedCounty = 'Select County';
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
  final StreamController<List<CountyWiseZoneModal>> _zoneController =
  StreamController<List<CountyWiseZoneModal>>.broadcast();
  List<ApiPatchCovrageData> addCovrage = [];
  List<int> zipCodes = [];
  String? selectedZipCodeZone;
  int docZoneId = 0;
  dynamic finalPath;
  String fileName = '';
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
                        color: Colors.blue.withOpacity(0.5),
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
                              style: EditProfile.customEditTextStyle(),
                            ),
                            CustomIconButton(
                              icon: Icons.upload_outlined,
                              text: AppString.photo, onPressed: () async {
                              // FilePickerResult? result = await FilePicker.platform.pickFiles(
                              //   allowMultiple: false,
                              // );
                              FilePickerResult? result =
                              await FilePicker.platform.pickFiles();
                              if (result != null) {
                                print("Result::: ${result}");

                                try {
                                  print('File picked: ${fileName}');
                                  //print(String.fromCharCodes(file));
                                  fileName = result.files.first.name;
                                  finalPath = result.files.first.bytes;

                                } catch (e) {
                                  print(e);
                                }
                              }
                            },
                            )
                          ],
                        ),
                      ),

                      ///
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HRManageTextField(
                              controller: nameController,
                              keyboardType: TextInputType.text,
                              text: AppString.name,
                              cursorHeight: 12,
                              labelText: AppString.name,
                              labelStyle: GoogleFonts.firaSans(fontSize: 12),
                              labelFontSize: 12),
                          FutureBuilder<List<EmployeeTypeModal>>(
                            future: EmployeeTypeGet(context, deptId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Container(
                                  alignment: Alignment.center,
                                  child: HRManageDropdown(
                                    controller: TextEditingController(text: ''),
                                    labelText: 'Select Employee Type',
                                    labelStyle: GoogleFonts.firaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: ColorManager.mediumgrey,
                                    ),
                                    labelFontSize: 12,
                                    items: [], // Empty while loading
                                  ),
                                );
                              }

                              if (snapshot.hasData && snapshot.data!.isEmpty) {
                                return HRManageDropdown(
                                  controller: TextEditingController(text: ''),
                                  labelText: 'Select Employee Type',
                                  labelStyle: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: ColorManager.mediumgrey,
                                  ),
                                  labelFontSize: 12,
                                  items: [],
                                );
                              }

                              if (snapshot.hasData) {
                                List<EmployeeTypeModal> employeeTypeList = snapshot.data!;
                                List<String> dropDownEmployeeTypes = employeeTypeList
                                    .map((employeeType) => employeeType.employeeType)
                                    .toList();

                                String? selectedEmployeeType = dropDownEmployeeTypes.isNotEmpty
                                    ? dropDownEmployeeTypes[0]
                                    : null;

                                int? selectedEmployeeTypeId = employeeTypeList.isNotEmpty
                                    ? employeeTypeList[0].employeeTypeId
                                    : null;

                                return HRManageDropdown(
                                  controller: TextEditingController(text: selectedEmployeeType ?? ''),
                                  labelText: "Select Employee Type",
                                  labelStyle: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: ColorManager.mediumgrey,
                                  ),
                                  labelFontSize: 12,
                                  items: dropDownEmployeeTypes,
                                  onChanged: (val) {
                                    selectedEmployeeType = val;
                                    selectedEmployeeTypeId = employeeTypeList
                                        .firstWhere((employeeType) => employeeType.employeeType == val)
                                        .employeeTypeId;

                                    print('Selected Employee Type ID: $selectedEmployeeTypeId');
                                  },
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                          FutureBuilder<List<HRHeadBar>>(
                            future: companyHRHeadApi(context, deptId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                List<String>dropDownServiceList =[];
                                return Container(
                                    alignment: Alignment.center,
                                    child:
                                    HRManageDropdown(
                                      controller: TextEditingController(
                                          text: ''),
                                      labelText: 'Select Department',
                                      labelStyle: GoogleFonts.firaSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: ColorManager.mediumgrey,
                                      ),
                                      labelFontSize: 12,
                                      items:  dropDownServiceList,

                                    )
                                );
                              }
                              if (snapshot.hasData &&
                                  snapshot.data!.isEmpty) {
                                return Center(
                                  child: Text(
                                    ErrorMessageString.noroleAdded,
                                    style: CustomTextStylesCommon.commonStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: FontSize.s12,
                                      color: ColorManager.mediumgrey,
                                    ),
                                  ),
                                );
                              }
                              if (snapshot.hasData) {
                                // Extract dropdown items from snapshot
                                List<String> dropDownServiceList = snapshot
                                    .data!
                                    .map((dept) => dept.deptName!)
                                    .toList();
                                String? firstDeptName =
                                snapshot.data!.isNotEmpty
                                    ? snapshot.data![0].deptName
                                    : null;
                                int? firstDeptId = snapshot.data!.isNotEmpty
                                    ? snapshot.data![0].deptId
                                    : null;

                                if (selectedDeptName == null &&
                                    dropDownServiceList.isNotEmpty) {
                                  selectedDeptName = firstDeptName;
                                  selectedDeptId = firstDeptId;
                                }

                                return HRManageDropdown(
                                  controller: TextEditingController(
                                      text: selectedDeptName ?? ''),
                                  labelText: "Select Department",
                                  labelStyle: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: ColorManager.mediumgrey,
                                  ),
                                  labelFontSize: 12,
                                  items: dropDownServiceList,
                                  onChanged: (val) {
                                    // setState(() {
                                      selectedDeptName = val;
                                      selectedDeptId = snapshot.data!
                                          .firstWhere(
                                              (dept) => dept.deptName == val)
                                          .deptId;
                                    // });
                                  },
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HRManageTextField(
                              controller: addressController,
                              keyboardType: TextInputType.text,
                              text: AppString.address,
                              cursorHeight: 12,
                              labelText: AppString.address,
                              labelStyle:TextStyle(fontSize: 10),
                              labelFontSize: 12),
                          HRManageTextField(
                            controller: ageController,
                            keyboardType: TextInputType.text,
                            text: 'Other Field',
                            cursorHeight: 12,
                            labelText: 'Other Field',
                            labelStyle: TextStyle(fontSize: 10),
                            labelFontSize: 12,
                            showDatePicker: true,
                          ),
                          HRManageTextField(
                              controller: genderController,
                              keyboardType: TextInputType.text,
                              text: AppStringMobile.gender,
                              // suffixIcon: Icon(Icons.calendar_month_outlined),
                              cursorHeight: 12,
                              labelText: AppStringMobile.gender,
                              labelStyle:TextStyle(fontSize: 10),
                              labelFontSize: 10),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          HRManageTextField(
                              controller: ssNController,
                              keyboardType: TextInputType.text,
                              text: AppString.ssn,
                              cursorHeight: 12,
                              labelText: AppString.ssn,
                              labelStyle: GoogleFonts.firaSans(fontSize: 12),
                              labelFontSize: 12),
                          HRManageTextField(
                              controller: phoneNController,
                              keyboardType: TextInputType.text,
                              text: AppString.phone_number,
                              cursorHeight: 12,
                              labelText: AppString.phone_number,
                              labelStyle: GoogleFonts.firaSans(fontSize: 12),
                              labelFontSize: 12),
                          HRManageTextField(
                              controller: workPhoneController,
                              keyboardType: TextInputType.text,
                              text: AppStringMobile.worNo,
                              cursorHeight: 12,
                              labelText: AppStringMobile.worNo,
                              labelStyle: GoogleFonts.firaSans(fontSize: 12),
                              labelFontSize: 12),
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
                              cursorHeight: 12,
                              labelText: AppStringMobile.perEmail,
                              labelStyle: GoogleFonts.firaSans(fontSize: 12),
                              labelFontSize: 12),
                          HRManageTextField(
                              controller: workEmailController,
                              keyboardType: TextInputType.text,
                              text: AppStringMobile.worEmail,
                              cursorHeight: 12,
                              labelText: AppStringMobile.worEmail,
                              labelStyle: GoogleFonts.firaSans(fontSize: 12),
                              labelFontSize: 12),
                          HRManageTextField(
                              controller: summaryController,
                              keyboardType: TextInputType.text,
                              text: AppStringMobile.summry,
                              cursorHeight: 12,
                              labelText: AppStringMobile.summry,
                              labelStyle: GoogleFonts.firaSans(fontSize: 12),
                              labelFontSize: 12),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FutureBuilder<List<ServicesMetaData>>(
                    future: getServicesMetaData(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Show loading indicator or dummy dropdown
                        return HRManageDropdown(
                          controller: TextEditingController(text: ''),
                          labelText: 'Select Service',
                          labelStyle: TextStyle(fontSize: 14),
                          items: [], labelFontSize: 12,
                        );
                      }

                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        List<String> serviceNames = snapshot.data!
                            .map((service) => service.serviceName)
                            .toList();

                        return HRManageDropdown(
                          controller: TextEditingController(),
                          labelText: 'Select Service',
                          items: serviceNames,
                          onChanged: (val) {
                            // Handle selected service
                            var selectedService = snapshot.data!
                                .firstWhere((service) => service.serviceName == val);
                            print('Selected Service ID: ${selectedService.serviceId}');
                          }, labelStyle:  TextStyle(fontSize: 14),labelFontSize: 12 ,
                        );
                      }

                      return const Text('No services available');
                    }, ),
                          FutureBuilder<List<CompanyOfficeListData>>(
                            future: getCompanyOfficeList(context),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return HRManageDropdown(
                                  // width: 320,
                                  // height: 40,
                                  controller: TextEditingController(text: ''),
                                  items: ['item 1', 'item 2'],
                                  labelText: 'Reporting Office',
                                  labelStyle: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    color: Color(0xff575757),
                                    fontWeight: FontWeight.w400,
                                  ), labelFontSize: 12,
                                );
                              }
                              if (snapshot.hasData) {
                                List<String> dropDownList = [];
                                for (var i in snapshot.data!) {
                                  dropDownList.add(i.name);
                                }
                                return HRManageDropdown(
                                  labelText: 'Reporting Office',
                                  labelStyle: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    color: Color(0xff575757),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  labelFontSize: 12,
                                  items: dropDownList,
                                  onChanged: (newValue) {
                                    for (var a in snapshot.data!) {
                                      if (a.name == newValue) {
                                        reportingOfficeId = a.name;
                                        print('Office Name : ${reportingOfficeId}');
                                        // int docType = a.employeeTypesId;
                                        // Do something with docType
                                      }
                                    }
                                  },  controller: TextEditingController(text: ''),
                                );
                              } else {
                                return const Offstage();
                              }
                            },
                          ),
                          Container(
                            height: 40,
                            width: 320,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              height: 20,
                              width: 320,
                              child: Text(
                                "Coverage",
                                style: EditProfile.customEditTextStyle(),
                              ),
                              // color: Colors.green,
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
                        ],
                      ),

                      ///Coverage
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                Text("County :",
                                    style: EditTextFontStyle
                                        .customEditTextStyle()),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(selectedCovrageCounty,
                                    style: EditTextFontStyle
                                        .customEditTextStyle()),
                                SizedBox(
                                  width: 30,
                                ),
                                Text('Zone :',
                                    style: EditTextFontStyle
                                        .customEditTextStyle()),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  selectedCovrageZone,
                                  style:
                                      EditTextFontStyle.customEditTextStyle(),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              side: BorderSide(color: Colors.blue, width: 2,),),
                                            child: SizedBox(
                                              height: 350,
                                              width: 730,
                                              child: SingleChildScrollView(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only( top: 8),
                                                        child: Text("Edit Coverage", style: EditProfile.customEditTextStyle(),),
                                                      ),

                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [

                                                          ///county zone
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(vertical: 20),
                                                            child: Container(
                                                              height: 300,
                                                              width: 150,
                                                              child:

                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    'County',
                                                                    style: GoogleFonts.firaSans(
                                                                      fontSize: 12,
                                                                      fontWeight: FontWeight.w600,
                                                                      color: const Color(0xff575757),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(height: 5),
                                                                  FutureBuilder<List<AllCountyGetList>>(
                                                                    future: getCountyZoneList(context),
                                                                    builder: (context, snapshot) {
                                                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                                                        return const Padding(
                                                                          padding: EdgeInsets.symmetric(horizontal: 7),
                                                                          child: CICCDropdown(
                                                                            hintText: 'Select County',
                                                                            items: [],
                                                                          ),
                                                                        );
                                                                      } else if (snapshot.hasError) {
                                                                        return const Text("Error fetching counties");
                                                                      } else if (snapshot.hasData) {
                                                                        countyDropDownList.clear();
                                                                        countyDropDownList.add(
                                                                          DropdownMenuItem<String>(
                                                                            child: Text('Select County'),
                                                                            value: 'Select County',
                                                                          ),
                                                                        );
                                                                        for (var county in snapshot.data!) {
                                                                          countyDropDownList.add(
                                                                            DropdownMenuItem<String>(
                                                                              child: Text(county.countyName),
                                                                              value: county.countyName,
                                                                            ),
                                                                          );
                                                                        }

                                                                        return StatefulBuilder(
                                                                          builder: (BuildContext context, StateSetter setState) {
                                                                            return Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                // County Dropdown
                                                                                CICCDropdown(
                                                                                  items: countyDropDownList,
                                                                                  initialValue: selectedCounty,
                                                                                  width: 150,
                                                                                  onChange: (newValue) async {
                                                                                    setState(() {
                                                                                      selectedCounty = newValue;
                                                                                      selectedCovrageCounty = newValue;
                                                                                    });

                                                                                    // Get the county ID for the selected county
                                                                                    for (var county in snapshot.data!) {
                                                                                      if (county.countyName == newValue) {
                                                                                        selectedCountyId = county.countyId;
                                                                                        break;
                                                                                      }
                                                                                    }
                                                                                    // Fetch zones for the selected county
                                                                                    // List<CountyWiseZoneModal> zones =
                                                                                    // await fetchCountyWiseZone(context, selectedCountyId);
                                                                                    //
                                                                                    // // Clear and populate zone dropdown list
                                                                                    // zoneDropDownList.clear();
                                                                                    // zoneDropDownList.add(
                                                                                    //   DropdownMenuItem<String>(
                                                                                    //     child: Text('Select Zone'),
                                                                                    //     value: 'Select Zone',
                                                                                    //   ),
                                                                                    // );
                                                                                    // for (var zone in zones) {
                                                                                    //   zoneDropDownList.add(
                                                                                    //     DropdownMenuItem<String>(
                                                                                    //       child: Text(zone.zoneName),
                                                                                    //       value: zone.zoneName,
                                                                                    //     ),
                                                                                    //   );
                                                                                    // }
                                                                                    print("Selected CountyId: $selectedCountyId");
                                                                                  },
                                                                                ),
                                                                                const SizedBox(height: 10),

                                                                                // Zone Label
                                                                                Text(
                                                                                  'Zone',
                                                                                  style: GoogleFonts.firaSans(
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.w600,
                                                                                    color: const Color(0xff575757),
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(height: 5),

                                                                                // Zone Dropdown with hint text
                                                                                StreamBuilder<
                                                                                    List<CountyWiseZoneModal>>(
                                                                                    stream: _zoneController.stream,
                                                                                    builder: (context, snapshotZone) {
                                                                                      fetchCountyWiseZone(context, selectedCountyId)
                                                                                          .then((data) {
                                                                                        _zoneController.add(data);
                                                                                      }).catchError((error) {});
                                                                                      if (snapshotZone.connectionState ==
                                                                                          ConnectionState.waiting) {
                                                                                        return Container(
                                                                                          width: 150,
                                                                                          height: 30,
                                                                                          decoration: BoxDecoration(
                                                                                            border: Border.all(
                                                                                                color: ColorManager
                                                                                                    .containerBorderGrey,
                                                                                                width: AppSize.s1),
                                                                                            borderRadius:
                                                                                            BorderRadius.circular(4),
                                                                                          ),
                                                                                          child: const Text(
                                                                                            "",
                                                                                            //AppString.dataNotFound,
                                                                                          ),
                                                                                        );
                                                                                      }
                                                                                      if (snapshotZone.data!.isEmpty) {
                                                                                        return Container(
                                                                                          width: 150,
                                                                                          height: 30,
                                                                                          decoration: BoxDecoration(
                                                                                            border: Border.all(
                                                                                                color: ColorManager
                                                                                                    .containerBorderGrey,
                                                                                                width: AppSize.s1),
                                                                                            borderRadius:
                                                                                            BorderRadius.circular(4),
                                                                                          ),
                                                                                          child: Align(
                                                                                            alignment: Alignment.centerLeft,
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets
                                                                                                  .symmetric(
                                                                                                  horizontal: 10),
                                                                                              child: Text(
                                                                                                ErrorMessageString
                                                                                                    .noZoneAdded,
                                                                                                //  AppString.dataNotFound,
                                                                                                style:
                                                                                                AllNoDataAvailable.customTextStyle(context),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        );
                                                                                      }
                                                                                      if (snapshotZone.hasData) {
                                                                                        List dropDown = [];
                                                                                        int docType = 0;
                                                                                        List<DropdownMenuItem<String>>
                                                                                        dropDownTypesList = [];
                                                                                        // dropDownTypesList.add(
                                                                                        //     const DropdownMenuItem<String>(
                                                                                        //   child: Text('Select zone'),
                                                                                        //   value: 'Select zone',
                                                                                        // ));
                                                                                        for (var i in snapshotZone.data!) {
                                                                                          dropDownTypesList.add(
                                                                                            DropdownMenuItem<String>(
                                                                                              value: i.zoneName,
                                                                                              child: Text(i.zoneName),
                                                                                            ),
                                                                                          );
                                                                                        }
                                                                                        if (selectedZipCodeZone == null) {
                                                                                          selectedZipCodeZone =
                                                                                              snapshotZone.data![0].zoneName;
                                                                                        }
                                                                                        docZoneId = snapshotZone.data![0].zone_id;
                                                                                        return CICCDropdown(
                                                                                            width: 150,
                                                                                            initialValue:
                                                                                            dropDownTypesList[0].value,
                                                                                            onChange: (val) {
                                                                                              selectedZipCodeZone = val;
                                                                                              selectedCovrageZone = val;
                                                                                              for (var a
                                                                                              in snapshotZone.data!) {
                                                                                                if (a.zoneName == val) {
                                                                                                  docType = a.zone_id;
                                                                                                  print(
                                                                                                      "ZONE id :: ${a.zone_id}");
                                                                                                  docZoneId = docType;
                                                                                                }
                                                                                              }
                                                                                              print(":::${docType}");
                                                                                              print(":::<>${docZoneId}");
                                                                                            },
                                                                                            items: dropDownTypesList);
                                                                                      }
                                                                                      return const SizedBox();
                                                                                    }),
                                                                                // CICCDropdown(
                                                                                //   hintText: 'Select Zone',
                                                                                //   items: zoneDropDownList.isNotEmpty ? zoneDropDownList : [],
                                                                                //   initialValue: selectedZone,
                                                                                //   width: 150,
                                                                                //   onChange: (newValue) {
                                                                                //     setState(() {
                                                                                //       selectedZone = newValue;
                                                                                //       print('Selected Zone: $selectedZone');
                                                                                //     });
                                                                                //     // for (var zone in zones) {
                                                                                //     //   if (county.countyName == newValue) {
                                                                                //     //     selectedCountyId = county.countyId;
                                                                                //     //     break;
                                                                                //     //   }
                                                                                //     // }
                                                                                //   },
                                                                                // ),
                                                                              ],
                                                                            );
                                                                          },
                                                                        );
                                                                      } else {
                                                                        return const Text('No Data available');
                                                                      }
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          ///Zipcode
                                                          Container(
                                                            height: 290,
                                                            width: 300,
                                                            // color:  Colors.green,
                                                            child:
                                                                DefaultTabController(
                                                              length: 1,
                                                              child: Column(
                                                                children: [
                                                                  Padding(padding: EdgeInsets.symmetric(horizontal: 5),
                                                                    child: TabBar(
                                                                      indicatorColor: const Color(0xff1696C8),
                                                                      labelColor: const Color(0xff686464),
                                                                      unselectedLabelColor:
                                                                          const Color(
                                                                              0xff686464),
                                                                      labelStyle:
                                                                          GoogleFonts
                                                                              .firaSans(
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                      ),
                                                                      unselectedLabelStyle:
                                                                          GoogleFonts
                                                                              .firaSans(
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                      ),
                                                                      tabs: const [
                                                                        Tab(
                                                                            text:
                                                                                'Zip Codes'),
                                                                        // Tab(text: 'Cities'),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  ///
                                                                  Expanded(
                                                                    child: Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              20.0,
                                                                          right:
                                                                              20.0),
                                                                      child:
                                                                          TabBarView(
                                                                        physics:
                                                                            const NeverScrollableScrollPhysics(),
                                                                        children: [
                                                                          StreamBuilder<
                                                                              List<
                                                                                  ZipcodeByCountyIdAndZoneIdData>>(
                                                                            stream:
                                                                                _countyStreamController.stream,
                                                                            builder:
                                                                                (BuildContext context,
                                                                                    snapshot) {
                                                                              getZipcodeByCountyIdAndZoneId(context: context, countyId: selectedCountyId, zoneId: docZoneId).then(
                                                                                  (data) {
                                                                                _countyStreamController.add(data);
                                                                              }).catchError(
                                                                                  (error) {
                                                                                // Handle error
                                                                              });
                                                                              if (snapshot.connectionState ==
                                                                                  ConnectionState.waiting) {
                                                                                return SizedBox();
                                                                              }
                                                                              if (selectedCountyId ==
                                                                                  0) {
                                                                                return Center(
                                                                                    child: Text(
                                                                                  'Select county',
                                                                                  style: GoogleFonts.firaSans(fontSize: 10.0, fontWeight: FontWeight.w500),
                                                                                ));
                                                                              }
                                                                              if (snapshot
                                                                                  .data!
                                                                                  .isEmpty) {
                                                                                return Center(
                                                                                    child: Text(
                                                                                  'No Data Found!',
                                                                                  style: GoogleFonts.firaSans(fontSize: 10.0, fontWeight: FontWeight.w500),
                                                                                ));
                                                                              }
                                                                              return Row(
                                                                                children: [
                                                                                  StatefulBuilder(
                                                                                    builder: (BuildContext context, void Function(void Function()) setState) {
                                                                                      return Container(
                                                                                        width: 200,
                                                                                        height: 300,
                                                                                        child: ListView.builder(
                                                                                          itemCount: snapshot.data!.length,
                                                                                          itemBuilder: (BuildContext context, int index) {
                                                                                            String zipCode = snapshot.data![index].zipCode;
                                                                                            bool isChecked = checkedZipCodes[zipCode] ?? false;
                                                                                            return CheckBoxTileConst(
                                                                                                text: zipCode,
                                                                                                value: isChecked,
                                                                                                onChanged: (bool? val) {
                                                                                                  setState(() {
                                                                                                    print('Clicked check box 1');
                                                                                                    checkedZipCodes[zipCode] = val ?? false;
                                                                                                    if (val == true) {
                                                                                                      selectedZipCodes.add(zipCode);
                                                                                                      zipCodes.add(int.parse(snapshot.data![index].zipCode));
                                                                                                    } else {
                                                                                                      selectedZipCodes.remove(zipCode);
                                                                                                      zipCodes.remove(int.parse(snapshot.data![index].zipCode));
                                                                                                    }
                                                                                                    selectedZipCodesString = selectedZipCodes.join(', ');
                                                                                                  });
                                                                                                });
                                                                                          },
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                CustomButton(
                                                  height: 28,
                                                  width: 70,
                                                  text: 'Add',
                                                  onPressed: () async {
                                                    // Uncomment if you need a loading state
                                                    // setState(() {
                                                    //   _isLoading = true;
                                                    // });
                                                    setState((){

                                                    });
                                                   addCovrage.add(ApiPatchCovrageData(city: "", countyId: selectedCountyId, zoneId: docZoneId, zipCodes: zipCodes));
                                                    print('Selected County ID: $selectedCountyId');
                                                    print('Selected Zone ID: $docZoneId');
                                                    print('Selected Zip Codes: $selectedZipCodes');
                                                    print('Selected City: $selectedCityName');
                                                    Navigator.pop(context);
                                                    // print('Salary: $_salary');
                                                    // print('Salary Type: $dropdownValue');
                                                    // print('Patient Count: ${patientsController.text}');
                                                    // try {
                                                    //   // var coverageResponse = await addEmpEnrollAddCoverage(
                                                    //   //   context,
                                                    //   //   0,
                                                    //   //   widget.employeeId!,
                                                    //   //   addCovrage,
                                                    //   // );
                                                    //   // if (coverageResponse.success) {
                                                    //   //   print("Coverage added successfully");
                                                    //   //    } else {
                                                    //   //  print("Failed To Add Coverage");
                                                    //   // }
                                                    // } catch (e) {
                                                    //   print("Error during adding coverage: $e");
                                                    // } finally {
                                                    //
                                                    //   // setState(() {
                                                    //   //   _isLoading = false;
                                                    //   // });
                                                    // }
                                                  },
                                                ),
                                                      SizedBox(height: 10,)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ));
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit_outlined,
                                    size: 15,
                                    color: ColorManager.mediumgrey,
                                  ),
                                ),
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
                        ],
                      ),

                      ///
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            height: 30,
                            width: 100,
                            onPressed: () async {
                              print(
                                  "code::::::::::::::::::::::::::::::::::::code");
                              print(
                                  "FirstName::::::::::::::::::::::::::::::::::::${nameController.text}");
                              print(
                                  "LastName::::::::::::::::::::::::::::::::::::${deptController.text}");
                              print(
                                  "DepartmentId::::::::::::::::::::::::::::::::::::1");
                              print(
                                  "EmployeeTypeId::::::::::::::::::::::::::::::::::::2");
                              print(
                                  "Expertise::::::::::::::::::::::::::::::::::::Expert");
                              print(
                                  "CityId::::::::::::::::::::::::::::::::::::1");
                              print(
                                  "CountryId::::::::::::::::::::::::::::::::::::1");
                              print(
                                  "CountyId::::::::::::::::::::::::::::::::::::1");
                              print(
                                  "ZoneId::::::::::::::::::::::::::::::::::::1");
                              print(
                                  "SSNNbr::::::::::::::::::::::::::::::::::::${ssNController.text}");
                              print(
                                  "PrimaryPhoneNbr::::::::::::::::::::::::::::::::::::${phoneNController.text}");
                              print(
                                  "SecondaryPhoneNbr::::::::::::::::::::::::::::::::::::");
                              print(
                                  "WorkPhoneNbr::::::::::::::::::::::::::::::::::::${workPhoneController.text}");
                              print(
                                  "RegOfficId::::::::::::::::::::::::::::::::::::${reportingOfficeController.text}");
                              print(
                                  "PersonalEmail::::::::::::::::::::::::::::::::::::${personalEmailController.text}");
                              print(
                                  "WorkEmail::::::::::::::::::::::::::::::::::::${workEmailController.text}");
                              print(
                                  "Address::::::::::::::::::::::::::::::::::::${addressController.text}");
                              print(
                                  "DateOfBirth::::::::::::::::::::::::::::::::::::${ageController.text}");
                              print(
                                  "EmergencyContact::::::::::::::::::::::::::::::::::::John Doe");
                              print(
                                  "Coverage::::::::::::::::::::::::::::::::::::Health");
                              print(
                                  "Employment::::::::::::::::::::::::::::::::::::Full Time");
                              print(
                                  "Gender::::::::::::::::::::::::::::::::::::${genderController.text}");
                              print(
                                  "Status::::::::::::::::::::::::::::::::::::Active");
                              print(
                                  "Service::::::::::::::::::::::::::::::::::::${serviceController.text}");
                              print(
                                  "ImgUrl::::::::::::::::::::::::::::::::::::");
                              print(
                                  "ResumeUrl::::::::::::::::::::::::::::::::::::");
                              print(
                                  "CompanyId::::::::::::::::::::::::::::::::::::1");
                              print(
                                  "OnboardingStatus::::::::::::::::::::::::::::::::::::Completed");
                              print(
                                  "DriverLicenceNbr::::::::::::::::::::::::::::::::::::DL123");
                              print(
                                  "DateOfTermination::::::::::::::::::::::::::::::::::::");
                              print(
                                  "DateOfResignation::::::::::::::::::::::::::::::::::::");
                              print(
                                  "DateOfHire::::::::::::::::::::::::::::::::::::2022-01-01");
                              print(
                                  "Rehirable::::::::::::::::::::::::::::::::::::Yes");
                              print(
                                  "Position::::::::::::::::::::::::::::::::::::Manager");
                              print(
                                  "FinalAddress::::::::::::::::::::::::::::::::::::${addressController.text}");
                              print(
                                  "Type::::::::::::::::::::::::::::::::::::Full Time");
                              print(
                                  "Reason::::::::::::::::::::::::::::::::::::");
                              print(
                                  "FinalPayCheck::::::::::::::::::::::::::::::::::::5000");
                              print(
                                  "CheckDate::::::::::::::::::::::::::::::::::::2022-01-01");
                              print(
                                  "GrossPay::::::::::::::::::::::::::::::::::::10000");
                              print(
                                  "NetPay::::::::::::::::::::::::::::::::::::8000");
                              print(
                                  "Methods::::::::::::::::::::::::::::::::::::Bank Transfer");
                              print(
                                  "Materials::::::::::::::::::::::::::::::::::::");
                              print(
                                  "Race::::::::::::::::::::::::::::::::::::Asian");
                              print(
                                  "Rating::::::::::::::::::::::::::::::::::::A+");
                              print(
                                  "SignatureURL::::::::::::::::::::::::::::::::::::");

                              try {
                                await getEmployeeEdit(
                                  context: context,
                                  employeeId: widget.employeeId,
                                  code: profileData.code,
                                  userId: profileData.userId,
                                  firstName: nameController.text,
                                  lastName: profileData.lastName,
                                  departmentId: int.parse(deptController.text),
                                  employeeTypeId:
                                      int.parse(empTypeController.text),
                                  expertise: 'Expert',
                                  cityId: profileData.cityId,
                                  countryId: profileData.countryId,
                                  countyId: 1,
                                  zoneId: int.parse(zoneController.text),
                                  SSNNbr: ssNController.text,
                                  primaryPhoneNbr: phoneNController.text,
                                  secondryPhoneNbr:
                                      profileData.secondryPhoneNbr,
                                  workPhoneNbr: workPhoneController.text,
                                  regOfficId: profileData.regOfficId,
                                  personalEmail: personalEmailController.text,
                                  workEmail: workEmailController.text,
                                  address: addressController.text,
                                  dateOfBirth: ageController.text,
                                  emergencyContact:
                                      profileData.emergencyContact,
                                  covreage: profileData.covreage,
                                  employment: profileData.employment,
                                  gender: genderController.text,
                                  status: profileData.status,
                                  service: serviceController.text,
                                  imgurl: profileData.imgurl,
                                  resumeurl: profileData.resumeurl,
                                  // companyId: 1,
                                  onboardingStatus:
                                      profileData.onboardingStatus,
                                  driverLicenceNbr:
                                      profileData.driverLicenceNbr,
                                  dateofTermination:
                                      profileData.dateofTermination,
                                  dateofResignation:
                                      profileData.dateofResignation,
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
                                var patchCoverage = await patchEmpEnrollAddCoverage(context,0,widget.employeeId,addCovrage);
                                if (patchCoverage.success) {
                                  print("Coverage added successfully");
                                } else {
                                  print("Failed To Add Coverage");
                                }
                                var uploadResponse = await UploadEmployeePhoto(context: context,documentFile: finalPath,employeeId: widget.employeeId);
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
                            text: 'Save',
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          ProfileEditCancelButton(
                            height: 30,
                            width: 100,
                            text: AppString.cancel,
                            onPressed: () {
                              print(
                                  "Edit Mode Cancel :::::::::::::::::::::::############");

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
    return TextStyle(
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w700,
      // : FontWeight.w500,
      color: ColorManager.blueprime,
      // decoration: TextDecoration.none,
    );
  }
}

class EditTextFontStyle {
  static TextStyle customEditTextStyle() {
    return TextStyle(
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
          child:
              Text(text!, textAlign: TextAlign.center, style: mergedTextStyle)),
    );
  }
}
