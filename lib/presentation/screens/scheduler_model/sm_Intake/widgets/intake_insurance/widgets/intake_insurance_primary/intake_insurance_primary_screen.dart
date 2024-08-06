import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/const_string.dart';
import '../../../../../../../../app/resources/font_manager.dart';
import '../../../intake_patients_data/widgets/patients_info/intake_patients_info.dart';

class IntakeInsurancePrimaryScreen extends StatefulWidget {
  const IntakeInsurancePrimaryScreen({super.key});

  @override
  State<IntakeInsurancePrimaryScreen> createState() => _IntakeInsurancePrimaryScreenState();
}

class _IntakeInsurancePrimaryScreenState extends State<IntakeInsurancePrimaryScreen> {
  String? status = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              child: SchedularTextField(
                                  labelText: 'Primary Insurance')
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText: 'Name')
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText: 'Street')
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText: 'Code')
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                  labelText: 'Suite/Apt #')
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText:'City')
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                labelText: 'State',)
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText:'Zip Code')
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                  labelText:'Type')
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText:'Phone')
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularDropdown(
                                labelText: 'Category', )
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText:'Authorisation')
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularTextField(
                                  labelText: 'Effective from', isDate: true)
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText:'Group #')
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText: 'Group Name')
                          ),
                          SizedBox(width: 35),
                          Flexible(
                              child: SchedularTextField(
                                  labelText:'Policy/ HIC #')
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Flexible(
                              child: SchedularDropdown(
                                labelText: 'Eligibility Status', )
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Insurance Verified',
                                    style: GoogleFonts.firaSans(
                                        color: ColorManager.lightgreyheading,
                                        fontSize: FontSize.s10, fontWeight: FontWeightManager.regular)
                                ),
                                SizedBox(height: 1),
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'Yes',
                                      groupValue: status,
                                      onChanged: (value) => setState(() => status = value),
                                    ),
                                    Text('Yes',
                                        style: GoogleFonts.firaSans(
                                            fontSize: FontSize.s12
                                            , fontWeight: FontWeightManager.regular)
                                    ),
                                    SizedBox(width: MediaQuery.of(context).size.width/100),
                                    Radio<String>(
                                      value: 'No',
                                      groupValue: status,
                                      onChanged: (value) => setState(() => status = value),
                                    ),
                                    Text('No',
                                        style: GoogleFonts.firaSans(
                                            fontSize: FontSize.s12
                                            , fontWeight: FontWeightManager.regular)
                                    ),
                                    SizedBox(width: MediaQuery.of(context).size.width/100),
                                    TextButton(
                                      onPressed: () => setState(() => status = null), // Clear selection
                                      child: Text(
                                        'Clear',
                                        style: GoogleFonts.firaSans(
                                            fontSize: MediaQuery.of(context).size.width * 0.008,
                                            fontWeight: FontWeightManager.regular,
                                            color: ColorManager.lightgreyheading
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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

    Future<void> _selectDateRange(BuildContext context) async {
      DateTimeRange? selectedDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        initialDateRange: DateTimeRange(
          start: DateTime.now(),
          end: DateTime.now().add(Duration(days: 1)),
        ),
      );

      if (selectedDateRange != null) {
        _dateController.text =
        "${DateFormat('yyyy-MM-dd').format(selectedDateRange.start)}    to   ${DateFormat('yyyy-MM-dd').format(selectedDateRange.end)}";
      }
    }

    return SizedBox(
      height: 25.38,
      child: TextFormField(
        controller: isDate ? _dateController : TextEditingController(text: initialValue),
        style: GoogleFonts.firaSans(
          fontSize: FontSize.s12,
          fontWeight: FontWeightManager.regular,
          color: ColorManager.black,
        ),
        cursorColor: ColorManager.black,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.firaSans(
            fontSize: FontSize.s10,
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
          await _selectDateRange(context);
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
          fontSize: FontSize.s12,
          fontWeight: FontWeightManager.regular,
          color: ColorManager.black,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.firaSans(
            fontSize: FontSize.s10,
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
          size: FontSize.s24, // size of icon
        ),
        isDense: false, // Adjust the density of the dropdown
      ),
    );
  }
}
