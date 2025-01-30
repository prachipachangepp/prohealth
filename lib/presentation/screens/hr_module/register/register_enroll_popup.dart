import 'package:flutter/material.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/provider/hr_register_provider.dart';
import 'package:prohealth/app/resources/provider/navigation_provider.dart';

import 'package:prohealth/app/services/api/managers/establishment_manager/all_from_hr_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/company_identrity_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/zone_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/register_manager/register_manager.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/company_identity_data_.dart';
import 'package:prohealth/data/api_data/establishment_data/zone/zone_model_data.dart';
import 'package:prohealth/presentation/screens/hr_module/register/offer_letter_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/register/taxtfield_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/after_clicking_on_link/multi_step_form.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/after_clicking_on_link/offer_letter_description_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/dropdown_const.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../app/services/api/managers/hr_module_manager/add_employee/clinical_manager.dart';
import '../../../../data/api_data/hr_module_data/add_employee/clinical.dart';
import '../../../widgets/error_popups/failed_popup.dart';
import '../../../widgets/error_popups/four_not_four_popup.dart';
import '../../../widgets/widgets/constant_textfield/const_textfield.dart';
import '../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import '../add_employee/widget/mcq_widget_add-employee.dart';
import '../manage/widgets/custom_icon_button_constant.dart';

class RegisterEnrollPopup extends StatelessWidget {
  final TextEditingController firstName;
  final TextEditingController lastName;
  //final TextEditingController phone;
  final TextEditingController email;
  final List<AEClinicalDiscipline> aEClinicalDiscipline;
  final int userId;
  final String role;
  final String status;
  final int employeeId;
  final int depId;
  //final int empId;

  // final TextEditingController position;
  final VoidCallback onReferesh;
  final VoidCallback onPressed;
  RegisterEnrollPopup({super.key,
    required this.firstName, required this.lastName,
    //required this.phone,
    required this.email,
    //required this.position,
    required this.onPressed, required this.userId, required this.role,
    required this.status, required this.employeeId,
    required this.aEClinicalDiscipline,
    required this.onReferesh,
    required this.depId,
    //required this.empId,
  });



  // Future<String> _generateUrlLink(String email, String Id) async {
  //   final String user = email;
  //   final String id = Id;
  //   final String url = '${AppConfig.deployment}/#/onBordingWelcome';
  //   generatedURL = url;
  //   print('Generated URL: $generatedURL');
  //   return url;
  // }
  // bool _isButtonEnabled = false;
  // bool _isLoad = false;

  //
  // @override
  // void initState() {
  //   super.initState();
  //   // Add listeners to the text controllers
  //   widget.firstName.addListener(_validateFields);
  //   widget.lastName.addListener(_validateFields);
  //   widget.email.addListener(_validateFields);
  //   // speciality.addListener(_validateFields);
  //  // position.addListener(_validateFields);
  //  //  phone.addListener(_validateFields);
  //   // Add other controllers if necessary
  // }
  // void _validateFields() {
  //   setState(() {
  //     // Check if any of the required fields are empty
  //     _isButtonEnabled = widget.firstName.text.isNotEmpty &&
  //         widget.lastName.text.isNotEmpty &&
  //         widget.email.text.isNotEmpty;
  //         // speciality.text.isNotEmpty &&
  //         //position.text.isNotEmpty &&
  //         // phone.text.isNotEmpty;
  //     // Add other conditions if necessary
  //   });
  // }
  // @override
  // void dispose() {
  //   // Dispose of the listeners when the widget is removed
  //   widget.firstName.removeListener(_validateFields);
  //   widget.lastName.removeListener(_validateFields);
  //   widget.email.removeListener(_validateFields);
  //   // speciality.removeListener(_validateFields);
  //   //position.removeListener(_validateFields);
  //   // phone.removeListener(_validateFields);
  //   super.dispose();
  // }
  // String? _PositionError;
  // String? _ZoneError;
  // String? _PhoneError;
  // String? _firstnameError;
  // String? _lastnameError;
  // String? _emailError;
  // String? _SpecialityError;
  // bool _isFormValid = true;
  // String? _expiryTypeError;
  //
  // String? _validateTextField(String value, String fieldName) {
  //   if (value.isEmpty) {
  //     _isFormValid = false;
  //     return "$fieldName";
  //   }
  //   return null;
  // }

  // void _validateFields() {
  //   setState(() {
  //     _isFormValid = true;
  //     _PositionError = _validateTextField(position.text, 'Please Enter Position');
  //     _PhoneError = _validateTextField(phone.text, 'Please Enter Phone Number');
  //     _SpecialityError = _validateTextField(speciality.text, 'Please Enter Speciality');
  //     _firstnameError = _validateTextField(widget.firstName.text, 'Please Enter First Name');
  //     _lastnameError = _validateTextField(widget.lastName.text, 'Please Enter Last Name');
  //     _emailError = _validateTextField(widget.email.text, 'Please Enter Email');
  //     //_ZoneError = _validateTextField(selectedZone!, 'Please Select Zone');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    String? selectedCountry;
    int countryId = 1;
    String selectedCity = '';
    int cityId = 0;
    String selectedZone = '';
    String? emptype;
    int zoneId = 0;
    int countyId =0;
    //var deptID = ;
    String reportingOfficeId ='';
    String specialityName = '';
    String clinicialName ='';
    int clinicalId =0;
    String cityName = '';
    String serviceVal ='';
    String generatedURL = '';
    bool _isLoading = false;

    String? selectedService="Hospice";

