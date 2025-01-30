import 'package:flutter/material.dart';

import '../../../../../../app/resources/value_manager.dart';
import '../../../them_manager/oasis_them_mnager.dart';
import '../popup_const.dart';

class Aten extends StatelessWidget {
  const Aten({super.key});

  @override
  Widget build(BuildContext context) {
    return OnclickPopup(
      width: 700,
      height:  MediaQuery.of(context).size.height /1,

      title: 'A1010', itembody: [
      Column(
        children: [
          Text(
              "The intent of this item is to identify the patient’s self-reported race data.",
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
                        "• The ability to improve understanding of and address racial and ethnic disparities in health care outcomes requires the availability of better data related to social determinants of health, including race.\n"
                        "• The ethnicity and race data elements use a two-question format. Collection of A1005, Ethnicity and A1010, Race provides data granularity important for documenting and tracking health disparities and conform to the 2011 Health and Human Services Data Standards.\n"
                        "• Collection of the race data is an important step in improving quality of care and health outcomes.\n"
                        "• Standardizing self-reported data collection for race allows for the equal comparison of data across multiple post-acute care settings.\n"
                        "• These categories are NOT used to determine eligibility for participation in any Federal program.\n"
                        "• \n"
                        "• \n"
                        , style: Normalfontstyle.customTextStyle(context),
                      ),


                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )

    ], responsebody: [
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          children: [
            Text(
              "• Ask the patient to select the category or categories that most closely correspond to the patient’s race from the list in A1010, Race.\n"
                  "• Individuals may be more comfortable if this and the preceding question are introduced by saying" "We want to make sure that all our patients get the best care possible, regardless of their racial background." "\n"
                  "• Respondents should be offered the option of selecting one or more race category.\n"
                  "• If a patient is unable to respond, a proxy response may be used.\n"
                  "• If neither the patient nor a proxy is able to respond to this item use medical record documentation.\n"
                  "• If the patient declines to respond, do not code based on a proxy response or medical record documentation.\n"
                  "• If the patient can provide a response:\n"

                  "• Check all that apply\n"
                  "• Check the box(es) for indicating the race category or categories identified by the patient.\n"

                  "• Complete as close to the time of SOC as possible.\n"
                  "• \n"
                  "• \n"
              // "• Preprinting this number on clinical documentation is allowed and recommended.",
              ,style: Normalfontstyle.customTextStyle(context),
            ),
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
                                  text:"•", style: BoldfontStyle.customTextStyle(context)
                              ),
                              TextSpan(
                                  text: " Code X, Patient unable to respond,", style: BoldfontStyle.customTextStyle(context)
                              ),
                              TextSpan(
                                  text: " if the patient is ", style: Normalfontstyle.customTextStyle(context)
                              ),
                              TextSpan(
                                  text: "unable to respond.", style: BoldfontStyle.customTextStyle(context)
                              ),

                            ],
                          ),
                        ),
                        Text(
                              "•In the cases where the patient is unable to respond, a response may be determined via proxy input. If a proxy is not able to provide a response, medical record documentation may be used.\n"
                              "• If the response(s) is/are determined via proxy input and/or medical documentation, check all boxes that apply, including Code X - Patient unable to respond.\n"
                             // "• \n"
                          // "• Preprinting this number on clinical documentation is allowed and recommended.",
                          ,style: Normalfontstyle.customTextStyle(context),
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text:"•", style: Normalfontstyle.customTextStyle(context)
                              ),
                              TextSpan(
                                  text: "If the patient is unable to respond and no other resources (proxy input or medical record documentation) provided the necessary information, Code X – Patient unable to respond", style: Normalfontstyle.customTextStyle(context)
                              ),
                              TextSpan(
                                  text: "only. ", style: BoldfontStyle.customTextStyle(context)
                              ),


                            ],
                          ),
                        ),

                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text:"•", style: BoldfontStyle.customTextStyle(context)
                              ),
                              TextSpan(
                                  text: "Code Y, Patient declines to respond,", style: BoldfontStyle.customTextStyle(context)
                              ),
                              TextSpan(
                                  text: " if the patient declines ", style: Normalfontstyle.customTextStyle(context)
                              ),
                              TextSpan(
                                  text: "to respond", style: BoldfontStyle.customTextStyle(context)
                              ),

                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text:"•", style: Normalfontstyle.customTextStyle(context)
                              ),
                              TextSpan(
                                  text: "In the cases where the patient declines to respond, Code Y – Patient declines to respond", style: Normalfontstyle.customTextStyle(context)
                              ),
                              TextSpan(
                                  text: "only. ", style: BoldfontStyle.customTextStyle(context)
                              ),


                            ],
                          ),

                        ),
                        Text(
                            "• If the patient declines to respond, do not code based on proxy input or medical record documentation to complete this item.\n"
                          // "• Preprinting this number on clinical documentation is allowed and recommended.",
                          ,style: Normalfontstyle.customTextStyle(context),
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text:"•", style: BoldfontStyle.customTextStyle(context)
                              ),
                              TextSpan(
                                  text: " Code Z, None of the above,", style: BoldfontStyle.customTextStyle(context)
                              ),
                              TextSpan(
                                  text: " , if the patient reports or it is determined from proxy or medical record documentation that none of the listed races apply to the patient. ", style: Normalfontstyle.customTextStyle(context)
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
        ),
      )
    ],
    );
  }
}







