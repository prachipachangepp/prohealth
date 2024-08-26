import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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

  IntakePharmacyVendorScreen({super.key, });

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
                          fontSize: FontSize.s12,
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
                            1,
                            //widget.patientId,
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

                            child: FutureBuilder<List<SuppliesData>>(
                              future: getSuppliesDMEDropDown(context),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SchedularTextField(
                                    controller: dummyCtrl,
                                    labelText: 'Supplies',
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
                                        labelText: 'Facility',
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
                                            dmeSupplies = a.idText!;
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
                                  controller: dmephone, labelText: 'Phone')),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  controller: dmeDeliverby,
                                  labelText: 'Deliver by',
                                  suffixIcon: Icon(
                                    Icons.calendar_month_outlined,color: ColorManager.blueprime,
                                    size: 18,
                                  ))),
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
                                    labelText: 'Pharmacy',
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
                                        labelText: 'Pharmacy',
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
                                            pharmacydd = a.idText!;
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
                                            pharmacycity = a.cityName!;
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
                                            pharmacystate = a.name!;
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
                                  suffixIcon: Icon(
                                    Icons.calendar_month_outlined,color: ColorManager.blueprime,
                                    size: 18,
                                  ))),
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
            ],
          ),
        ),
      ),
    );
  }
}
