import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../em_dashboard_const.dart';

class OfficeClinicianConst extends StatelessWidget {
  const OfficeClinicianConst({super.key});

  @override
  Widget build(BuildContext context) {
    return EMDashboardContainerConst(
        height: 150,
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello',
                  style: CustomTextStylesCommon.commonStyle(
                      fontSize: 23,
                      color: ColorManager.bluebottom,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  '“ Enjoy Your life, We’ll Be Here to\nSave it.”',
                  style: CustomTextStylesCommon.commonStyle(
                      fontSize: 14,
                      color: ColorManager.mediumgrey,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: Image.asset(
                      "images/em_dashboard/office_clinician.png",
                      fit: BoxFit.contain,
                    )),
              ],
            )
          ]),
        ));
  }
}

///average clinician listview
class AverageClinicianListview extends StatelessWidget {
  const AverageClinicianListview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Average Clinicians Tenure per Office',style: CustomTextStylesCommon.commonStyle(
                  color: ColorManager.mediumgrey,
                  fontSize: FontSize.s16,
                  fontWeight: FontWeight.w700)),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "View More",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.bluebottom,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],),
          ///heading
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: AppSize.s30,
                  // margin: EdgeInsets.symmetric(horizontal: 48,vertical: 10),
                  padding: EdgeInsets.only(left: 10,right: 12),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: ColorManager.black.withOpacity(.02),
                          blurRadius: 4,
                          spreadRadius: 0,
                          offset: Offset(0, 2))
                    ],
                    color: ColorManager.dashBlueHead,

                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sr. No.",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.mediumgrey,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: Text(
                          "Clinician Name",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: FontSize.s12,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.mediumgrey,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      Text(
                        "Tenure (YRS)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.mediumgrey,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          "Start Year",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: FontSize.s12,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.mediumgrey,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      Text(
                        "Order Quantity",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.mediumgrey,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: AppSize.s30,
                ),
              ),
            ],
          ),
          ///data
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: 210,
                 // width: 500,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      //int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                      // String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                      // EmployeeDocumentModal employeedoc = paginatedData[index];
                      return Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: AppSize.s44,
                            padding: EdgeInsets.only(left: AppPadding.p20),
                            //margin: EdgeInsets.symmetric(horizontal: AppMargin.m2),
                            decoration: BoxDecoration(
                              color: ColorManager.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(width: 1, color: Color(0xFFE9E9E9)),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorManager.black.withOpacity(0.1),
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "01",
                                    textAlign: TextAlign.start,
                                    style: CustomTextStylesCommon.commonStyle(
                                      fontSize: FontSize.s12,
                                      fontWeight: FontWeight.w400,
                                      color: ColorManager.black,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex:2,
                                  child: Text(
                                    "Clinician 1",
                                    textAlign: TextAlign.start,
                                    style: CustomTextStylesCommon.commonStyle(
                                      fontSize: FontSize.s12,
                                      fontWeight: FontWeight.w400,
                                      color: ColorManager.black,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex:1,
                                  child: Text(
                                    "5",
                                    textAlign: TextAlign.start,
                                    style: CustomTextStylesCommon.commonStyle(
                                      fontSize: FontSize.s12,
                                      fontWeight: FontWeight.w400,
                                      color: ColorManager.black,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex:1,
                                  child: Text(
                                    "2019",
                                    textAlign: TextAlign.start,
                                    style: CustomTextStylesCommon.commonStyle(
                                      fontSize: FontSize.s12,
                                      fontWeight: FontWeight.w400,
                                      color: ColorManager.black,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex:1,
                                  child: Text(
                                    "100",
                                    textAlign: TextAlign.center,
                                    style: CustomTextStylesCommon.commonStyle(
                                      fontSize: FontSize.s12,
                                      fontWeight: FontWeight.w400,
                                      color: ColorManager.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Container(
                        height: 35,
                      decoration: BoxDecoration(
                        color: ColorManager.dashBlueHead,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(6),topRight: Radius.circular(6))
                      ),
                      child:  Center(
                        child: Text('Average Tenure (Years)',style: CustomTextStylesCommon.commonStyle(
                            color: ColorManager.mediumgrey,
                            fontSize: FontSize.s14,
                            fontWeight: FontWeight.w600)),
                      ),),
                      Container(height: 125,
                        decoration: BoxDecoration(
                            color: ColorManager.white,
                            border: Border(top: BorderSide.none,bottom: BorderSide(color: ColorManager.blueBorder,width: 1),
                            left: BorderSide(color: ColorManager.blueBorder,width: 1),right: BorderSide(color: ColorManager.blueBorder,width: 1)),
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(6),bottomLeft: Radius.circular(6))
                        ),
                        child: Center(
                          child: RichText(
                              text: TextSpan(
                                text: '5',
                                style:  CustomTextStylesCommon.commonStyle(
                                    color: ColorManager.mediumgrey,
                                    fontSize: FontSize.s30,
                                    fontWeight: FontWeight.w700),
                                children: [
                                  TextSpan(
                                    text: 'yrs',
                                    style: CustomTextStylesCommon.commonStyle(
                                        color: ColorManager.mediumgrey,
                                        fontSize: FontSize.s14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                                                ),
                        ),
                      )],
                  ))
            ],
          )
        ],
      ),
    );
  }
}


///office with highest patients listview
class OfficeHighestPatientList extends StatelessWidget {
  const OfficeHighestPatientList({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Office With Highest Patients',style: CustomTextStylesCommon.commonStyle(
                  color: ColorManager.mediumgrey,
                  fontSize: FontSize.s14,
                  fontWeight: FontWeight.w700)),
            ],),
          SizedBox(height: 20,),
          Container(
            height: AppSize.s30,
            // margin: EdgeInsets.symmetric(horizontal: 48,vertical: 10),
            padding: EdgeInsets.only(left: 10,right: 10),
            // decoration: BoxDecoration(
            //   boxShadow: [
            //     BoxShadow(
            //         color: ColorManager.black.withOpacity(.02),
            //         blurRadius: 4,
            //         spreadRadius: 0,
            //         offset: Offset(0, 2))
            //   ],
            //   color: ColorManager.dashBlueHead,
            //
            //   borderRadius: BorderRadius.circular(12),
            // ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "No. of Offices",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.mediumgrey,
                    decoration: TextDecoration.none,
                  ),
                ),
               Expanded(flex:1 ,child: Container()),
                Padding(
                  padding: const EdgeInsets.only(right: 80.0),
                  child: Text(
                    "Ratio",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.mediumgrey,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                SizedBox(width: 30,),
                Padding(
                  padding: const EdgeInsets.only(right: 40.0),
                  child: Text(
                    "Count",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.mediumgrey,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 15,
              itemBuilder: (context, index) {
                //int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                // String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                // EmployeeDocumentModal employeedoc = paginatedData[index];
                return Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: AppSize.s44,
                      padding: EdgeInsets.only(left: AppPadding.p20),
                      //margin: EdgeInsets.symmetric(horizontal: AppMargin.m2),
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1, color: Color(0xFFE9E9E9)),
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.black.withOpacity(0.1),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex:1,
                            child: Text(
                              "Office 1",
                              textAlign: TextAlign.start,
                              style: CustomTextStylesCommon.commonStyle(
                                fontSize: FontSize.s12,
                                fontWeight: FontWeight.w400,
                                color: ColorManager.black,
                              ),
                            ),
                          ),
                          Expanded(
                              flex:2,
                              child:  LinearProgressIndicator(
                                backgroundColor: ColorManager.grey,
                                color: ColorManager.pieChartYellow,
                                value: 55/100,//.totalVal/100
                                minHeight: 10,
                                borderRadius: BorderRadius.circular(30),
                              )
                          ),
                          //SizedBox(width: 20,),
                          Expanded(
                            flex:1,
                            child: Text(
                              "55%",
                              textAlign: TextAlign.center,
                              style: CustomTextStylesCommon.commonStyle(
                                fontSize: FontSize.s12,
                                fontWeight: FontWeight.w400,
                                color: ColorManager.black,
                              ),
                            ),
                          ),
                          Expanded(
                            flex:1,
                            child: Text(
                              "1000",
                              textAlign: TextAlign.center,
                              style: CustomTextStylesCommon.commonStyle(
                                fontSize: FontSize.s12,
                                fontWeight: FontWeight.w400,
                                color: ColorManager.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),)
        ],
      ),
    );
  }
}

