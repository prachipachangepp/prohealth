import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/dialogue_template.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';

class ContractDocAuditPopup extends StatelessWidget {
  const ContractDocAuditPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(width: 600,
        height: 450, body: [
          SizedBox(height: 10,),
          Container(
            height: AppSize.s30,
            padding: EdgeInsets.only(left: 15,right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "No. of Offices",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.mediumgrey,
                    decoration: TextDecoration.none,
                  ),
                ),
                //Expanded(flex:1 ,child: Container()),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Text(
                    "Status",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.mediumgrey,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                //SizedBox(width: 30,),
                Text(
                  "Random Number",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.mediumgrey,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            height: 260,
            padding: EdgeInsets.only(left: 25,),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 15,
              itemBuilder: (context, index) {
                //int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                // String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                // EmployeeDocumentModal employeedoc = paginatedData[index];
                return Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex:1,
                          child: Text(
                            "Audit 1",
                            textAlign: TextAlign.start,
                            style: CustomTextStylesCommon.commonStyle(
                              fontSize: FontSize.s12,
                              fontWeight: FontWeight.w400,
                              color: ColorManager.black,
                            ),
                          ),
                        ),

                        Expanded(
                          flex:1,
                          child: Text(
                            "Pass",
                            textAlign: TextAlign.center,
                            style: CustomTextStylesCommon.commonStyle(
                              fontSize: FontSize.s12,
                              fontWeight: FontWeight.w400,
                              color: ColorManager.black,
                            ),
                          ),
                        ),
                        Expanded(
                          flex:1,
                          child: Text(
                            "0.12587",
                            textAlign: TextAlign.center,
                            style: CustomTextStylesCommon.commonStyle(
                              fontSize: FontSize.s12,
                              fontWeight: FontWeight.w400,
                              color: ColorManager.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),)
        ],
        bottomButtons: Container(), title: "Random Audit Passed");
  }
}

///penalty popup
class ContractDocPenaltyPopup extends StatelessWidget {
  const ContractDocPenaltyPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(width: 600,
        height: 450, body: [
          SizedBox(height: 10,),
          Container(
            height: AppSize.s30,
            padding: EdgeInsets.only(left: 15,right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "No. of Offices",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.mediumgrey,
                    decoration: TextDecoration.none,
                  ),
                ),
                //Expanded(flex:1 ,child: Container()),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Text(
                    "Date",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.mediumgrey,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                //SizedBox(width: 30,),
                Text(
                  "Penalty Amount",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.mediumgrey,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            height: 260,
            padding: EdgeInsets.only(left: 25,),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 15,
              itemBuilder: (context, index) {
                //int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                // String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                // EmployeeDocumentModal employeedoc = paginatedData[index];
                return Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex:1,
                          child: Text(
                            "Audit 1",
                            textAlign: TextAlign.start,
                            style: CustomTextStylesCommon.commonStyle(
                              fontSize: FontSize.s12,
                              fontWeight: FontWeight.w400,
                              color: ColorManager.black,
                            ),
                          ),
                        ),

                        Expanded(
                          flex:1,
                          child: Text(
                            "27-07-2025",
                            textAlign: TextAlign.center,
                            style: CustomTextStylesCommon.commonStyle(
                              fontSize: FontSize.s12,
                              fontWeight: FontWeight.w400,
                              color: ColorManager.black,
                            ),
                          ),
                        ),
                        Expanded(
                          flex:1,
                          child: Text(
                            r"$500",
                            textAlign: TextAlign.center,
                            style: CustomTextStylesCommon.commonStyle(
                              fontSize: FontSize.s12,
                              fontWeight: FontWeight.w400,
                              color: ColorManager.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),)
        ],
        bottomButtons: Container(), title: "Audit Penalty Amounts");
  }
}
