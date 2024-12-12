import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/icon_button_constant.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/sm_intake_screen.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/common_resources/em_dashboard_theme.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/hr_resources/string_manager.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../../../widgets/app_clickable_widget.dart';
import '../../../../hr_module/dashboard/widgets/view_details_popup.dart';
import '../../../../hr_module/manage/widgets/custom_icon_button_constant.dart';

class InformationUpdateScreen extends StatelessWidget {
  const InformationUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 55.0),
      child: Column(
        children: [
          ///button
          Row(
            //crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(color: ColorManager.red,width: 500,),
              Padding(
                padding: const EdgeInsets.only(bottom: 10,),
                child: Container(
                  height: 33,
                  child: CustomIconButton(
                    color: ColorManager.bluebottom,
                      icon: Icons.add,
                      text: "Add Patient",
                      onPressed: () async {
                        // showDialog(
                        //     context: context,
                        //     builder: (context) {
                        //       return FutureBuilder<List<TypeofDocpopup>>(
                        //           future: getTypeofDoc(
                        //               context, docTypeMetaIdCC, selectedSubDocId),
                        //           builder: (contex, snapshot) {
                        //             if (snapshot.connectionState ==
                        //                 ConnectionState.waiting) {
                        //               return Center(
                        //                   child: CircularProgressIndicator());
                        //             }
                        //             if (snapshot.hasData) {
                        //               return UploadDocumentAddPopup(
                        //                 loadingDuration: _isLoading,
                        //                 title: 'Upload Document',
                        //                 officeId: widget.officeId,
                        //                 docTypeMetaIdCC: docTypeMetaIdCC,
                        //                 selectedSubDocId: selectedSubDocId,
                        //                 dataList: snapshot.data!,
                        //                 docTypeText: AppStringEM.corporateAndComplianceDocuments,
                        //                 subDocTypeText: getSubDocTypeText(selectedSubDocId),
                        //               );
                        //             } else {
                        //               return ErrorPopUp(
                        //                   title: "Received Error",
                        //                   text: snapshot.error.toString());
                        //             }
                        //           });
                        //     });
                      }),
                ),
              ),
            ],
          ),
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
                Container(
                  height: AppSize.s88,
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p10),
                 // margin: EdgeInsets.symmetric(horizontal: AppMargin.m2),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.black.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: Image.asset(
                                  'images/hr_dashboard/man.png', // Replace with your image path
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "John smith",
                                textAlign: TextAlign.center,
                                style: CustomTextStylesCommon.commonStyle(fontSize: FontSize.s12,
                                  fontWeight: FontWeight.w400,
                                  color: ColorManager.textBlack,),
                              ),
                              Text(
                               "Intake Date: 09/15/2024",
                                textAlign: TextAlign.center,
                                style: CustomTextStylesCommon.commonStyle(fontSize: FontSize.s12,
                                  fontWeight: FontWeight.w600,
                                  color: ColorManager.mediumgrey,),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Image.asset(
                              "images/sm/location.png",
                            height: 25,width: 26,fit: BoxFit.fill,
                          ),
                          SizedBox(width: 10,),
                          Text(
                            "Tufts International Center, 20 Sawyer Ave,\nMedford MA 02155 ",
                            textAlign: TextAlign.start,
                            style: CustomTextStylesCommon.commonStyle(fontSize: FontSize.s12,
                              fontWeight: FontWeight.w400,
                              color: ColorManager.textBlack,),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(width: 10,),
                    // Expanded(
                    //   flex: 1,
                    //   child: Row(
                    //     children: [
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Text(
                    //             "Refferal :",
                    //             textAlign: TextAlign.start,
                    //             style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                    //               fontWeight: FontWeight.w400,
                    //               color: ColorManager.textBlack,),
                    //           ),
                    //          // SizedBox(width: 25,),
                    //           Text(
                    //             "Prohealth App",
                    //             textAlign: TextAlign.start,
                    //             style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                    //               fontWeight: FontWeight.w400,
                    //               color: ColorManager.textBlack,),
                    //           ),
                    //         ],
                    //       ),
                    //
                    //     ],
                    //   ),
                    // ),
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Refferal :",
                                textAlign: TextAlign.start,
                                style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                                  fontWeight: FontWeight.w400,
                                  color: ColorManager.textBlack,),
                              ),
                              // SizedBox(width: 25,),
                              Text(
                                "Prohealth App",
                                textAlign: TextAlign.start,
                                style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                                  fontWeight: FontWeight.w400,
                                  color: ColorManager.textBlack,),
                              ),
                            ],
                          ),
                          SizedBox(width: 10,),
                          Padding(
                            padding: const EdgeInsets.only(top:35.0),
                            child: Row(
                              children: [
                                SMDashboardMenuButtons(
                                    onTap: (int index) {
                                      //_selectButton(index);
                                    },
                                    index: 0,
                                    grpIndex: 0,
                                    heading: "Patients Data"),
                                SMDashboardMenuButtons(
                                    onTap: (int index) {
                                      //_selectButton(index);
                                    },
                                    index: 0,
                                    grpIndex: 0,
                                    heading: "Physical Info"),
                                SMDashboardMenuButtons(
                                    onTap: (int index) {
                                      //_selectButton(index);
                                    },
                                    index: 0,
                                    grpIndex: 0,
                                    heading: "Medication"),
                                SMDashboardMenuButtons(
                                    onTap: (int index) {
                                      //_selectButton(index);
                                    },
                                    index: 0,
                                    grpIndex: 0,
                                    heading: "Lab Results"),
                                SMDashboardMenuButtons(
                                    onTap: (int index) {
                                      //_selectButton(index);
                                    },
                                    index: 0,
                                    grpIndex: 0,
                                    heading: "Insurance"),
                                SMDashboardMenuButtons(
                                    onTap: (int index) {
                                      //_selectButton(index);
                                    },
                                    index: 0,
                                    grpIndex: 0,
                                    heading: "Notes"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                   Image.asset("images/sm/contact.png",height: 50,width: 80,fit: BoxFit.fill,),
                    ///conditional button don't delete
                    Expanded(
                      child: Container(
                        height:33,
                        width: 160,
                        child: ElevatedButton.icon(
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Icon(Icons.edit_outlined,size: 20,),
                          ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SMIntakeScreen()));
                            //showDialog(context: context, builder: (context) => ViewDetailsPopup());
                          },
                      
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            backgroundColor: ColorManager.bluebottom,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: ColorManager.dashListviewData),
                            ),
                          ), label: Text(
                                  "Update",
                                  style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                                  fontWeight: FontWeight.w500,
                                  color: ColorManager.white,)
                                  ),
                        ),
                      ),
                    ),
                    // Container(
                    //   height:33,
                    //   width: 160,
                    //   child: ElevatedButton.icon(
                    //     icon: Image.asset("images/sm/calendar.png",height: 20,width: 20,),
                    //     onPressed: (){
                    //       showDialog(context: context, builder: (context) => ViewDetailsPopup());
                    //     },
                    //     style: ElevatedButton.styleFrom(
                    //       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    //       backgroundColor: ColorManager.white,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(12),
                    //         side: BorderSide(color: ColorManager.bluebottom),
                    //       ),
                    //     ), label: Text(
                    //             "Move to Schedular",
                    //             style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                    //             fontWeight: FontWeight.w500,
                    //             color: ColorManager.bluebottom,)
                    //             ),
                    //   ),
                    // ),
                  ],),
                ),
                SizedBox(height: AppSize.s5),
              ],
            );
          },
          )),
        ],
      ),
    );
  }
}

