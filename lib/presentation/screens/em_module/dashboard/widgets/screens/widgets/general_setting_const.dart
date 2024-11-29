import 'package:flutter/material.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/theme_manager.dart';
import '../../em_dashboard_const.dart';
///row1 col 1
class GeneralSettingConst extends StatelessWidget {
  const GeneralSettingConst({super.key});

  @override
  Widget build(BuildContext context) {
    return  EMDashboardContainerConst(
        height: 150,
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hello',style: CustomTextStylesCommon.commonStyle(fontSize: 23,
                        color:ColorManager.bluebottom,fontWeight: FontWeight.w700),),
                    Text('"Empower Your Privacy with Precision Settings"',
                      style: CustomTextStylesCommon.commonStyle(fontSize: 14,
                          color: ColorManager.mediumgrey,fontWeight: FontWeight.w400),),
                  ],),
                SizedBox(width: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(child: Image.asset("images/em_dashboard/em_general_pic.png",fit: BoxFit.contain,)),
                  ],
                )
              ]),
        ));
  }
}

///row 1 col 2
class UserRoleDistribution extends StatefulWidget {
   UserRoleDistribution({super.key});

  @override
  State<UserRoleDistribution> createState() => _UserRoleDistributionState();
}

class _UserRoleDistributionState extends State<UserRoleDistribution> {
  int _selectedIndex = 0;

  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;
    });

  }
  @override
  Widget build(BuildContext context) {
    return EMDashboardAllBlueSideContainer(
        height: 150,
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0,top: 10,right: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                            width: 50,
                            height: 50,
                            color: ColorManager.bluebottom,
                            child: Icon(Icons.lock_clock, color: ColorManager
                                .white, size: 24,)
                          // Image.asset(
                          //   imageTile, // Replace with your image path
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                      ),
                      SizedBox(width: 30,),
                      Text("User Password Expiry Status",
                        style: CustomTextStylesCommon.commonStyle(
                            fontSize: 16,
                            color: ColorManager.mediumgrey,
                            fontWeight: FontWeight.w400),),
                    ],
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [
                              ColorManager.mediumgrey,
                              ColorManager.bluebottom
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.srcIn,
                        // Ensures the gradient applies only to the text
                        child: Text(
                          "08",
                          style: CustomTextStylesCommon.commonStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],),
              Padding(
                padding: const EdgeInsets.only(left: 70.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    BlueBgTabButton(
                      index: 0,
                      selectedIndex: _selectedIndex,
                      text: "Admin",
                      onTap: (int index) {
                        _selectButton(index);
                      },
                    ),
                    BlueBgTabButton(
                      index: 1,
                      selectedIndex: _selectedIndex,
                      text: AppStringEM.sales,
                      onTap: (int index) {
                        _selectButton(index);
                      },
                    ),
                    BlueBgTabButton(
                      index: 2,
                      selectedIndex: _selectedIndex,
                      text: "Clinicians",
                      onTap: (int index) {
                        _selectButton(index);
                      },
                    ),
                    BlueBgTabButton(
                      index: 3,
                      selectedIndex: _selectedIndex,
                      text: "Patients",
                      onTap: (int index) {
                        _selectButton(index);
                      },
                    ),
                    BlueBgTabButton(
                      index: 4,
                      selectedIndex: _selectedIndex,
                      text: "Physicians",
                      onTap: (int index) {
                        _selectButton(index);
                      },
                    ),
                  ],
                ),
              ),

            ],
          ),
        ));
  }
}

typedef OnTabTapCallback = void Function(int index);

class BlueBgTabButton extends StatelessWidget {
  const BlueBgTabButton({
    Key? key,
    required this.index,
    required this.selectedIndex,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final int index;
  final int selectedIndex;
  final String text;
  final OnTabTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () => onTap(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0), // Optional spacing
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: selectedIndex == index
                ? ColorManager.bluebottom
                : Colors.transparent,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: FontSize.s12,
              fontWeight: selectedIndex == index
                  ? FontWeight.w700
                  : FontWeight.w500,
              color: selectedIndex == index
                  ? ColorManager.white
                  : ColorManager.mediumgrey,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
