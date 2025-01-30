import 'package:flutter/material.dart';

import '../../../them_manager/oasis_them_mnager.dart';
import '../popup_const.dart';

class MFourteen extends StatelessWidget {
  const MFourteen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnclickPopup(
      width: 700,
      height:350,

      title: 'M0014', itembody: [
      Column(
        children: [
          Text(
              "Specifies the State where the agency branch office is located.",
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
              "• Agency administrative and billing staff could be consulted for this item.\n"
                 // "• Enter the agency's CMS certification (Medicare provider) number, if applicable.\n"
                  "• Enter the two-letter postal service abbreviation of the State in which the branch office is located\n"
                  "• If a branch ID (not N or P) is entered in M0016, then M0014 cannot be blank.\n"
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










///eighteen popup
class MEighteen extends StatelessWidget {
  const MEighteen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnclickPopup(
      width: 700,
      height:350,

      title: 'M0018', itembody: [
      Column(
        children: [
          Text(
              "Identifies the physician/allowed practitioner who will sign the Plan of Care.",
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
              "• Agency medical records department could be consulted for this item.\n"
              // "• Enter the agency's CMS certification (Medicare provider) number, if applicable.\n"
                  "• For more information see the link for NPI registry in Appendix E of this manual.\n"
                  "• The NPI is a ten-digit numeric identifier.\n",
                 // "• Preprinting this number on clinical documentation is allowed and recommended.",
              style: Normalfontstyle.customTextStyle(context),
            ),
          ],
        ),
      )
    ],
    );
  }
}



///twenty
class MTwenty extends StatelessWidget {
  const MTwenty({super.key});

  @override
  Widget build(BuildContext context) {
    return OnclickPopup(
      width: 700,
      height:350,

      title: 'M0020', itembody: [
      Column(
        children: [
          Text(
              "Identifies the agency-specific patient identifier.",
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
              "• Agency medical records department could be consulted for this item.\n"
              "• Enter the identification code the agency assigns to the patient and uses for record keeping \n   purposes for this episode of care.\n"
                  "• If there are fewer digits than boxes provided, leave boxes at the end blank.\n"
                  "• The patient ID number may stay the same from one admission to the next or may change with each subsequent admission, depending on agency policy. However, it should remain constant throughout a single episode of care (for example, from start of care to discharge).\n",
                 // "• Preprinting this number on clinical documentation is allowed and recommended.",
              style: Normalfontstyle.customTextStyle(context),
            ),
          ],
        ),
      )
    ],
    );
  }
}


///thirty
class MThirty extends StatelessWidget {
  const MThirty({super.key});

  @override
  Widget build(BuildContext context) {
    return OnclickPopup(
      width: 700,
      height:  MediaQuery.of(context).size.height /1,

      title: 'M0030', itembody: [
      Column(
        children: [
          Text(
              "Specifies the start of care date, which is the date that the first reimbursable service is delivered.",
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
              "• Agency administrative staff may be consulted for this item\n"
                  "• In multidiscipline cases, coverage criteria, regulatory requirements (such as the Conditions of Participation), and agency policy establish which discipline’s visit is considered the start of care. A reimbursable service must be delivered to be considered the start of care. All other coverage criteria must be met for this initial service to be billable and to establish the start of care.\n"
                  "• If the day or month is only one digit, that digit should be preceded by a ""0"" (for example, May 4, 2021 = 05/04/2021).\n"
                  "• Enter all four digits for the year.\n"
                  "• For skilled PT or SLP to perform the start of care visit for a Medicare patient:\n"
                  "• the HHA is expected to have orders from the patient’s physician/allowed practitioner indicating the need for physical therapy or SLP prior to the initial assessment visit;\n"
                  "• no orders are present for nursing at the start of care\n"
                  "• a reimbursable service must be provided; and\n"
                  "• the need for this service establishes program eligibility for the Medicare home health benefit.\n"



                  "• For skilled OT to perform the start of care visit for a Medicare patient \n"
                  "• The referral order must not include skilled nursing but does include\n"
                  "• occupational therapy AND\n"
                  "• physical therapy AND/OR speech language pathology\n"
                  "• Note: the above guidance does not alter Medicare's criteria for establishing eligibility for the home health benefit as it relates to occupational therapy.\n"



                  "• Accuracy of this date is essential; many other aspects of data collection are based on this date.\n"
                  "• When the agency's policy/practice is for an RN to perform the SOC assessment in a therapy-only case, the nursing assessment visit must be made the same day or within five days after the therapist’s first visit.\n"
                  "• If questions exist as to the start of care date, clarify the exact date with agency administrative personnel.\n",
              // "• Preprinting this number on clinical documentation is allowed and recommended.",
              style: Normalfontstyle.customTextStyle(context),
            ),
          ],
        ),
      )
    ],
    );
  }
}




///fourty
class MFourty extends StatelessWidget {
  const MFourty({super.key});

  @override
  Widget build(BuildContext context) {
    return OnclickPopup(
      width: 700,
      height:350,

      title: 'M0040', itembody: [
      Column(
        children: [
          Text(
              "Specifies the full name of the patient: first name, middle initial, last name, and suffix (for example, Jr., III, etc.).",
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
              "• The data sources/resources for this item include, the patient's Medicare card, private insurance card, HMO identification card, etc\n"
              "• Enter all letters of the first and last names, the middle initial, and the abbreviated suffix. Correct spelling is important.\n"
              "• If no suffix, leave blank. If middle initial is not known, leave blank.  \n"
              "• The name entered should be exactly as it appears on the patient’s Medicare or other insurance card.\n"
              "• The name entered should be the patient’s legal name, even if the patient consistently uses a nickname.\n"
              "• The sequence of the names may be reordered (that is, last name, first name, etc.) in agency forms, if desired.\n"
              ,style: Normalfontstyle.customTextStyle(context),
            ),
          ],
        ),
      )
    ],
    );
  }
}



///fifty
class MFifty extends StatelessWidget {
  const MFifty({super.key});