typedef void OnManuButtonTapCallBack(int index);
class SMDashboardMenuButtons extends StatelessWidget {
  const SMDashboardMenuButtons({
    super.key,
    required this.onTap,
    required this.index,
    required this.grpIndex,
    required this.heading,
  });

  final OnManuButtonTapCallBack onTap;
  final int index;
  final int grpIndex;
  final String heading;

  @override
  Widget build(BuildContext context) {
    return AppClickableWidget(
      onTap: () {
        onTap(index);
      },
      onHover: (bool val) {},
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p14),
            child: Text(
              heading,
              style: TextStyle(
                fontSize: FontSize.s10,
                fontWeight: FontWeight.w400,
                color: ColorManager.textBlack,
              ),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final textPainter = TextPainter(
                text: TextSpan(
                  text: heading,
                  style: TextStyle(
                    fontSize: FontSize.s10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                textDirection: TextDirection.ltr,
              )..layout();

              final textWidth = textPainter.size.width;

              return Container(
                margin: const EdgeInsets.symmetric(vertical: AppMargin.m5),
                height: 6,
                width: textWidth + 10,
                decoration: BoxDecoration(
                    color: ColorManager.greenDark,
                    borderRadius: BorderRadius.circular(12)
                ),

              );
            },
          ),
        ],
      ),
    );
  }
}
