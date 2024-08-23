import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/sm_module_manager/referral_data/agency_info_manager.dart';
import 'package:prohealth/presentation/screens/scheduler_model/widgets/constant_widgets/button_constant.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../../app/services/api/managers/sm_module_manager/physician_info/physician_info_manager.dart';
import '../../../../../../../../data/api_data/sm_data/scheduler_create_data/create_data.dart';
import '../../../../../textfield_dropdown_constant/schedular_dropdown_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_withbutton_const.dart';

class IntakeAgencyInfoScreen extends StatefulWidget {
  const IntakeAgencyInfoScreen({super.key});

  @override
  State<IntakeAgencyInfoScreen> createState() => _IntakeAgencyInfoScreenstate();
}

class _IntakeAgencyInfoScreenstate extends State<IntakeAgencyInfoScreen> {
  String? selectedState;
  String? selectedRate;
  String? selectedCity;
  TextEditingController ctlrAgency = TextEditingController();
  TextEditingController ctlrAgencyName = TextEditingController();
  TextEditingController ctlrStreet = TextEditingController();
  TextEditingController ctlrSuitApt = TextEditingController();
  TextEditingController ctlrZipCode = TextEditingController();
  TextEditingController ctlrPhone = TextEditingController();
  TextEditingController ctlrFax = TextEditingController();
  TextEditingController ctlrEmail = TextEditingController();
  TextEditingController ctlrUnites = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Status Completed',
                      style: GoogleFonts.firaSans(
                          decoration: TextDecoration.none,
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.greenDark),
                    ),
                    SizedBox(width: 8,),
                    SchedularIconButtonConst(
                        text: AppString.save,
                        onPressed: () async {
                       await AddAgencyInfo(context,
                           1,
                           ctlrAgency.text,
                           ctlrAgencyName.text,
                            1,         //  selectedRate.toString(),      // int.parse(selectedRate.toString()),
                           ctlrStreet.text,
                           ctlrSuitApt.text,
                           selectedCity.toString(),
                           selectedState.toString(),
                           ctlrZipCode.text,
                           ctlrPhone.text,
                           ctlrFax.text,
                           ctlrEmail.text,
                           ctlrUnites.text);
                        }),
                  ],
                ),
              ),
              SizedBox(height: AppSize.s10),
              Container(
                height: AppSize.s249,
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
                child: Column(
                  children: [
                    SizedBox(height: AppSize.s20),
                    Row(
                      children: [
                        Flexible(
                            child: SchedularTextField(
                              controller: ctlrAgency,
                          labelText: 'Agency',
                        )),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularTextField(
                              controller: ctlrAgencyName,
                          labelText: 'Agency Name',
                        )),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularDropdown(
                          labelText: 'Rate',
                          items: ['Option 1', 'Option 2', 'Option 3'],
                          onChanged: (newValue) {
                            setState(() {
                              selectedRate = newValue;
                            });
                          },
                        )),
                        SizedBox(width: 35),
                        Flexible(
                            child: SchedularTextField(
                              controller: ctlrStreet,
                          labelText: AppString.street,
                        )),
                      ],
                    ),
                    SizedBox(height: AppSize.s20),
                    Row(
                      children: [
                        Flexible(



                            child: SchedularTextField(
                              controller: ctlrSuitApt,
                          labelText: AppString.suite_Apt,
                        ),
                        ),
                        SizedBox(width: AppSize.s35),
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
                                          selectedCity = a.cityName!;
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



                        //     child: SchedularDropdown(
                        //   labelText: AppString.city,
                        //   items: ['Option 1', 'Option 2', 'Option 3'],
                        //   onChanged: (newValue) {
                        //     setState(() {
                        //       selectedCity = newValue;
                        //     });
                        //   },
                        // )
                        ),
                        SizedBox(width: AppSize.s35),
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
                                          selectedState = a.name!;
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

                                // );
                              } else {
                                return const Offstage();
                              }
                            },
                          ),
                        //     child: SchedularDropdown(
                        //   labelText: AppString.state,
                        //   items: ['Option 1', 'Option 2', 'Option 3'],
                        //   onChanged: (newValue) {
                        //     setState(() {
                        //       selectedState = newValue;
                        //     });
                        //   },
                        // ),
                        ),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextFieldWithButton(
                              controller: ctlrZipCode,
                                labelText: AppString.zip_code,
                                //initialValue: '26586845121',
                                buttonText: 'View Zone')),
                      ],
                    ),
                    SizedBox(height: AppSize.s20),
                    Row(
                      children: [
                        Flexible(
                            child:
                                SchedularTextField(
                                    controller: ctlrPhone,
                                    labelText: AppString.phone)),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child:
                                SchedularTextField(
                                    controller: ctlrFax,
                                    labelText: AppString.fax)),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child:
                                SchedularTextField(
                                    controller: ctlrEmail,
                                    labelText: AppString.email)),
                        SizedBox(width: AppSize.s35),
                        Flexible(
                            child: SchedularTextField(
                                controller: ctlrUnites,
                                labelText: 'Unites')),
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
