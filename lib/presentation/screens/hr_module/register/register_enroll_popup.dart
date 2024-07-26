import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/all_from_hr_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/company_identrity_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/all_from_hr/all_from_hr_data.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/company_identity_data_.dart';
import 'package:prohealth/presentation/screens/hr_module/register/confirmation_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/register/offer_letter_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/register/taxtfield_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/dropdown_const.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../app/services/api/managers/hr_module_manager/add_employee/clinical_manager.dart';
import '../../../../data/api_data/hr_module_data/add_employee/clinical.dart';
import '../../../widgets/widgets/constant_textfield/const_textfield.dart';
import '../../../widgets/widgets/custom_icon_button_constant.dart';
import '../add_employee/widget/mcq_widget_add-employee.dart';

class RegisterEnrollPopup extends StatefulWidget {
  final TextEditingController firstName;
  final TextEditingController lastName;
  //final TextEditingController phone;
  final TextEditingController email;
  final int userId;
  final String role;
  final String status;

  // final TextEditingController position;
  final VoidCallback onPressed;
  RegisterEnrollPopup({super.key,
    required this.firstName, required this.lastName,
    //required this.phone,
    required this.email,
    //required this.position,
    required this.onPressed, required this.userId, required this.role, required this.status,
  });

  @override
  State<RegisterEnrollPopup> createState() => _RegisterEnrollPopupState();
}

class _RegisterEnrollPopupState extends State<RegisterEnrollPopup> {
  // final TextEditingController controller = TextEditingController();
  // final TextEditingController firstName = TextEditingController();
  // final TextEditingController lastName = TextEditingController();
   final TextEditingController phone = TextEditingController();
   final TextEditingController position = TextEditingController();
  // final TextEditingController email = TextEditingController();
  FocusNode _focusNode = FocusNode();
  int? _selectedItemIndex;
   int country = 0;
   int zoneId = 0;
   int countyId =0;
   String reportingOfficeId ='';
   String specialityName = '';
   String clinicialName ='';
   String cityName = '';
   String serviceVal ='';

