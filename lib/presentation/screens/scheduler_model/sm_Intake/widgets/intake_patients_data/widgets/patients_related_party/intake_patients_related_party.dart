import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/sm_module_manager/patient_data/patient_data_related_party_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../../../../app/services/api/managers/sm_module_manager/physician_info/physician_info_manager.dart';
import '../../../../../../../../data/api_data/sm_data/scheduler_create_data/create_data.dart';
import '../../../../../sm_scheduler/widget/schedular_create/widget/assign_visit_pop_up.dart';
import '../../../../../sm_scheduler/widget/schedular_create/widget/edit_appointment_pop_up.dart';
import '../../../../../textfield_dropdown_constant/schedular_dropdown_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_withbutton_const.dart';
import '../../../../../widgets/constant_widgets/button_constant.dart';
import '../../../intake_physician_info/widget/physician_info_info/physician_info_info.dart';
import '../../../intake_referral/widget/referral_agency_info/intake_referral_submit_popup.dart';

class IntakeRelatedPartiesScreen extends StatefulWidget {
  final int patientId;

  const IntakeRelatedPartiesScreen({
    super.key,
    required this.patientId,
  });

  @override
  State<IntakeRelatedPartiesScreen> createState() =>
      _RelatedPartiesScreenstate();
}

class _RelatedPartiesScreenstate extends State<IntakeRelatedPartiesScreen> {
  TextEditingController ctlrEmgContact = TextEditingController();
  TextEditingController ctlrTelphoneNo = TextEditingController();
  TextEditingController ctlrEmgContactAddress = TextEditingController();
  TextEditingController ctlrCity = TextEditingController();
  TextEditingController ctlrCityy = TextEditingController();
  TextEditingController ctlrComment = TextEditingController();
  TextEditingController ctlrSuffix = TextEditingController();
  TextEditingController ctlrPreffix = TextEditingController();
  TextEditingController ctlrFirstname = TextEditingController();
  TextEditingController ctlrLastName = TextEditingController();
  TextEditingController ctlrMi = TextEditingController();
  TextEditingController ctlrAddress = TextEditingController();
  TextEditingController ctlrPhoneNo = TextEditingController();
  TextEditingController ctlrZipCode = TextEditingController();
  TextEditingController ctlrApartment = TextEditingController();
  TextEditingController ctlrCell = TextEditingController();
  TextEditingController ctlrAddInfo = TextEditingController();
  TextEditingController ctlrEmail = TextEditingController();
  TextEditingController optforChaps = TextEditingController();
  TextEditingController dummyCtrl = TextEditingController();
  bool isOptForCAHPSSurvey = false;
  String? status = 'Active';
  String? selectedStateEC;
  String? selectedCityEC;
  String? selectedStatePC;
  String? selectedCityPC;
  String? selectedCity;
  String? selectedCountry;
  String? selectedRelationshipEC;
  String? selectedRelationshipPC;
  String? selectedPriority;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Status: Partially Completed',
                      style: GoogleFonts.firaSans(
                          decoration: TextDecoration.none,
                          fontSize: FontSize.s14,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.orangeheading),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width / 60),
                    Container(
                        height: 30,
                        width: 170,
                        child: SchedularIconButtonConst(
                          icon: Icons.add,
                          text: 'Add Related Parties',
                          onPressed: () async {
                            await IntakeRelatedPartyAdd(
                                context,
                                widget.patientId,
                                ctlrEmgContact.text,
                                ctlrTelphoneNo.text,
                                selectedRelationshipEC.toString(),
                                ctlrEmgContactAddress.text,
                                selectedCityEC.toString(),
                                selectedStateEC.toString(),
                                ctlrZipCode.text,
                                selectedPriority.toString(),
                                ctlrComment.text,
                                ctlrPreffix.text,
                                ctlrFirstname.text,
                                ctlrMi.text,
                                ctlrLastName.text,
                                ctlrSuffix.text,
                                optforChaps.text,
                                ctlrAddress.text,
                                ctlrApartment.text,
                                selectedCityPC.toString(),
                                selectedStatePC.toString(),
                                ctlrZipCode.text,
                                ctlrPhoneNo.text,
                                ctlrCell.text,
                                ctlrEmail.text,
                                selectedRelationshipPC.toString(),
                                ctlrAddInfo.text);
                          },
                        ))
                  ],
                ),
              ),
              SizedBox(height: AppSize.s10),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  // height: 405,
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
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Emergency Contact Information',
                            style: TextStyle(
                                fontSize: FontSize.s14,
                                fontWeight: FontWeightManager.semiBold,
                                color: ColorManager.mediumgrey),
                          )
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                  controller: ctlrEmgContact,
                                  labelText: 'Emergency Contact',
                                  phoneField:true,
                              )),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: ctlrTelphoneNo,
                                  labelText: 'Telephone Number',
                                  phoneField:true)),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                            child:FutureBuilder<List<RelationshipData>>(
                              future: getRelationshipDropDown(context),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SchedularTextField(
                                    controller: dummyCtrl,
                                    labelText: 'Relationship',
                                    suffixIcon: Icon(Icons.arrow_drop_down,
                                      color: ColorManager.blueprime,),);
                                }
                                if (snapshot.hasData) {
                                  List<String> dropDownList = [];
                                  for (var i in snapshot.data!) {
                                    dropDownList.add(i.relationship!);
                                  }

                                  return SizedBox(
                                    height: 27,
                                    child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        labelText: 'Relationship',
                                        labelStyle: GoogleFonts.firaSans(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w400,
                                          color: ColorManager.greylight,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: ColorManager.containerBorderGrey), // border color
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
                                        color: ColorManager.blueprime,),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: GoogleFonts.firaSans(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff686464),
                                      ),

                                      onChanged: (newValue) {
                                        for (var a in snapshot.data!) {
                                          if (a.relationship == newValue) {
                                            selectedRelationshipEC = a.relationship!;
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
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                            controller: ctlrEmgContactAddress,
                            labelText: 'Emergency Contact Address',
                          )),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                            child: FutureBuilder<List<CityData>>(
                              future: getCityDropDown(context),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SchedularTextField(
                                    controller: dummyCtrl,
                                    labelText: 'City',
                                    suffixIcon: Icon(Icons.arrow_drop_down,
                                      color: ColorManager.blueprime,),);
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
                                           selectedCityEC = a.cityName!;
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
                              //     controller: ctlrCity,
                              //     labelText: AppString.city),
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                            child:FutureBuilder<List<StateData>>(
                              future: getStateDropDown(context),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SchedularTextField(
                                    controller: dummyCtrl,
                                    labelText: 'State',
                                    suffixIcon: Icon(Icons.arrow_drop_down,
                                      color: ColorManager.blueprime,),);
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
                                          borderSide: BorderSide(color: ColorManager.containerBorderGrey), // border color
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
                                        color: ColorManager.blueprime,),
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
                                            selectedStateEC = a.name!;
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
                           ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextFieldWithButton(
                                  textController: ctlrZipCode,
                                  labelText: AppString.zip_code,
                                  initialValue: '',
                                  buttonText: 'View Zone')),
                          SizedBox(width: 35),
                          Flexible(

                            child: FutureBuilder<List<PriorityDisasterData>>(
                              future: getPiorityDisastorDropDown(context),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SchedularTextField(
                                    controller: dummyCtrl,
                                    labelText: 'Priority/Disaster Code',
                                    suffixIcon: Icon(Icons.arrow_drop_down,
                                      color: ColorManager.blueprime,),);
                                }
                                if (snapshot.hasData) {
                                  List<String> dropDownList = [];
                                  for (var i in snapshot.data!) {
                                    dropDownList.add(i.idText!);
                                  }

                                  return SizedBox(
                                    height: 27,
                                    child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        labelText: 'Priority/Disaster Code',
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
                                          if (a.idText == newValue) {
                                            selectedPriority = a.idText!;
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
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                  controller: ctlrComment,
                                  labelText: AppString.comments)),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child:
                                  Container()), // Empty container for alignment
                          SizedBox(width: AppSize.s35),
                          Flexible(child: Container()),
                          SizedBox(width: AppSize.s35),
                          Flexible(child: Container()),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Text(
                            'Primary Care Giver',
                            style: TextStyle(
                                fontSize: FontSize.s14,
                                fontWeight: FontWeightManager.semiBold,
                                color: ColorManager.mediumgrey),
                          )
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                  controller: ctlrPreffix, labelText: 'Prefix')),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                            controller: ctlrFirstname,
                            labelText: 'First Name',
                            initialValue: 'Erica',
                          )),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                            controller: ctlrMi,
                            labelText: 'M.I.',
                            initialValue: 'A',
                          )),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: ctlrLastName,
                                  labelText: 'Last Name')),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                  controller: ctlrSuffix, labelText: 'Suffix')),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                            child: Row(
                              children: [
                                Checkbox(
                                  // checkColor: Color(0xff50B5E5),
                                  value: isOptForCAHPSSurvey,
                                  onChanged: (value) {
                                    setState(() {
                                      isOptForCAHPSSurvey = value!;
                                    });
                                  },
                                ),
                                Expanded(
                                    child: SchedularTextField(
                                      controller: optforChaps,
                                        labelText: 'Opt for CAHPS Survey')),
                              ],
                            ),
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: ctlrAddress,
                                  labelText: AppString.address)),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: ctlrApartment,
                                  labelText: 'Suite/ Apt.')),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                            child: FutureBuilder<List<CityData>>(
                              future: getCityDropDown(context),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SchedularTextField(
                                    controller: dummyCtrl,
                                    labelText: 'City',
                                    suffixIcon: Icon(Icons.arrow_drop_down,
                                      color: ColorManager.blueprime,),);
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
                                            selectedCityPC = a.cityName!;
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
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                            child:FutureBuilder<List<StateData>>(
                              future: getStateDropDown(context),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SchedularTextField(
                                    controller: dummyCtrl,
                                    labelText: 'State',
                                    suffixIcon: Icon(Icons.arrow_drop_down,
                                      color: ColorManager.blueprime,),);
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
                                          borderSide: BorderSide(color: ColorManager.containerBorderGrey), // border color
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
                                        color: ColorManager.blueprime,),
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
                                            selectedStatePC = a.name!;
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
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextFieldWithButton(
                                  labelText: AppString.zip_code,
                                  initialValue: '',
                                  buttonText: 'View Zone')),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: ctlrPhoneNo, labelText: 'Phone',phoneField:true)),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                  controller: ctlrCell, labelText: 'Cell')),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: ctlrEmail,
                                  labelText: AppString.email)),
                          SizedBox(width: 35),
                          Flexible(

                            child:FutureBuilder<List<RelationshipData>>(
                              future: getRelationshipDropDown(context),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SchedularTextField(
                                    controller: dummyCtrl,
                                    labelText: 'Relationship',
                                    suffixIcon: Icon(Icons.arrow_drop_down,
                                      color: ColorManager.blueprime,),);
                                }
                                if (snapshot.hasData) {
                                  List<String> dropDownList = [];
                                  for (var i in snapshot.data!) {
                                    dropDownList.add(i.relationship!);
                                  }

                                  return SizedBox(
                                    height: 27,
                                    child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        labelText: 'Relationship',
                                        labelStyle: GoogleFonts.firaSans(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w400,
                                          color: ColorManager.greylight,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: ColorManager.containerBorderGrey), // border color
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
                                        color: ColorManager.blueprime,),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: GoogleFonts.firaSans(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff686464),
                                      ),

                                      onChanged: (newValue) {
                                        for (var a in snapshot.data!) {
                                          if (a.relationship == newValue) {
                                            selectedRelationshipPC = a.relationship!;
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


                              // child: SchedularDropdown(
                              //     labelText: 'Relationship',
                              //     items: ['Single', 'Married', 'Separated'], onChanged: (newValue) {
                              //   setState(() {
                              //     selectedRelationship = newValue;
                              //   });
                              // },),
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: ctlrAddInfo,
                                  labelText:
                                      'Additional Information')), // Empty container for alignment
                        ],
                      ),
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
}
