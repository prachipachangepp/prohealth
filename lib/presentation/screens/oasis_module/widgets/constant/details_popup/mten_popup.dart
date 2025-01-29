import 'package:flutter/material.dart';

import '../../../them_manager/oasis_them_mnager.dart';
import '../popup_const.dart';

class MTen extends StatelessWidget {
  const MTen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnclickPopup(
      width: 700,
      height:350,

      title: 'M0010', itembody: [
      Column(
        children: [
          Text(
              "Specifies the agency's Centers for Medicare & Medicaid Services (CMS) certification number (CCN/Medicare provider number). ",
              style:Normalfontstyle.customTextStyle(context)
          ),

        ],
      )

    ], responsebody: [
      Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Column(
          children: [
            Text(
              "• Agency administrative and billing staff could be consulted for this item.\n"
                  "• Enter the agency's CMS certification (Medicare provider) number, if applicable.\n"
                  "• If the agency is not Medicare-certified, leave it blank.\n"
                  "• This is NOT the Provider's NPI number.\n"
                  "• Preprinting this number on clinical documentation is allowed and recommended.",
              style: Normalfontstyle.customTextStyle(context),
            ),
          ],
        ),
      )
    ],
    );
  }
}