  @override
  Widget build(BuildContext context) {
    double textFieldWidth = MediaQuery.of(context).size.width/10;
    double textFieldHeight = 38;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.6, //0.55
          height:  500,
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
                height: 35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Enroll',
                        style: GoogleFonts.firaSans(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.semiBold,
                          color: ColorManager.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close,color: ColorManager.white,),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
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
                            cursorHeight: 20,
                            labelText: 'First Name',
                            labelStyle: GoogleFonts.firaSans(
                              fontSize: 12,
                              color: Color(0xff575757),
                              fontWeight: FontWeight.w400,
                            ),
                            controller: widget.firstName,//firstname
                            labelFontSize: 12,
                          ),
                          // CustomTextFieldRegister(
                          //   height: AppSize.s30,
                          //   width: MediaQuery.of(context).size.width / 7,
                          //   controller: firstName,
                          //   labelText: AppString.fname,
                          //   keyboardType: TextInputType.text,
                          //   padding: EdgeInsets.only(
                          //       bottom: AppPadding.p5, left: AppPadding.p20),
                          //   onChanged: (value) {},
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return AppString.enterText;
                          //     }
                          //     return null;
                          //   },
                          // ),
                          SizedBox(
                            height: AppSize.s10,
                          ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width/7,
                          //   height: AppSize.s30,
                          //   //alignment: Alignment.center,
                          //   //color: Colors.cyan,
                          //
                          //   child: MyDropdownTextField(
                          //     hint: AppString.speciality,
                          //
                          //     //width: MediaQuery.of(context).size.width/7,
                          //     // height: AppSize.s25,
                          //     items: ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
                          //     onChanged: (String? newValue) {
                          //
                          //       print('Selected item: $newValue');
                          //     },
                          //   ),
                          // ),
                          FutureBuilder<List<AEClinicalDiscipline>>(
                            future: HrAddEmplyClinicalDisciplinApi(context, 1),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7),
                                    child: Container(
                                      width: AppSize.s250,
                                      height: AppSize.s40,
                                      decoration: BoxDecoration(
                                          color: ColorManager.faintGrey),
                                    ),
                                  ),
                                );
                              }
                              if (snapshot.hasData) {
                                List<String> dropDownList = [];
                      
                                for (var i in snapshot.data!) {
                                  dropDownList.add(i.empType!);
                                }
                                return CustomDropdownTextField(
                                  labelText: 'Speciality',
                                  labelStyle: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    color: Color(0xff575757),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  labelFontSize: 12,
                                  items: dropDownList,
                                  onChanged: (newValue) {
                                    for (var a in snapshot.data!) {
                                      if (a.empType == newValue) {
                                        specialityName = a.empType!;
                                      }
                                    }
                                  },
                                );
                              } else {
                                return const Offstage();
                              }
                            },
                          ),
                          SizedBox(
                            height: AppSize.s10,
                          ),
                          ///email
                          CustomTextField(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            cursorHeight: 22,
                            labelText: 'Email',
                            labelStyle: GoogleFonts.firaSans(
                              fontSize: 12,
                              color: Color(0xff575757),
                              fontWeight: FontWeight.w400,
                            ),
                            controller: widget.email,
                            labelFontSize: 12,
                          ),
                          // CustomTextFieldRegister(
                          //   height: AppSize.s30,
                          //   width: MediaQuery.of(context).size.width / 7,
                          //   controller: email,
                          //   labelText: AppString.email,
                          //   keyboardType: TextInputType.text,
                          //   padding: EdgeInsets.only(
                          //       bottom: AppPadding.p5, left: AppPadding.p20),
                          //   onChanged: (value) {},
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return AppString.enterText;
                          //     }
                          //     return null;
                          //   },
                          // ),
                          SizedBox(
                            height: AppPadding.p10,
                          ),
                          ///zone
                          FutureBuilder<List<AEClinicalZone>>(
                            future: HrAddEmplyClinicalZoneApi(
                              context,
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7),
                                    child: Container(
                                      width: AppSize.s250,
                                      height: AppSize.s40,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300]),
                                    ),
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return CustomDropdownTextField(
                                  labelText: 'Zone',
                                  labelStyle: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff575757),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  labelFontSize: 12,
                                  items: ['Error'],
                                );
                              } else if (snapshot.hasData) {
                                List<String> dropDownList = snapshot.data!
                                    .map((zone) => zone.zoneName ?? '')
                                    .toList();
                                print("Zone: ");
                                return CustomDropdownTextField(
                                  labelText: 'Zone',
                                  labelStyle: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    color: Color(0xff575757),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  labelFontSize: 12,
                                  items: dropDownList,
                                  onChanged: (newValue) {
                                    // Handle onChanged here if needed
                                  },
                                );
                              } else {
                                return CustomDropdownTextField(
                                  labelText: 'Zone',
                                  labelStyle: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    color: Color(0xff575757),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  labelFontSize: 12,
                                  items: ['No Data'],
                                );
                              }
                            },
                          ),
                      
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
                            cursorHeight: 20,
                            labelText: 'Last Name',
                            labelStyle: GoogleFonts.firaSans(
                              fontSize: 12,
                              color: Color(0xff575757),
                              fontWeight: FontWeight.w400,
                            ),
                            controller: widget.lastName,
                            labelFontSize: 12,
                          ),
                          // CustomTextFieldRegister(
                          //   height: AppSize.s30,
                          //   width: MediaQuery.of(context).size.width / 7,
                          //   controller: lastName,
                          //   labelText: AppString.lname,
                          //   keyboardType: TextInputType.text,
                          //   padding: EdgeInsets.only(
                          //       bottom: AppPadding.p5, left: AppPadding.p20),
                          //   onChanged: (value) {},
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return AppString.enterText;
                          //     }
                          //     return null;
                          //   },
                          // ),
                          SizedBox(
                            height: AppSize.s10,
                          ),
                          ///clinician
                          FutureBuilder<List<AEClinicalDiscipline>>(
                            future: HrAddEmplyClinicalDisciplinApi(context, 1),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7),
                                    child: Container(
                                      width: AppSize.s250,
                                      height: AppSize.s40,
                                      decoration: BoxDecoration(
                                          color: ColorManager.faintGrey),
                                    ),
                                  ),
                                );
                              }
                              if (snapshot.hasData) {
                                List<String> dropDownList = [];
                                for (var i in snapshot.data!) {
                                  dropDownList.add(i.empType!);
                                }
                                return CustomDropdownTextField(
                                  labelText: 'Clinician',
                                  labelStyle: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    color: Color(0xff575757),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  labelFontSize: 12,
                                  items: dropDownList,
                                  onChanged: (newValue) {
                                    for (var a in snapshot.data!) {
                                      if (a.empType == newValue) {
                                        clinicialName = a.empType!;
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
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width/7,
                          //   height: AppSize.s30,
                          //   //alignment: Alignment.center,
                          //   //color: Colors.cyan,
                          //
                          //   child: MyDropdownTextField(
                          //     hint: AppString.clinician,
                          //
                          //     //width: MediaQuery.of(context).size.width/7,
                          //     // height: AppSize.s25,
                          //     items: ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
                          //     onChanged: (String? newValue) {
                          //       print('Selected item: $newValue');
                          //     },
                          //   ),
                          // ),
                      
                          SizedBox(
                            height: AppSize.s10,
                          ),
                      
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width/7,
                          //   height: AppSize.s30,
                          //   //alignment: Alignment.center,
                          //   //color: Colors.cyan,
                          //
                          //   child: MyDropdownTextField(
                          //     hint: AppString.city,
                          //
                          //     //width: MediaQuery.of(context).size.width/7,
                          //     // height: AppSize.s25,
                          //     items: ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
                          //     onChanged: (String? newValue) {
                          //       print('Selected item: $newValue');
                          //     },
                          //   ),
                          // ),
                          FutureBuilder<List<AEClinicalCity>>(
                            future: HrAddEmplyClinicalCityApi(context),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7),
                                    child: Container(
                                      width: AppSize.s250,
                                      height: AppSize.s40,
                                      decoration: BoxDecoration(
                                          color: ColorManager.faintGrey),
                                    ),
                                  ),
                                );
                              }
                              if (snapshot.hasData) {
                                List<String> dropDownList = [];
                                for (var i in snapshot.data!) {
                                  dropDownList.add(i.cityName!);
                                }
                                return CustomDropdownTextField(
                                  onChanged: (val){
                                    cityName = val!;
                                  },
                                  labelText: 'City',
                                  labelStyle: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    color: Color(0xff575757),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  labelFontSize: 12,
                                  items: dropDownList,
                                );
                              } else {
                                return const Offstage();
                              }
                            },
                          ),
                          SizedBox(
                            height: AppSize.s10,
                          ),
                          CustomTextField(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            cursorHeight: 20,
                            labelText: 'Position',
                            labelStyle: GoogleFonts.firaSans(
                              fontSize: 12,
                              color: Color(0xff575757),
                              fontWeight: FontWeight.w400,
                            ),
                            controller: position,
                            labelFontSize: 12,
                          ),
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
                            cursorHeight: 22,
                            labelText: 'Phone No',
                            labelStyle: GoogleFonts.firaSans(
                              fontSize: 12,
                              color: Color(0xff575757),
                              fontWeight: FontWeight.w400,
                            ),
                            controller: phone,
                            labelFontSize: 12,
                          ),
                          // CustomTextFieldRegister(
                          //   height: AppSize.s30,
                          //   width: MediaQuery.of(context).size.width / 7,
                          //   controller: phone,
                          //   labelText: AppString.phoneNumber,
                          //   keyboardType: TextInputType.text,
                          //   padding: EdgeInsets.only(
                          //       bottom: AppPadding.p5, left: AppPadding.p20),
                          //   onChanged: (value) {},
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return AppString.enterText;
                          //     }
                          //     return null;
                          //   },
                          // ),
                          SizedBox(
                            height: AppSize.s10,
                          ),
                          ///reporting office
                          FutureBuilder<List<CompanyIdentityModel>>(
                            future: companyOfficeListGet(context, 1,20),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7),
                                    child: Container(
                                      width: AppSize.s250,
                                      height: AppSize.s40,
                                      decoration: BoxDecoration(
                                          color: ColorManager.faintGrey),
                                    ),
                                  ),
                                );
                              }
                              if (snapshot.hasData) {
                                List<String> dropDownList = [];
                                for (var i in snapshot.data!) {
                                  dropDownList.add(i.officeName!);
                                }
                                return CustomDropdownTextField(
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
                                      if (a.officeName == newValue) {
                                        reportingOfficeId = a.officeName;
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
                      
                          SizedBox(
                            height: AppSize.s10,
                          ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width/7,
                          //   height: AppSize.s30,
                          //   //alignment: Alignment.center,
                          //   //color: Colors.cyan,
                          //
                          //   child: MyDropdownTextField(
                          //     hint: AppString.country,
                          //
                          //     //width: MediaQuery.of(context).size.width/7,
                          //     // height: AppSize.s25,
                          //     items: ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
                          //     onChanged: (String? newValue) {
                          //       print('Selected item: $newValue');
                          //     },
                          //   ),
                          // ),
                          ///country
                          FutureBuilder<List<AEClinicalReportingOffice>>(
                            future: HrAddEmplyClinicalReportingOfficeApi(
                                context, 11),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7),
                                    child: Container(
                                      width: AppSize.s250,
                                      height: AppSize.s40,
                                      decoration: BoxDecoration(
                                          color: ColorManager.faintGrey),
                                    ),
                                  ),
                                );
                              }
                              if (snapshot.hasData) {
                                List<String> dropDownList = [];
                                for (var i in snapshot.data!) {
                                  if (i.name != null) {
                                    dropDownList.add(i.name!);
                                    //print("Country: $ctlrCountry");
                                  }
                                }
                                return CustomDropdownTextField(
                                  labelText: 'Country',
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
                                       //country = a
                                        // int? docType = a.companyOfficeID;
                                      }
                                    }
                                  },
                                );
                              } else {
                                return const Offstage();
                              }
                            },
                          ),
                          SizedBox(
                            height: AppSize.s50,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ///
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16),
                child: Divider(
                  color: ColorManager.cream,
                  thickness: 4,
                ),
              ),
              SizedBox(
                height: AppSize.s5,
              ),
              Expanded(
                child: Column(
               //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: McqWidget(
                          title: 'Employment',
                          items: [
                            'Full Time',
                            'Contract',
                            'Part Time',
                            'Per Diem'
                          ],
                          onChanged: (selectedIndex) {
                            print('Selected index: $selectedIndex');
                            _selectedItemIndex = selectedIndex;
                          },
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: FutureBuilder<
                          List<AEClinicalService>>(
                          future:
                          HrAddEmplyClinicalServiceRadioButtonApi(
                              context, 1),
                          builder: (context, snap) {
                            if (snap.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child:
                                    CircularProgressIndicator(
                                      color:
                                      ColorManager.blueprime,
                                    )),
                              );
                            }
                            if (snap.hasData) {
                              List<String> serviceName = [];
                              for (var i in snap.data!) {
                                serviceName.add(i.serviceName!);
                              }
                              return Padding(
                                padding: EdgeInsets.only(left: 16.0),
                                child: McqWidget(
                                  title: 'Service',
                                  items: serviceName,
                                  onChanged: (val) {

                                    serviceVal =  serviceName[val].toString();
                                   print('Service data ${serviceVal}');
                                  },
                                ),
                              );
                            }
                            return SizedBox();
                          }),
                    ),
                  ],
                ),
              ),
              ///////////////////////////////
              SizedBox(
                height: AppSize.s6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconButtonConst(
                      text: AppString.next,
                  onPressed: (){
                        Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> OfferLetterScreen(
                      email: widget.email.text,
                      userId: widget.userId,
                      status: widget.status,
                      firstName: widget.firstName.text,
                      lastName: widget.lastName.text,
                      role: widget.role,
                      position: position.text,
                      phone: phone.text,
                      reportingOffice: reportingOfficeId,
                      services: serviceVal,
                      employement: 'Full Time',
                      clinicalName: clinicialName,
                      soecalityName: specialityName,
                      )));
                  },
                  //     onPressed: () {
                  //   //Navigator.push(context, MaterialPageRoute(builder: (context) => OfferLetterScreen()));
                  //   // Navigator.pop(context);
                  //   // showDialog(
                  //   //     context: context,
                  //   //     builder:
                  //   //         (BuildContext context) {
                  //   //       return OfferLetterScreen(
                  //   //       );
                  //   //     });
                  //   //Navigator.pop(context);
                  // }
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height/40)
            ],
          )),
    );
  }
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
                    style: CustomTextStylesCommon.commonStyle(
                      fontSize: FontSize.s14,
                      color: ColorManager.white,
                      fontWeight: FontWeightManager.medium,
                    ),
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
                    CustomTextFieldRegister(
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
                    CustomTextFieldRegister(
                      height: AppSize.s35,
                      width: MediaQuery.of(context).size.width / 6,
                      controller: phone,
                      labelText: AppString.phoneNumber,
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
                    Center(
                      child: CustomIconButtonConst(
                        width: AppSize.s100,
                          text: AppString.enroll, onPressed: () {
                            // showDialog(context: context, builder: (BuildContext context) {
                            //   return ConfirmationPopup(onConfirm: (){}, title: 'Confirm Enrollment',
                            //     onCancel: () {
                            //     Navigator.pop(context);
                            //   },);
                            //     //OfferLetterScreen();
                            // });
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => OfferLetterScreen()));

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
