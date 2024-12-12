import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/hr_module/dashboard/widgets/bottomsheet_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/dashboard/widgets/view_details_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/download_doc_const.dart';

import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../../../app/resources/hr_resources/string_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';

class HrDashboardContainerConst extends StatefulWidget {
  final String headText;
  final Color headSubTextColor;
  final String subText;
  final String imageTile;
 // final Color? imageTileColor;

  const HrDashboardContainerConst({super.key,
    required this.headText, required this.headSubTextColor,
    required this.subText, required this.imageTile,});

  @override
  State<HrDashboardContainerConst> createState() => _HrDashboardContainerConstState();
}

class _HrDashboardContainerConstState extends State<HrDashboardContainerConst> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border(top: BorderSide(
          color: Color(0xFFBCBCBC),
          width: 3,
        ),),
        // border: Border.symmetric(vertical: BorderSide.none,horizontal: BorderSide(width: 1,color: Color(0xFFBCBCBC)),),//all(width: 1, color: Color(0xFFBCBCBC)),
        boxShadow: [
          // BoxShadow(
          //   color: ColorManager.mediumgrey.withOpacity(0.2),
          //   blurRadius: 1,
          //   spreadRadius: 2,
          //   offset: const Offset(0, -3), // Upward shadow
          // ),
          BoxShadow(
            color: ColorManager.black.withOpacity(0.2),
            blurRadius: 4,
            spreadRadius: 0,
            offset: const Offset(0, 4), // Downward shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(widget.headText,
                style: CustomTextStylesCommon.commonStyle(fontSize: 16,
                    color: widget.headSubTextColor,fontWeight: FontWeight.w600),),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(widget.subText,
                      style: CustomTextStylesCommon.commonStyle(fontSize: 32,
                          color: widget.headSubTextColor,fontWeight: FontWeight.w600),),
                  )),
              Expanded(child: Center(
                child: Container(
                    child:Image.asset(widget.imageTile,fit: BoxFit.cover,
                    height: 80,)),))
            ],)
        ],
      ),
    );
  }
}

///part 2 Graph container const
class HrDashboadGraphContainer extends StatelessWidget {
  final Widget child;
  const HrDashboadGraphContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 280,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border(top: BorderSide(
            color: Color(0xFF579EBA),
            width: 3,
          ),),
          // border: Border.symmetric(vertical: BorderSide.none,horizontal: BorderSide(width: 1,color: Color(0xFFBCBCBC)),),//all(width: 1, color: Color(0xFFBCBCBC)),
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withOpacity(0.2),
              blurRadius: 4,
              spreadRadius: 0,
              offset: const Offset(0, 4), // Downward shadow
            ),
          ],
        ),
    child: child,);
  }
}

class HrDashboardSmallcontainer extends StatelessWidget {
  final Widget child;
  const HrDashboardSmallcontainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 135,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border(top: BorderSide(
            color: Color(0xFF579EBA),
            width: 2.5,
          ),),
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withOpacity(0.2),
              blurRadius: 4,
              spreadRadius: 0,
              offset: const Offset(0, 4), // Downward shadow
            ),
          ],
        ),
    child: child,);
  }
}

class TextCircleConst extends StatelessWidget {
  final String text;
  final Color circleColor;
  final Color? textColor;
  const TextCircleConst({super.key, required this.text, required this.circleColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10.0,
          height: 15.0,
          decoration: BoxDecoration(
            color: circleColor,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 10,),
        Text(text,style: CustomTextStylesCommon.commonStyle(
            color: textColor ?? ColorManager.dashListviewData,
        fontSize: FontSize.s12,
        fontWeight: FontWeight.w500),)
      ],
    );
  }
}


