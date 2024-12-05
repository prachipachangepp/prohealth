import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/common_resources/em_dashboard_theme.dart';
import '../../../../../../../app/resources/establishment_resources/em_dashboard_string_manager.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../em_dashboard_const.dart';

class ContractDocConst extends StatelessWidget {
  const ContractDocConst({super.key});

  @override
  Widget build(BuildContext context) {
    return EMDashboardContainerConst(
        height: AppSize.s150,
        child: Padding(
          padding: const EdgeInsets.only(left: AppPadding.p30),
          child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  EmDashboardStringManager.hello,
                  style: EmDashHelloText.customTextStyle(context)
                ),
                Text(EmDashboardStringManager.securingSuccess,
                  style: EmDashHelloSubText.customTextStyle(context)
                ),
              ],
            ),
            SizedBox(
              width: AppSize.s20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: Image.asset(
                      "images/em_dashboard/contract_doc_audit.png",
                      fit: BoxFit.contain,
                    )),
              ],
            )
          ]),
        ));
  }
}

///Audit Preparation Time Per Office
class AuditPrepTimeOffice extends StatelessWidget {
  const AuditPrepTimeOffice({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Audit Preparation Time Per Office',style: CustomTextStylesCommon.commonStyle(
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
        SizedBox(height: 10,),
        Row(
          children: [
            Expanded(
              //flex: 3,
              child: Container(
                height: AppSize.s30,
                // margin: EdgeInsets.symmetric(horizontal: 48,vertical: 10),
                padding: EdgeInsets.only(left: 10,right: 60),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: ColorManager.black.withOpacity(.02),
                        blurRadius: 4,
                        spreadRadius: 0,
                        offset: Offset(0, 2))
                  ],
                  color: ColorManager.pieChartGreen.withOpacity(0.78),

                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      EmDashboardStringManager.srNo,
                      textAlign: TextAlign.start,
                      style: EmDashListviewHeadText.customTextStyle(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: Text(
                        "Office Name",
                        textAlign: TextAlign.start,
                        style: EmDashListviewHeadText.customTextStyle(context),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        "Audit",
                        textAlign: TextAlign.start,
                        style: EmDashListviewHeadText.customTextStyle(context),
                      ),
                    ),
                    Text(
                      "Time",
                      textAlign: TextAlign.start,
                      style: EmDashListviewHeadText.customTextStyle(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                height: 205,
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
                                // flex: 1,
                                child: Text(
                                  "01",
                                  textAlign: TextAlign.start,
                                  style: EmDashListviewDataText.customTextStyle(context),
                                ),
                              ),
                              Expanded(
                                // flex:2,
                                child: Text(
                                  "Office 1",
                                  textAlign: TextAlign.start,
                                  style: EmDashListviewDataText.customTextStyle(context),
                                ),
                              ),
                              Expanded(
                                // flex:2,
                                child: Text(
                                  "Audit 1",
                                  textAlign: TextAlign.center,
                                  style: EmDashListviewDataText.customTextStyle(context),
                                ),
                              ),
                              Expanded(
                                // flex:2,
                                child: Text(
                                  "10:00:00 AM",
                                  textAlign: TextAlign.center,
                                  style: EmDashListviewDataText.customTextStyle(context),
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
          ],
        )
      ],
    );
  }
}

///Average Compliance Rating per Office
class AvgComRatingOffice extends StatelessWidget {
  const AvgComRatingOffice({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Average Compliance Rating per Office',style: CustomTextStylesCommon.commonStyle(
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
        SizedBox(height: 10,),
        ///heading
        Container(
          height: AppSize.s30,
          // margin: EdgeInsets.symmetric(horizontal: 48,vertical: 10),
          padding: EdgeInsets.only(left: 10,right: 40),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: ColorManager.mediumgrey.withOpacity(0.2),
                  blurRadius: 4,
                  spreadRadius: 0,
                  offset: Offset(0, 2))
            ],
            color: Color(0xFFC8CFF9),

            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "No. of Offices",
                textAlign: TextAlign.start,
                style: EmDashListviewHeadText.customTextStyle(context),
              ),
              Text(
                "Compliance Rating",
                textAlign: TextAlign.start,
                style: EmDashListviewHeadText.customTextStyle(context),
              ),
            ],
          ),
        ),
        SizedBox(height: 10,),
        Expanded(
          child: Container(
            height: 210,
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
                    SizedBox(height: 6,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex:1,
                          child: Text(
                            "Office 1",
                            textAlign: TextAlign.start,
                            style: EmDashListviewDataText.customTextStyle(context),
                          ),
                        ),
                        Expanded(flex:1 ,child: Container()),
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              RatingStars(
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
                          SizedBox(width: 20,),
                          Text(
                            "5",
                            textAlign: TextAlign.center,
                            style: EmDashListviewDataText.customTextStyle(context),)
                            ],
                          ),
                        ),
                        // Expanded(
                        //   flex:1,
                        //   child: Text(
                        //     "5",
                        //     textAlign: TextAlign.center,
                        //     style: CustomTextStylesCommon.commonStyle(
                        //       fontSize: FontSize.s12,
                        //       fontWeight: FontWeight.w400,
                        //       color: ColorManager.black,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(height: 6,),
                    Divider(color: ColorManager.containerBorderGrey,height: 1,thickness: 1,)
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

