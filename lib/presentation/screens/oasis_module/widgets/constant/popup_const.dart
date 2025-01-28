import 'package:flutter/material.dart';

import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../them_manager/oasis_them_mnager.dart';

class OnclickPopup extends StatelessWidget {
  final double width;
  final double? height;
  final String title;
 // final List<Widget> body;
  final List<Widget> itembody;
  final List<Widget> responsebody;
  const OnclickPopup({
    super.key,
    required this.width,
    required this.height,
   // required this.body,
    required this.itembody,
    required this.responsebody,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: width,
        height: height ?? AppSize.s500,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorManager.bluebottom,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: AppPadding.p2, horizontal: AppPadding.p20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: AppPadding.p10),
                    child: Text(
                      'Details',
                      style: PopupBlueBarText.customTextStyle(context),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.maximize_sharp,
                          color: ColorManager.white,
                        ),
                      ),
                      IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.compare_arrows_rounded,
                          color: ColorManager.white,
                        ),
                      ),
                      IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          color: ColorManager.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p10, horizontal: AppPadding.p10,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
               // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: AppPadding.p2, horizontal: AppPadding.p20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title,
                                style: BoldfontStyle.customTextStyle(context)),
                            IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              onPressed: () {},
                              icon: Icon(
                                Icons.volume_up_outlined,
                                color: ColorManager.bluebottom,
                                size: IconSize.I18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Item Intent',
                                style: BoldfontStyle.customTextStyle(context)),
                            SizedBox(height: AppSize.s10,),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: itembody,
                              ),
                            ),
                            SizedBox(height: AppSize.s20,),
                            Text('Response - Specific Instructions',
                                style: BoldfontStyle.customTextStyle(context)),
                            SizedBox(height: AppSize.s10,),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: responsebody,
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: AppSize.s5),

            ///button
          ],
        ),
      ),
    );
  }
}

class mten extends StatelessWidget {
  const mten({super.key});

  @override
  Widget build(BuildContext context) {
    return OnclickPopup(
      width: 700,
      height:350,

      title: 'M0100', itembody: [
        Column(
          children: [
            Text(
                "Specifies the agency's Centers for Medicare & Medicaid Services (CMS) certification number (CCN/Medicare provider number). ,",
                style:Normalfontstyle.customTextStyle(context)
            ),

          ],
        )

    ], responsebody: [
      Column(
        children: [
          Text(
              "Agency administrative and billing staff could be consulted for this item."
        " Enter the agency's CMS certification (Medicare provider) number, if applicable."
       "If agency is not Medicare- certified, leave blank."
    "This is NOT the Provider's NPI number."
    "Preprinting this number on clinical documentation is allowed and recommended."
    ,
              style:Normalfontstyle.customTextStyle(context)
          ),

        ],
      )
    ],
    );
  }
}
