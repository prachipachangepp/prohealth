import 'package:flutter/material.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_plan_care/plane_container_box.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_patients_data/widgets/patients_plan_care/planer_notifier.dart';
import 'package:prohealth/presentation/widgets/widgets/constant_textfield/const_textfield.dart';
import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../../app/services/api/managers/establishment_manager/all_from_hr_manager.dart';
import '../../../../../../../../app/services/api/managers/establishment_manager/ci_visit_manager.dart';
import '../../../../../../../../data/api_data/establishment_data/all_from_hr/all_from_hr_data.dart';
import '../../../../../../../../data/api_data/establishment_data/company_identity/ci_visit_data.dart';
import '../patients_compliance/widget/compliance_add_popup.dart';
import 'package:provider/provider.dart';

class IntakePlanCareScreen extends StatefulWidget {
  final int patientId;

  const IntakePlanCareScreen({super.key, required this.patientId});

  @override
  State<IntakePlanCareScreen> createState() => _IntakePlanCareScreenState();
}

class _IntakePlanCareScreenState extends State<IntakePlanCareScreen> {
  List<Map<String, dynamic>> containers = [];
  String? _selectedClinician;

  @override
  void initState() {
    super.initState();
  }

  void addContainer() {
    setState(() {
      containers.add({
        'clinician': _selectedClinician,
        'weeks': [{'week': 'Week 1', 'visits': ''}],
      });
    });
  }

  void addWeek(int index) {
    setState(() {
      containers[index]['weeks'].add({
        'week': 'Week ${containers[index]['weeks'].length + 1}',
        'visits': '',
      });
    });
  }

