import 'dart:html';

import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_insurance/ci_insurance_contract.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_insurance/ci_insurance_vendor.dart';


class CiPageview extends StatelessWidget {
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
    required this.screenList, required this.mediaQueryWidth,
  }) : super(key: key);
   // CiInsurancePageview({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
          child: Container(
            height: 28,
            width: MediaQuery.of(context).size.width / mediaQueryWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: nameList
                  .asMap()
                  .entries
                  .map(
                    (entry) => InkWell(
                      splashColor: Colors.white,
                  highlightColor: Colors.white,
                  hoverColor: Colors.white,
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width / 10,
                    // padding: EdgeInsets.all(10),
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(20),
                    //   color: selectedIndex == entry.key
                    //       ? Colors.white
                    //       : null,
                    // ),
                    child: Column(
                      children: [
                        Text(
                          entry.value,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color:selectedIndex == entry.key
                                ? ColorManager.blueprime
                                : Colors.black54,

                          ),
                        ),
                        selectedIndex == entry.key ?
                        Divider(color:ColorManager.blueprime,):Offstage()
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