///Audit Dates
class AuditDates extends StatelessWidget {
  const AuditDates({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Audit Dates',style: CustomTextStylesCommon.commonStyle(
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
        SizedBox(height: 10,),
        Row(
          children: [
            Expanded(
              //flex: 3,
              child: Container(
                height: AppSize.s30,
                // margin: EdgeInsets.symmetric(horizontal: 48,vertical: 10),
                padding: EdgeInsets.only(left: 10,right: 65),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: ColorManager.black.withOpacity(.02),
                        blurRadius: 4,
                        spreadRadius: 0,
                        offset: Offset(0, 2))
                  ],
                  color: Color(0xFF6FC2EA).withOpacity(0.26),

    borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      EmDashboardStringManager.srNo,
                      textAlign: TextAlign.start,
                      style: EmDashListviewHeadText.customTextStyle(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30.0),
                      child: Text(
                        "Audit",
                        textAlign: TextAlign.start,
                        style: EmDashListviewHeadText.customTextStyle(context),
                      ),
                    ),
                    Text(
                      "Dates",
                      textAlign: TextAlign.start,
                      style: EmDashListviewHeadText.customTextStyle(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                height: 190,
                // width: 500,
                padding: EdgeInsets.only(left: 20,),
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
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              // flex: 1,
                              child: Text(
                                "01",
                                textAlign: TextAlign.start,
                                style: EmDashListviewDataText.customTextStyle(context),
                              ),
                            ),
                            Expanded(
                             flex:2,
                              child: Text(
                                "Next Scheduled Gov. Date",
                                textAlign: TextAlign.start,
                                style: EmDashListviewDataText.customTextStyle(context),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "27-08-2025",
                                    textAlign: TextAlign.center,
                                    style: EmDashListviewDataText.customTextStyle(context),
                                  ),
                                  SizedBox(width: 15),
                                  IconButton(
                                    icon: Icon(Icons.calendar_today, size: 16, color: ColorManager.bluebottom),
                                    onPressed: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(), // Default date
                                        firstDate: DateTime(1950), // Earliest date
                                        lastDate: DateTime(3100), // Latest date
                                      );

                                      if (pickedDate != null) {
                                        print("Selected date: ${pickedDate.toString()}");
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                        Divider(color: ColorManager.containerBorderGrey,height: 1,thickness: 1,)
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

///Number of  Offices with Upcoming Compliance Deadlines
class UpcomingCpmDeadlines extends StatelessWidget {
  const UpcomingCpmDeadlines({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Number of  Offices with Upcoming\nCompliance Deadlines ',style: CustomTextStylesCommon.commonStyle(
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
        SizedBox(height: 10,),
        Row(
          children: [
            Expanded(
              //flex: 3,
              child: Container(
                height: AppSize.s30,
                // margin: EdgeInsets.symmetric(horizontal: 48,vertical: 10),
                padding: EdgeInsets.only(left: 10,right: 90),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: ColorManager.black.withOpacity(.02),
                        blurRadius: 4,
                        spreadRadius: 0,
                        offset: Offset(0, 2))
                  ],
                  color: Color(0xFFC8CFF9),

    borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      EmDashboardStringManager.srNo,
                      textAlign: TextAlign.start,
                      style: EmDashListviewHeadText.customTextStyle(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        "Offices",
                        textAlign: TextAlign.start,
                        style: EmDashListviewHeadText.customTextStyle(context),
                      ),
                    ),
                    Text(
                      "Compliance Deadline",
                      textAlign: TextAlign.start,
                      style: EmDashListviewHeadText.customTextStyle(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                height: 110,
                // width: 500,
                padding: EdgeInsets.only(left: 20,),
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
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              // flex: 1,
                              child: Text(
                                "01",
                                textAlign: TextAlign.start,
                                style: EmDashListviewDataText.customTextStyle(context),
                              ),
                            ),
                            Expanded(
                              // flex:2,
                              child: Text(
                                "Office 1",
                                textAlign: TextAlign.start,
                                style: EmDashListviewDataText.customTextStyle(context),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "27-08-2025",
                                    textAlign: TextAlign.center,
                                    style: EmDashListviewDataText.customTextStyle(context),
                                  ),
                                  SizedBox(width: 15),
                                  IconButton(
                                    icon: Icon(Icons.calendar_today, size: 16, color: ColorManager.bluebottom),
                                    onPressed: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(), // Default date
                                        firstDate: DateTime(1950), // Earliest date
                                        lastDate: DateTime(3100), // Latest date
                                      );

                                      if (pickedDate != null) {
                                        print("Selected date: ${pickedDate.toString()}");
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                        Divider(color: ColorManager.containerBorderGrey,height: 1,thickness: 1,)
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

///Offices with expiring Compliance documents
class OfficeExpiringComDoc extends StatelessWidget {
  const OfficeExpiringComDoc({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Offices with expiring Compliance documents',style: CustomTextStylesCommon.commonStyle(
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
        SizedBox(height: 10,),
        Row(
          children: [
            Expanded(
              //flex: 3,
              child: Container(
                height: AppSize.s54,
                // margin: EdgeInsets.symmetric(horizontal: 48,vertical: 10),
                padding: EdgeInsets.only(left: 10,right: 50),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: ColorManager.black.withOpacity(.02),
                        blurRadius: 4,
                        spreadRadius: 0,
                        offset: Offset(0, 2))
                  ],
                  color: Color(0xFF6FC2EA).withOpacity(0.26),

                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Office Name",
                      textAlign: TextAlign.start,
                      style: EmDashListviewHeadText.customTextStyle(context),
                    ),
                    Text(
                      "Status",
                      textAlign: TextAlign.start,
                      style: EmDashListviewHeadText.customTextStyle(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: Text(
                        "Certificate",
                        textAlign: TextAlign.end,
                        style: EmDashListviewHeadText.customTextStyle(context),
                      ),
                    ),
                    Text(
                      "+Add Document",
                      textAlign: TextAlign.start,
                      style: EmDashListviewHeadText.customTextStyle(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                height: 380,
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
                          height: 6,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                // flex: 1,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: CircleAvatar(
                                        backgroundColor: ColorManager.bluebottom,
                                        radius: 15,
                                        child: Icon(Icons.home_work_outlined,color: ColorManager.white,size: 14,),
                                      ),
                                    ),
                                    SizedBox(width: 6,),
                                    Text(
                                      "Office 1",
                                      textAlign: TextAlign.start,
                                      style: EmDashListviewDataText.customTextStyle(context),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(child: Container()),
                              Expanded(
                                flex:3,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 10.0,
                                      height: 15.0,
                                      decoration: BoxDecoration(
                                        color: ColorManager.EMred, //add condition with color EMgreen
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Text('Partially Completed', // add condition with Fully Completed
                                      style:EmDashListviewDataText.customTextStyle(context),)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: Container(
                                  width: 60,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1,color: ColorManager.EMred),
                                      borderRadius: BorderRadius.circular(8),
                                      color: ColorManager.EMred.withOpacity(0.1)
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Expired",
                                      textAlign: TextAlign.center,
                                      style: CustomTextStylesCommon.commonStyle(
                                        fontSize: FontSize.s12,
                                        fontWeight: FontWeight.w400,
                                        color: ColorManager.EMred,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              ///apply with condition
                              // Container(
                              //   width: 60,
                              //   height: 35,
                              //   decoration: BoxDecoration(
                              //     border: Border.all(width: 1,color: ColorManager.EMgreen),
                              //       borderRadius: BorderRadius.circular(8),
                              //       color: ColorManager.EMgreen.withOpacity(0.1)
                              //   ),
                              //   child: Center(
                              //     child: Icon(FontAwesomeIcons.fileInvoice,color: ColorManager.EMgreen,),
                              //   ),
                              // ),
                              Expanded(child: Container()),
                              ElevatedButton.icon(
                                onPressed: () async{
                                  showDialog(context: context, builder: (context) => ContractUploadDocPopup());
                                },
                                icon: Icon(Icons.file_upload_outlined, color: Colors.white, size: 20),
                                label: Text(
                                    "Upload Document",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: FontSize.s12,
                                        fontWeight: FontWeight.w500,
                                        color: ColorManager.white)),
                                style: ElevatedButton.styleFrom(
                                    padding:  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                    backgroundColor:  ColorManager.blueprime,
                                    // shadowColor: Colors.grey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 5
                                ),
                              )

                            ],
                          ),
                        ),
                        Divider(color: ColorManager.containerBorderGrey,height: 1,thickness: 1,)
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

///Average time to resolve Audit Findings
class AverageTimeAuditFindings extends StatelessWidget {
  const AverageTimeAuditFindings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Average time to resolve Audit Findings',style: CustomTextStylesCommon.commonStyle(
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
        SizedBox(height: 10,),
        Row(
          children: [
            Expanded(
              //flex: 3,
              child: Container(
                height: AppSize.s30,
                // margin: EdgeInsets.symmetric(horizontal: 48,vertical: 10),
                padding: EdgeInsets.only(left: 10,right: 60),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: ColorManager.black.withOpacity(.02),
                        blurRadius: 4,
                        spreadRadius: 0,
                        offset: Offset(0, 2))
                  ],
                  color: Color(0xFF16DBCC).withOpacity(0.42),

                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      EmDashboardStringManager.srNo,
                      textAlign: TextAlign.start,
                      style: EmDashListviewHeadText.customTextStyle(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 60.0),
                      child: Text(
                        "Audit",
                        textAlign: TextAlign.start,
                        style: EmDashListviewHeadText.customTextStyle(context),
                      ),
                    ),
                    Text(
                      "Time",
                      textAlign: TextAlign.start,
                      style: EmDashListviewHeadText.customTextStyle(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                height: 205,
                // width: 500,
                padding: EdgeInsets.only(left: 20,),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              // flex: 1,
                              child: Text(
                                "01",
                                textAlign: TextAlign.start,
                                style: EmDashListviewDataText.customTextStyle(context),
                              ),
                            ),
                            Expanded(
                              // flex:2,
                              child: Text(
                                "Audit 1",
                                textAlign: TextAlign.start,
                                style: EmDashListviewDataText.customTextStyle(context),
                              ),
                            ),
                            Expanded(
                              // flex:2,
                              child: Text(
                                "10:00:00 AM",
                                textAlign: TextAlign.center,
                                style: EmDashListviewDataText.customTextStyle(context),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(color: ColorManager.containerBorderGrey,height: 1,thickness: 1,)
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class ContractUploadDocPopup extends StatelessWidget {
  const ContractUploadDocPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorManager.white,
      child: Container(
        width: 60.0,
        height: 250.0,
        decoration: BoxDecoration(
          color: ColorManager.white,
         borderRadius: BorderRadius.circular(12)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Upload document",
              textAlign: TextAlign.center,
              style: CustomTextStylesCommon.commonStyle(
                fontSize: FontSize.s16,
                fontWeight: FontWeight.w700,
                color: ColorManager.mediumgrey,
              ),
            ),
            Text(
              "Don’t forget to upload\nyour document",
              textAlign: TextAlign.center,
              style: CustomTextStylesCommon.commonStyle(
                fontSize: FontSize.s14,
                fontWeight: FontWeight.w400,
                color: ColorManager.mediumgrey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                height: 70,
                child: DottedBorder(
                  padding: EdgeInsets.all(8),
                    borderType: BorderType.RRect,
                    radius: Radius.circular(20),
                    dashPattern: [10, 10],
                    color: Colors.grey,
                    strokeWidth: 2,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: ColorManager.bluebottom,
                          child: Icon(Icons.add,color: ColorManager.white,size: 18,),
                        ),
                        Text(
                          "Upload document",
                          textAlign: TextAlign.center,
                          style: CustomTextStylesCommon.commonStyle(
                            fontSize: FontSize.s12,
                            fontWeight: FontWeight.w400,
                            color: ColorManager.mediumgrey,
                          ),
                        ),
                      ],
                    )
              ),
            )),
            CustomElevatedButton(
              width: AppSize.s130,
              height: AppSize.s30,
              text: "Save",
              onPressed: () async{},
            )
          ],
        ),
      ),
    );
  }
}
