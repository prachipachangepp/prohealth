import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/common_resources/em_dashboard_theme.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/hr_resources/string_manager.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../../hr_module/dashboard/widgets/view_details_popup.dart';

class InformationUpdateScreen extends StatelessWidget {
  const InformationUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80.0),
      child: Column(
        children: [
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
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p40),
                  margin: EdgeInsets.symmetric(horizontal: AppMargin.m2),
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
                      child: Row(
                        children: [
                          Image.asset(
                              "images/sm/location.png",
                            height: 25,width: 26,fit: BoxFit.fill,
                          ),
                          SizedBox(width: 25,),
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
                    Expanded(
                      child: Row(
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
                                  fontWeight: FontWeight.w500,
                                  color: ColorManager.textBlack,),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                   Image.asset("images/sm/contact.png",height: 50,width: 80,fit: BoxFit.fill,),
                    // LinearProgressIndicator(
                    //   backgroundColor: ColorManager.white,
                    //   color: ColorManager.blueprime,
                    //   value: 50/100,
                    // ),
                    Container(
                      height:33,
                      width: 100,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.edit_outlined),
                        onPressed: (){
                          showDialog(context: context, builder: (context) => ViewDetailsPopup());
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
                    )
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