///clinician attendance
class AttendanceRatioConst extends StatelessWidget {
  final String officeName;
  final String attendance;
  final Color containerColor;
  const AttendanceRatioConst({super.key, required this.officeName, required this.attendance, required this.containerColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Container(
              width: 10.0,
              height: 15.0,
              decoration: BoxDecoration(
                color: containerColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 10,),
            Text(officeName,style: CustomTextStylesCommon.commonStyle(
                color:  ColorManager.black,
                fontSize: FontSize.s12,
                fontWeight: FontWeight.w500),),
          ],
        ),
        SizedBox(width: 10,),
        Text(attendance,style: CustomTextStylesCommon.commonStyle(
            color:  ColorManager.black,
            fontSize: FontSize.s12,
            fontWeight: FontWeight.w500),)
      ],
    );
  }
}

///popup
class OfficeClinicianPopup extends StatelessWidget {
  const OfficeClinicianPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 220,
        width: 400,
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Text('Customer Satisfaction Rating',
            style: CustomTextStylesCommon.commonStyle(
                color: ColorManager.mediumgrey,
                fontSize: FontSize.s14,
                fontWeight: FontWeight.w700),),
            SizedBox(height: 20,),
            ///heading
            Container(
              height: AppSize.s30,
              // margin: EdgeInsets.symmetric(horizontal: 48,vertical: 10),
              padding: EdgeInsets.only(left: 10,right: 12),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: ColorManager.mediumgrey.withOpacity(0.2),
                      blurRadius: 4,
                      spreadRadius: 0,
                      offset: Offset(0, 2))
                ],
                color: Color(0xFFC77AC4).withOpacity(0.74),

                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Customer",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Text(
                    "Satisfaction Rating",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: Container(
                height: 280,
                // width: 500,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    //int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                    // String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                    // EmployeeDocumentModal employeedoc = paginatedData[index];
                    double rating = 4.5 - (index % 2) * 0.5;
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Customer ${index + 1}",
                                textAlign: TextAlign.start,
                                style: CustomTextStylesCommon.commonStyle(
                                  fontSize: FontSize.s12,
                                  fontWeight: FontWeight.w400,
                                  color: ColorManager.black,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: RatingStars(
                                value: rating,
                                starCount: 5,
                                starSize: 18,
                                maxValue: 5,
                                starSpacing: 2,
                                maxValueVisibility: false,
                                valueLabelVisibility: false,
                                starOffColor: ColorManager.grey, // Unselected stars
                                starColor: Colors.orange, // Selected stars
                              ),
                            ),
                            Expanded(
                              flex:1,
                              child: Text(
                                "5",
                                textAlign: TextAlign.center,
                                style: CustomTextStylesCommon.commonStyle(
                                  fontSize: FontSize.s12,
                                  fontWeight: FontWeight.w400,
                                  color: ColorManager.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider()
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
