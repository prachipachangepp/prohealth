
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../app/resources/const_string.dart';
import '../../../taxtfield_constant.dart';

class ReferencesScreen extends StatefulWidget {
  const ReferencesScreen({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  State<ReferencesScreen> createState() => _ReferencesScreenState();
}

class _ReferencesScreenState extends State<ReferencesScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Center(
              child: Text(
                AppString.references,
                style: GoogleFonts.firaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff50B5E5)),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 60),
            Container(
              width: 952,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Color(0xFFE6F7FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Please provide the names and contact information of three professional references who can speak to your work experience and qualifications. For each\n reference, Kindly include the following information:',
                          style: GoogleFonts.firaSans(
                            color: Color(0xFF686464),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 166.0, right: 166),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'References # 1',
                      style: GoogleFonts.firaSans(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff686464)),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height / 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppString.name,
                                style: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff686464)),
                              ),
                              SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height /
                                      60),
                              CustomTextFieldRegister(
                                hintText: 'Enter Text',
                                hintStyle: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B9B9B),
                                ),
                                height: 32,
                              ),
                              SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height /
                                      40),
                              Text(
                                AppString.title_position,
                                style: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff686464)),
                              ),
                              SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height /
                                      60),
                              CustomTextFieldRegister(
                                hintText: 'Enter Text',
                                hintStyle: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B9B9B),
                                ),
                                height: 32,
                              ),
                              SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height /
                                      30),
                              Text(
                                AppString.company_organization,
                                style: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff686464)),
                              ),
                              SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height /
                                      60),
                              CustomTextFieldRegister(
                                hintText: 'Enter Text',
                                hintStyle: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B9B9B),
                                ),
                                height: 32,
                              ),
                              SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height /
                                      30),
                              Text(
                                AppString.mobile_number,
                                style: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff686464)),
                              ),
                              SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height /
                                      60),
                              CustomTextFieldRegister(
                                hintText: 'Enter Text',
                                hintStyle: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B9B9B),
                                ),
                                height: 32,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            width:
                            MediaQuery.of(context).size.width / 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppString.email,
                                style: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff686464)),
                              ),
                              SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height /
                                      60),
                              CustomTextFieldRegister(
                                hintText: 'Enter Text',
                                hintStyle: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B9B9B),
                                ),
                                height: 32,
                              ),
                              SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height /
                                      60),
                              Text(
                                AppString.how_do_you_know_this_person,
                                style: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff686464)),
                              ),
                              SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height /
                                      60),
                              CustomTextFieldRegister(
                                hintText: 'Enter Text',
                                hintStyle: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B9B9B),
                                ),
                                height: 32,
                              ),
                              SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height /
                                      60),
                              Text(
                                AppString.length_of_association,
                                style: GoogleFonts.firaSans(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff686464)),
                              ),
                              SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height /
                                      60),
                              CustomTextFieldRegister(
                                hintText: 'Enter Text',
                                hintStyle: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B9B9B),
                                ),
                                height: 32,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height / 20),
                    Text(
                      'Please ensure that the references you provide are professional contacts who can provide insight into \n your skills, work ethic, and character ',
                      style: GoogleFonts.firaSans(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff686464)),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height / 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            // Handle add education action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff50B5E5),
                            // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          icon: Icon(Icons.add, color: Colors.white),
                          label: Text(
                            AppString.add_education,
                            style: GoogleFonts.firaSans(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
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
    );
  }
}