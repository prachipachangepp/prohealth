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

///big popup
class FullScreenPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              IconButton(onPressed: (){
                Navigator.pop(context);
              },
                icon: Icon(Icons.close,))
            ],),
          ),
        SizedBox(height: 200,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: ColorManager.mediumgrey,
                  ),
                  children: [
                    TextSpan(text: "You have "),
                    TextSpan(
                      text: "30 ",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        color: ColorManager.bluebottom,
                      ),
                    ),
                    TextSpan(text: "days remaining before your contract expires."),
                  ],
                ),
              ),
                  SizedBox(height: 20),
                  Text(
                    "Your Auto-Renew is OFF\nYour subscription will NOT automatically renew",
                    style: TextStyle(fontSize: 20, color: ColorManager.mediumgrey,fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      // Add your auto-renew logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.EMbrightred,
                      shadowColor: ColorManager.mediumgrey,
                      elevation: 6,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // Adjust the radius for a more circular shape
                      ),
                    ),
                    child: Text(
                      "TURN AUTO-RENEW ON",
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 11),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "go back",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: ColorManager.blueprime),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}