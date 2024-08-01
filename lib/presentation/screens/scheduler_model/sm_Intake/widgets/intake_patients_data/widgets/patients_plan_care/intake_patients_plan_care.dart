import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/value_manager.dart';

class IntakePlanCareScreen extends StatefulWidget {
  const IntakePlanCareScreen({super.key});

  @override
  State<IntakePlanCareScreen> createState() => _IntakePlanCareScreenState();
}

class _IntakePlanCareScreenState extends State<IntakePlanCareScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(right: 160.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Completed',
                    style: GoogleFonts.firaSans(
                        decoration: TextDecoration.none,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffFFA500)),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 60),
                  Container(
                    height: 32,
                    width: 128,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // showDialog(
                        //   context: context,
                        //   builder: (BuildContext context) {
                        //     return ClinicianAddPopUp();
                        //   },
                        // );
                      },
                      icon: Icon(Icons.add,
                          color: Colors.white, size: AppSize.s20),
                      label: Text(
                        'Add Clinician',
                        style: GoogleFonts.firaSans(
                          color: Colors.white,
                          fontSize: AppSize.s12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF50B5E5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Container(
                    height: 246,
                    width: 295,
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
                        Row(
                          children: [
                            Text(
                              'PT',
                              style: TextStyle(
                                  fontSize: AppSize.s12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff686464)),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'Week 1',
                              style: TextStyle(
                                  fontSize: AppSize.s10,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff686464)),
                            ),
                            SizedBox(width: 50),
                            Flexible(
                                child: PlanOfCareTextField(
                                  labelText: 'Visits',
                                  initialValue: '2',
                                )),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              'Week 2',
                              style: TextStyle(
                                  fontSize: AppSize.s10,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff686464)),
                            ),
                            SizedBox(width: 50),
                            Flexible(
                                child: PlanOfCareTextField(
                                  labelText: 'Visits',
                                  initialValue: '3',
                                )),
                          ],
                        ),
                        SizedBox(height: 40,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 32,
                              width: 112,
                              child: ElevatedButton.icon(
                                onPressed: () {

                                },
                                icon: Icon(Icons.add,color: Colors.white, size: AppSize.s20),
                                label: Text(
                                  'Add Week',
                                  style: GoogleFonts.firaSans(
                                    color: Colors.white,
                                    fontSize: AppSize.s12,
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
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 246,
                    width: 295,
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
                        Row(
                          children: [
                            Text(
                              'OT',
                              style: TextStyle(
                                  fontSize: AppSize.s12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff686464)),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              'Week 1',
                              style: TextStyle(
                                  fontSize: AppSize.s10,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff686464)),
                            ),
                            SizedBox(width: 50),
                            Flexible(
                                child: PlanOfCareTextField(
                                  labelText: 'Visits',
                                  initialValue: '2',
                                )),
                          ],
                        ),
                        SizedBox(height: 80,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 32,
                              width: 112,
                              child: ElevatedButton.icon(
                                onPressed: () {

                                },
                                icon: Icon(Icons.add,color: Colors.white, size: AppSize.s20),
                                label: Text(
                                  'Add Week',
                                  style: GoogleFonts.firaSans(
                                    color: Colors.white,
                                    fontSize: AppSize.s12,
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
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PlanOfCareTextField extends StatelessWidget {
  final String labelText;
  final String? initialValue;

  PlanOfCareTextField({
    super.key,
    required this.labelText,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.38,
      width: 118,
      child: TextFormField(
        initialValue: initialValue,
        style: GoogleFonts.firaSans(
          fontSize: AppSize.s12,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.firaSans(
            fontSize: AppSize.s10,
            color: ColorManager.greylight, // label text color
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
