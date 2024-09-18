
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_insurance/ci_insurance_contract.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_insurance/ci_insurance_vendor.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';


class CiPageview extends StatelessWidget {
  final int docId;
  final PageController managePageController;
  final int selectedIndex;
  final Function(int) selectButton;
  final List<String> nameList;
  final List<Widget> screenList;
  final double mediaQueryWidth;


  CiPageview({
    Key? key,
    required this.managePageController,
    required this.selectedIndex,
    required this.selectButton,
    required this.nameList,
    required this.screenList, required this.mediaQueryWidth, required this.docId,
  }) : super(key: key);
  // CiInsurancePageview({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 8),
          child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width / mediaQueryWidth,
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: nameList
                  .asMap()
                  .entries
                  .map(
                    (entry) => InkWell(
                  //splashColor: Colors.white,
                  highlightColor: Color(0xFFF2F9FC),
                  hoverColor: Color(0xFFF2F9FC),
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 10,
                    child: Column(
                      children: [
                        Text(
                          entry.value,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.firaSans(
                            fontSize: FontSize.s12,
                            fontWeight: selectedIndex == entry.key
                                ? FontWeight.w700
                                : FontWeight.w400,
                            color:selectedIndex == entry.key
                                ? ColorManager.blueprime
                                : ColorManager.mediumgrey,

                          ),
                        ),
                        selectedIndex == entry.key ?
                        Divider(color:ColorManager.blueprime,thickness: 2,):Offstage()
                      ],
                    ),
                  ),
                  onTap: () => selectButton(entry.key),
                ),
              )
                  .toList(),
            ),
          ),
        ),
       
        Expanded(
          flex: 10,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 60),
            child: PageView(
                controller: managePageController,
                physics: NeverScrollableScrollPhysics(),
                children: screenList),
          ),
        ),
      ],
      ),
    );
  }
}