///zerofive
class AZeroFive extends StatelessWidget {
  const AZeroFive({super.key});

  @override
  Widget build(BuildContext context) {
    return OnclickPopup(
      width: 700,
      height:  MediaQuery.of(context).size.height /1,

      title: 'A1010', itembody: [
      Column(
        children: [
          Text(
              "The intent of this item is to identify the patient’s self-reported ethnicity data.",
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
                        "• The ability to improve understanding of and address racial and ethnic disparities in health care outcomes requires the availability of better data related to social determinants of health, including race.\n"
                            "• The ethnicity and race data elements use a two-question format. Collection of A1005, Ethnicity and A1010, Race provides data granularity important for documenting and tracking health disparities and conform to the 2011 Health and Human Services Data Standards.\n"
                            "• Collection of the race data is an important step in improving quality of care and health outcomes.\n"
                            "• Standardizing self-reported data collection for race allows for the equal comparison of data across multiple post-acute care settings.\n"
                            "• These categories are NOT used to determine eligibility for participation in any Federal program.\n"
                            "• \n"
                            "• \n"
                        , style: Normalfontstyle.customTextStyle(context),
                      ),


                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )

    ], responsebody: [
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          children: [
            Text(
              "• Ask the patient to select the category or categories that most closely corresponds to the patient’s ethnicity from the list in A1005, Ethnicity.\n"
                  "• Individuals may be more comfortable if this and the subsequent question are introduced by saying," "We want to make sure that all our patients get the best care possible, regardless of their ethnic background." "\n"
                  "• Respondent should be offered the option of selecting one or more ethnic designations.\n"

              ,style: Normalfontstyle.customTextStyle(context),
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text:"•", style: Normalfontstyle.customTextStyle(context)
                  ),
                  TextSpan(
                      text: "If a patient is", style: Normalfontstyle.customTextStyle(context)
                  ),
                  TextSpan(
                      text: " unable to respond ", style: BoldfontStyle.customTextStyle(context)
                  ),
                  TextSpan(
                      text: "a proxy response may be used.", style: Normalfontstyle.customTextStyle(context)
                  ),

                ],
              ),
            ),
                 // "• If a patient is unable to respond, a proxy response may be used.\n"
              Text(

                  "• If neither the patient nor a proxy is able to provide a response to this item, use medical record documentation.\n"
                  "• If a patient declines to respond, do not code based on proxy response or medical record documentation.\n"
                ,style: Normalfontstyle.customTextStyle(context),
              ),
                 // "• If the patient can provide a response:\n"
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text:"•", style: Normalfontstyle.customTextStyle(context)
                  ),
                  TextSpan(
                      text: "If the patient", style: Normalfontstyle.customTextStyle(context)
                  ),
                  TextSpan(
                      text: " can provide a response: ", style: BoldfontStyle.customTextStyle(context)
                  ),


                ],
              ),
            ),
                Text(
                  "• Check all that apply\n"
                  "• Check the box(es) indicating the ethnic category or categories identified by the patient\n"

                  "• Complete as close to the time of SOC as possible\n"
                  "• \n"
                  "• \n"
              // "• Preprinting this number on clinical documentation is allowed and recommended.",
              ,style: Normalfontstyle.customTextStyle(context),
            ),
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
                                  text:"•", style: BoldfontStyle.customTextStyle(context)
                              ),
                              TextSpan(
                                  text: " Code X, Patient unable to respond,", style: BoldfontStyle.customTextStyle(context)
                              ),
                              TextSpan(
                                  text: " if the patient is ", style: Normalfontstyle.customTextStyle(context)
                              ),
                              TextSpan(
                                  text: "unable to respond.", style: Normalfontstyle.customTextStyle(context)
                              ),

                            ],
                          ),
                        ),
                        Text(
                          "•In the cases where the patient is unable to respond, a response may be determined via proxy input. If a proxy is not able to provide a response, medical record documentation may be used.\n"
                              "• If the response(s) is/are determined via proxy input and/or medical documentation, check all boxes that apply, including Code X - Patient unable to respond.\n"
                        "• If the patient is unable to respond and no other resources (proxy input or medical record documentation) provided the necessary information, Code X – Patient unable to respond,only.\n"
                          // "• Preprinting this number on clinical documentation is allowed and recommended.",
                          ,style: Normalfontstyle.customTextStyle(context),
                        ),
                        // Text.rich(
                        //   TextSpan(
                        //     children: [
                        //       TextSpan(
                        //           text:"•", style: Normalfontstyle.customTextStyle(context)
                        //       ),
                        //       TextSpan(
                        //           text: "If the patient is unable to respond and no other resources (proxy input or medical record documentation) provided the necessary information, Code X – Patient unable to respond", style: Normalfontstyle.customTextStyle(context)
                        //       ),
                        //       TextSpan(
                        //           text: "only. ", style: BoldfontStyle.customTextStyle(context)
                        //       ),
                        //
                        //
                        //     ],
                        //   ),
                        // ),

                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text:"•", style: BoldfontStyle.customTextStyle(context)
                              ),
                              TextSpan(
                                  text: "Code Y, Patient declines to respond,", style: BoldfontStyle.customTextStyle(context)
                              ),
                              TextSpan(
                                  text: " if the patient ", style: Normalfontstyle.customTextStyle(context)
                              ),
                              TextSpan(
                                  text: "declines to respond.", style: BoldfontStyle.customTextStyle(context)
                              ),

                            ],
                          ),
                        ),
                        Text(
                          "• In the cases where the patient declines to respond, Code Y – Patient declines to respond,only.\n"
                          // "• Preprinting this number on clinical documentation is allowed and recommended.",
                          ,style: Normalfontstyle.customTextStyle(context),
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text:"•", style: Normalfontstyle.customTextStyle(context)
                              ),
                              TextSpan(
                                  text: "If the patient", style: Normalfontstyle.customTextStyle(context)
                              ),
                              TextSpan(
                                  text: "declines to respond, ", style: BoldfontStyle.customTextStyle(context)
                              ),
                              TextSpan(
                                  text: "do not code based on a proxy input or medical record documentation.", style: Normalfontstyle.customTextStyle(context)
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
        ),
      )
    ],
    );
  }
}