    String? selectedServiceName;
    final TextEditingController phone = TextEditingController();
    final TextEditingController position = TextEditingController();
    final TextEditingController speciality = TextEditingController();
    double textFieldWidth = MediaQuery.of(context).size.width/10;
    double textFieldHeight = 38;
    final enrollProviderState = Provider.of<HrEnrollEmployeeProvider>(context,listen:false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      enrollProviderState.clearValidationText();
      enrollProviderState.enrollServicesList(context);
    });

    return Consumer<HrEnrollEmployeeProvider>(
      builder: (context, providerState,child) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
          ),

          child: Container(
              width: MediaQuery.of(context).size.width * 0.6, //0.55
              height:  655,
              // MediaQuery.of(context).size.height * 0.66,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorManager.white),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: ColorManager.bluebottom,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    padding: EdgeInsets.only(left: 22,right: 18),
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ///botton
                        Text(
                          'Enroll',
                          style: PopupBlueBarText.customTextStyle(context),
                          // style: GoogleFonts.firaSans(
                          //   fontSize: FontSize.s12,
                          //   fontWeight: FontWeightManager.semiBold,
                          //   color: ColorManager.white,
                          //   decoration: TextDecoration.none,
                          // ),
                        ),
                        IconButton(
                          onPressed: () {
              Navigator.pop(context);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => MultiStepForm(employeeID: employeeId, depID: 1,)),
                            // );
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => OfferLetterDescriptionScreen(employeeId: widget.employeeId, depID: 1,)),
                            // );
                          },
                          icon: Icon(Icons.close,color: ColorManager.white,),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text( AppStringLegalDocument.popupMsgHead,
                          style:  LegalDocumentPopupMessage.customTextStyle(context),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            children: [
                              ///firstname
                              CustomTextField(
                                width: textFieldWidth,
                                height: textFieldHeight,
                                cursorHeight: 15,
                                controller: firstName,//firstname
                                text: 'First Name',
                                onChanged: (val){
                                  providerState.validateField(
                                    firstName.text,
                                    'Please Enter First Name',
                                    providerState.setFirstnameError,
                                  );
                                },
                              ), providerState.firstnameError != null ? // Display error if any
                                Padding(
                                  padding: const EdgeInsets.only(right:140),
                                  child: Text(
                                    providerState.firstnameError!,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: FontSize.s10,
                                    ),
                                  ),
                                ):SizedBox(height: 11,),
                              SizedBox(
                                height: AppSize.s8,
                              ),
                              CustomTextField(
                                width: textFieldWidth,
                                height: textFieldHeight,
                                cursorHeight: 15,
                                text: 'Speciality',
                                controller: speciality,
                                onChanged: (val){
                                  providerState.validateField(
                                    val,
                                    'Please Enter Speciality',
                                    providerState.setSpecialityError,
                                  );
                                },//firstname
                              ),
                              providerState.specialityError  != null? // Display error if any
                                Padding(
                                  padding: const EdgeInsets.only(right:140),
                                  child: Text(
                                    providerState.specialityError!,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: FontSize.s10,
                                    ),
                                  ),
                                ):SizedBox(height: 11,),

                              SizedBox(
                                height: AppSize.s8,
                              ),
                              ///email
                              CustomTextField(
                                width: textFieldWidth,
                                height: textFieldHeight,
                                cursorHeight: 15,
                                text: 'Email',
                                controller: email,
                                onChanged: (val){
                                  providerState.validateField(
                                    email.text,
                                    'Please Enter Email',
                                    providerState.setEmailError,
                                  );
                                },
                              ),
                              providerState.emailError   != null ? // Display error if any
                                Padding(
                                  padding: const EdgeInsets.only(right:150),
                                  child: Text(
                                    providerState.emailError!,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: FontSize.s10,
                                    ),
                                  ),
                                ):SizedBox(height: 11,),
                              SizedBox(
                                height: AppPadding.p8,
                              ),
                              ///zone
                              ///
                              ////position
                              CustomTextField(
                                width: textFieldWidth,
                                height: textFieldHeight,
                                cursorHeight: 15,
                                text: 'Position',
                                controller: position,
                                onChanged: (val){
                                  providerState.validateField(
                                    val,
                                    'Please Enter Position',
                                    providerState.setPositionError,
                                  );
                                },
                              ),
                             providerState.positionError  != null ? // Display error if any
                                Padding(
                                  padding: const EdgeInsets.only(right:140),
                                  child: Text(
                                    providerState.positionError!,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: FontSize.s10,
                                    ),
                                  ),
                                ) : SizedBox(height: 11,),
                              // FutureBuilder<List<AEClinicalZone>>(
                              //   future: HrAddEmplyClinicalZoneApi(context),
                              //   builder: (context, snapshot) {
                              //     if (snapshot.connectionState ==
                              //         ConnectionState.waiting) {
                              //       return  CustomDropdownTextField(
                              //         headText: 'Zone',
                              //         width: textFieldWidth,
                              //         height: textFieldHeight,
                              //         items: [],
                              //       );
                              //
                              //     }  if (snapshot.hasData) {
                              //       List<DropdownMenuItem<String>> dropDownList = [];
                              //       int degreeID = 0;
                              //       for(var i in snapshot.data!){
                              //         dropDownList.add(DropdownMenuItem<String>(
                              //           child: Text(i.zoneName!,style: DocumentTypeDataStyle.customTextStyle(context),),
                              //           value: i.zoneName!,
                              //         ));
                              //       }
                              //       return CustomDropdownTextField(
                              //         headText: 'Zone',
                              //         dropDownMenuList: dropDownList,
                              //         onChanged: (newValue) {
                              //         //  setState(() {
                              //             for(var a in snapshot.data!){
                              //               if(a.zoneName == newValue){
                              //                 selectedZone= a.zoneName;
                              //                 zoneId = a.zoneID!;
                              //                 countyId = a.countyID!;
                              //                 print("Selected zoin id :: ${zoneId}");
                              //                 print("Zone :: ${selectedZone}");
                              //                 print("county Id :: ${countyId}");
                              //                 //empTypeId = docType;
                              //               }
                              //             }
                              //         //  });
                              //
                              //         },
                              //       );
                              //
                              //     } else {
                              //       return const Offstage();
                              //     }
                              //   },
                              // ),
                              // if (_ZoneError != null) // Display error if any
                              //   Padding(
                              //     padding: const EdgeInsets.only(right:150),
                              //     child: Text(
                              //       _ZoneError!,
                              //       style: TextStyle(
                              //         color: Colors.red,
                              //         fontSize: FontSize.s10,
                              //       ),
                              //     ),
                              //   ),

                            ],
                          ),
                        ),
                        ///
                        Flexible(
                          child: Column(
                            children: [
                              CustomTextField(
                                width: textFieldWidth,
                                height: textFieldHeight,
                                cursorHeight: 15,
                                text: 'Last Name',
                                controller: lastName,
                                onChanged: (val){
                                  providerState.validateField(
                                    lastName.text,
                                    'Please Enter Last Name',
                                    providerState.setLastnameError,
                                  );
                                },
                              ), providerState.lastnameError != null ? // Display error if any
                                Padding(
                                  padding: const EdgeInsets.only(right:140),
                                  child: Text(
                                    providerState.lastnameError!,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: FontSize.s10,
                                    ),
                                  ),
                                ):SizedBox(height: 11,),

                              SizedBox(
                                height: AppSize.s8,
                              ),
                              ///clinician
                              //widget.role == AppConfig.clinicalId
                              Column(
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children: [
                                  FutureBuilder<List<AEClinicalDiscipline>>(
                                    future: HrAddEmplyClinicalDisciplinApi(context, depId),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return CustomDropdownTextField(
                                          // Adjust headText based on depId
                                          headText: depId == AppConfig.clinicalId
                                              ?'Select Clinical Type '
                                              : depId == AppConfig.salesId
                                              ? 'Select Sales Type'
                                              : depId == AppConfig.AdministrationId
                                              ? 'Select Admin Type'
                                              : 'Unknown', // Default fallback if depId doesn't match any of the expected values
                                          items: [],
                                        );
                                      }
                                      if (snapshot.hasData) {
                                        List<String> dropDownList = [];
                                        for (var i in aEClinicalDiscipline) {
                                          dropDownList.add(i.empType!);
                                        }
                                        return CustomDropdownTextField(
                                          // Adjust headText based on depId
                                          headText: depId == AppConfig.clinicalId
                                              ?'Select Clinical Type '
                                              : depId == AppConfig.salesId
                                              ? 'Select Sales Type'
                                              : depId == AppConfig.AdministrationId
                                              ? 'Select Admin Type'
                                              : 'Unknown', // Default fallback if depId doesn't match any of the expected values
                                          items: dropDownList,
                                          onChanged: (newValue) {
                                            for (var a in snapshot.data!) {
                                              if (a.empType == newValue) {
                                                providerState.validateField(
                                                  a.empType!,
                                                  'Please Select Clinical Type',
                                                  providerState.setClinicalTypeError,
                                                );
                                                clinicialName = a.empType!;
                                                clinicalId = a.employeeTypesId;
                                                print("Dept ID'''''' ${clinicalId}");
                                                print("';';';''''''''Dept ID ${clinicialName}");
                                                // Do something with docType
                                              }
                                            }
                                          },
                                        );
                                      } else {
                                        return const Offstage();
                                      }
                                    },
                                  ),
                                 providerState.clinicalType != null?
                                    Padding(
                                      padding: const EdgeInsets.only(left:5),
                                      child: Text(
                                        providerState.clinicalType!,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: FontSize.s10,
                                        ),
                                      ),
                                    ):SizedBox(height:11),
                                ],
                              ),

                              SizedBox(
                                height: AppSize.s8,
                              ),
                              Column(
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children: [
                                  FutureBuilder<List<AEClinicalCity>>(
                                    future: HrAddEmplyClinicalCityApi(context),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CustomDropdownTextField(
                                          headText: 'City',
                                          width: textFieldWidth,
                                          height: textFieldHeight,
                                          items: [],
                                        );

                                      } else if (snapshot.hasError) {
                                        return  CustomDropdownTextField(
                                          headText: 'City',
                                          //width: MediaQuery.of(context).size.width / 5,
                                          items: ['Error'],
                                        );
                                      } else if (snapshot.hasData) {
                                        List<DropdownMenuItem<String>> dropDownList = [];
                                        int degreeID = 0;
                                        for(var i in snapshot.data!){
                                          dropDownList.add(DropdownMenuItem<String>(
                                            child: Text(i.cityName!, style:DocumentTypeDataStyle.customTextStyle(context),),
                                            value: i.cityName!,
                                          ));
                                        }
                                        return CustomDropdownTextField(
                                          headText: 'City',
                                          dropDownMenuList: dropDownList,
                                          onChanged: (newValue) {
                                            for(var a in snapshot.data!){
                                              if(a.cityName == newValue){
                                                providerState.validateField(
                                                  a.cityName!,
                                                  'Please Select City',
                                                  providerState.setCityError,
                                                );
                                                selectedCity= a.cityName!;
                                                cityId = a.cityID!;
                                                print("City :: ${selectedCity}");
                                                //empTypeId = docType;
                                              }
                                            }
                                          },
                                        );
                                      } else {
                                        return CustomDropdownTextField(
                                          headText: 'City',
                                          // width: MediaQuery.of(context).size.width / 5,
                                          items: ['No Data'],
                                        );
                                      }
                                    },
                                  ),
                                  providerState.cityError != null ?
                                    Padding(
                                      padding: const EdgeInsets.only(left:5),
                                      child: Text(
                                        providerState.cityError!,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: FontSize.s10,
                                        ),
                                      ),
                                    ):SizedBox(height: 11,)
                                ],
                              ),
                              SizedBox(
                                height: AppSize.s10,
                              ),
                              SizedBox(
                                height: AppSize.s60,
                              ),
                              // CustomTextField(
                              //   width: textFieldWidth,
                              //   height: textFieldHeight,
                              //   cursorHeight: 15,
                              //   text: 'Position',
                              //   controller: position,
                              // ),
                              // if (_PositionError != null) // Display error if any
                              //   Padding(
                              //     padding: const EdgeInsets.only(right:140),
                              //     child: Text(
                              //       _PositionError!,
                              //       style: TextStyle(
                              //         color: Colors.red,
                              //         fontSize: FontSize.s10,
                              //       ),
                              //     ),
                              //   ),
                            ],
                          ),
                        ),
                        ///
                        Flexible(
                          child: Column(
                            children: [
                              CustomTextFieldPhone(
                                width: textFieldWidth,
                                height: textFieldHeight,
                                cursorHeight: 15,
                                text: 'Phone No',
                                controller: phone,
                                onChanged: (val){
                                  providerState.validateField(
                                    val,
                                    'Please Enter Phone Number',
                                    providerState.setPhoneError,
                                  );
                                },
                              ),
                              providerState.phoneError  != null ?  // Display error if any
                                Padding(
                                  padding: const EdgeInsets.only(right:120),
                                  child: Text(
                                    providerState.phoneError!,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: FontSize.s10,
                                    ),
                                  ),
                                ):SizedBox(height:11),
                              SizedBox(
                                height: AppSize.s8,
                              ),
                              ///reporting office

                              ///
                              ////
                             Column(
                               crossAxisAlignment:CrossAxisAlignment.start,
                               children: [
                                 FutureBuilder<List<CompanyOfficeListData>>(
                                        future: getCompanyOfficeList(context),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return CustomDropdownTextField(
                                              headText: 'Reporting Office',
                                              width: textFieldWidth,
                                              height: textFieldHeight,
                                              items: [],
                                             );
                                          }
                                          if (snapshot.hasData) {
                                            List<String> dropDownList = [];
                                            for (var i in snapshot.data!) {
                                              dropDownList.add(i.name);
                                            }
                                            return CustomDropdownTextField(
                                              headText: 'Reporting Office',
                                              items: dropDownList,
                                              onChanged: (newValue) {
                                                for (var a in snapshot.data!) {
                                                  if (a.name == newValue) {
                                                    providerState.validateField(
                                                      a.name,
                                                      'Please Select Reporting Office',
                                                      providerState.setReportingOfficeError,
                                                    );
                                                    reportingOfficeId = a.name;
                                                    print('Office Name ::::>>>> ${reportingOfficeId}');
                                                    // int docType = a.employeeTypesId;
                                                    // Do something with docType
                                                  }
                                                }
                                              },
                                            );
                                          } else {
                                            return const Offstage();
                                          }
                                        },
                                      ),
                                 providerState.reportingOfficeError != null ?
                                 Padding(
                                   padding: const EdgeInsets.only(left:5),
                                   child: Text(
                                     providerState.reportingOfficeError!,
                                     style: TextStyle(
                                       color: Colors.red,
                                       fontSize: FontSize.s10,
                                     ),
                                   ),
                                 ):SizedBox(height: 11,)
                               ],
                             ),

                              SizedBox(
                                height: AppSize.s8,
                              ),
                              ///country
                             // buildDropdownButton(context),
                              Column(
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children: [
                                  FutureBuilder<List<AEClinicalZone>>(
                                    future: HrAddEmplyClinicalZoneApi(context),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return  CustomDropdownTextField(
                                          headText: 'Zone',
                                          width: textFieldWidth,
                                          height: textFieldHeight,
                                          items: [],
                                        );

                                      }  if (snapshot.hasData) {
                                        List<DropdownMenuItem<String>> dropDownList = [];
                                        int degreeID = 0;
                                        for(var i in snapshot.data!){
                                          dropDownList.add(DropdownMenuItem<String>(
                                            child: Text(i.zoneName!,style: DocumentTypeDataStyle.customTextStyle(context),),
                                            value: i.zoneName!,
                                          ));
                                        }
                                        return CustomDropdownTextField(
                                          headText: 'Zone',
                                          dropDownMenuList: dropDownList,
                                          onChanged: (newValue) {
                                            //  setState(() {
                                            for(var a in snapshot.data!){
                                              if(a.zoneName == newValue){
                                                providerState.validateField(
                                                  a.zoneName!,
                                                  'Please Select Zone',
                                                  providerState.setZoneError,
                                                );
                                                selectedZone= a.zoneName!;
                                                zoneId = a.zoneID!;
                                                countyId = a.countyID!;
                                                print("Selected zoin id :: ${zoneId}");
                                                print("Zone :: ${selectedZone}");
                                                print("county Id :: ${countyId}");
                                                //empTypeId = docType;
                                              }
                                            }
                                            //  });

                                          },
                                        );

                                      } else {
                                        return const Offstage();
                                      }
                                    },
                                  ),
                                  providerState.zoneError != null ?
                                  Padding(
                                    padding: const EdgeInsets.only(left:5),
                                    child: Text(
                                      providerState.zoneError!,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: FontSize.s10,
                                      ),
                                    ),
                                  ):SizedBox(height: 11,)
                                ],
                              ),
                              SizedBox(
                                height: AppSize.s73,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ///
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      color: ColorManager.cream,
                      thickness: 4,
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: StatefulBuilder(

                      builder: (BuildContext context, void Function(void Function()) setState) { return  Container(
                        height: 90,
                        child:
                        Column(
                          children: [
                            Row(
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: "Employment", // Main text
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
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                           //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomRadioListTile(
                                  title: 'Full Time',
                                  value: 'Full Time',
                                  groupValue: emptype,
                                  onChanged: (value) {
                                    setState(() {
                                      emptype = value;
                                    });
                                  },
                                ),
                                CustomRadioListTile(
                                  title: 'Contract',
                                  value: 'Contract',
                                  groupValue: emptype,
                                  onChanged: (value) {
                                    setState(() {
                                      emptype = value;
                                    });
                                  },
                                ),
                                CustomRadioListTile(
                                  title: 'Part Time',
                                  value: 'Part Time',
                                  groupValue: emptype,
                                  onChanged: (value) {
                                    setState(() {
                                      emptype = value;
                                    });
                                  },
                                ),
                                CustomRadioListTile(
                                  title: 'Per Diem',
                                  value: 'Per Diem',
                                  groupValue: emptype,
                                  onChanged: (value) {
                                    setState(() {
                                      emptype = value;
                                    });
                                  },
                                ),

                              ],
                            ),

                          ],
                        ),

                        //                 child: Padding(
                        //                   padding: EdgeInsets.only(left: 20),
                        //                   child: McqWidget(
                        //                     title: 'Employment',
                        //                     items: [
                        //                       'Full Time',
                        //                       'Contract',
                        //                       'Part Time',
                        //                       'Per Diem'
                        //                     ],
                        //                     onChanged: (selectedIndex) {
                        // setState(() {
                        //   _selectedItemIndex = selectedIndex;
                        // });
                        //                       print('Selected index: ::::$_selectedItemIndex');
                        //
                        //                     },
                        //                   ),
                        //                 ),
                      ); },

                    ),
                  ),
                  Container(
                    height: 100,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Service", // Main text
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
                          ),
                          SizedBox(height: 5,),
                          StatefulBuilder(
                            builder: (BuildContext context, void Function(void Function()) setState) {return Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: providerState.enrollService.map((service) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Radio<String>(
                                        splashRadius: 0,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,// Change to String if servicename is a String
                                        value: service.servicename,  // Use servicename as the value
                                        groupValue: selectedServiceName, // Group value to determine the selected button
                                        onChanged: (String? value) {
                                          setState(() {
                                            selectedServiceName = value; // Update the selected value
                                          });
                                          print('Selected Service: >>>>>$value');
                                          // Print selected value
                                        },
                                      ),
                                      Text(
                                        service.servicename,
                                        style: DocumentTypeDataStyle.customTextStyle(context),
                                      ),
                                      SizedBox(width: 18,)
                                    ],
                                  );
                                }).toList(),
                              ),
                            );  },

                          ),
                        ],
                      ),
                    ),
                    // FutureBuilder<List<EnrollServices>>(
                    //   future: EmpServiceRadioButtonApi(context),
                    //   builder: (context, snap) {
                    //     if (snap.connectionState == ConnectionState.waiting) {
                    //       return Center(
                    //         child: SizedBox(
                    //           height: 20,
                    //           width: 20,
                    //           child: CircularProgressIndicator(),
                    //         ),
                    //       );
                    //     }
                    //     if (snap.hasData) {
                    //       return Padding(
                    //         padding: EdgeInsets.only(left: 20.0),
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             RichText(
                    //               text: TextSpan(
                    //                 text: "Service", // Main text
                    //                 style: AllPopupHeadings.customTextStyle(context), // Main style
                    //                 children: [
                    //                   TextSpan(
                    //                     text: ' *', // Asterisk
                    //                     style: AllPopupHeadings.customTextStyle(context).copyWith(
                    //                       color: ColorManager.red, // Asterisk color
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //             SizedBox(height: 5,),
                    //             StatefulBuilder(
                    //               builder: (BuildContext context, void Function(void Function()) setState) {return Container(
                    //                 child: Row(
                    //                   mainAxisAlignment: MainAxisAlignment.start,
                    //                   children: providerState.enrollService.map((service) {
                    //                     return Row(
                    //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //                       children: [
                    //                         Radio<String>(
                    //                           splashRadius: 0,
                    //                           focusColor: Colors.transparent,
                    //                           hoverColor: Colors.transparent,// Change to String if servicename is a String
                    //                           value: service.servicename,  // Use servicename as the value
                    //                           groupValue: selectedServiceName, // Group value to determine the selected button
                    //                           onChanged: (String? value) {
                    //                             setState(() {
                    //                               selectedServiceName = value; // Update the selected value
                    //                             });
                    //                             print('Selected Service: >>>>>$value');
                    //                             // Print selected value
                    //                           },
                    //                         ),
                    //                         Text(
                    //                           service.servicename,
                    //                           style: DocumentTypeDataStyle.customTextStyle(context),
                    //                         ),
                    //                         SizedBox(width: 18,)
                    //                       ],
                    //                     );
                    //                   }).toList(),
                    //                 ),
                    //               );  },
                    //
                    //             ),
                    //           ],
                    //         ),
                    //       );
                    //     }
                    //     return Center(child: Text('No data available')); // Handle no data case
                    //   },
                    // ),
                  ),





                  // Container(
                  //   height: 100,
                  //   child:   FutureBuilder<List<EnrollServices>>(
                  //     future: EmpServiceRadioButtonApi(context,),
                  //     builder: (context, snap) {
                  //       if (snap.connectionState == ConnectionState.waiting) {
                  //         return Center(
                  //           child: SizedBox(
                  //             height: 20,
                  //             width: 20,
                  //             child: CircularProgressIndicator(
                  //               color: ColorManager.blueprime,
                  //             ),
                  //           ),
                  //         );
                  //       }
                  //       if (snap.hasData) {
                  //         List<String> serviceName = [];
                  //         for (var i in snap.data!) {
                  //           serviceName.add(i.servicename!);
                  //         }
                  //         return Padding(
                  //           padding: EdgeInsets.only(left: 20.0),
                  //           child: McqWidget(
                  //             title: 'Service',
                  //             items: serviceName,
                  //             onChanged: (val) {
                  //
                  //               serviceVal = serviceName[val].toString();
                  //               print('Service data:::::>> $serviceVal');
                  //               print('Service data:::::>> $serviceName');
                  //             },
                  //           ),
                  //         );
                  //       }
                  //       return SizedBox();
                  //     },
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: AppSize.s6,
                  // ),
                  StatefulBuilder(
                    builder: (BuildContext context, void Function(void Function()) setState) {
                      return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      providerState.load
                          ? SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(color: ColorManager.blueprime,))
                          :  Container(width:100,
                        child: CustomIconButton(
                            text: AppString.next,
                            onPressed: () async{
                              providerState.validateFields(
                                  position: position.text,
                                  phone: phone.text,
                                  speciality: speciality.text,
                                  firstName: firstName.text,
                                  lastName: lastName.text,
                                  email: email.text, clinicalType: clinicialName,
                                  repoartingOffice: reportingOfficeId,
                                  zone: selectedZone,
                                  city:selectedCity);
                              if (providerState.isFormValid) {
                                providerState.loaderTrue();
                                providerState.generateUrlLink();
                                // ApiData response = await addEmpEnroll(
                                //   context: context,
                                //   employeeId: widget
                                //       .employeeId,
                                //   code: "",
                                //   userId: widget.userId,
                                //   firstName: widget
                                //       .firstName.text,
                                //   lastName: widget
                                //       .lastName.text,
                                //   phoneNbr: phone.text,
                                //   email: widget.email
                                //       .text,
                                //   link: generatedURL,
                                //   status: widget.status,
                                //   departmentId: widget.depId,
                                //   position: position
                                //       .text,
                                //   speciality: speciality
                                //       .text,
                                //   clinicianTypeId:clinicalId,
                                //   reportingOfficeId: reportingOfficeId,
                                //   cityId: cityId,
                                //   countryId: countryId,
                                //   countyId: countyId,
                                //   zoneId: zoneId,
                                //  // employment: "Full Time",
                                //   employment: emptype.toString(),
                                //  // service: "Hospice",
                                // service: selectedServiceName.toString(),
                                // );
                                print("countryname>>>> :: ${selectedCountry}");
                                print("countryID>>>>> :: ${countryId}");
                                print("countryID :: ${countryId}");

                                providerState.loaderFalse();

                                // if (response.statusCode == 200 || response.statusCode == 201) {
                                  Navigator.pop(
                                      context);
                                  Provider.of<RouteProvider>(context, listen: false)
                                      .navigateWithData(
                                    context,
                                        (ctx) => OfferLetterScreen(
                                          //apiData: response,
                                          employeeId: employeeId,
                                          email:email
                                              .text,
                                          userId: userId,
                                          status:status,
                                          firstName:firstName
                                              .text,
                                          lastName: lastName
                                              .text,
                                          role: role,
                                          position: position
                                              .text,
                                          phone: phone
                                              .text,
                                          reportingOffice: reportingOfficeId,
                                          services: selectedServiceName.toString(),
                                          employement: emptype.toString(),
                                          clinicalId: clinicalId,
                                          soecalityName: speciality.text,
                                          onRefreshRegister: onReferesh,
                                          depId: depId,
                                          cityId: cityId,
                                          countyId: countyId,
                                          zoneId: zoneId,
                                          link: providerState.generatedURL,
                                          countryId: countryId,
                                        ),
                                  );
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (
                                  //             context) =>
                                  //             OfferLetterScreen(
                                  //               apiData: response,
                                  //               employeeId: widget
                                  //                   .employeeId,
                                  //               email: widget
                                  //                   .email
                                  //                   .text,
                                  //               userId: widget
                                  //                   .userId,
                                  //               status: widget
                                  //                   .status,
                                  //               firstName: widget
                                  //                   .firstName
                                  //                   .text,
                                  //               lastName: widget
                                  //                   .lastName
                                  //                   .text,
                                  //               role: widget
                                  //                   .role,
                                  //               position: position
                                  //                   .text,
                                  //               phone: phone
                                  //                   .text,
                                  //               reportingOffice: reportingOfficeId,
                                  //               services: selectedServiceName.toString(),
                                  //               employement: emptype.toString(),
                                  //               clinicalId: clinicalId,
                                  //               soecalityName: speciality.text,
                                  //               onRefreshRegister: () {
                                  //                 setState(() {
                                  //
                                  //                 });
                                  //               }, depId: widget.depId,
                                  //               cityId: cityId,
                                  //               countyId: countyId,
                                  //               zoneId: zoneId,
                                  //               link: generatedURL,
                                  //               countryId: countryId,
                                  //             )));
                                // } else if(response.statusCode == 400 || response.statusCode == 404){
                                //   // Navigator.pop(context);
                                //   await showDialog(
                                //     context: context,
                                //     builder: (BuildContext context) => const FourNotFourPopup(),
                                //   );
                                // }
                                // else {
                                //   // Navigator.pop(context);
                                //   await showDialog(
                                //     context: context,
                                //     builder: (BuildContext context) => FailedPopup(text: response.message),
                                //   );
                                // }
                                print("${employeeId}");
                              }

                            }),
                      ),
                    ],
                  );
                  },
                  ),
                  //SizedBox(height: MediaQuery.of(context).size.height/80)
                ],
              )),
        );
      }
    );
  }
  // /// Country dropdown
  // Widget buildDropdownButton(BuildContext context) {
  //   double textFieldWidth = MediaQuery.of(context).size.width/10;
  //   double textFieldHeight = 38;
  //   return
  //       FutureBuilder<List<CountryGetData>>(
  //         future: getCountry(context: context),
  //         builder: (context, snapshot) {
  //           if (snapshot.connectionState ==
  //               ConnectionState.waiting) {
  //             return CustomDropdownTextField(
  //               headText: 'Country',
  //               width: textFieldWidth,
  //               height: textFieldHeight,
  //               items: [],
  //              );
  //
  //           } else if (snapshot.hasError) {
  //             return  CustomDropdownTextField(
  //               headText: 'Country',
  //               //width: MediaQuery.of(context).size.width / 5,
  //               items: ['Error'],
  //             );
  //           } else if (snapshot.hasData) {
  //             List<DropdownMenuItem<String>> dropDownList = [];
  //             int degreeID = 0;
  //             for(var i in snapshot.data!){
  //               dropDownList.add(DropdownMenuItem<String>(
  //                 value: i.name,
  //                 child: Text(i.name, style:DocumentTypeDataStyle.customTextStyle(context),),
  //               ));
  //             }
  //             return CustomDropdownTextField(
  //               headText: 'Country',
  //               dropDownMenuList: dropDownList,
  //               onChanged: (newValue) {
  //                 for(var a in snapshot.data!){
  //                   if(a.name == newValue){
  //                     selectedCountry = a.name;
  //                     countryId = a.countryId;
  //                     print("country :: ${selectedCountry}");
  //                     print("country :: ${countryId}");
  //                     //empTypeId = docType;
  //                   }
  //                 }
  //               },
  //             );
  //           } else {
  //             return CustomDropdownTextField(
  //               headText: 'Country',
  //               // width: MediaQuery.of(context).size.width / 5,
  //              items: ['No Data'],
  //             );
  //           }
  //         },
  //       );
  //
  // }
  //
  // /// City dropDown
  // Widget buildCityDropdownButton(BuildContext context) {
  //   double textFieldWidth = MediaQuery.of(context).size.width/10;
  //   double textFieldHeight = 38;
  //   return
  //       FutureBuilder<List<AEClinicalCity>>(
  //         future: HrAddEmplyClinicalCityApi(context),
  //         builder: (context, snapshot) {
  //           if (snapshot.connectionState ==
  //               ConnectionState.waiting) {
  //             return CustomDropdownTextField(
  //               headText: 'City',
  //               width: textFieldWidth,
  //               height: textFieldHeight,
  //               items: [],
  //              );
  //
  //           } else if (snapshot.hasError) {
  //             return  CustomDropdownTextField(
  //               headText: 'City',
  //               //width: MediaQuery.of(context).size.width / 5,
  //              items: ['Error'],
  //             );
  //           } else if (snapshot.hasData) {
  //             List<DropdownMenuItem<String>> dropDownList = [];
  //             int degreeID = 0;
  //             for(var i in snapshot.data!){
  //               dropDownList.add(DropdownMenuItem<String>(
  //                 child: Text(i.cityName!, style:DocumentTypeDataStyle.customTextStyle(context),),
  //                 value: i.cityName!,
  //               ));
  //             }
  //             return CustomDropdownTextField(
  //               headText: 'City',
  //               dropDownMenuList: dropDownList,
  //               onChanged: (newValue) {
  //                 for(var a in snapshot.data!){
  //                   if(a.cityName == newValue){
  //                     selectedCity= a.cityName;
  //                     cityId = a.cityID!;
  //                     print("City :: ${selectedCity}");
  //                     //empTypeId = docType;
  //                   }
  //                 }
  //               },
  //             );
  //           } else {
  //             return CustomDropdownTextField(
  //               headText: 'City',
  //               // width: MediaQuery.of(context).size.width / 5,
  //               items: ['No Data'],
  //             );
  //           }
  //         },
  //       );
  // }
  //
  // /// Zone dropDown
  // Widget buildZoneDropdownButton(BuildContext context) {
  //   double textFieldWidth = MediaQuery.of(context).size.width/10;
  //   double textFieldHeight = 38;
  //   return
  //       FutureBuilder<List<AEClinicalZone>>(
  //         future: HrAddEmplyClinicalZoneApi(context),
  //         builder: (context, snapshot) {
  //           if (snapshot.connectionState ==
  //               ConnectionState.waiting) {
  //             return  CustomDropdownTextField(
  //               headText: 'Zone',
  //               width: textFieldWidth,
  //               height: textFieldHeight,
  //               items: [],
  //              );
  //           } else if (snapshot.hasError) {
  //             return  CustomDropdownTextField(
  //               headText: 'Zone',
  //               //width: MediaQuery.of(context).size.width / 5,
  //               items: ['Error'],
  //             );
  //           } else if (snapshot.hasData) {
  //             List<DropdownMenuItem<String>> dropDownList = [];
  //             int degreeID = 0;
  //             for(var i in snapshot.data!){
  //               dropDownList.add(DropdownMenuItem<String>(
  //                 child: Text(i.zoneName!,style: DocumentTypeDataStyle.customTextStyle(context),),
  //                 value: i.zoneName!,
  //               ));
  //             }
  //             return CustomDropdownTextField(
  //               headText: 'Zone',
  //               dropDownMenuList: dropDownList,
  //               onChanged: (newValue) {
  //                 for(var a in snapshot.data!){
  //                   if(a.zoneName == newValue){
  //                     selectedZone= a.zoneName;
  //                     zoneId = a.zoneID!;
  //                     countyId = a.countyID!;
  //                     print("Zone :: ${selectedZone}");
  //                     print("county Id :: ${countyId}");
  //                     //empTypeId = docType;
  //                   }
  //                 }
  //               },
  //             );
  //           } else {
  //             return CustomDropdownTextField(
  //               headText: 'Zone',
  //               // width: MediaQuery.of(context).size.width / 5,
  //               items: ['No Data'],
  //             );
  //           }
  //         },
  //       );
  // }
}

