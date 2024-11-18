import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/dialogue_template.dart';
import 'package:prohealth/presentation/screens/hr_module/dashboard/widgets/hr_dashboard_const.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../../../app/resources/hr_resources/string_manager.dart';
import '../../../../../app/resources/theme_manager.dart';

class ViewDetailsPopup extends StatelessWidget {
  const ViewDetailsPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
        width: AppSize.s900,
        height: AppSize.s650,
        title: "User Details",
        body: [
          ///profile
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 70,
                  width: 70,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Circular avatar for the image or icon
                      ClipOval(
                        child:
                        // widget.searchByEmployeeIdProfileData!.imgurl == 'imgurl' || widget.searchByEmployeeIdProfileData!.imgurl == null
                        //     ?
                        CircleAvatar(radius: 50,child: Image.asset("images/profilepic.png",fit: BoxFit.cover,),)
                        //     : CachedNetworkImage(
                        //   imageUrl: widget.searchByEmployeeIdProfileData!.imgurl,
                        //   placeholder: (context, url) => CircularProgressIndicator(),
                        //   errorWidget: (context, url, error) => CircleAvatar(child: Image.asset("images/profilepic.png", fit: BoxFit.cover,),),
                        //   fit: BoxFit.cover,
                        //   height: 67,
                        //   width: 67,
                        // ),
                      ),
                      // Circular progress indicator around the image
                      SizedBox(
                        height: AppSize.s70,
                        width: AppSize.s70,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              ColorManager.greenF),
                          strokeWidth: 3,
                          value: 20
                        //  widget.searchByEmployeeIdProfileData!.profileScorePercentage,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 40,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///"Expired License"
                    ViewDetailsLicenseConst(
                      onTap: () {
                      },
                      text: AppString.expiredlicense,
                      // containerColor: Colors.deepOrangeAccent,
                      containerColor: Color(0xffD16D6A),
                      textOval: "5",//expiredCount.toString(),
                    ),
                    SizedBox(height: 5),

                    ///"About To Expired License"
                    ViewDetailsLicenseConst(
                        onTap: () {
                        },
                        text: AppString.abouttoexpire,
                        // containerColor: Colors.orange,
                        containerColor: Color(0xffFEBD4D),
                        textOval:"10"// upToDateCount.toString()
                    ),
                    SizedBox(height: 5),

                    ///"Up To Date License"
                    ViewDetailsLicenseConst(
                        onTap: () {
                        },
                        text: AppString.uptodate,
                        // containerColor: Colors.lightGreen,
                        containerColor: Color(0xffB4DB4C),
                        textOval: "2"//aboutToCount.toString()
                      ),
                  ],
                ),
              ],),
          ),
          SizedBox(height: 40,),
          ///data
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ViewDetailsRowConst(isUnderlined: false,headText: AppStringHr.name, dataText: 'John Scott',),
                    ViewDetailsRowConst(isUnderlined: false,headText: AppStringHr.empType, dataText: 'Full Time',),
                    ViewDetailsRowConst(isUnderlined: false,headText: AppStringHr.address, dataText: 'San Jose, Z4',),
                    ViewDetailsRowConst(isUnderlined: false,headText: AppStringHr.age, dataText: '05-031997(27)',),
                    ViewDetailsRowConst(isUnderlined: false,headText: AppStringHr.gender, dataText: 'Male',),
                    ViewDetailsRowConst(isUnderlined: false,headText: AppStringHr.ssn, dataText: '32165321321',),
                    ViewDetailsRowConst(isUnderlined: false,headText: AppStringHr.phone, dataText: '(+1) 123-4567',),
                    ViewDetailsRowConst(isUnderlined: false,headText: AppStringHr.personal, dataText: '(+1) 123-4567',),
                    ViewDetailsRowConst(isUnderlined: false,headText: AppStringHr.work, dataText: '(+1) 123-4567',),

                  ],),
                SizedBox(width: 50,),
                Column(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ViewDetailsRowConst(isUnderlined: false, headText: AppStringHr.zone, dataText: 'ProHealth, San Jose Z4',),
                    ViewDetailsRowConst(isUnderlined: false, headText: AppStringHr.zone, dataText: 'ProHealth, San Jose Z4',),
                    ViewDetailsRowConst(isUnderlined: false, headText: AppStringHr.zone, dataText: 'ProHealth, San Jose Z4',),
                    ViewDetailsRowConst(isUnderlined: false,headText: AppStringHr.speciality, dataText: 'Physical Thearpy',),
                    ViewDetailsRowConst(isUnderlined: false,headText: AppStringHr.service, dataText: 'NA',),
                    ViewDetailsRowConst(isUnderlined: false,headText: AppStringHr.reportingOffice, dataText: 'NA',),
                    ViewDetailsRowConst(isUnderlined: false,headText: AppStringHr.summary, dataText: 'NA',),
                    ViewDetailsRowConst(isUnderlined: false,headText: AppStringHr.hireDate, dataText: '09/02/2014 (09 Y 11 M)',),
                    ViewDetailsRowConst(isUnderlined: false,headText: AppStringHr.pta, dataText: '1.2',),
                  ],),
              ],),
          ),
        ],
        bottomButtons: Container(
          height:35,
          width: 120,
          child: ElevatedButton(
            onPressed: (){
                Navigator.pop(context);
            },
            child: Text(
                AppStringHr.back,
                style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s14p,
                  fontWeight: FontWeight.w700,
                  color: ColorManager.blueprime,)
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: ColorManager.blueprime,width: 2),
              ),
            ),
          ),
        ),);
  }
}


class ViewDetailsRowConst extends StatelessWidget {
  final String headText;
  final String dataText;
  final bool isUnderlined;
  final Color? color;
  const ViewDetailsRowConst({super.key, required this.headText, required this.dataText, required this.isUnderlined, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
     // color: Colors.orangeAccent,
      width: 370,
      height: 40,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            Expanded(
              child: Container(
                //color: ColorManager.pinkfaint,
                  height: 30,
                  child: Text(headText,style: TableHeadHRDashboard.customTextStyle(context),)),
            ),
            SizedBox(width: 5,),
            Expanded(
              child: Container(
                 // color: ColorManager.pink,
                  height: 30,
                  child: Text(dataText,style: TextStyle(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeight.w400,
                      color: color ?? ColorManager.mediumgrey,
                    decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
                      decorationColor: ColorManager.bluebottom
                  ),)),
            ),
          ],),
          Divider(thickness: 1,color: ColorManager.dashDivider,height: 1,)
        ],
      ),
    );
  }
}
///licenses
class ViewDetailsLicenseConst extends StatelessWidget {
  String? text;
  final String textOval;
  final Color containerColor;
  final VoidCallback? onTap;

  ViewDetailsLicenseConst({
    Key? key,
    required this.text,
    required this.containerColor,
    required this.textOval, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        width: 180,
       // color: Colors.purple,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text!,
              textAlign: TextAlign.start,
              style: CustomTextStylesCommon.commonStyle(
                fontSize: FontSize.s10,
                fontWeight: FontWeight.w700,
                color: Color(0xFF579EBA)
              ),
            ),
            SizedBox(width: 20),
            ClipOval(
              child: Container(
                height: 20,
                width: 21,
                decoration: BoxDecoration(
                  color: containerColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    textOval,
                    textAlign: TextAlign.center,
                    style: ProfileBarClipText.profileTextStyle(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