///part 3 heading
// class HrDashboardListviewHeading extends StatelessWidget {
//   const HrDashboardListviewHeading({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: AppSize.s62,
//       // margin: EdgeInsets.symmetric(horizontal: 48,vertical: 10),
//       // padding: EdgeInsets.only(left: 100,right: 50),
//       decoration: BoxDecoration(
//         border: Border(
//           bottom: BorderSide(
//             color: ColorManager.dashBlueHeadBottom,  // Set the color of the bottom border
//             width: 1.0,          // Set the thickness of the bottom border
//           ),
//         ),
//         color: ColorManager.dashBlueHead,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(6),
//           topRight: Radius.circular(6),
//         ),
//       ),
//       child: Row(
//         //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: Text(
//               AppStringHr.empName,
//               textAlign: TextAlign.center,
//               style: TableHeadHRDashboard.customTextStyle(context),
//             ),
//           ),
//           Expanded(
//             // flex: 1,
//             child: Text(
//               AppStringHr.expDVisa,
//               textAlign: TextAlign.center,
//               style: TableHeadHRDashboard.customTextStyle(context),
//             ),
//           ),
//           Expanded(
//             // flex: 1,
//             child: Text(
//               AppStringHr.expDPermit,
//               textAlign: TextAlign.center,
//               style: TableHeadHRDashboard.customTextStyle(context),
//             ),
//           ),
//           Expanded(
//             // flex: 1,
//             child: Text(
//               AppStringHr.expDLicense,
//               textAlign: TextAlign.center,
//               style: TableHeadHRDashboard.customTextStyle(context),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               AppStringHr.expDTrain,
//               textAlign: TextAlign.center,
//               style: TableHeadHRDashboard.customTextStyle(context),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               AppStringHr.avgSickDay,
//               textAlign: TextAlign.center,
//               style: TableHeadHRDashboard.customTextStyle(context),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               AppStringHr.viewDetails,
//               textAlign: TextAlign.center,
//               style: TableHeadHRDashboard.customTextStyle(context),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


///bottomsheet listview
class HRDashBottomSheetData extends StatelessWidget {
  const HRDashBottomSheetData({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s88,
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
      margin: EdgeInsets.symmetric(horizontal: AppMargin.m2),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(children: [
        Expanded(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
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
              SizedBox(width: 30,),
              Text(
                "Ace Prabhu",
                textAlign: TextAlign.center,
                style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s14,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.black,),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Text(
                "Employee Type",
                textAlign: TextAlign.center,
                style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                  fontWeight: FontWeight.w400,
                  color: ColorManager.mediumgrey,),
              ),
              SizedBox(width: 15,),
              Text(
                "Clinical",
                textAlign: TextAlign.center,
                style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                  fontWeight: FontWeight.w400,
                  color: ColorManager.black,),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Text(
                "Phone Number",
                textAlign: TextAlign.center,
                style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                  fontWeight: FontWeight.w400,
                  color: ColorManager.mediumgrey,),
              ),
              SizedBox(width: 15,),
              Text(
                "1234567890",
                textAlign: TextAlign.center,
                style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                  fontWeight: FontWeight.w400,
                  color: ColorManager.black,),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Text(
                "Document Names",
                textAlign: TextAlign.center,
                style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                  fontWeight: FontWeight.w400,
                  color: ColorManager.mediumgrey,),
              ),
              SizedBox(width: 20,),
              Container(
                height: 70,
                //color: Colors.blue,
                child: GestureDetector(
                  onTap: (){
                    showDialog(context: context, builder: (context) => BottomsheetPopup());
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Driving License",
                            textAlign: TextAlign.start,
                            style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                              fontWeight: FontWeight.w400,
                              color: ColorManager.black,),
                          ),
                          SizedBox(width: 20,),
                          Text(
                            "expiry in 10 month",
                            textAlign: TextAlign.start,
                            style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF428634)),
                          ),
                        ],
                      ),
                      Text(
                        "Domicile",
                        textAlign: TextAlign.start,
                        style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                          fontWeight: FontWeight.w400,
                          color: ColorManager.black,),
                      ),
                      Text(
                        "Birth Certificate",
                        textAlign: TextAlign.start,
                        style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                          fontWeight: FontWeight.w400,
                          color: ColorManager.black,),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],),
    );
  }
}


