import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/dialogue_template.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../em_dashboard_const.dart';

class OfficeLocationConst extends StatelessWidget {
  const OfficeLocationConst({super.key});

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
                  '“Locate, Elevate, Participate.”',
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
                  "images/em_dashboard/office_location.png",
                  fit: BoxFit.contain,
                )),
              ],
            )
          ]),
        ));
  }
}

/// listview head
class OfficeEquipmentHead extends StatelessWidget {
  const OfficeEquipmentHead({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s30,
      // margin: EdgeInsets.symmetric(horizontal: 48,vertical: 10),
      padding: EdgeInsets.only(left: 10,right: 10),
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
            padding: const EdgeInsets.only(right: 70.0),
            child: Text(
              "Equipment Name",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: FontSize.s12,
                fontWeight: FontWeight.w700,
                color: ColorManager.mediumgrey,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 60.0),
            child: Text(
              "Category",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: FontSize.s12,
                fontWeight: FontWeight.w700,
                color: ColorManager.mediumgrey,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          Text(
            "Quantity on Hand",
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: FontSize.s12,
              fontWeight: FontWeight.w700,
              color: ColorManager.mediumgrey,
              decoration: TextDecoration.none,
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
    );
  }
}

///listview data
class OfficeEquipmentData extends StatelessWidget {
  const OfficeEquipmentData({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                        "1",
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
                        "Equipment",
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
                        "Supplies",
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
    );
  }
}

///graph list const
class GraphMenuConst extends StatelessWidget {
  final String text;
  final Color squareColor;
  final Color? textColor;
  const GraphMenuConst({super.key, required this.text, required this.squareColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text,style: CustomTextStylesCommon.commonStyle(
            color: textColor ?? ColorManager.dashListviewData,
            fontSize: FontSize.s12,
            fontWeight: FontWeight.w500),),
        SizedBox(width: 10,),
        Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
            color: squareColor,
            shape: BoxShape.rectangle,
          ),
        ),

      ],
    );
  }
}

///popup
class OfficeLocationPopup extends StatelessWidget {
  const OfficeLocationPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(width: 600, height: 450,
        body: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('No of Offices',style: CustomTextStylesCommon.commonStyle(
                        color: ColorManager.mediumgrey,
                        fontSize: FontSize.s14,
                        fontWeight: FontWeight.w700)),
                    Row(children: [
                      Text('Attendance Ratio',style: CustomTextStylesCommon.commonStyle(
                          color: ColorManager.mediumgrey,
                          fontSize: FontSize.s14,
                          fontWeight: FontWeight.w700)),
                      SizedBox(width: 20,),
                      Icon(Icons.calendar_today,color: ColorManager.bluebottom,size: 20,)
                    ],)
                  ],),
                SizedBox(height: 10,),
                Container(
                  height: 255,
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
                                  )
                                ),
                                SizedBox(width: 20,),
                                Expanded(
                                  flex:1,
                                  child: Text(
                                    "55%",
                                    textAlign: TextAlign.start,
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
          )

        ],
        bottomButtons: Offstage(),
        title: "Average Daily Attendance per Office");
  }
}
