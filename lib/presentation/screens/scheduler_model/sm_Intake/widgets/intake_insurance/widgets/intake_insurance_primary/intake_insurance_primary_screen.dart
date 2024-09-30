import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/const_string.dart';
import '../../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../../app/services/api/managers/sm_module_manager/insurance/primary_mamager.dart';
import '../../../../../../../../app/services/api/managers/sm_module_manager/physician_info/physician_info_manager.dart';
import '../../../../../../../../data/api_data/sm_data/scheduler_create_data/create_data.dart';
import '../../../../../textfield_dropdown_constant/double_date_picker_textfield.dart';
import '../../../../../textfield_dropdown_constant/schedular_dropdown_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_const.dart';
import '../../../intake_patients_data/widgets/patients_info/intake_patients_info.dart';

class IntakeInsurancePrimaryScreen extends StatefulWidget {
  final int patientId;
  const IntakeInsurancePrimaryScreen({super.key, required this.patientId});

  @override
  State<IntakeInsurancePrimaryScreen> createState() => _IntakeInsurancePrimaryScreenState();
}

class _IntakeInsurancePrimaryScreenState extends State<IntakeInsurancePrimaryScreen> {

  String? varifiedinsurance;
  String? eligiblityStatus;
  String? selectedState;
  String? selectedCity;
  String? selectedCategory;

