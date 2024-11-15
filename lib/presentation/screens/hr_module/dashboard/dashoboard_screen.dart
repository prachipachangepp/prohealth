import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/hr_resources/string_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/dashboard/widgets/hr_dashboard_const.dart';

import '../../../../app/resources/color.dart';
import '../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../app/resources/hr_resources/hr_theme_manager.dart';

class DashBoardScreen extends StatefulWidget {
  DashBoardScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p10,horizontal: AppPadding.p14),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: AppSize.s150,
                    width: double.maxFinite,
                    decoration: BoxDecoration(color:Color(0xFFE9F2F5),// Color(0xFFF2F9FC),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: ColorManager.mediumgrey.withOpacity(0.5),
                      //     blurRadius: 2,
                      //     spreadRadius: -3,
                      //     offset: const Offset(0, -6),
                      //   ),
                      // ]
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 40,horizontal: 80),
                      child: Row(
                        children: [
                          Expanded(
                            child: HrDashboardContainerConst(
                                headText: "Total Employees",
                                headSubTextColor: ColorManager.skini,
                                subText: "101",
                                imageTile: 'images/hr_dashboard/total.png',
                                imageTileColor: ColorManager.skini.withOpacity(0.8),
                            ),
                          ),
                          SizedBox(width: 25,),
                          Expanded(
                            child: HrDashboardContainerConst(
                              headText: "New Joining's",
                              headSubTextColor: ColorManager.blueDash,
                              subText: "03",
                              imageTile: 'images/hr_dashboard/joinies.png',
                              imageTileColor: ColorManager.blueDash.withOpacity(0.8),
                            ),
                          ),

                          SizedBox(width: 25,),
                          Expanded(
                            child: HrDashboardContainerConst(
                              headText: "Today’s Attendance",
                              headSubTextColor: ColorManager.pink,
                              subText: "90%",
                              imageTile: 'images/hr_dashboard/attendies.png',
                              imageTileColor: ColorManager.pink.withOpacity(0.8),
                            ),
                          ),
                          SizedBox(width: 25,),
                          Expanded(
                            child: HrDashboardContainerConst(
                              headText: "Employees on Leave",
                              headSubTextColor: ColorManager.purpleBlack,
                              subText: "08",
                              imageTile: 'images/hr_dashboard/emp_leave.png',
                              imageTileColor: ColorManager.purple.withOpacity(0.8),
                            ),
                          ),
                        ],
                      )),
                ],
              ),

              ///graph section
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p15,right: AppPadding.p15,bottom: AppPadding.p10),
                child: Container(
                  height: AppSize.s700,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p10,horizontal: 5),
                  child: Column(
                    children: [
                      Row(children: [
                        Expanded(flex:3, child: Container(height: 250,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            // border: Border.symmetric(vertical: BorderSide.none,horizontal: BorderSide(width: 1,color: Color(0xFFBCBCBC)),),//all(width: 1, color: Color(0xFFBCBCBC)),
                            boxShadow: [
                              BoxShadow(
                                color: ColorManager.fmediumgrey.withOpacity(0.2),
                                blurRadius: 2,
                                spreadRadius: 1,
                                offset: const Offset(0, 3), // Downward shadow
                              ),
                            ],
                          ),)),
                        SizedBox(width: 15,),
                        Expanded(flex:1, child: Container(height: 250,decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          // border: Border.symmetric(vertical: BorderSide.none,horizontal: BorderSide(width: 1,color: Color(0xFFBCBCBC)),),//all(width: 1, color: Color(0xFFBCBCBC)),
                          boxShadow: [
                            BoxShadow(
                              color: ColorManager.fmediumgrey.withOpacity(0.2),
                              blurRadius: 2,
                              spreadRadius: 1,
                              offset: const Offset(0, 3), // Downward shadow
                            ),
                          ],
                        ),)),
                        SizedBox(width: 15,),
                        Expanded(flex:2, child: Container(height: 250,
                            decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          // border: Border.symmetric(vertical: BorderSide.none,horizontal: BorderSide(width: 1,color: Color(0xFFBCBCBC)),),//all(width: 1, color: Color(0xFFBCBCBC)),
                          boxShadow: [
                            BoxShadow(
                              color: ColorManager.fmediumgrey.withOpacity(0.2),
                              blurRadius: 2,
                              spreadRadius: 1,
                              offset: const Offset(0, 3), // Downward shadow
                            ),
                          ],
                        ))),
                      ],),
                      Center(
                        child: Text("widget.headText",
                          style: CustomTextStylesCommon.commonStyle(fontSize: 16,
                              color: ColorManager.black,fontWeight: FontWeight.w600),),
                      ),
                    ],
                  ),
                ),
              ),
              ///listview section
              Padding(
                padding: const EdgeInsets.only(left: AppPadding.p25,right: AppPadding.p25,bottom: AppPadding.p10),
                child: Container(
                  height: AppSize.s450,
                  color: Colors.white,
                  child: Column(
                    children: [
                      HrDashboardListviewHeading(),
                      ///
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 15,
                          itemBuilder: (context, index) {
                            //int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                           // String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                           // EmployeeDocumentModal employeedoc = paginatedData[index];
                            return Column(
                              children: [
                                SizedBox(height: AppSize.s5),
                                HRDashboardListViewData(),
                                SizedBox(height: AppSize.s5),
                              ],
                            );
                          },
                        ),
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
