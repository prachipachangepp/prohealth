import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/const_string.dart';
import '../../../../../../../../app/resources/font_manager.dart';
import '../../../intake_patients_data/widgets/patients_info/intake_patients_info.dart';

class IntakePharmacyVendorScreen extends StatefulWidget {
  const IntakePharmacyVendorScreen({super.key});

  @override
  State<IntakePharmacyVendorScreen> createState() => _IntakePharmacyVendorScreenState();
}

class _IntakePharmacyVendorScreenState extends State<IntakePharmacyVendorScreen> {

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
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.greenDark
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
                                  labelText: 'Supplies/ DME', )
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: Container()),
                          SizedBox(width: 35),
                          Flexible(
                              child: Container()),
                          SizedBox(width: 35),
                          Flexible(
                              child: Container()),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                  labelText: 'Contact')
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText:'Phone')
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText: 'Deliver by', isDate: true)
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText:'Fax')
                          ),
                      ],
                      ),
                      SizedBox(height: 32),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularDropdown(
                                  labelText: 'Pharmacy',)
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: Container()),
                          SizedBox(width: 35),
                          Flexible(
                              child: Container()),
                          SizedBox(width: 35),
                          Flexible(
                              child: Container()),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                  labelText: 'Contact')
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText:'Phone')
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText: 'Address')
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText:'City')
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                  labelText: 'State')
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText:'Zip Code')
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText: 'Deliver by', isDate: true)
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText:'Fax')
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Flexible(
                              child: Container(
                                height: 99,
                                child: TextFormField(
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

class SchedularTextField extends StatelessWidget {
  final String labelText;
  final String? initialValue;
  final bool isDate;

  SchedularTextField({
    Key? key,
    required this.labelText,
    this.initialValue,
    this.isDate = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _dateController = TextEditingController(text: initialValue);

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );

      if (selectedDate != null) {
        _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      }
    }

    return SizedBox(
      height: 25.38,
      child: TextFormField(
        controller: isDate ? _dateController : TextEditingController(text: initialValue),
        style: GoogleFonts.firaSans(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: ColorManager.black,
        ),
        cursorColor: ColorManager.black,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.firaSans(
            fontSize: 10,
            color: ColorManager.greylight, // label text color
          ),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0XFFB1B1B1)), // border color
          ),
          suffixIcon: isDate
              ? Icon(Icons.calendar_month_outlined, color: ColorManager.blueprime) // calendar color
              : null,
        ),
        readOnly: isDate,
        onTap: isDate
            ? () async {
          await _selectDate(context);
        }
            : null,
      ),
    );
  }
}

class SchedularDropdown extends StatelessWidget {
  final String labelText;
  final String? initialValue;

  const SchedularDropdown({
    super.key,
    required this.labelText,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.38, // DROPDOWN CONTAINER HEIGHT
      child: DropdownButtonFormField<String>(
        value: initialValue,
        style: GoogleFonts.firaSans(
          fontSize: 12,
          fontWeight: FontWeightManager.regular,
          color: ColorManager.black,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.firaSans(
            fontSize: 10,
            fontWeight: FontWeightManager.regular,
            color: ColorManager.greylight, // text color in dropdown
          ),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0XFFB1B1B1)), // border color
          ),
        ),
        items: [initialValue ?? '']
            .map((value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ))
            .toList(),
        onChanged: (value) {
          // Handle dropdown change
        },
        icon: Icon(
          Icons.arrow_drop_down,
          color: ColorManager.blueprime, // dropdown icon color
          size: 24, // size of icon
        ),
        isDense: false, // Adjust the density of the dropdown
      ),
    );
  }
}
