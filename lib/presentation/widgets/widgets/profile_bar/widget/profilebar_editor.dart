import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/company_identrity_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/progress_form_manager/form_general_manager.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/manage_emp/gender_api.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/gender_data.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/widgets/constant_textfield/const_textfield.dart';
import 'package:prohealth/presentation/widgets/widgets/profile_bar/widget/profile_bar_editor_popup.dart';

import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../../app/services/api/managers/establishment_manager/all_from_hr_manager.dart';
import '../../../../../app/services/api/managers/establishment_manager/manage_details_manager.dart';
import '../../../../../app/services/api/managers/hr_module_manager/profile_mnager.dart';
import '../../../../../app/services/api/managers/hr_module_manager/register_manager/register_manager.dart';
import '../../../../../data/api_data/api_data.dart';
import '../../../../../data/api_data/establishment_data/all_from_hr/all_from_hr_data.dart';
import '../../../../../data/api_data/establishment_data/ci_manage_button/manage_details_data.dart';
import '../../../../../data/api_data/establishment_data/company_identity/company_identity_data_.dart';
import '../../../../../data/api_data/establishment_data/zone/zone_model_data.dart';
import '../../../../../data/api_data/hr_module_data/profile_editor/profile_editor.dart';
import '../../../../screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import '../../../../screens/em_module/widgets/dialogue_template.dart';
import 'add_coverage_popup.dart';



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
  String genderId ='';
  Map<String, bool> checkedZipCodes = {};
  Map<String, bool> checkedCityName = {};
  List<String> selectedZipCodes = [];
  List<String> selectedCityName = [];
  String selectedZipCodesString = '';
  var deptId = 1;
  int? firstDeptId;
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
  String? selectedServiceId;
  String? selectedOfficeId;
  String? selectedGenderId;


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
  bool pickedFilePath = false;
  dynamic finalPath;
  String fileName = '';
  @override
  Widget build(BuildContext context) {

    // print("Edit Mode Cancel :::::::::::::::::::::::############");
    return FutureBuilder<ProfileEditorModal>(
      future: getEmployeePrefill(context, widget.employeeId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
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
          summaryController.text = profileData.summary ?? '';
          print('Profile image ${profileData.imgurl}');
          String countyName = "";
          String zoneName = "";
          return Column(
            children: [
              Expanded(
                child: Container(

                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 5),
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
                        offset: const Offset(0, -4),
                        // blurRadius: 8.0,
                        spreadRadius: 1.0,
                      ),
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: const Offset(0, 4),
                        spreadRadius: 1.0,
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      // height: 750,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 23,top:10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [

                                      ProfileEditCancelButton(
                                        height: AppSize.s30,
                                        width: AppSize.s100,
                                        text: AppString.cancel,
                                        onPressed: () {
                                          print("Edit Mode Cancel :::::::::::::::::::::::############");
                                          widget.onCancel();
                                        },
                                      ),


                                    const SizedBox(
                                      width: 30,
                                    ),
                                    CustomButton(
                                      height: AppSize.s30,
                                      width: AppSize.s100,
                                      onPressed: () async {
                                        try {
                                          var response = await patchEmployeeEdit(
                                            context: context,
                                            employeeId: widget.employeeId,
                                            code: profileData.code,
                                            userId: profileData.userId,
                                            firstName: nameController.text,
                                            lastName: profileData.lastName,
                                            departmentId: profileData.departmentId,
                                            employeeTypeId:
                                            profileData.employeeTypeId,
                                            expertise: 'Expert',
                                            cityId: profileData.cityId,
                                            countryId: profileData.countryId,
                                            countyId: profileData.countyId,
                                            zoneId: profileData.zoneId,
                                            SSNNbr: ssNController.text,
                                            primaryPhoneNbr: phoneNController.text,
                                            secondryPhoneNbr:
                                            profileData.secondryPhoneNbr,
                                            workPhoneNbr: workPhoneController.text,
                                            regOfficId: selectedOfficeId ?? profileData.regOfficId,
                                            personalEmail: personalEmailController.text,
                                            workEmail: workEmailController.text,
                                            address: addressController.text,
                                            dateOfBirth: profileData.dateOfBirth == ageController.text ? profileData.dateOfBirth.toString() : ageController.text,
                                            emergencyContact:
                                            profileData.emergencyContact,
                                            covreage: profileData.covreage,
                                            employment: profileData.employment,
                                            gender: selectedGenderId ?? genderController.text,
                                            status: profileData.status,
                                            service: selectedServiceId ?? serviceController.text,
                                            summary: summaryController.text,
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
                                          if(response.statusCode == 200 || response.statusCode == 201){
                                        // var patchCoverage = await patchEmpEnrollAddCoverage(context,profileData.employeeEnrollId,widget.employeeId,addCovrage);
                                          showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                          return const AddSuccessPopup(
                                          message: 'Employee updated successfully',
                                          );
                                          },
                                          );
                                          ///
                                          //   if (patchCoverage.success) {
                                          //     print("Coverage added successfully");
                                          //   } else {
                                          //     print("Failed To Add Coverage........");
                                          //   }
                                            if(pickedFilePath){
                                              var uploadResponse = await UploadEmployeePhoto(context: context,documentFile: finalPath,employeeId: widget.employeeId);
                                            }else{
                                              print('Document Error');
                                            }
                                          }
                                          widget.onCancel();
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
                                          summaryController.clear();
                                        } catch (e) {
                                          print(e);
                                        }
                                      },
                                      text: 'Save',
                                    ),

                                  ],
                                ),
                              ),
                              const SizedBox(height: 20,),
                              ///upload file
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 18),
                                      child: Text(
                                        AppString.editProfile,
                                        style: EditProfile.customEditTextStyle(),
                                      ),
                                    ),
                                    StatefulBuilder(
                                      builder: (BuildContext context, void Function(void Function()) setState) {
                                        return Padding(
                                          padding: const EdgeInsets.only(right:20),
                                          child: Row(
                                            children: [
                                              // Show the picked image or the network image
                                              pickedFilePath
                                                  ? Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black.withOpacity(0.2),
                                                      spreadRadius: 2,
                                                      blurRadius: 5,
                                                      offset: const Offset(0, 3), // Shadow position
                                                    ),
                                                  ],
                                                ),
                                                child: CircleAvatar(
                                                  radius: 20, // Adjust the size of the avatar
                                                  backgroundColor: ColorManager.faintGrey,
                                                  child: ClipOval(
                                                    child: Image.memory(
                                                      finalPath!, // Display the selected image from gallery
                                                      fit: BoxFit.cover, // Ensure the image fills the avatar
                                                      width: double.infinity, // Ensures the image fills the avatar width
                                                      height: double.infinity, // Ensures the image fills the avatar height
                                                    ),
                                                  ),
                                                ),
                                              )
                                                  : profileData.imgurl == null
                                                  ? const Text('') // Display nothing if no image is available
                                                  : Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black.withOpacity(0.2),
                                                      spreadRadius: 2,
                                                      blurRadius: 5,
                                                      offset: const Offset(0, 3), // Shadow position
                                                    ),
                                                  ],
                                                ),
                                                child: CircleAvatar(
                                                  radius: 20, // Adjust the size of the avatar
                                                  backgroundColor: ColorManager.faintGrey,
                                                  child: ClipOval(
                                                    child: CachedNetworkImage(
                                                      imageUrl: profileData.imgurl,
                                                      fit: BoxFit.cover, // Ensures the image fills the avatar
                                                      width: double.infinity, // Ensures the image fills the avatar width
                                                      height: double.infinity, // Ensures the image fills the avatar height
                                                      placeholder: (context, url) =>
                                                          const CircularProgressIndicator(),
                                                      errorWidget: (context, url, error) =>
                                                          const Icon(Icons.error),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              // Custom icon button for uploading files
                                              CustomIconButton(
                                                icon: Icons.upload_outlined,
                                                text: AppString.photo,
                                                onPressed: () async {
                                                  FilePickerResult? result = await FilePicker.platform.pickFiles();
                                                  if (result != null) {
                                                    print("Result::: ${result}");

                                                    try {
                                                      print('File picked: ${fileName}');
                                                      setState(() {
                                                        pickedFilePath = true;
                                                        fileName = result.files.first.name;
                                                        finalPath = result.files.first.bytes; // Store the picked file bytes
                                                      });
                                                    } catch (e) {
                                                      print(e);
                                                    }
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),

                              /// row 1
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  FirstSMTextFConst(
                                    controller: nameController,
                                    keyboardType: TextInputType.text,
                                    text: AppString.name,

                                  ),


                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Select Employee Type',
                                          //  widget.depTitle,
                                          style: AllPopupHeadings.customTextStyle(context)),
                                      SizedBox(height: 5,),
                                      FutureBuilder<List<EmployeeTypeModal>>(
                                        future: EmployeeTypeGet(context, deptId),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Container(
                                              alignment: Alignment.center,
                                              child: HRUManageDropdown(
                                                controller: TextEditingController(text: ''),
                                                labelText: 'Select Employee Type',
                                                labelStyle:CustomTextStylesCommon.commonStyle( fontSize: 12,
                                                  color: Color(0xff575757),
                                                  fontWeight: FontWeight.w500,),
                                                labelFontSize: 12,
                                                items: [], // Empty while loading
                                              ),
                                            );
                                          }
                                          if (snapshot.hasData && snapshot.data!.isEmpty) {
                                            return HRUManageDropdown(

                                              controller: TextEditingController(text: ''),
                                              labelText: 'Select Employee Type',
                                              labelStyle:CustomTextStylesCommon.commonStyle( fontSize: 12,
                                                color: ColorManager.mediumgrey,
                                                fontWeight: FontWeight.w500,),
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

                                            return HRUManageDropdown(
                                              controller: TextEditingController(text: selectedEmployeeType ?? ''),
                                              labelText: "Select Employee Type",
                                              labelStyle:CustomTextStylesCommon.commonStyle( fontSize: 12,
                                                color: ColorManager.mediumgrey,
                                                fontWeight: FontWeight.w500,),
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
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Select Department',
                                          //  widget.depTitle,
                                          style: AllPopupHeadings.customTextStyle(context)),
                                      SizedBox(height: 5,),
                                      FutureBuilder<List<HRHeadBar>>(
                                        future: companyHRHeadApi(context, deptId),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            List<String>dropDownServiceList =[];
                                            return Container(
                                                alignment: Alignment.center,
                                                child:
                                                HRUManageDropdown(
                                                  controller: TextEditingController(
                                                      text: ''),
                                                  labelText: 'Select Department',
                                                  labelStyle:CustomTextStylesCommon.commonStyle( fontSize: 12,
                                                    color: Color(0xff575757),
                                                    fontWeight: FontWeight.w500,),
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
                                                  fontSize: FontSize.s14,
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

                                              return HRUManageDropdown(
                                                controller: TextEditingController(
                                                    text: selectedDeptName ?? ''),
                                                labelText: "Select Department",
                                                labelStyle:CustomTextStylesCommon.commonStyle( fontSize: 12,
                                                  color: const Color(0xff575757),
                                                  fontWeight: FontWeight.w500,),
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
                                  ],
                                ),
                                ///row 2
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    FirstSMTextFConst(
                                      controller: addressController,
                                      keyboardType: TextInputType.text,
                                      text: AppString.address,

                                  ),

                                  FirstSMTextFConst(
                                    controller: ageController,
                                    keyboardType: TextInputType.text,
                                    text: 'DOB',
                                    showDatePicker: true,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Gender',
                                          //  widget.depTitle,
                                          style: AllPopupHeadings.customTextStyle(context)),
                                      const SizedBox(height: 5,),
                                      FutureBuilder<List<GenderData>>(
                                        future: getGenderDropdown(context),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return HRUManageDropdown(

                                                hintText: "Gender",
                                                // width: 320,
                                                // height: 40,
                                                controller: TextEditingController(text: ''),
                                                items: ['item 1', 'item 2'],
                                                // labelText: 'Reporting Office',
                                                labelStyle:CustomTextStylesCommon.commonStyle( fontSize: 12,
                                                  color: const Color(0xff575757),
                                                  fontWeight: FontWeight.w400,),
                                                // GoogleFonts.firaSans(
                                                //   fontSize: 12,
                                                //   color: Color(0xff575757),
                                                //   fontWeight: FontWeight.w400,
                                                // ),
                                                labelFontSize: 12,
                                              );
                                            }
                                            if (snapshot.hasData) {
                                              List<String> dropDownList = [];
                                              for (var i in snapshot.data!) {
                                                dropDownList.add(i.gender);
                                              }
                                              return HRUManageDropdown(
                                                hintText: "Gender",
                                                labelStyle: const TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xff575757),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                labelFontSize: 12,
                                                items: dropDownList,
                                                onChanged: (newValue) {
                                                  for (var a in snapshot.data!) {
                                                    if (a.gender == newValue) {
                                                      selectedGenderId = a.gender;
                                                      print('Gender Name : ${genderId}');
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
                                      ],
                                    ),
                                    // FirstSMTextFConst(
                                    //   controller: genderController,
                                    //   keyboardType: TextInputType.text,
                                    //   text: 'Gender',
                                    //   // showDatePicker: true,
                                    // ),
                                  ],
                                ),
                                ///row 3
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    FirstSMTextFConst(
                                      controller: ssNController,
                                      keyboardType: TextInputType.text,
                                      text: AppString.ssnN,
                                      // showDatePicker: true,
                                    ),

                                    SMTextFConstPhone(
                                      controller: phoneNController,
                                      keyboardType: TextInputType.phone,
                                      text: AppString.phone_number,

                                      // showDatePicker: true,
                                    ),
                                    SMTextFConstPhone(
                                      controller: workPhoneController,
                                      keyboardType: TextInputType.text,
                                      text:  AppStringMobile.worNo,

                                      // showDatePicker: true,
                                    ),
                                  ],
                                ),

                                /// row 4
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    SMTextFConst(
                                      controller: personalEmailController,
                                      keyboardType: TextInputType.text,
                                      text: AppStringMobile.perEmail,
                                      // showDatePicker: true,
                                    ),

                                  SMTextFConst(
                                    controller: workEmailController,
                                    keyboardType: TextInputType.text,
                                    text: AppStringMobile.worEmail,
                                    // showDatePicker: true,
                                  ),
                                  FirstSMTextFConst(
                                    controller: summaryController,
                                    keyboardType: TextInputType.text,
                                    text: AppStringMobile.summry,
                                    // showDatePicker: true,
                                  ),
                                ],
                              ),
                              ///row 5
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Select Service',
                                          //  widget.depTitle,
                                          style: AllPopupHeadings.customTextStyle(context)),
                                      SizedBox(height: 5,),
                                      FutureBuilder<List<ServicesMetaData>>(
                                        future: getServicesMetaData(context),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            // Show loading indicator or dummy dropdown
                                            return HRUManageDropdown(
                                              hintText: 'Select Service',
                                              controller: TextEditingController(text: ''),
                                              // labelText: 'Select Service',
                                              labelStyle: TextStyle(fontSize: 14),
                                              items: [], labelFontSize: 12,
                                            );
                                          }

                                            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                                              List<String> serviceNames = snapshot.data!
                                                  .map((service) => service.serviceName)
                                                  .toList();

                                            return HRUManageDropdown(
                                              controller: TextEditingController(),
                                              // labelText: 'Select Service',
                                              hintText: 'Select Service',
                                              items: serviceNames,
                                              onChanged: (val) {
                                                // Handle selected service
                                                var selectedService = snapshot.data!
                                                    .firstWhere((service) => service.serviceName == val);
                                                selectedServiceId = selectedService.serviceName;
                                                print('Selected Service ID: ${selectedService.serviceId}');
                                              }, labelStyle:  const TextStyle(fontSize: 14),labelFontSize: 12 ,
                                            );
                                          }

                                          return const Text('No services available');
                                        }, ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Reporting Office',
                                          //  widget.depTitle,
                                          style: AllPopupHeadings.customTextStyle(context)),
                                      const SizedBox(height: 5,),
                                      FutureBuilder<List<CompanyOfficeListData>>(
                                        future: getCompanyOfficeList(context),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return HRUManageDropdown(

                                              hintText: "Reporting Office",
                                              // width: 320,
                                              // height: 40,
                                              controller: TextEditingController(text: ''),
                                              items: ['item 1', 'item 2'],
                                              // labelText: 'Reporting Office',
                                              labelStyle:CustomTextStylesCommon.commonStyle( fontSize: 12,
                                                color: const Color(0xff575757),
                                                fontWeight: FontWeight.w400,),
                                              // GoogleFonts.firaSans(
                                              //   fontSize: 12,
                                              //   color: Color(0xff575757),
                                              //   fontWeight: FontWeight.w400,
                                              // ),
                                              labelFontSize: 12,
                                            );
                                          }
                                          if (snapshot.hasData) {
                                            List<String> dropDownList = [];
                                            for (var i in snapshot.data!) {
                                              dropDownList.add(i.name);
                                            }
                                            return HRUManageDropdown(
                                              hintText: "Reporting Office",
                                              labelStyle: const TextStyle(
                                                fontSize: 12,
                                                color: Color(0xff575757),
                                                fontWeight: FontWeight.w400,
                                              ),
                                              labelFontSize: 12,
                                              items: dropDownList,
                                              onChanged: (newValue) {
                                                for (var a in snapshot.data!) {
                                                  if (a.name == newValue) {
                                                    selectedOfficeId = a.name;
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
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        //color: Colors.red,
                                        width:354,
                                        height:30,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              ///coverage head
                              StatefulBuilder(
                                builder: (BuildContext context, void Function(void Function()) setState) {
                                  return  Column(
                                    children: [
                                      Row(
                                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 45),
                                            child: Container(
                                              height: 20,
                                              width:354,
                                              child: Text(
                                                  "Coverage",
                                                  style: AllPopupHeadings.customTextStyle(context)
                                              ),
                                              // color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                      ///Coverage
                                      ///
                                      FutureBuilder <EmployeeModel>(
                                          future: getCoverageList(context: context, employeeId: widget.employeeId,
                                              employeeEnrollId:profileData.employeeEnrollId ),
                                          builder: (context ,snapshot){
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return const Center(
                                                child: CircularProgressIndicator(),
                                              );
                                            }
                                            if (snapshot.hasError) {
                                              return const Center(
                                                child: Text('Error fetching profile data'),
                                              );
                                            }
                                            if (snapshot.hasError) {
                                              return Center(
                                                  child: Padding(
                                                    padding:const EdgeInsets.symmetric(vertical: 100),
                                                    child: Text(
                                                      "No available coverage!",
                                                      style: CustomTextStylesCommon.commonStyle(
                                                          fontWeight: FontWeightManager.medium,
                                                          fontSize: FontSize.s14,
                                                          color: ColorManager.mediumgrey),
                                                    ),
                                                  ));
                                            }


                                            if (snapshot.hasData){

                                              return Container(
                                                width: MediaQuery.of(context).size.width / 1,
                                                // height: MediaQuery.of(context).size.width / 2.2,
                                                // color: ColorManager.red,
                                                child: Wrap(
                                                  spacing: 2.0,
                                                  children: List.generate((snapshot.data!.coverageDetails.length / 2).ceil(), (index) {
                                                    int firstItemIndex = index * 2;
                                                    int secondItemIndex = firstItemIndex + 1;
                                                    return Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 5),
                                                      child: StatefulBuilder(
                                                        builder: (BuildContext context, void Function(void Function()) setState) {
                                                          return CoverageRowWidget(
                                                              countyName: snapshot.data!.coverageDetails[index].countyName,
                                                              zoneName: snapshot.data!.coverageDetails[index].zoneName,
                                                              onDelete: () {},
                                                              onEdit: () {
                                                                showDialog(
                                                                  context: context,
                                                                  builder: (BuildContext context) {
                                                                    return ProfileBarEditPopup(employeeId: profileData.employeeId,
                                                                        employeeEnrollId: profileData.employeeEnrollId,
                                                                        employeeEnrollCoverageId: snapshot.data!.coverageDetails[index].employeeEnrollCoverageId);
                                                                  },
                                                                );
                                                              }
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              );
                                            }
                                            else{
                                              return const SizedBox();
                                            }
                                          }),
                                      const SizedBox(height: 20,),
                                      ///add coverage
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: (){showDialog(
                                                context: context,
                                                builder: (BuildContext context)=> ProfileBarAddPopup(employeeId: widget.employeeId,employeeEnrollId: profileData.employeeEnrollId,
                                                  onRefresh: () {
                                                    setState((){
                                                      getCoverageList(context: context, employeeId: widget.employeeId,
                                                          employeeEnrollId:profileData.employeeEnrollId );
                                                    });
                                                },));} ,
                                            child: Container(
                                                height: 40,
                                                width: 200,
                                                //color: Colors.red,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(14),
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.add_circle,
                                                        size: 26,
                                                        color: ColorManager.bluebottom,
                                                      ),
                                                      const SizedBox(width: 3,),
                                                      Text(
                                                        'Add Coverage',
                                                        style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s14,
                                                          fontWeight: FontWeight.w700,
                                                          color: ColorManager.bluebottom,),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),


                            ],
                          ),
                          const SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return const Center(
          child: Text('No data available'),
        );
      },
    );
  }
}


class CoverageRowWidget extends StatelessWidget {
  final String countyName;
  final String zoneName;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const CoverageRowWidget({
    Key? key,
    required this.countyName,
    required this.zoneName,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 510,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: ColorManager.blueprime,
            width: 2,
          ),
         // color: ColorManager.red
      ),
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 2,
              child: Text(
                "County:",
                style: AllPopupHeadings.customTextStyle(context),
              )),
          SizedBox(width: 5,),
          Expanded(
              flex: 3,
              child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(
              countyName,
              style: EditTextFontStyle.customEditTextStyle(),
            ),
          ],)),

          Expanded(
              flex: 2,
              child: Text(
                "Zone:",
                style: AllPopupHeadings.customTextStyle(context),
              )),
          SizedBox(width: 5,),
          Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    zoneName,
                    style: EditTextFontStyle.customEditTextStyle(),
                  ),
                ],)),
          const SizedBox(width: 5),
          Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            icon: Icon(Icons.edit_outlined, color: ColorManager.bluebottom, size: 15),
            onPressed: onEdit,
          ),
          const SizedBox(width: 3),
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            icon: const Icon(Icons.delete, color: Colors.red, size: 15),
            onPressed: onDelete,
          ),
                      ],),
        ],
      ),
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


class Coverage {
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
    final defaultTextStyle =  CustomTextStylesCommon.commonStyle( color: textColor,
      fontSize: 12,
      fontWeight: FontWeight.w600,);
    // GoogleFonts.firaSans(
    //   color: textColor,
    //   fontSize: 12,
    //   fontWeight: FontWeightManager.bold,
    // );
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