///part 3 listview container
class HRDashboardListViewData extends StatelessWidget {
  const HRDashboardListViewData({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s88,
     padding: EdgeInsets.symmetric(horizontal: AppPadding.p40),
     margin: EdgeInsets.symmetric(horizontal: AppMargin.m2),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: ColorManager.mediumgrey.withOpacity(0.4),
            spreadRadius: 0,
            blurRadius: 5,
            offset: Offset(0, 4),
          ),
        ],
      ),
    child: Row(children: [
      Expanded(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Container(
                width: 60,
                height: 70,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: ColorManager.dashListviewDataPink,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
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
            ),
            SizedBox(width: 30,),
            Text(
              "Ace Prabhu",
              textAlign: TextAlign.center,
              style: CustomTextStylesCommon.commonStyle(fontSize: FontSize.s14,
                fontWeight: FontWeight.w500,
                color: ColorManager.black,),
            ),
          ],
        ),
      ),
      Expanded(
        child: Row(
          children: [
            Text(
              "Expiry Date for\nDriving License",
              textAlign: TextAlign.start,
              style: CustomTextStylesCommon.commonStyle(fontSize: FontSize.s12,
                fontWeight: FontWeight.w400,
                color: ColorManager.mediumgrey,),
            ),
            SizedBox(width: 25,),
            Text(
              "24.06.2025",
              textAlign: TextAlign.start,
              style: CustomTextStylesCommon.commonStyle(fontSize: FontSize.s12,
                fontWeight: FontWeight.w500,
                color: ColorManager.textBlack,),
            ),
          ],
        ),
      ),
      Expanded(
        child: Row(
          children: [
            Text(
              "Expiry Date for\nPractioner License",
              textAlign: TextAlign.start,
              style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                fontWeight: FontWeight.w400,
                color: ColorManager.mediumgrey,),
            ),
            SizedBox(width: 25,),
            Text(
              "24.06.2025",
              textAlign: TextAlign.start,
              style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                fontWeight: FontWeight.w500,
                color: ColorManager.textBlack,),
            ),
          ],
        ),
      ),
      Expanded(
        child: Row(
          children: [
            Text(
              "Average Sick\nDays",
              textAlign: TextAlign.start,
              style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                fontWeight: FontWeight.w400,
                color: ColorManager.mediumgrey,),
            ),
            SizedBox(width: 25,),
            Text(
              "12 Days",
              textAlign: TextAlign.start,
              style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                fontWeight: FontWeight.w500,
                color: ColorManager.textBlack,),
            ),
          ],
        ),
      ),
      Expanded(
        child: Row(
          children: [
            Text(
              "Driving License",
              textAlign: TextAlign.start,
              style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                fontWeight: FontWeight.w400,
                color: ColorManager.mediumgrey,),
            ),
            SizedBox(width: 15,),
            PdfDownloadButton(apiUrl: 'apiUrl', documentName: 'documentName')
          ],
        ),
      ),
      Expanded(
        child: Row(
          children: [
            Text(
              "Practional License",
              textAlign: TextAlign.start,
              style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                fontWeight: FontWeight.w400,
                color: ColorManager.mediumgrey,),
            ),
            SizedBox(width: 15,),
            PdfDownloadButton(apiUrl: 'apiUrl', documentName: 'documentName')
          ],
        ),
      ),
      Container(
        height:33,
        width: 100,
        child: ElevatedButton(
          onPressed: (){
            showDialog(context: context, builder: (context) => ViewDetailsPopup());
          },
          child: Text(
              AppStringHr.viewDetails,
              style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                fontWeight: FontWeight.w500,
                color: ColorManager.white,)
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            backgroundColor: ColorManager.bluebottom,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: ColorManager.dashListviewData),
            ),
          ),
        ),
      )
    ],),
    );
  }
}
