import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../../../../app/resources/const_string.dart';
import '../../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../../app/services/api/managers/sm_module_manager/physician_info/physician_info_manager.dart';
import '../../../../../../../../data/api_data/sm_data/scheduler_create_data/create_data.dart';
import '../../../../../textfield_dropdown_constant/schedular_dropdown_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_withbutton_const.dart';
import '../../../../../widgets/constant_widgets/textfield_constant.dart';

class PhysicianInfoInfoScreen extends StatefulWidget {
  const PhysicianInfoInfoScreen({super.key});

  @override
  State<PhysicianInfoInfoScreen> createState() => _RelatedPartiesScreenstate();
}

class _RelatedPartiesScreenstate extends State<PhysicianInfoInfoScreen> {
  bool isOptForCAHPSSurvey = false;
  String? status = 'Active';
  String? selectedStatepr;
  String? selectedCitypr;
  String? selectedStateff;
  String? selectedCityff;
  String? selectedStatus;

  TextEditingController primaryPhysician = TextEditingController();
  TextEditingController prFirstName = TextEditingController();
  TextEditingController prLastName = TextEditingController();
  TextEditingController prPECOSStatus = TextEditingController();
  TextEditingController prUPINNbr = TextEditingController();
  TextEditingController prNPINbr = TextEditingController();
  TextEditingController prStreet = TextEditingController();
  TextEditingController prSuiteApt = TextEditingController();
  TextEditingController prCity = TextEditingController();
  TextEditingController prState = TextEditingController();
  TextEditingController prZipcode = TextEditingController();
  TextEditingController prPhone = TextEditingController();
  TextEditingController prFax = TextEditingController();
  TextEditingController prProtocol = TextEditingController();
  TextEditingController contractFFPhysician = TextEditingController();
  TextEditingController ffFirstName = TextEditingController();
  TextEditingController ffLastName = TextEditingController();
  TextEditingController ffPECOSStatus = TextEditingController();
  TextEditingController ffUPINNbr = TextEditingController();
  TextEditingController ffNPINbr = TextEditingController();
  TextEditingController ffStreet = TextEditingController();
  TextEditingController ffSuiteApt = TextEditingController();
  TextEditingController ffCity = TextEditingController();
  TextEditingController ffState = TextEditingController();
  TextEditingController ffZipcode = TextEditingController();
  TextEditingController ffPhone = TextEditingController();
  TextEditingController ffFax = TextEditingController();
  TextEditingController ffProtocol = TextEditingController();


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
                    Text('Status Completed',
                      style: GoogleFonts.firaSans(
                          decoration: TextDecoration.none,
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.greenDark
                      ),
                    ),
                    SizedBox(width: 15,),
                    ElevatedButton(
                      onPressed: () async {
                        await postPhysicianInfoScreen(
                            context,
                            1,  //widget.patientId
                            1, //widget.companyId
                            primaryPhysician.text,
                            prFirstName.text,
                            prLastName.text,
                            prPECOSStatus.text,
                            prUPINNbr.text,
                            prNPINbr.text,
                            prStreet.text,
                            prSuiteApt.text,
                           selectedCitypr.toString(),
                            selectedStatepr.toString(),
                            prZipcode.text,
                            prPhone.text,
                            prFax.text,
                            prProtocol.text,
                            contractFFPhysician.text,
                            ffFirstName.text,
                            ffLastName.text,
                            ffPECOSStatus.text,
                            ffUPINNbr.text,
                            ffNPINbr.text,
                            ffStreet.text,
                            ffSuiteApt.text,
                          selectedCityff.toString(),
                          selectedStateff.toString(),
                            ffZipcode.text,
                            ffPhone.text,
                            ffFax.text,
                            ffProtocol.text,



                           );
                      },
                      child: Text(
                        AppString.save,
                        style: GoogleFonts.firaSans(
                          fontSize: FontSize.s12,
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
                  ],
                ),
              ),
              SizedBox(height: 19.5),
              SizedBox(height: AppSize.s10),
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                // height: 405,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
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
                child: Column(
                  children: [
                    SizedBox(height: AppSize.s16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                              controller:primaryPhysician ,
                              labelText: 'Primary Physician',)
                        ),
                        SizedBox(width:AppSize.s35),
                        Flexible(
                            child: SchedularTextField(
                              controller: prFirstName,
                              labelText: 'Physician’s First Name', )
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularTextField(
                              controller: prLastName,
                              labelText: 'Physician’s Last Name',)
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularTextField(
                              controller: prPECOSStatus,
                              labelText: 'PECOS Status',)
                        ),
                      ],
                    ),
                    SizedBox(height:AppSize.s16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                              controller: prUPINNbr,
                              labelText: 'UPIN#', )
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularTextField(
                              controller: prNPINbr,
                              labelText: 'NPI#', )
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularTextField(
                              controller: prStreet,
                                labelText: AppString.street)
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularTextField(
                              controller: prSuiteApt,
                              labelText: 'Suite/ Apt', )
                        ),
                      ],
                    ),
                    SizedBox(height:AppSize.s16),
                    Row(
                      children: [
                        Flexible(

                          child: FutureBuilder<List<citydata>>(
                            future: getCityDropDown(context),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7),
                                  child: Container(
                                      width: AppSize.s250,
                                      height: AppSize.s40,
                                      decoration: BoxDecoration(
                                          color: ColorManager.white),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Loading...',
                                          style: GoogleFonts.firaSans(
                                            fontSize: 12,
                                            color: ColorManager.mediumgrey,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      )),
                                );
                              }
                              if (snapshot.hasData) {
                                List<String> dropDownList = [];
                                for (var i in snapshot.data!) {
                                  dropDownList.add(i.cityName!);
                                }

                                return SizedBox(
                                  height: 27,
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'City',
                                      labelStyle: GoogleFonts.firaSans(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w400,
                                        color: ColorManager.greylight,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorManager
                                                .containerBorderGrey),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(4.0),
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                      ),
                                      contentPadding:
                                      const EdgeInsets.symmetric(
                                        //   //  vertical: 5,
                                          horizontal: 12),
                                    ),
                                    // value: selectedCountry,
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: ColorManager.blueprime,
                                    ),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff686464),
                                    ),

                                    onChanged: (newValue) {
                                      for (var a in snapshot.data!) {
                                        if (a.cityName == newValue) {
                                          selectedCitypr = a.cityName!;
                                          //country = a
                                          // int? docType = a.companyOfficeID;
                                        }
                                      }
                                    },
                                    items: dropDownList.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: GoogleFonts.firaSans(
                                            fontSize: 12,
                                            color: Color(0xff575757),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                );
                              } else {
                                return const Offstage();
                              }
                            },
                          ),
                            // child: SchedularTextField(
                            //   controller: prCity,
                            //     labelText: AppString.city)
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                          child:FutureBuilder<List<statedata>>(
                            future: getStateDropDown(context),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7),
                                  child: Container(
                                      width: AppSize.s250,
                                      height: AppSize.s40,
                                      decoration: BoxDecoration(
                                          color: ColorManager.white),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text('Loading...',style: GoogleFonts.firaSans(
                                          fontSize: 12,
                                          color: ColorManager.mediumgrey,
                                          fontWeight: FontWeight.w400,
                                        ),),
                                      )
                                  ),
                                );
                              }
                              if (snapshot.hasData) {
                                List<String> dropDownList = [];
                                for (var i in snapshot.data!) {
                                  dropDownList.add(i.name!);
                                }

                                 return SizedBox(
                                  height: 27,
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                       labelText: 'State',
                                      labelStyle: GoogleFonts.firaSans(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w400,
                                        color: ColorManager.greylight,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: ColorManager.containerBorderGrey),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(4.0),
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                      ),
                                      contentPadding:
                                      const EdgeInsets.symmetric(
                                        //   //  vertical: 5,
                                          horizontal: 12),
                                    ),
                                    // value: selectedCountry,
                                    icon: Icon(Icons.arrow_drop_down,
                                      color: ColorManager.blueprime),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff686464),
                                    ),

                                    onChanged: (newValue) {
                                      for (var a in snapshot.data!) {
                                        if (a.name == newValue) {
                                          selectedStatepr = a.name!;
                                          //country = a
                                          // int? docType = a.companyOfficeID;
                                        }
                                      }
                                    },
                                    items: dropDownList.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: GoogleFonts.firaSans(
                                            fontSize: 12,
                                            color: Color(0xff575757),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                );
                                // return SchedularDropdown(
                                //   labelText: 'State',
                                //   // labelStyle: GoogleFonts.firaSans(
                                //   //   fontSize: 12,
                                //   //   color: Color(0xff575757),
                                //   //   fontWeight: FontWeight.w400,
                                //   // ),
                                //   // labelFontSize: 12,
                                //   items: dropDownList,
                                //   onChanged: (newValue) {
                                //     for (var a in snapshot.data!) {
                                //       if (a.name == newValue) {
                                //         selectedStatepr = a.name!;
                                //         // stateId = a.stateId!;
                                //         //  print("Dept ID ${stateId}");
                                //         // int docType = a.employeeTypesId;
                                //         // Do something with docType
                                //       }
                                //     }
                                //   },
                                // );
                              } else {
                                return const Offstage();
                              }
                            },
                          ),
                            // child: SchedularDropdown(
                            //
                            //   labelText: AppString.state,
                            //     items: ['Option 1', 'Option 2', 'Option 3'],
                            //   onChanged: (newValue) {
                            //   setState(() {
                            //     selectedStatepr = newValue;
                            //   });
                            // },)
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularTextFieldWithButton(
                              controller: prZipcode,
                                labelText: AppString.zip_code,

                                buttonText: AppString.viewzone)
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularTextField(
                              controller: prPhone,
                                labelText: 'Phone')
                        ),
                      ],
                    ),
                    SizedBox(height:AppSize.s16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                              controller: prFax,
                                labelText: AppString.fax)
                        ),
                        SizedBox(width:AppSize.s35),
                        Flexible(
                            child: SchedularTextField(
                              controller: prProtocol,
                              labelText: AppString.protocol)
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: Container()), // Empty container for alignment
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: Container()),
                      ],
                    ),
                    SizedBox(height:AppSize.s32),

                    Divider(
                      height: AppSize.s5,
                      color: ColorManager.cream,
                      thickness: 4,
                    ),

                    ////////////////////////second box///////////////////////////


                    SizedBox(height:AppSize.s32),
                    Row(
                      children: [
                        Flexible(child: SchedularTextField(
                          controller: contractFFPhysician,
                            labelText: 'Certifying or F2F Physician')
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularTextField(
                              controller: ffFirstName,
                              labelText: 'Physician’s First Name')
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularTextField(
                              controller: ffLastName,
                              labelText: 'Physician’s Last Name.',)
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(child: SchedularTextField(
                          controller: ffPECOSStatus,
                            labelText: 'PECOS Status')
                        ),
                      ],
                    ),
                    SizedBox(height:AppSize.s16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                              controller: ffUPINNbr,
                              labelText: 'UPIN#', )
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularTextField(
                              controller: ffNPINbr,
                              labelText: 'NPI#', )
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularTextField(
                              controller: ffStreet,
                                labelText: AppString.street)
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularTextField(
                              controller: ffSuiteApt,
                              labelText: 'Suite/ Apt', )
                        ),
                      ],
                    ),
                    SizedBox(height:AppSize.s16),
                    Row(
                      children: [
                        Flexible(
                          child: FutureBuilder<List<citydata>>(
                            future: getCityDropDown(context),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7),
                                  child: Container(
                                      width: AppSize.s250,
                                      height: AppSize.s40,
                                      decoration: BoxDecoration(
                                          color: ColorManager.white),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Loading...',
                                          style: GoogleFonts.firaSans(
                                            fontSize: 12,
                                            color: ColorManager.mediumgrey,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      )),
                                );
                              }
                              if (snapshot.hasData) {
                                List<String> dropDownList = [];
                                for (var i in snapshot.data!) {
                                  dropDownList.add(i.cityName!);
                                }

                                return SizedBox(
                                  height: 27,
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'City',
                                      labelStyle: GoogleFonts.firaSans(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w400,
                                        color: ColorManager.greylight,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorManager
                                                .containerBorderGrey),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(4.0),
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                      ),
                                      contentPadding:
                                      const EdgeInsets.symmetric(
                                        //   //  vertical: 5,
                                          horizontal: 12),
                                    ),
                                    // value: selectedCountry,
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: ColorManager.blueprime,
                                    ),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff686464),
                                    ),

                                    onChanged: (newValue) {
                                      for (var a in snapshot.data!) {
                                        if (a.cityName == newValue) {
                                          selectedCityff = a.cityName!;
                                          //country = a
                                          // int? docType = a.companyOfficeID;
                                        }
                                      }
                                    },
                                    items: dropDownList.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: GoogleFonts.firaSans(
                                            fontSize: 12,
                                            color: Color(0xff575757),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                );
                              } else {
                                return const Offstage();
                              }
                            },
                          ),

                            // child: SchedularTextField(
                            //   controller: ffCity,
                            //     labelText: AppString.city)
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                          child:FutureBuilder<List<statedata>>(
                            future: getStateDropDown(context),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7),
                                  child: Container(
                                      width: AppSize.s250,
                                      height: AppSize.s40,
                                      decoration: BoxDecoration(
                                          color: ColorManager.white),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text('Loading...',style: GoogleFonts.firaSans(
                                          fontSize: 12,
                                          color: ColorManager.mediumgrey,
                                          fontWeight: FontWeight.w400,
                                        ),),
                                      )
                                  ),
                                );
                              }
                              if (snapshot.hasData) {
                                List<String> dropDownList = [];
                                for (var i in snapshot.data!) {
                                  dropDownList.add(i.name!);
                                }

                                return SizedBox(
                                  height: 27,
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'State',
                                      labelStyle: GoogleFonts.firaSans(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w400,
                                        color: ColorManager.greylight,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: ColorManager.containerBorderGrey),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(4.0),
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                      ),
                                      contentPadding:
                                      const EdgeInsets.symmetric(
                                        //   //  vertical: 5,
                                          horizontal: 12),
                                    ),
                                    // value: selectedCountry,
                                    icon: Icon(Icons.arrow_drop_down,
                                        color: ColorManager.blueprime),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: GoogleFonts.firaSans(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff686464),
                                    ),

                                    onChanged: (newValue) {
                                      for (var a in snapshot.data!) {
                                        if (a.name == newValue) {
                                          selectedStateff = a.name!;
                                          //country = a
                                          // int? docType = a.companyOfficeID;
                                        }
                                      }
                                    },
                                    items: dropDownList.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: GoogleFonts.firaSans(
                                            fontSize: 12,
                                            color: Color(0xff575757),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                );
                                // return SchedularDropdown(
                                //   labelText: 'State',
                                //   // labelStyle: GoogleFonts.firaSans(
                                //   //   fontSize: 12,
                                //   //   color: Color(0xff575757),
                                //   //   fontWeight: FontWeight.w400,
                                //   // ),
                                //   // labelFontSize: 12,
                                //   items: dropDownList,
                                //   onChanged: (newValue) {
                                //     for (var a in snapshot.data!) {
                                //       if (a.name == newValue) {
                                //         selectedStatepr = a.name!;
                                //         // stateId = a.stateId!;
                                //         //  print("Dept ID ${stateId}");
                                //         // int docType = a.employeeTypesId;
                                //         // Do something with docType
                                //       }
                                //     }
                                //   },
                                // );
                              } else {
                                return const Offstage();
                              }
                            },
                          ),
                            // child: SchedularDropdown(
                            //   initialValue: selectedStateff,
                            //   labelText: AppString.state,
                            //     items: ['Option 1', 'Option 2', 'Option 3'],
                            //     onChanged: (newValue) {
                            //       setState(() {
                            //         selectedStateff = newValue;
                            //       });
                            //     },)
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularTextFieldWithButton(
                              controller: ffZipcode,
                                labelText: AppString.zip_code,
                                buttonText: AppString.viewzone)
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularTextField(
                              controller: ffPhone,
                                labelText: 'Phone')
                        ),
                      ],
                    ),
                    SizedBox(height:AppSize.s16),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                              controller: ffFax,
                                labelText: AppString.fax)
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: SchedularTextField(
                              controller: ffProtocol,
                              labelText: AppString.protocol)
                        ),
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: Container()), // Empty container for alignment
                        SizedBox(width:AppSize.s35 ),
                        Flexible(
                            child: Container()),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