  TextEditingController primaryinsuranceController =TextEditingController();
  TextEditingController prnameController =TextEditingController();
  TextEditingController prstreetController =TextEditingController();
  TextEditingController prcodeController =TextEditingController();
  TextEditingController suiteAptController =TextEditingController();
  TextEditingController cityController =TextEditingController();
  TextEditingController stateController =TextEditingController();
  TextEditingController zipcodeController =TextEditingController();
  TextEditingController typeController =TextEditingController();
  TextEditingController phoneController =TextEditingController();
  TextEditingController categoryController =TextEditingController();
  TextEditingController authorisationController =TextEditingController();
  TextEditingController effectiveFromController =TextEditingController();
  TextEditingController effectiveToController =TextEditingController();
  TextEditingController groupNbrController =TextEditingController();
  TextEditingController groupNameController =TextEditingController();
  TextEditingController policyHICNbrController =TextEditingController();
  //TextEditingController eligiblityStatusController =TextEditingController();
  TextEditingController insuranceVerifiedController =TextEditingController();
  TextEditingController commentController =TextEditingController();
  TextEditingController dummyCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Status Completed',
                      style: GoogleFonts.firaSans(
                          decoration: TextDecoration.none,
                          fontSize: FontSize.s14,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.greenDark
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await postIPrimaryScreen(
                          context,
                          widget.patientId,
                          primaryinsuranceController.text,
                          prnameController.text,
                          prstreetController.text,
                          prcodeController.text,
                          suiteAptController.text,
                            selectedCity.toString(),
                          selectedState.toString(),
                          zipcodeController.text,
                          typeController.text,
                          phoneController.text,
                          selectedCategory.toString(),
                          authorisationController.text,
                          //"2024-08-09",
                          effectiveFromController.text,
                          //"2024-08-09",
                          effectiveToController.text,
                          groupNbrController.text,
                          groupNameController.text,
                          policyHICNbrController.text,
                          eligiblityStatus.toString(),
                          varifiedinsurance.toString(),
                          commentController.text,


                        );
                        print("${effectiveFromController.text}");
                        print("${effectiveToController.text}");

                      },
                      child: Text(
                        AppString.save,
                        style: GoogleFonts.firaSans(
                          fontSize: FontSize.s14,
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
              Container(
                // height: 490,
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
                    children: [
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                controller: primaryinsuranceController,

                                  labelText: 'Primary Insurance')
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                controller: prnameController,
                                  labelText: AppString.name)
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                controller: prstreetController,
                                  labelText: AppString.street)
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                controller: prcodeController,
                                  labelText: AppString.code)
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                controller: suiteAptController,
                                  labelText: 'Suite/Apt #')
                          ),
                          SizedBox(width: AppSize.s35),
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

                                } else {
                                  return const Offstage();
                                }
                              },
                            ),
                              // child: SchedularTextField(
                              //   controller: stateController,
                              //   labelText: AppString.state,)
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                controller: zipcodeController,
                                  labelText:AppString.zip_code)
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                controller: typeController,
                                  labelText:AppString.type)
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                controller: phoneController,
                                  labelText:'Phone')
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(



                            child: FutureBuilder<List<CategoryData>>(
                              future: getCategoryDropDown(context),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SchedularTextField(
                                    controller: dummyCtrl,
                                    labelText: 'Category',
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
                                        labelText: 'category',
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
                                            selectedCategory = a.idText!;
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
                              //   labelText: AppString.category,
                              //     items: ['Option 1', 'Option 2', 'Option 3'], onChanged: (newValue) {  },
                              // )
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                controller: authorisationController,
                                  labelText:'Authorisation')
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                              child: DoubleDatePickerTextField(
                                  labelText: 'Effective from',
                                  isDate: true,
                                startDateController: effectiveFromController,
                                endDateController: effectiveToController,)
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                controller: groupNbrController,
                                  labelText:'Group #')
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                controller: groupNameController,
                                  labelText: 'Group Name')
                          ),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: SchedularTextField(
                                controller: policyHICNbrController,
                                  labelText:'Policy/ HIC #')
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(





                            child: FutureBuilder<List<EligiblityStatusData>>(
                              future: getEligiblityStatusDropDown(context),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SchedularTextField(
                                    controller: dummyCtrl,
                                    labelText: 'Status',
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
                                        labelText: 'Eligibility Status',
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
                                            eligiblityStatus = a.idText!;
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
                              child: Container()),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: Container()),
                          SizedBox(width: AppSize.s35),
                          Flexible(
                              child: Container()),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Insurance Verified',
                                    style: GoogleFonts.firaSans(
                                        color: ColorManager.greylight,
                                        fontSize: FontSize.s10, fontWeight: FontWeightManager.regular)
                                ),
                                SizedBox(height: 1),
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'Yes',
                                      groupValue: varifiedinsurance,
                                      onChanged: (value) => setState(() => varifiedinsurance = value),
                                    ),
                                    Text(AppString.yes,
                                        style: GoogleFonts.firaSans(
                                            fontSize: FontSize.s14
                                            , fontWeight: FontWeightManager.regular)
                                    ),
                                    SizedBox(width: MediaQuery.of(context).size.width/100),
                                    Radio<String>(
                                      value: 'No',
                                      groupValue: varifiedinsurance,
                                      onChanged: (value) => setState(() => varifiedinsurance = value),
                                    ),
                                    Text(AppString.no,
                                        style: GoogleFonts.firaSans(
                                            fontSize: FontSize.s14
                                            , fontWeight: FontWeightManager.regular)
                                    ),
                                    SizedBox(width: MediaQuery.of(context).size.width/100),
                                    TextButton(
                                      onPressed: () => setState(() => varifiedinsurance = null), // Clear selection
                                      child: Text(
                                        'Clear',
                                        style: GoogleFonts.firaSans(
                                            fontSize: MediaQuery.of(context).size.width * 0.008,
                                            fontWeight: FontWeightManager.regular,
                                            color: ColorManager.greylight
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.s16),
                      Row(
                        children: [
                          Flexible(
                            child: Container(

                              height: AppSize.s99,
                              child: TextFormField(
                                controller: commentController,
                                maxLines: 3,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  labelText: 'Comments',
                                  labelStyle: GoogleFonts.firaSans(
                                    fontSize: FontSize.s10,
                                    fontWeight: FontWeightManager.regular,
                                    color: ColorManager.greylight,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      color: ColorManager.containerBorderGrey,
                                      width: 1.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      color: ColorManager.containerBorderGrey,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      color: ColorManager.containerBorderGrey,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
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