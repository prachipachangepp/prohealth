import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/hr_module/dashboard/widgets/view_details_popup.dart';

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
  final Color imageTileColor;

  const HrDashboardContainerConst({super.key,
    required this.headText, required this.headSubTextColor,
    required this.subText, required this.imageTile, required this.imageTileColor,});

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
        // border: Border.symmetric(vertical: BorderSide.none,horizontal: BorderSide(width: 1,color: Color(0xFFBCBCBC)),),//all(width: 1, color: Color(0xFFBCBCBC)),
        boxShadow: [
          BoxShadow(
            color: ColorManager.mediumgrey.withOpacity(0.2),
            blurRadius: 1,
            spreadRadius: 2,
            offset: const Offset(0, -3), // Upward shadow
          ),
          BoxShadow(
            color: ColorManager.fmediumgrey.withOpacity(0.1),
            blurRadius: 3,
            spreadRadius: 0,
            offset: const Offset(0, 6), // Downward shadow
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
                    child:Image.asset(widget.imageTile,fit: BoxFit.cover,color: widget.imageTileColor,
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
        height: 250,
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
        height: 120,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border(top: BorderSide(
            color: Color(0xFF579EBA),  // Set the color of the bottom border
            width: 2.5,          // Set the thickness of the bottom border
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


///part 3 heading
class HrDashboardListviewHeading extends StatelessWidget {
  const HrDashboardListviewHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s62,
      // margin: EdgeInsets.symmetric(horizontal: 48,vertical: 10),
      // padding: EdgeInsets.only(left: 100,right: 50),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: ColorManager.dashBlueHeadBottom,  // Set the color of the bottom border
            width: 1.0,          // Set the thickness of the bottom border
          ),
        ),
        color: ColorManager.dashBlueHead,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(6),
        ),
      ),
      child: Row(
        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              AppStringHr.empName,
              textAlign: TextAlign.center,
              style: TableHeadHRDashboard.customTextStyle(context),
            ),
          ),
          Expanded(
            // flex: 1,
            child: Text(
              AppStringHr.expDVisa,
              textAlign: TextAlign.center,
              style: TableHeadHRDashboard.customTextStyle(context),
            ),
          ),
          Expanded(
            // flex: 1,
            child: Text(
              AppStringHr.expDPermit,
              textAlign: TextAlign.center,
              style: TableHeadHRDashboard.customTextStyle(context),
            ),
          ),
          Expanded(
            // flex: 1,
            child: Text(
              AppStringHr.expDLicense,
              textAlign: TextAlign.center,
              style: TableHeadHRDashboard.customTextStyle(context),
            ),
          ),
          Expanded(
            child: Text(
              AppStringHr.expDTrain,
              textAlign: TextAlign.center,
              style: TableHeadHRDashboard.customTextStyle(context),
            ),
          ),
          Expanded(
            child: Text(
              AppStringHr.avgSickDay,
              textAlign: TextAlign.center,
              style: TableHeadHRDashboard.customTextStyle(context),
            ),
          ),
          Expanded(
            child: Text(
              AppStringHr.viewDetails,
              textAlign: TextAlign.center,
              style: TableHeadHRDashboard.customTextStyle(context),
            ),
          ),
        ],
      ),
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
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Container(
              width: 60,
              height: 70,
              padding: EdgeInsets.all(10),
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
          SizedBox(width: 35,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Ross",
                textAlign: TextAlign.center,
                style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s16,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.black,),
              ),
              Text(
                "Male | 49y",
                textAlign: TextAlign.center,
                style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s10,
                  fontWeight: FontWeight.w400,
                  color: ColorManager.mediumgrey,),
              ),
              SizedBox(height: 10,),
              Text(
                "Psychiatrist",
                textAlign: TextAlign.center,
                style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                  fontWeight: FontWeight.w400,
                  color: ColorManager.dashListviewData,),
              ),
              SizedBox(height: 10,),
            ],
          ),
        ],
      ),
      Expanded(
        child: Text(
          "24.06.2025",
          textAlign: TextAlign.center,
          style: TableDataHRDashboard.customTextStyle(context),
        ),
      ),
      Expanded(
        child: Text(
          "14.11.2025",
          textAlign: TextAlign.center,
          style: TableDataHRDashboard.customTextStyle(context),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: AppPadding.p15),
          child: Text(
            "01.06.2032",
            textAlign: TextAlign.center,
            style: TableDataHRDashboard.customTextStyle(context),
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 45.0),
          child: Text(
            "24.06.2025",
            textAlign: TextAlign.start,
            style: TableDataHRDashboard.customTextStyle(context),
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 45.0),
          child: Text(
            "12 Days",
            textAlign: TextAlign.start,
            style: TableDataHRDashboard.customTextStyle(context),
          ),
        ),
      ),
      Container(
        height:35,
        width: 120,
        child: ElevatedButton(
          onPressed: (){
            showDialog(context: context, builder: (context) => ViewDetailsPopup());
          },
          child: Text(
              AppStringHr.viewDetails,
              style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s15,
                fontWeight: FontWeight.w500,
                color: ColorManager.dashListviewData,)
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(color: ColorManager.dashListviewData),
            ),
          ),
        ),
      )
    ],),
    );
  }
}
