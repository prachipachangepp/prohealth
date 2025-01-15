import 'package:flutter/material.dart';

import '../../../../app/resources/color.dart';
import '../../../../app/resources/font_manager.dart';
import '../../../../app/resources/theme_manager.dart';

class PatientChartScreen extends StatefulWidget {
  const PatientChartScreen({super.key});

  @override
  State<PatientChartScreen> createState() => _PatientChartScreenState();
}

class _PatientChartScreenState extends State<PatientChartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // This Row will have a height of 100
          Container(
            height: 100,
           // color: Colors.blue,  // Set color for the top row
            child: Row(
              children: [
                Container(
                  width: 450,
                  //height: 200, // Height is also needed for a circular shape
                  decoration: BoxDecoration(
                    color: Color(0xFFB1D6F4), // Background color
                    borderRadius: BorderRadius.circular(10), // Rounded border (half of the width for a circle)
                  ),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: SizedBox(
                                width: 60,
                                height: 60,
                                child: Image.asset(
                                  'images/hr_dashboard/man.png', // Replace with your image path
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15),
Text("JOHN SCOTT", style: CustomTextStylesCommon.commonStyle(fontSize: FontSize.s14,
  fontWeight: FontWeight.w600,
  color: ColorManager.textBlack,),),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("DOB", style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                                    fontWeight: FontWeight.w500,
                                    color: ColorManager.mediumgrey,),),
                                  SizedBox(height: 10),
                                  Text("Chart Number", style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                                    fontWeight: FontWeight.w500,
                                    color: ColorManager.mediumgrey,) ),
                                ],
                              ),
                              //SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("08-03-1997 (27)", style: CustomTextStylesCommon.commonStyle(fontSize: FontSize.s12,
                                    fontWeight: FontWeight.w600,
                                    color: ColorManager.textBlack,),),
                                  SizedBox(height: 10),
                                  Text("123456", style: CustomTextStylesCommon.commonStyle(fontSize: FontSize.s12,
                                    fontWeight: FontWeight.w600,
                                    color: ColorManager.textBlack,),),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      // Add your widgets here
                    ],
                  ),
                )

              ],
            ),
          ),
          SizedBox(height: 10),
          // This SingleChildScrollView will make the container scrollable
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: Row(
                  children: [
                    // First Column with flex: 2
                    Expanded(
                      flex: 3,
                      child: Container(
                        color: Color(0xFF51B5E6),  // Color to identify this column
                        child: Column(
                          children: [
                            Text('Column 1', style: TextStyle(color: Colors.white)),
                            SizedBox(
                              height: 500,
                            )
                          ],
                        ),
                      ),
                    ),
                    // Second Column with remaining space
                    Expanded(
                      flex: 7,
                      child: Container(
                        color: Colors.white,  // Color to identify this column
                        child: Column(
                          children: [
                            Text('Column 2', style: TextStyle(color: Colors.white)),
                            SizedBox(
                              height: 500,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
}
}
