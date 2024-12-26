import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/presentation/screens/scheduler_model/widgets/constant_widgets/dropdown_constant_sm.dart';

import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/const_string.dart';
import '../../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../../app/services/api/managers/sm_module_manager/medications/pharmacy_vendor_manager.dart';
import '../../../../../../../../app/services/api/managers/sm_module_manager/physician_info/physician_info_manager.dart';
import '../../../../../../../../data/api_data/sm_data/scheduler_create_data/create_data.dart';
import '../../../../../textfield_dropdown_constant/schedular_dropdown_const.dart';
import '../../../../../textfield_dropdown_constant/schedular_textfield_const.dart';
import '../../../intake_patients_data/widgets/patients_info/intake_patients_info.dart';

class IntakePharmacyVendorScreen extends StatefulWidget {
  final int patientId;
  IntakePharmacyVendorScreen({super.key, required this.patientId, });

  @override
  State<IntakePharmacyVendorScreen> createState() =>
      _IntakePharmacyVendorScreenState();
}

class _IntakePharmacyVendorScreenState
    extends State<IntakePharmacyVendorScreen> {
  TextEditingController dmeContact = TextEditingController();
  TextEditingController dmephone = TextEditingController();
  TextEditingController dmeDeliverby = TextEditingController();
  TextEditingController dmefax = TextEditingController();
  TextEditingController pharmacycontact = TextEditingController();
  TextEditingController pharmacyphone = TextEditingController();
  TextEditingController pharmacyaddress = TextEditingController();
  //TextEditingController pharmacycity = TextEditingController();
 // TextEditingController pharmacystate = TextEditingController();
  TextEditingController pharmacyzipcode = TextEditingController();
  TextEditingController pharmacydeliverby = TextEditingController();
  TextEditingController pharmacyfax = TextEditingController();
  TextEditingController pharmacycontactsecond = TextEditingController();
  TextEditingController dummyCtrl = TextEditingController();

  String? dmeSupplies;
  String? pharmacydd;
  String? pharmacystate;
  String? pharmacycity;

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
                    Text(
                      'Status Completed',
                      style: GoogleFonts.firaSans(
                          decoration: TextDecoration.none,
                          fontSize: FontSize.s14,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.greenDark),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await postMedicationScreen(
                            context,
                            widget.patientId,
                            dmeSupplies.toString(),
                            dmeContact.text,
                            dmephone.text,
                            dmeDeliverby.text,
                            dmefax.text,
                            pharmacydd.toString(),
                            pharmacycontact.text,
                            pharmacyphone.text,
                            pharmacyaddress.text,
                            pharmacycity.toString(),
                            pharmacystate.toString(),
                            pharmacyzipcode.text,
                            pharmacydeliverby.text,
                            pharmacyfax.text,
                            pharmacycontactsecond.text);
                        print("${dmeDeliverby.text}");
                        print("${pharmacydeliverby.text}");
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
                  borderRadius: BorderRadius.circular(12),
                  // border: Border.symmetric(vertical: BorderSide(width: 0.2,color: ColorManager.grey),horizontal: BorderSide(width: 0.2,color: ColorManager.grey),),//all(width: 1, color: Color(0xFFBCBCBC)),
                  border: Border.all(width: 0.2,color: ColorManager.lightGrey),//all(width: 1, color: Color(0xFFBCBCBC)),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(

                            child: FutureBuilder<List<SuppliesData>>(
                              future: getSuppliesDMEDropDown(context),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SchedularTextField(
                                    controller: dummyCtrl,
                                    labelText: 'Supplies');
                                }
                                if (snapshot.hasData) {
                                  List<DropdownMenuItem<String>> dropDownList = [];
                                  for (var i in snapshot.data!) {
                                    dropDownList.add(DropdownMenuItem<String>(
                                      child: Text(i.idText!),
                                      value: i.idText,
                                    ));
                                  }

                                  return CustomDropdownTextFieldsm(headText: 'Supplies/DME',dropDownMenuList: dropDownList,
                                      onChanged: (newValue) {
                                        for (var a in snapshot.data!) {
                                          if (a.idText == newValue) {
                                            dmeSupplies = a.idText!;
                                            //country = a
                                            // int? docType = a.companyOfficeID;
                                          }
                                        }
                                      });

                                } else {
                                  return const Offstage();
                                }
                              },
                            ),

                          ),
                          SizedBox(width: 35),
                          Flexible(child: Container()),
                          SizedBox(width: 35),
                          Flexible(child: Container()),
                          SizedBox(width: 35),
                          Flexible(child: Container()),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                  controller: dmeContact,
                                  labelText: 'Contact')),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  phoneField: true,
                                  controller: dmephone, labelText: 'Phone')),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: dmeDeliverby,
                                  labelText: 'Deliver by',
                                  showDatePicker: true,)),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: dmefax, labelText: 'Fax')),
                        ],
                      ),
                      SizedBox(height: 32),
                      Row(
                        children: [
                          Flexible(
                            child: FutureBuilder<List<PharmacyData>>(
                              future: getPharmacyDropDown(context),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SchedularTextField(
                                    controller: dummyCtrl,
                                    labelText: 'Pharmacy');
                                }
                                if (snapshot.hasData) {
                                  List<DropdownMenuItem<String>> dropDownList = [];
                                  for (var i in snapshot.data!) {
                                    dropDownList.add(DropdownMenuItem<String>(
                                      child: Text(i.idText!),
                                      value: i.idText,
                                    ));
                                  }
                                  return CustomDropdownTextFieldsm(headText: 'Pharmacy',dropDownMenuList: dropDownList,
                                      onChanged: (newValue) {
                                        for (var a in snapshot.data!) {
                                          if (a.idText == newValue) {
                                            pharmacydd = a.idText!;
                                            //country = a
                                            // int? docType = a.companyOfficeID;
                                          }
                                        }
                                      });

                                } else {
                                  return const Offstage();
                                }
                              },
                            ),

                          ),
                          SizedBox(width: 35),
                          Flexible(child: Container()),
                          SizedBox(width: 35),
                          Flexible(child: Container()),
                          SizedBox(width: 35),
                          Flexible(child: Container()),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                  controller: pharmacycontact,
                                  labelText: 'Contact')),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: pharmacyphone,
                                  labelText: 'Phone')),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: pharmacyaddress,
                                  labelText: 'Address')),
                          SizedBox(width: 35),
                          Flexible(

                            child: FutureBuilder<List<CityData>>(
                              future: getCityDropDown(context),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SchedularTextField(
                                    controller: dummyCtrl,
                                    labelText: 'City',);
                                }
                                if (snapshot.hasData) {
                                  List<DropdownMenuItem<String>> dropDownList = [];
                                  for (var i in snapshot.data!) {
                                    dropDownList.add(DropdownMenuItem<String>(
                                      child: Text(i.cityName!),
                                      value: i.cityName,
                                    ));
                                  }
                                  return CustomDropdownTextFieldsm(headText: 'City',dropDownMenuList: dropDownList,
                                      onChanged: (newValue) {
                                        for (var a in snapshot.data!) {
                                          if (a.cityName == newValue) {
                                            pharmacycity = a.cityName!;
                                            //country = a
                                            // int? docType = a.companyOfficeID;
                                          }
                                        }
                                      });
                                } else {
                                  return const Offstage();
                                }
                              },
                            ),
                              // child: SchedularTextField(
                              //     controller: pharmacycity, labelText: 'City'),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Flexible(

                            child:FutureBuilder<List<StateData>>(
                              future: getStateDropDown(context),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SchedularTextField(
                                    controller: dummyCtrl,
                                    labelText: 'State');
                                }
                                if (snapshot.hasData) {
                                  List<DropdownMenuItem<String>> dropDownList = [];
                                  for (var i in snapshot.data!) {
                                    dropDownList.add(DropdownMenuItem<String>(
                                      child: Text(i.name),
                                      value: i.name,
                                    ));
                                  }
                                  return CustomDropdownTextFieldsm(headText: 'State',dropDownMenuList: dropDownList,
                                      onChanged: (newValue) {
                                        for (var a in snapshot.data!) {
                                          if (a.name == newValue) {
                                            pharmacystate = a.name;
                                            //country = a
                                            // int? docType = a.companyOfficeID;
                                          }
                                        }
                                      });
                                } else {
                                  return const Offstage();
                                }
                              },
                            ),
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: pharmacyzipcode,
                                  labelText: 'Zip Code')),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: pharmacydeliverby,
                                  labelText: 'Deliver by',
                                  showDatePicker: true,)),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: pharmacyfax, labelText: 'Fax')),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Flexible(
                            child: Container(
                              height: 99,
                              child: TextFormField(
                                controller: pharmacycontactsecond,
                                maxLines: 3,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  labelText: 'Contact',
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
              SizedBox(height: 19.5),
            ],
          ),
        ),
      ),
    );
  }
}
