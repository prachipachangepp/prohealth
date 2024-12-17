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
  final VoidCallback onUpdateButtonPressed;
  final void Function(int patientId) onPatientIdReceived;

  InformationUpdateScreen({super.key, required this.onUpdateButtonPressed, required this.onPatientIdReceived});

  void handlePatientId(int patientId) {
    /// Pass the patientId back to the parent widget
    onPatientIdReceived(patientId);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();
    int fetchedPatientId = 0; // Replace this with your actual patientId
    handlePatientId(fetchedPatientId);
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 55.0),
      child: Column(
        children: [
          ///button
          Row(
            //crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 320,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: ColorManager.mediumgrey.withOpacity(0.1),width: 1)
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black26,
                  //     blurRadius: 5.0,
                  //   ),
                  // ],
                ),
                child: TextField(
                  controller: _searchController,
                  textInputAction: TextInputAction.search,
                  //onSubmitted: (value) => _performSearch(),
                  decoration: InputDecoration(
                    hintText: "Search location",
                    hintStyle: CustomTextStylesCommon.commonStyle(fontSize: FontSize.s12,color: ColorManager.mediumgrey,fontWeight: FontWeight.w400),
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15.0, right: 15,bottom: 5),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10,),
                child: Container(
                  height: 33,
                  child: CustomIconButton(
                    color: ColorManager.bluebottom,
                      icon: Icons.add,
                      text: "Add Patient",
                      onPressed: () async {
                      try {
                        onUpdateButtonPressed();
                      }
                      catch (e){
                        print("Error: $e");
                      }
                      },
                      ),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                                  fontWeight: FontWeight.w700,
                                  color: ColorManager.mediumgrey,),
                              ),
                              Text(
                               "Intake Date: 09/15/2024",
                                textAlign: TextAlign.center,
                                style: CustomTextStylesCommon.commonStyle(fontSize: FontSize.s12,
                                  fontWeight: FontWeight.w400,
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
                          Icon(Icons.location_on_outlined,size: IconSize.I18,color: ColorManager.bluebottom,),
                          // Image.asset(
                          //     "images/sm/location.png",
                          //   height: 25,width: 26,fit: BoxFit.fill,
                          // ),
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
                    Expanded(
                      flex: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                         // SizedBox(width: 10,),
                          Padding(
                            padding: const EdgeInsets.only(top:35.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SMDashboardMenuButtons(
                                    onTap: (int index) {
                                      //_selectButton(index);
                                    },
                                    index: 0,
                                    grpIndex: 0,
                                    heading: "Patients Data"),
                                SizedBox(width: 5,),
                                SMDashboardMenuButtons(
                                    onTap: (int index) {
                                      //_selectButton(index);
                                    },
                                    index: 0,
                                    grpIndex: 0,
                                    heading: "Physical Info"),
                                SizedBox(width: 5,),
                                SMDashboardMenuButtons(
                                    onTap: (int index) {
                                      //_selectButton(index);
                                    },
                                    index: 0,
                                    grpIndex: 0,
                                    heading: "Medication"),
                                SizedBox(width: 5,),
                                SMDashboardMenuButtons(
                                    onTap: (int index) {
                                      //_selectButton(index);
                                    },
                                    index: 0,
                                    grpIndex: 0,
                                    heading: "Lab Results"),
                                SizedBox(width: 5,),
                                SMDashboardMenuButtons(
                                    onTap: (int index) {
                                      //_selectButton(index);
                                    },
                                    index: 0,
                                    grpIndex: 0,
                                    heading: "Insurance"),
                                SizedBox(width: 5,),
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
                         // SizedBox(width: 15,),
                          Image.asset("images/sm/contact.png",height: 50,width: 60,fit: BoxFit.fill,),

                        ],
                      ),
                    ),
                    SizedBox(width: 10,),
                    ///conditional button don't delete
                    //   Container(
                    //     height:33,
                    //     width: 160,
                    //     child: ElevatedButton(
                    //      // icon: Image.asset("images/sm/calendar.png",height: 20,width: 20,),
                    //       onPressed: (){
                    //         showDialog(context: context, builder: (context) => ViewDetailsPopup());
                    //       },
                    //       style: ElevatedButton.styleFrom(
                    //         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    //         backgroundColor: ColorManager.white,
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(12),
                    //           side: BorderSide(color: ColorManager.bluebottom),
                    //         ),
                    //       ), child: Text(
                    //         "Update",
                    //         style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                    //           fontWeight: FontWeight.w500,
                    //           color: ColorManager.bluebottom,)
                    //     ),
                    //     ),
                    //   ),
                    ///old blue button
                    // Expanded(
                    //   child: Container(
                    //     height:33,
                    //     width: 160,
                    //     child: ElevatedButton.icon(
                    //       icon: Padding(
                    //         padding: const EdgeInsets.only(right: 15.0),
                    //         child: Icon(Icons.edit_outlined,size: 20,),
                    //       ),
                    //       onPressed:onUpdateButtonPressed,
                    //       //     (){
                    //       //   Navigator.push(context, MaterialPageRoute(builder: (context) => SMIntakeScreen()));
                    //       //   //showDialog(context: context, builder: (context) => ViewDetailsPopup());
                    //       // },
                    //
                    //       style: ElevatedButton.styleFrom(
                    //         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    //         backgroundColor: ColorManager.bluebottom,
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(12),
                    //           side: BorderSide(color: ColorManager.dashListviewData),
                    //         ),
                    //       ), label: Text(
                    //               "Update",
                    //               style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                    //               fontWeight: FontWeight.w500,
                    //               color: ColorManager.white,)
                    //               ),
                    //     ),
                    //   ),
                    // ),
                    Container(
                      height:33,
                      width: 160,
                      child: ElevatedButton.icon(
                        icon: Image.asset("images/sm/calendar.png",height: 20,width: 20,),
                        onPressed: (){
                          showDialog(context: context, builder: (context) => ViewDetailsPopup());
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          backgroundColor: ColorManager.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: ColorManager.bluebottom),
                          ),
                        ), label: Text(
                                "Move to Schedular",
                                style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                                fontWeight: FontWeight.w500,
                                color: ColorManager.bluebottom,)
                                ),
                      ),
                    ),
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
///
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
          Text(
            heading,
            style: TextStyle(
              fontSize: FontSize.s10,
              fontWeight: FontWeight.w400,
              color: ColorManager.mediumgrey,
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
              print("textwidth :::::::: $heading $textWidth");
              return Container(
                margin: const EdgeInsets.symmetric(vertical: AppMargin.m5),
                height: 6,
                width: 65,// textWidth + 10,
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
