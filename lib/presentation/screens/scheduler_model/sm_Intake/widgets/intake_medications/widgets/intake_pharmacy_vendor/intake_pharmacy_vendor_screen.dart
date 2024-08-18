import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/const_string.dart';
import '../../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../../app/services/api/managers/sm_module_manager/medications/pharmacy_vendor_manager.dart';
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
  TextEditingController pharmacycity = TextEditingController();
  TextEditingController pharmacystate = TextEditingController();
  TextEditingController pharmacyzipcode = TextEditingController();
  TextEditingController pharmacydeliverby = TextEditingController();
  TextEditingController pharmacyfax = TextEditingController();
  TextEditingController pharmacycontactsecond = TextEditingController();

  String? dmeSupplies;
  String? pharmacydd;

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
                            pharmacycity.text,
                            pharmacystate.text,
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
                              child: SchedularDropdown(
                            labelText: 'Supplies/ DME',
                            items: ['Option 1', 'Option 2', 'Option 3'],
                            onChanged: (newValue) {
                              setState(() {
                                dmeSupplies = newValue;
                              });
                            },
                          )),
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
                                    Icons.calendar_month_outlined,
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
                              child: SchedularDropdown(
                            labelText: 'Pharmacy',
                            items: ['Option 1', 'Option 2', 'Option 3'],
                            onChanged: (newValue) {
                              setState(() {
                                pharmacydd = newValue;
                              });
                            },
                          )),
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
                              child: SchedularTextField(
                                  controller: pharmacycity, labelText: 'City')),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                  controller: pharmacystate,
                                  labelText: 'State')),
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
                                    Icons.calendar_month_outlined,
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
