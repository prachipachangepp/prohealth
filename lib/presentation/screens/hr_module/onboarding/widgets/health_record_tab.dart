import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/value_manager.dart';

class HealthRecordTab extends StatelessWidget {
  const HealthRecordTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p80, vertical: AppPadding.p40),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: AppSize.s181,
                  width: MediaQuery.of(context).size.width / 70,
                  padding: EdgeInsets.symmetric(vertical: AppPadding.p10),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 81.0),
                  child: Container(
                    height: 64,
                    width: 145,
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: Color(0xffC6C6C6)),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                          child: Container(
                            height: 44.0,
                            width: 44.0,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffC6C6C6)),
                            ),
                            child: Icon(Icons.description_outlined),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Physical Exam',
                              style: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            Text(
                              '2023-08-17',
                              style: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w300
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 30),
                Container(
                  height: 64,
                  width: 145,
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Color(0xffC6C6C6)),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                        child: Container(
                          height: 44.0,
                          width: 44.0,
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffC6C6C6)),
                          ),
                          child: Icon(Icons.description_outlined),
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'TB',
                            style: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          Text(
                            '2023-08-17',
                            style: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w300
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Container(
                  height: AppSize.s181,
                  width: MediaQuery.of(context).size.width / 70,
                  padding: EdgeInsets.symmetric(vertical: AppPadding.p10),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 81.0),
                  child: Container(
                    height: 64,
                    width: 145,
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: Color(0xffC6C6C6)),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                          child: Container(
                            height: 44.0,
                            width: 44.0,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffC6C6C6)),
                            ),
                            child: Icon(Icons.description_outlined),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'MMR Vaccine',
                              style: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            Text(
                              '2023-08-17',
                              style: GoogleFonts.firaSans(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w300
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 30),
                Container(
                  height: 64,
                  width: 145,
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Color(0xffC6C6C6)),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                        child: Container(
                          height: 44.0,
                          width: 44.0,
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffC6C6C6)),
                          ),
                          child: Icon(Icons.description_outlined),
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Covid Vaccine',
                            style: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          Text(
                            '2023-08-17',
                            style: GoogleFonts.firaSans(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w300
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