  @override
  Widget build(BuildContext context) {
    return OnclickPopup(
      width: 700,
      height:350,

      title: 'M0050', itembody: [
      Column(
        children: [
          Text(
              "Specifies the State in which the patient is currently residing while receiving home care.",
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
              "• The data sources/resources for this item include, municipal, county, or State officials, in order to clarify the exact (State) location of the residence, if necessary.\n"
                  "• Enter the two-letter postal service abbreviation of the State in which the patient is CURRENTLY residing, even if this is not the patient's usual (or legal) residence.\n"

              ,style: Normalfontstyle.customTextStyle(context),
            ),
          ],
        ),
      )
    ],
    );
  }
}



///sixty four
class MSixtyFour extends StatelessWidget {
  const MSixtyFour({super.key});

  @override
  Widget build(BuildContext context) {
    return OnclickPopup(
      width: 700,
      height:350,

      title: 'M0064', itembody: [
      Column(
        children: [
          Text(
              "Specifies the patient’s Social Security number. ",
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
              "• Review the Patient's Social Security card.\n"
                  "• Referral information may include the number, but it should be verified with the patient.\n"
              "•Depending on specific State regulations or procedures, you may need to verify coverage and effective dates with the social services agency. Include all digits and letters. If patient does not have Medicaid coverage or Medicaid coverage is pending, mark" "NA – No Medicaid.""\n"
                  "• Regardless of payer source for the home care episode, indicate if the patient has Medicaid.",
              style: Normalfontstyle.customTextStyle(context),
            ),
          ],
        ),
      )
    ],
    );
  }
}





///sixty five
class MSixtyFive extends StatelessWidget {
  const MSixtyFive({super.key});

  @override
  Widget build(BuildContext context) {
    return OnclickPopup(
      width: 700,
      height:350,

      title: 'M0065', itembody: [
      Column(
        children: [
          Text(
              "Specifies the patient's Medicaid number. ",
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
              "• Review the patient's Medicaid card or other verifying information.\n"
                  "• Referral information may include the number, but it should be verified with the patient. Make sure that coverage is still in effect by checking the expiration date.\n"
              // "• This is NOT the Provider's NPI number.\n"
                  "• Include all nine numbers. Mark" "UK" "if unknown or not available (for example, information cannot be obtained or patient refuses to provide information).",
              style: Normalfontstyle.customTextStyle(context),
            ),
          ],
        ),
      )
    ],
    );
  }
}




///sixty six
class MSixtySix extends StatelessWidget {
  const MSixtySix({super.key});