  Future<void> _showAddClinicianDialog() async {
    final deptId = 1; // Replace with your actual deptId

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              backgroundColor: ColorManager.white,
              titlePadding: EdgeInsets.zero,
              title: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFB1B1B1), width: 1),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(
                          12,
                        ),
                        topLeft: Radius.circular(
                          12,
                        ),
                      ),
                      color: Color(0xff50B5E5),
                    ),
                    height: AppSize.s40,
                     width: 308,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            'Add Clinician',
                            style: CustomTextStylesCommon.commonStyle(
                              fontSize: FontSize.s14,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.white,
                            ),
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            color: ColorManager.white,
                          ),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              content: Container(
                height: 40,
                child: FutureBuilder<List<HRAllData>>(
                  future: getAllHrDeptWise(context, deptId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CustomDropDownPOC(
                        labelText: 'Select Clinician',
                        items: ['Loading...'],
                        onChanged: null,
                      );
                    } else if (snapshot.hasError) {
                      return Container(
                          height: 200,
                          // width: 200,
                          child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.data!.isEmpty) {
                      return Container(
                          height: 200,
                          // width: 200,
                          child: Text('No data available'));
                    } else if(snapshot.hasData){

                      List<String> abbreviations = snapshot.data!
                          .map((data) => data.abbrivation)
                          .where((abbr) => abbr != null)
                          .cast<String>()
                          .toList();

                      return CustomDropDownPOC(
                        labelText: 'Select Clinician',
                        items: abbreviations,
                        value: _selectedClinician,
                        onChanged: (value) {
                          setState(() {
                            _selectedClinician = value;
                          });
                        },
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
              actions: [
               Padding(
                 padding: const EdgeInsets.only(
                   bottom: 30
                 ),
                 child: Center(
                   child: CustomButton(
                     height: 30,
                     width: 100,
                     text: 'Submit',
                     onPressed: () {
                     if (_selectedClinician != null) {
                       addContainer();
                       Navigator.pop(context);
                     }
                   },),
                 ),
               )
              ],
            );
          },
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(right: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Completed',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff008000),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 60),
                  Container(
                    height: 32,
                    width: 128,
                    child: ElevatedButton.icon(
                      onPressed: _showAddClinicianDialog,
                      icon: Icon(Icons.add, color: Colors.white, size: 20),
                      label: Text(
                        'Add Clinician',
                        style: CustomTextStylesCommon.commonStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF50B5E5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
              children: containers.asMap().entries.map((entry) {
                int index = entry.key;
                var container = entry.value;
                return Container(
                  width: 270,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: ContainerWidget(
                      clinician: container['clinician'],
                      weeks: container['weeks'],
                      onAddWeek: () => addWeek(index),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class ContainerWidget extends StatelessWidget {
  final String? clinician;
  final List<Map<String, String>> weeks;
  final VoidCallback onAddWeek;

  const ContainerWidget({
    Key? key,
    required this.clinician,
    required this.weeks,
    required this.onAddWeek,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 246,
      width: 300,

      padding: EdgeInsets.all(10),
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
          Row(
            children: [
              Text(
                clinician ?? 'Select a Clinician',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff686464),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: weeks.length,
              itemBuilder: (context, index) {
                final week = weeks[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          week['week']!,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff686464),
                          ),
                        ),
                        SizedBox(width: 50),
                        Flexible(
                          child: PlanOfCareTextField(
                            labelText: 'Visits',
                            initialValue: week['visits']!,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 32,
                width: 112,
                child: ElevatedButton.icon(
                  onPressed: onAddWeek,
                  icon: Icon(Icons.add, color: Colors.white, size: 20),
                  label: Text(
                    'Add Week',
                    style: CustomTextStylesCommon.commonStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF50B5E5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Week {
  final String weekNumber;
  String initialValue;

  Week({
    required this.weekNumber,
    required this.initialValue,
  });
}

class PlanOfCareTextField extends StatelessWidget {
  final String labelText;
  final String initialValue;

  PlanOfCareTextField({
    super.key,
    required    this.labelText,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.38,
      width: 118,
      child: TextFormField(
        initialValue: initialValue,
        style: CustomTextStylesCommon.commonStyle(
          fontSize: AppSize.s12,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: CustomTextStylesCommon.commonStyle(
            fontSize: AppSize.s10,
            color: ColorManager.greylight,
          ),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0XFFB1B1B1)), //  border color
          ),
        ),
      ),
    );
  }
}

class CustomDropDownPOC extends StatefulWidget {
  final String labelText;
  final String? hintText;
  final TextStyle? hintStyle;
  final List<String> items;
  final String? value;
  final void Function(String?)? onChanged;

  const CustomDropDownPOC({
    Key? key,
    required this.labelText,
    required this.items,
    this.hintText,
    this.hintStyle,
    this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  _CustomDropDownPOCState createState() => _CustomDropDownPOCState();
}

class _CustomDropDownPOCState extends State<CustomDropDownPOC> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 31, // Customize height if needed
      child:
      DropdownButtonFormField<String>(
        iconEnabledColor: Color(0xff50B5E5),
        iconDisabledColor: Color(0xff50B5E5),
        dropdownColor: Colors.white,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          hintStyle: widget.hintStyle ?? CustomTextStylesCommon.commonStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xff575757),
          ),
          labelStyle: CustomTextStylesCommon.commonStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: Color(0xff575757),
          ),
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Color(0xffB1B1B1),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Color(0xffB1B1B1),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Color(0xffB1B1B1),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        ),
        items: widget.items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: CustomTextStylesCommon.commonStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xff575757),
              ),
            ),
          );
        }).toList(),
        onChanged: widget.onChanged,
        value: widget.items.contains(widget.value) ? widget.value : null, // Ensure valid value
        isExpanded: true,
      )

      ///

      // DropdownButtonFormField<String>(
      //   iconEnabledColor: Color(0xff50B5E5),
      //   iconDisabledColor: Color(0xff50B5E5),
      //   dropdownColor: Colors.white,
      //   decoration: InputDecoration(
      //     labelText: widget.labelText,
      //     hintText: widget.hintText,
      //     hintStyle: widget.hintStyle ?? GoogleFonts.firaSans(
      //       fontSize: 12,
      //       fontWeight: FontWeight.w400,
      //       color: Color(0xff575757),
      //     ),
      //     labelStyle: GoogleFonts.firaSans(
      //       fontSize: 10,
      //       fontWeight: FontWeight.w400,
      //       color: Color(0xff575757),
      //     ),
      //     fillColor: Colors.white,
      //     filled: true,
      //     enabledBorder: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(5.0),
      //       borderSide: BorderSide(
      //         color: Color(0xffB1B1B1),
      //       ),
      //     ),
      //     focusedBorder: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(5.0),
      //       borderSide: BorderSide(
      //         color: Color(0xffB1B1B1),
      //       ),
      //     ),
      //     border: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(5.0),
      //       borderSide: BorderSide(
      //         color: Color(0xffB1B1B1),
      //       ),
      //     ),
      //     contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      //   ),
      //   items: widget.items.map((String value) {
      //     return DropdownMenuItem<String>(
      //       value: value,
      //       child: Text(
      //         value,
      //         style: GoogleFonts.firaSans(
      //           fontSize: 12,
      //           fontWeight: FontWeight.w400,
      //           color: Color(0xff575757),
      //         ),
      //       ),
      //     );
      //   }).toList(),
      //   onChanged: widget.onChanged,
      //   value: widget.value,
      //   isExpanded: true,
      // ),
    );
  }
}