///
class RegisterEnrollAlertDialog {
  final TextEditingController controller = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  FocusNode _focusNode = FocusNode();
  int? _selectedItemIndex;


  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          backgroundColor: Colors.white,
          titlePadding: EdgeInsets.zero,
          // contentPadding: EdgeInsets.zero,
          title: Container(
            height: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8)
                ),
                color: ColorManager.bluebottom
            ),
            child:Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppString.enroll,
                    style:PopupBlueBarText.customTextStyle(context),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close, color: ColorManager.white,))
                ],
              ),
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.15,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: ColorManager.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFieldRegister(
                      height: AppSize.s35,
                      width: MediaQuery.of(context).size.width / 6,
                      controller: firstName,
                      labelText: AppString.fname,
                      keyboardType: TextInputType.text,
                      padding: EdgeInsets.only(
                          bottom: AppPadding.p5, left: AppPadding.p20),
                      onChanged: (value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppString.enterText;
                        }
                        return null;
                      },
                    ),
                    CustomTextFieldRegister(
                      height: AppSize.s35,
                      width: MediaQuery.of(context).size.width / 6,
                      controller: lastName,
                      labelText: AppString.lname,
                      keyboardType: TextInputType.text,
                      padding: EdgeInsets.only(
                          bottom: AppPadding.p5, left: AppPadding.p20),
                      onChanged: (value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppString.enterText;
                        }
                        return null;
                      },
                    ),
                    CustomTextFieldForEmail(
                      height: AppSize.s35,
                      width: MediaQuery.of(context).size.width / 6,
                      controller: email,
                      labelText: AppString.email,
                      keyboardType: TextInputType.text,
                      padding: EdgeInsets.only(
                          bottom: AppPadding.p5, left: AppPadding.p20),
                      onChanged: (value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppString.enterText;
                        }
                        return null;
                      },
                    ),
                    CustomTextFieldRegisterPhone(
                      height: AppSize.s35,
                      width: MediaQuery.of(context).size.width / 6,
                      controller: phone,
                      labelText: AppString.phoneNumber,
                      keyboardType: TextInputType.text,
                      padding: EdgeInsets.only(
                          bottom: AppPadding.p5, left: AppPadding.p20),
                      // onChanged: (value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppString.enterText;
                        }
                        return null;
                      },
                    ),
                    Center(
                      child: CustomIconButtonConst(
                          width: AppSize.s100,
                          text: AppString.enroll, onPressed: () {


                      }),
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
}
// ApiData result = await addEmpEnroll(
//   context: context,
//   employeeId: employeeId,
//   code: code,
//   userId: userId,
//   firstName: firstName,
//   lastName: lastName,
//   phoneNbr: phoneNbr,
//   email: email,
//   link: link,
//   status: status,
//   departmentId: departmentId,
//   position: position,
//   speciality: speciality,
//   clinicianTypeId: clinicianTypeId,
//   reportingOfficeId: reportingOfficeId,
//   cityId: cityId,
//   countryId: countryId,
//   countyId: countyId,
//   zoneId: zoneId,
//   employment: employment,
//   service: service,
// );

