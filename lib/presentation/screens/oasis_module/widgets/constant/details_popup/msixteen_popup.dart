import 'package:flutter/material.dart';

import '../../../../../../app/resources/value_manager.dart';
import '../../../them_manager/oasis_them_mnager.dart';
import '../popup_const.dart';

class MsixteenPopup extends StatelessWidget {
  const MsixteenPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return OnclickPopup(
      width: 700,
      height:400,

      title: 'M0016', itembody: [
      Column(
        children: [
          Text(
              "Specifies the branch identification code, as assigned by CMS. ",
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
                  "• Enter the Federal branch identification number specified for this branch as assigned by CMS.\n"
                  "• The identifier consists of 10 digits – the State code as the first two digits, followed by Q (upper    \n   case),followed by the last four digits of the current Medicare provider number, ending with the \n    three-digit CMSassigned branch number.\n"
                 // "• This is NOT the Provider's NPI number.\n"
                  "• Preprinting this number on clinical documentation is allowed and recommended.",
              style: Normalfontstyle.customTextStyle(context),
            ),

          ],
        ),
      ),
      SizedBox(height: AppSize.s20,),
      Text('Coding Instructions',
          style: BoldfontStyle.customTextStyle(context)),
      SizedBox(height: AppSize.s10,),
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Column(
                children: [
                  Text(
                    "• Code N,if you are an HHA with no branches. The remaining 9 boxes should be blank.\n"
                        "• Code P,if you are a parent HHA that has branches. The remaining 9 boxes should be blank.\n",
                    //     "•The identifier consists of 10 digits – the State code as the first two digits, followed by Q (upper case),followed by the last four digits of the current Medicare provider number, ending with the three-digit CMSassigned branch number.\n"
                    // // "• This is NOT the Provider's NPI number.\n"
                    //     "• Preprinting this number on clinical documentation is allowed and recommended.",
                    style: Normalfontstyle.customTextStyle(context),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    ],
    );
  }
}





/// thirty two


class MThirtyTwoPopup extends StatelessWidget {
  const MThirtyTwoPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return OnclickPopup(
      width: 700,
      height:400,

      title: 'M0032', itembody: [
      Column(
        children: [
          Text(
              "Specifies the date of the first visit following an inpatient stay by a patient receiving service from the home health agency. ",
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
              "• Agency administrative staff may be consulted for this item\n"
                  "• The resumption of care date must be updated on the Patient Tracking Sheet each time a patient returns to service following an inpatient facility stay.\n"
                  "• The most recent resumption of care date should be entered.\n"
               "• If the day or month is only one digit, that digit is preceded by a ""0"" (for example May 4, 2021, = 05/04/2021).\n"
                  "• Enter all four digits of the year.",
              style: Normalfontstyle.customTextStyle(context),
            ),

          ],
        ),
      ),
      SizedBox(height: AppSize.s20,),
      Text('Coding Instructions',
          style: BoldfontStyle.customTextStyle(context)),
      SizedBox(height: AppSize.s10,),
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Column(
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text:"•", style: Normalfontstyle.customTextStyle(context)
                        ),
                        TextSpan(
                            text: " Code NA,", style: BoldfontStyle.customTextStyle(context)
                        ),
                        TextSpan(
                            text: " if a start of care assessment", style: Normalfontstyle.customTextStyle(context)
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    ],
    );
  }
}




///sixty
class MSixty extends StatelessWidget {
  const MSixty({super.key});

  @override
  Widget build(BuildContext context) {
    return OnclickPopup(
      width: 700,
      height:350,

      title: 'M0060', itembody: [
      Column(
        children: [
          Text(
              " Specifies the ZIP code for the address at which the patient is currently residing while receiving home care.",
              style:Normalfontstyle.customTextStyle(context)
          ),
          SizedBox(height: AppSize.s20,),
          Text('Item Rationale',
              style: BoldfontStyle.customTextStyle(context)),
          SizedBox(height: AppSize.s10,),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(
                    children: [
                      Text(
                        "• The patient’s ZIP code is used for Care Compare to determine places where your agency provides service.\n"
                           ,
                        style: Normalfontstyle.customTextStyle(context),
                      ),


                    ],
                  ),
                ),
              ],
            ),
          ),

        ],
      )

    ],



      responsebody: [
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          children: [
            Text(
                  "• The data sources/resources for this item include the post office, to verify the ZIP code, if necessary.\n"
                  "• Enter the ZIP code for the address of the patient's CURRENT residence, even if this is not the patient's usual (or legal) residence.\n"
                  "• Be sure to use the ZIP code where the service is provided.\n"
                  "• Enter at least five digits (nine digits if known).\n"

              ,style: Normalfontstyle.customTextStyle(context),
            ),
          ],
        ),
      )
    ],
    );
  }
}






///sixty three
class MSixtyThree extends StatelessWidget {
  const MSixtyThree({super.key});

  @override
  Widget build(BuildContext context) {
    return OnclickPopup(
      width: 700,
      height:350,

      title: 'M0063', itembody: [
      Column(
        children: [
          Text(
              "This item identifies the patient's Medicare number, including any prefixes or suffixes.",
              style:Normalfontstyle.customTextStyle(context)
          ),

        ],
      )

    ], responsebody: [
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          children: [
            Text(
              "• Review the patient's Medicare card. The referral information may include the number, but it should be verified with the patient. \n"
                  "• In an effort to fight identity theft for Medicare beneficiaries, CMS replaced the Social Security number (SSN)-based Health Insurance Claim Number (HICN) with a new Medicare Beneficiary Identifier (MBI). \n"

                  "• After December 31, 2019: Enter the MBI. Do not report the patient's SSN-based HICN. \n"

                  "• If the patient does not have Medicare, mark"" NA – No Medicare."" \n"
                  "• If the patient is a member of a Medicare HMO, another Medicare Advantage plan, or Medicare Part C, enter the Medicare number if available. If not available, mark " "NA – No Medicare." "Do not enter the HMO identification number." "\n"
                  "• Enter Medicare number (if known) whether or not Medicare is the primary payment source for this episode of care. \n"
                  "• If there are fewer digits than boxes provided, leave boxes at the end blank. \n"

              ,style: Normalfontstyle.customTextStyle(context),
            ),
          ],
        ),
      )
    ],
    );
  }
}



