import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/all_from_hr_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/company_identrity_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/zone_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/register_manager/register_manager.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/establishment_data/all_from_hr/all_from_hr_data.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/company_identity_data_.dart';
import 'package:prohealth/data/api_data/establishment_data/zone/zone_model_data.dart';
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
  final List<AEClinicalDiscipline> aEClinicalDiscipline;
  final int userId;
  final String role;
  final String status;
  final int employeeId;
  //final int empId;

  // final TextEditingController position;
  final VoidCallback onPressed;
  RegisterEnrollPopup({super.key,
    required this.firstName, required this.lastName,
    //required this.phone,
    required this.email,
    //required this.position,
    required this.onPressed, required this.userId, required this.role, required this.status, required this.employeeId, required this.aEClinicalDiscipline,
    //required this.empId,
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
   final TextEditingController speciality = TextEditingController();
  // final TextEditingController email = TextEditingController();
  FocusNode _focusNode = FocusNode();
  int? _selectedItemIndex;
   int country = 0;
   int countyId =0;
   String reportingOfficeId ='';
   String specialityName = '';
   String clinicialName ='';
   int clinicalId = 1;
   String cityName = '';
   String serviceVal ='';
   String generatedURL = '';
   bool _isLoading = false;

   Future<String> _generateUrlLink(String email, String Id) async {
     final String user = email;
     final String id = Id;
     final String url = 'https://staging.symmetry.care/#/onBordingWelcome';
     generatedURL = url;
     print('Generated URL: $generatedURL');
     return url;
   }

   Future<void> performEnroll({
     required BuildContext context,
     required int employeeId,
     required String code,
     required int userId,
     required String firstName,
     required String lastName,
     required String phoneNbr,
     required String email,
     required String link,
     required String status,
     required int departmentId,
     required String position,
     required String speciality,
     required int clinicianTypeId,
     required String reportingOfficeId,
     required int cityId,
     required int countryId,
     required int countyId,
     required int zoneId,
     required String employment,
     required String service
   }) async {
     setState(() {
       _isLoading = true;
     });

     Future.delayed(Duration(seconds: 2));
     setState(() {
       _isLoading = false;
     });
     // if (result.success) {
     // await _generateUrlLink(email, userId.toString());
       Navigator.pop(context);
       Navigator.push(context, MaterialPageRoute(builder: (context)=> OfferLetterScreen(
         //apiData: (),
         employeeId: widget.employeeId,
         email: widget.email.text,
         userId: widget.userId,
         status: widget.status,
         firstName: widget.firstName.text,
         lastName: widget.lastName.text,
         role: widget.role,
         position: position,
         phone: phone.text,
         reportingOffice: reportingOfficeId,
         services: serviceVal,
         employement: 'Full Time',
         clinicalName: clinicialName,
         soecalityName: speciality,
       )));
     // }
     // else {
     //   ScaffoldMessenger.of(context).showSnackBar(
     //     SnackBar(content: Text('Error: ${result.message}')),
     //   );
     // }
   }
   bool _isButtonEnabled = false;
   bool _isLoad = false;
   String? selectedCountry;
   int countryId = 0;
   String? selectedCity;
   int cityId = 0;
   String? selectedZone;
   int zoneId = 0;

   @override
   void initState() {
     super.initState();
     // Add listeners to the text controllers
     widget.firstName.addListener(_validateFields);
     widget.lastName.addListener(_validateFields);
     widget.email.addListener(_validateFields);
     speciality.addListener(_validateFields);
    // position.addListener(_validateFields);
     phone.addListener(_validateFields);
     // Add other controllers if necessary
   }
   void _validateFields() {
     setState(() {
       // Check if any of the required fields are empty
       _isButtonEnabled = widget.firstName.text.isNotEmpty &&
           widget.lastName.text.isNotEmpty &&
           widget.email.text.isNotEmpty &&
           speciality.text.isNotEmpty &&
           //position.text.isNotEmpty &&
           phone.text.isNotEmpty;
       // Add other conditions if necessary
     });
   }
   @override
   void dispose() {
     // Dispose of the listeners when the widget is removed
     widget.firstName.removeListener(_validateFields);
     widget.lastName.removeListener(_validateFields);
     widget.email.removeListener(_validateFields);
     speciality.removeListener(_validateFields);
     //position.removeListener(_validateFields);
     phone.removeListener(_validateFields);
     super.dispose();
   }

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
                    ///botton
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
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
                            cursorHeight: 15,
                            labelText: 'First Name',
                            labelStyle: GoogleFonts.firaSans(
                              fontSize: 15,
                              color: Color(0xff575757),
                              fontWeight: FontWeight.w400,
                            ),
                            controller: widget.firstName,//firstname
                            labelFontSize: 12,
                          ),
                          SizedBox(
                            height: AppSize.s10,
                          ),
                          CustomTextField(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            cursorHeight: 15,
                            labelText: 'Speciality',
                            labelStyle: GoogleFonts.firaSans(
                              fontSize: 15,
                              color: Color(0xff575757),
                              fontWeight: FontWeight.w400,
                            ),
                            controller: speciality,//firstname
                            labelFontSize: 12,
                          ),

                          SizedBox(
                            height: AppSize.s10,
                          ),
                          ///email
                          CustomTextField(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            cursorHeight: 15,
                            labelText: 'Email',
                            labelStyle: GoogleFonts.firaSans(
                              fontSize: 12,
                              color: Color(0xff575757),
                              fontWeight: FontWeight.w400,
                            ),
                            controller: widget.email,
                            labelFontSize: 12,
                          ),
                          SizedBox(
                            height: AppPadding.p10,
                          ),
                          ///zone
                          buildZoneDropdownButton(context),
                      
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
                            labelText: 'Last Name',
                            labelStyle: GoogleFonts.firaSans(
                              fontSize: 12,
                              color: Color(0xff575757),
                              fontWeight: FontWeight.w400,
                            ),
                            controller: widget.lastName,
                            labelFontSize: 12,
                          ),

                          SizedBox(
                            height: AppSize.s10,
                          ),
                          ///clinician
                          FutureBuilder<List<AEClinicalDiscipline>>(
                            future: HrAddEmplyClinicalDisciplinApi(context, 1),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CustomDropdownTextField(
                                  width: textFieldWidth,
                                  height: textFieldHeight,
                                  items: ['item 1', 'item 2'],
                                  labelText: 'Clinician',
                                  labelStyle: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    color: Color(0xff575757),
                                    fontWeight: FontWeight.w400,
                                  ),
                                );
                              }
                              if (snapshot.hasData) {
                                List<String> dropDownList = [];
                                for (var i in widget.aEClinicalDiscipline) {
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
                                        clinicalId = a.deptID!;
                                        print("Dept ID ${clinicalId}");
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
                          buildCityDropdownButton(context),
                          SizedBox(
                            height: AppSize.s10,
                          ),
                          CustomTextField(
                            width: textFieldWidth,
                            height: textFieldHeight,
                            cursorHeight: 15,
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
                            cursorHeight: 15,
                            labelText: 'Phone No',
                            labelStyle: GoogleFonts.firaSans(
                              fontSize: 12,
                              color: Color(0xff575757),
                              fontWeight: FontWeight.w400,
                            ),
                            controller: phone,
                            labelFontSize: 12,
                          ),
                          SizedBox(
                            height: AppSize.s10,
                          ),
                          ///reporting office
                          FutureBuilder<List<CompanyOfficeListData>>(
                            future: getCompanyOfficeList(context),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CustomDropdownTextField(
                                  width: textFieldWidth,
                                  height: textFieldHeight,
                                  items: ['item 1', 'item 2'],
                                  labelText: 'Reporting Office',
                                  labelStyle: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    color: Color(0xff575757),
                                    fontWeight: FontWeight.w400,
                                  ),
                                );
                              }
                              if (snapshot.hasData) {
                                List<String> dropDownList = [];
                                for (var i in snapshot.data!) {
                                  dropDownList.add(i.name);
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
                                      if (a.name == newValue) {
                                        reportingOfficeId = a.name;
                                        print('Office Name : ${reportingOfficeId}');
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
                          ///country
                          buildDropdownButton(context),
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
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  color: ColorManager.cream,
                  thickness: 4,
                ),
              ),
              SizedBox(
                height: AppSize.s5,
              ),
              Container(
                height: 60,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
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
              Container(
                height: 100,
                child:   FutureBuilder<List<AEClinicalService>>(
                  future: HrAddEmplyClinicalServiceRadioButtonApi(context,),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: ColorManager.blueprime,
                          ),
                        ),
                      );
                    }
                    if (snap.hasData) {
                      List<String> serviceName = [];
                      for (var i in snap.data!) {
                        serviceName.add(i.serviceName!);
                      }
                      return Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: McqWidget(
                          title: 'Service',
                          items: serviceName,
                          onChanged: (val) {
                            serviceVal = serviceName[val].toString();
                            print('Service data $serviceVal');
                          },
                        ),
                      );
                    }
                    return SizedBox();
                  },
                ),
              ),
              SizedBox(
                height: AppSize.s6,
              ),
              StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) setState) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _isLoading
                          ? SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(color: ColorManager.blueprime,))
                          :  CustomIconButtonConst(
                        text: AppString.next,
                        onPressed: () async{
                          setState(() {
                            _isLoading = true;
                          });
                          await _generateUrlLink(widget.email.text, widget.userId.toString());
                          ApiData result = await addEmpEnroll(
                            context: context,
                            employeeId: widget.employeeId,
                            code: "",
                            userId:  widget.userId,
                            firstName: widget.firstName.text,
                            lastName: widget.lastName.text,
                            phoneNbr: phone.text,
                            email:  widget.email.text,
                            link: generatedURL,
                            status: widget.status,
                            departmentId: clinicalId,
                            position: position.text,
                            speciality: speciality.text,
                            clinicianTypeId: 1,
                            reportingOfficeId: reportingOfficeId,
                            cityId: cityId,
                            countryId: countryId,
                            countyId: countyId,
                            zoneId: zoneId,
                            employment: "Full Time",
                            service: "Home Health",
                          );
                          setState(() {
                            _isLoading = false;
                          });
                          if (result.success) {
                            Navigator.pop(context);
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) =>
                                OfferLetterScreen(
                                  apiData: result,
                                  employeeId: widget.employeeId,
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
                          }else {
                            print('Error');
                          }
                          print("${widget.employeeId}");

                        },
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height/40)
            ],
          )),
    );
  }
  /// Country dropdown
   Widget buildDropdownButton(BuildContext context) {
     double textFieldWidth = MediaQuery.of(context).size.width/10;
     double textFieldHeight = 38;
     return FutureBuilder<List<CountryGetData>>(
       future: getCountry(context: context),
       builder: (context, snapshot) {
         if (snapshot.connectionState ==
             ConnectionState.waiting) {
           return CustomDropdownTextField(
             width: textFieldWidth,
             height: textFieldHeight,
             items: ['item 1', 'item 2'],
             labelText: 'Country',
             labelStyle: GoogleFonts.firaSans(
               fontSize: 12,
               color: Color(0xff575757),
               fontWeight: FontWeight.w400,
             ),
           );

         } else if (snapshot.hasError) {
           return const CustomDropdownTextField(
             //width: MediaQuery.of(context).size.width / 5,
             labelText: 'Country',
             labelStyle: TextStyle(
               fontSize: 12,
               color: Color(0xff575757),
               fontWeight: FontWeight.w400,
             ),
             labelFontSize: 12,
             items: ['Error'],
           );
         } else if (snapshot.hasData) {
           List<DropdownMenuItem<String>> dropDownList = [];
           int degreeID = 0;
           for(var i in snapshot.data!){
             dropDownList.add(DropdownMenuItem<String>(
               value: i.name,
               child: Text(i.name, style: GoogleFonts.firaSans(
                 fontSize: 12,
                 color: Color(0xff575757),
                 fontWeight: FontWeight.w400,
               ),),
               ));
           }
           return CustomDropdownTextField(
             labelText: 'Country',
             labelStyle: GoogleFonts.firaSans(
               fontSize: 12,
               color: Color(0xff575757),
               fontWeight: FontWeight.w400,
             ),
             labelFontSize: 12,
             dropDownMenuList: dropDownList,
             onChanged: (newValue) {
               for(var a in snapshot.data!){
                 if(a.name == newValue){
                   selectedCountry = a.name;
                   countryId = a.countryId;
                   print("country :: ${selectedCountry}");
                   //empTypeId = docType;
                 }
               }
             },
           );
         } else {
           return CustomDropdownTextField(
             // width: MediaQuery.of(context).size.width / 5,
             labelText: 'Country',
             labelStyle: GoogleFonts.firaSans(
               fontSize: 12,
               color: const Color(0xff575757),
               fontWeight: FontWeight.w400,
             ),
             labelFontSize: 12,
             items: ['No Data'],
           );
         }
       },
     );
   }

   /// City dropDown
   Widget buildCityDropdownButton(BuildContext context) {
     double textFieldWidth = MediaQuery.of(context).size.width/10;
     double textFieldHeight = 38;
     return FutureBuilder<List<AEClinicalCity>>(
       future: HrAddEmplyClinicalCityApi(context),
       builder: (context, snapshot) {
         if (snapshot.connectionState ==
             ConnectionState.waiting) {
           return CustomDropdownTextField(
             width: textFieldWidth,
             height: textFieldHeight,
             items: ['item 1', 'item 2'],
             labelText: 'City',
             labelStyle: GoogleFonts.firaSans(
               fontSize: 12,
               color: Color(0xff575757),
               fontWeight: FontWeight.w400,
             ),
           );

         } else if (snapshot.hasError) {
           return const CustomDropdownTextField(
             //width: MediaQuery.of(context).size.width / 5,
             labelText: 'City',
             labelStyle: TextStyle(
               fontSize: 12,
               color: Color(0xff575757),
               fontWeight: FontWeight.w400,
             ),
             labelFontSize: 12,
             items: ['Error'],
           );
         } else if (snapshot.hasData) {
           List<DropdownMenuItem<String>> dropDownList = [];
           int degreeID = 0;
           for(var i in snapshot.data!){
             dropDownList.add(DropdownMenuItem<String>(
               child: Text(i.cityName!, style: GoogleFonts.firaSans(
                 fontSize: 12,
                 color: Color(0xff575757),
                 fontWeight: FontWeight.w400,
               ),),
               value: i.cityName!,
             ));
           }
           return CustomDropdownTextField(
             labelText: 'City',
             labelStyle: GoogleFonts.firaSans(
               fontSize: 12,
               color: Color(0xff575757),
               fontWeight: FontWeight.w400,
             ),
             labelFontSize: 12,
             dropDownMenuList: dropDownList,
             onChanged: (newValue) {
               for(var a in snapshot.data!){
                 if(a.cityName == newValue){
                   selectedCity= a.cityName;
                   cityId = a.cityID!;
                   print("City :: ${selectedCity}");
                   //empTypeId = docType;
                 }
               }
             },
           );
         } else {
           return CustomDropdownTextField(
             // width: MediaQuery.of(context).size.width / 5,
             labelText: 'City',
             labelStyle: GoogleFonts.firaSans(
               fontSize: 12,
               color: const Color(0xff575757),
               fontWeight: FontWeight.w400,
             ),
             labelFontSize: 12,
             items: ['No Data'],
           );
         }
       },
     );
   }

   /// Zone dropDown
   Widget buildZoneDropdownButton(BuildContext context) {
     double textFieldWidth = MediaQuery.of(context).size.width/10;
     double textFieldHeight = 38;
     return FutureBuilder<List<AEClinicalZone>>(
       future: HrAddEmplyClinicalZoneApi(context),
       builder: (context, snapshot) {
         if (snapshot.connectionState ==
             ConnectionState.waiting) {
           return  CustomDropdownTextField(
             width: textFieldWidth,
             height: textFieldHeight,
             items: ['item 1', 'item 2'],
             labelText: 'Zone',
             labelStyle: GoogleFonts.firaSans(
               fontSize: 12,
               color: Color(0xff575757),
               fontWeight: FontWeight.w400,
             ),
           );
         } else if (snapshot.hasError) {
           return const CustomDropdownTextField(
             //width: MediaQuery.of(context).size.width / 5,
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
           List<DropdownMenuItem<String>> dropDownList = [];
           int degreeID = 0;
           for(var i in snapshot.data!){
             dropDownList.add(DropdownMenuItem<String>(
               child: Text(i.zoneName!, style: GoogleFonts.firaSans(
                 fontSize: 12,
                 color: Color(0xff575757),
                 fontWeight: FontWeight.w400,
               ),),
               value: i.zoneName!,
             ));
           }
           return CustomDropdownTextField(
             labelText: 'Zone',
             labelStyle: GoogleFonts.firaSans(
               fontSize: 12,
               color: Color(0xff575757),
               fontWeight: FontWeight.w400,
             ),
             labelFontSize: 12,
             dropDownMenuList: dropDownList,
             onChanged: (newValue) {
               for(var a in snapshot.data!){
                 if(a.zoneName == newValue){
                   selectedZone= a.zoneName;
                   zoneId = a.zoneID!;
                   countyId = a.countyID!;
                   print("Zone :: ${selectedZone}");
                   print("county Id :: ${countyId}");
                   //empTypeId = docType;
                 }
               }
             },
           );
         } else {
           return CustomDropdownTextField(
             // width: MediaQuery.of(context).size.width / 5,
             labelText: 'Zone',
             labelStyle: GoogleFonts.firaSans(
               fontSize: 12,
               color: const Color(0xff575757),
               fontWeight: FontWeight.w400,
             ),
             labelFontSize: 12,
             items: ['No Data'],
           );
         }
       },
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