// showDialog(context: context, builder: (BuildContext context) {
//   return ConfirmationPopup(onConfirm: (){}, title: 'Confirm Enrollment',
//     onCancel: () {
//     Navigator.pop(context);
//   },);
//     //OfferLetterScreen();
// });
//Navigator.push(context, MaterialPageRoute(builder: (context) => OfferLetterScreen()));
// var response =  await performEnroll(
//      context: context,
//      employeeId: widget.employeeId,
//      code: "",
//      userId: widget.userId,
//      firstName: widget.firstName.text,
//      lastName: widget.lastName.text,
//      phoneNbr: phone.text,
//      email: widget.email.text,
//      link: generatedURL,
//      status: widget.status,
//      departmentId: clinicalId,
//      position: position.text,
//      speciality: specialityName.toString(),
//      clinicianTypeId: 1,
//      reportingOfficeId: reportingOfficeId,
//      cityId: cityId,
//      countryId: countryId,
//      countyId: countyId,
//      zoneId: zoneId,
//      employment: "Full Time",
//      service: "Home Health"
//  );
// FutureBuilder<List<AEClinicalDiscipline>>(
//   future: HrAddEmplyClinicalDisciplinApi(context, 1),
//   builder: (context, snapshot) {
//     if (snapshot.connectionState ==
//         ConnectionState.waiting) {
//       return Padding(
//           padding: const EdgeInsets.symmetric(
//               horizontal: 7),
//           child: Container(
//             width: AppSize.s250,
//             height: AppSize.s40,
//             decoration: BoxDecoration(
//                 color: ColorManager.white),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text('Loading...',style: GoogleFonts.firaSans(
//                   fontSize: 12,
//                   color: ColorManager.mediumgrey,
//                   fontWeight: FontWeight.w400,
//                 ),),
//               )
//           ),
//         );
//     }
//     if (snapshot.hasData) {
//       List<String> dropDownList = [];
//
//       for (var i in snapshot.data!) {
//         dropDownList.add(i.empType!);
//       }
//       return CustomDropdownTextField(
//         labelText: 'Speciality',
//         labelStyle: GoogleFonts.firaSans(
//           fontSize: 12,
//           color: Color(0xff575757),
//           fontWeight: FontWeight.w400,
//         ),
//         labelFontSize: 12,
//         items: dropDownList,
//         onChanged: (newValue) {
//           for (var a in snapshot.data!) {
//             if (a.empType == newValue) {
//               specialityName = a.empType!;
//             }
//           }
//         },
//       );
//     } else {
//       return const Offstage();
//     }
//   },
// ),