  @override
  Widget build(BuildContext context) {
    return OnclickPopup(
      width: 700,
      height:350,

      title: 'M0066', itembody: [
      Column(
        children: [
          Text(
              "Specifies the birth date of the patient, including month, day, and four digits for the year. ",
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
              "• Interview the patient and/or caregiver report, or review other legal documents (driver's license, stateissued ID card, etc.).\n"
                  "• Referral information may include the number, but it should be verified with the patient. Make sure that coverage is still in effect by checking the expiration date.\n"
               "• If the day or month is only one digit, that digit should be preceded by a" "0"" (for example, May 4, 2021= 05/04/2021).\n"
                  "• Enter all four digits of the year.",
              style: Normalfontstyle.customTextStyle(context),
            ),
          ],
        ),
      )
    ],
    );
  }
}



///sixty nine
class MSixtyNine extends StatelessWidget {
  const MSixtyNine({super.key});

  @override
  Widget build(BuildContext context) {
    return OnclickPopup(
      width: 700,
      height:350,

      title: 'M0069', itembody: [
      Column(
        children: [
          Text(
              "Specifies the gender of the patient. ",
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
              "• Interview the patient and/or caregiver. If the patient does not self-identify, referral information (including hospital or physician office clinical data), or observation and physical assessment may be used.\n"
                  // "• Referral information may include the number, but it should be verified with the patient. Make sure that coverage is still in effect by checking the expiration date.\n"
                  // "• If the day or month is only one digit, that digit should be preceded by a" "0"" (for example, May 4, 2021= 05/04/2021).\n"
                  "• Based on the resources mentioned above, enter a response for patient's gender.",
              style: Normalfontstyle.customTextStyle(context),
            ),
          ],
        ),
      )
    ],
    );
  }
}




///one Fifty
class MOneFifty extends StatelessWidget {
  const MOneFifty({super.key});

  @override
  Widget build(BuildContext context) {
    return OnclickPopup(
      width: 700,
      height:350,

      title: 'M0150', itembody: [
      Column(
        children: [
          Text(
              "This item identifies payers who will be billed by your home health agency for services provided during the home health episode.",
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
              "• Review referral information and health insurance identification cards\n"
              "• Exclude" "pending" "payment sources.\n"
              "• If the patient's care is being reimbursed by multiple payers (for example, Medicare and Medicaid; private insurance and self-pay; etc.), include all sources.\n"
              "• If one or more payment sources are known but additional sources are uncertain, mark only those that are known.\n"
              "• Do not consider any equipment, medications, or supplies being paid for by the patient in part or in full.\n"
              , style: Normalfontstyle.customTextStyle(context),
            ),
          ],
        ),
      )
    ],
    );
  }
}




///Eighty
class MEighty extends StatelessWidget {
  const MEighty({super.key});

  @override
  Widget build(BuildContext context) {
    return OnclickPopup(
      width: 700,
      height:350,

      title: 'M0080', itembody: [
      Column(
        children: [
          Text(
              "Specifies the discipline of the clinician completing the comprehensive assessment at the specified OASIS time point or the clinician reporting the transfer to an inpatient facility or death at home",
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
              "• Data sources/resources for this item are agency policies.\n"
                  "• Enter the response associated with the discipline of the individual completing the assessment (referred to as the assessing clinician).\n"
                  // "• If the patient's care is being reimbursed by multiple payers (for example, Medicare and Medicaid; private insurance and self-pay; etc.), include all sources.\n"
                  // "• If one or more payment sources are known but additional sources are uncertain, mark only those that are known.\n"
                  // "• Do not consider any equipment, medications, or supplies being paid for by the patient in part or in full.\n"
              , style: Normalfontstyle.customTextStyle(context),
            ),
          ],
        ),
      )
    ],
    );
  }
}





///Hundred
class MHundred extends StatelessWidget {
  const MHundred({super.key});

  @override
  Widget build(BuildContext context) {
    return OnclickPopup(
      width: 700,
      height:350,

      title: 'M0100', itembody: [
      Column(
        children: [
          Text(
              " Identifies the “time point” – reason why the assessment data are being collected and reported.",
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
              "• Consult with the agency case manager or other care team provider and/or the clinical record. Hospital or other health care provider information may identify transfer to inpatient facility or death at home.\n"
                 // "• Enter the response associated with the discipline of the individual completing the assessment (referred to as the assessing clinician).\n"
              // "• If the patient's care is being reimbursed by multiple payers (for example, Medicare and Medicaid; private insurance and self-pay; etc.), include all sources.\n"
              // "• If one or more payment sources are known but additional sources are uncertain, mark only those that are known.\n"
              // "• Do not consider any equipment, medications, or supplies being paid for by the patient in part or in full.\n"
              , style: Normalfontstyle.customTextStyle(context),
            ),
          ],
        ),
      )
    ],
    );
  }
}