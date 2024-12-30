import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_scheduler/widget/schedular/widget/completed_page.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_scheduler/widget/schedular/widget/history_page.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_scheduler/widget/schedular/widget/overdue_page.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_scheduler/widget/schedular/widget/pending_page.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_scheduler/widget/schedular/widget/poc_page.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_scheduler/widget/schedular/widget/soc_page.dart';

import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../widgets/app_clickable_widget.dart';
import '../../../../em_module/company_identity/company_identity_screen.dart';

class NewSchedulerScreen extends StatefulWidget {
  const NewSchedulerScreen({super.key});

  @override
  State<NewSchedulerScreen> createState() => _NewSchedulerScreenState();
}

class _NewSchedulerScreenState extends State<NewSchedulerScreen> {


  final PageController _tabPageController = PageController();
  int _selectedIndex = 0;

  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;
    //
    //   _updateSelectedSubDocId(index == 0
    //       ? AppConfig.subDocId1Licenses
    //       : index == 1
    //       ? AppConfig.subDocId2Adr
    //       : index == 2
    //       ? AppConfig.subDocId3CICCMedicalCR
    //       : index == 3
    //       ? AppConfig.subDocId4CapReport
    //       : AppConfig.subDocId5BalReport);
    });
    _tabPageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 200,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SMTabbar(onTap: (int index){
                _selectButton(0);
              }, index: 0, grpIndex: _selectedIndex, heading: "Pending",badgeNumber: 55, ),
              SMTabbar(onTap: (int index){
                _selectButton(1);
              }, index: 1, grpIndex: _selectedIndex, heading: "SOC"),
              SMTabbar(onTap: (int index){
                _selectButton(2);
              }, index: 2, grpIndex: _selectedIndex, heading: "POC"),
              SMTabbar(onTap: (int index){
                _selectButton(3);
              }, index: 3, grpIndex: _selectedIndex, heading: "Overdue",badgeNumber: 55),
              SMTabbar(onTap: (int index){
                _selectButton(4);
              }, index: 4, grpIndex: _selectedIndex, heading: "Completed"),
              SMTabbar(onTap: (int index){
                _selectButton(5);
              }, index: 5, grpIndex: _selectedIndex, heading: "History"),

            ],
          ),
        ),


        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 60),
            child: NonScrollablePageView(
              controller: _tabPageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: [
                // Page 1
                PendingPageView(
                  // docId: widget.docId,
                  // subDocId: AppConfig.subDocId1Licenses,
                  // officeId: widget.officeId,
                ),
                SocPageView(
                  // docId: widget.docId,
                  // subDocId: AppConfig.subDocId2Adr,
                  // officeId: widget.officeId,
                ),
                PocPageView(
                  // docId: widget.docId,
                  // subDocId: AppConfig.subDocId3CICCMedicalCR,
                  // officeId: widget.officeId,
                ),
                OverdeuPageView(
                  // docId: widget.docId,
                  // subDocId: AppConfig.subDocId4CapReport,
                  // officeId: widget.officeId,
                ),
                CompletedPageView(
                  // docId: widget.docId,
                  // subDocId: AppConfig.subDocId5BalReport,
                  // officeId: widget.officeId,
                ),
                HistoryPageView(),
              ],
            ),
          ),
        )
      ],
    );
  }
}







typedef void OnManuButtonTapCallBack(int index);



class SMTabbar extends StatelessWidget {
  const SMTabbar({
    super.key,
    required this.onTap,
    required this.index,
    required this.grpIndex,
    required this.heading,
    this.badgeNumber, // Optional badge number parameter
  });

  final OnManuButtonTapCallBack onTap;
  final int index;
  final int grpIndex;
  final String heading;
  final int? badgeNumber; // Badge number is optional

  @override
  Widget build(BuildContext context) {
    return AppClickableWidget(
      onTap: () {
        onTap(index);
      },
      onHover: (bool val) {},
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none, // Allows badge to overflow
            children: [
              Container(
                width: 100, // Fixed width for the heading container
                height: 40, // Fixed height for the heading container
                child: Align(
                  alignment: Alignment.center, // Align text to the left
                  child: Text(
                    heading,
                    style: TextStyle(
                      fontSize: FontSize.s14,
                      fontWeight: grpIndex == index
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: grpIndex == index
                          ? ColorManager.blueprime
                          : ColorManager.mediumgrey,
                    ),
                  ),
                ),
              ),
              if (badgeNumber != null) // Only show badge if badgeNumber is not null
                Positioned(
                 // top: -5, // Adjust position of the badge
                  right: -5, // Adjust position of the badge
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: ColorManager.blueprime, // Badge color
                      borderRadius: BorderRadius.circular(12), // Rounded badge
                    ),
                    child: Text(
                      badgeNumber!.toString(),
                      style: TextStyle(
                        fontSize: FontSize.s10, // Adjust font size
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Badge text color
                      ),
                    ),
                  ),
                ),
            ],
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final textPainter = TextPainter(
                text: TextSpan(
                  text: heading,
                  style: TextStyle(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                textDirection: TextDirection.ltr,
              )..layout();

              final textWidth = textPainter.size.width;

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                height: 2,
                width: textWidth + 100, // Adjust padding around text
                color: grpIndex == index
                    ? ColorManager.blueprime
                    : Colors.transparent,
              );
            },
          ),
        ],
      ),
    );
  }
}







// class SMTabbar extends StatelessWidget {
//   const SMTabbar({
//     super.key,
//     required this.onTap,
//     required this.index,
//     required this.grpIndex,
//     required this.heading,
//   });
//
//   final OnManuButtonTapCallBack onTap;
//   final int index;
//   final int grpIndex;
//   final String heading;
//
//   @override
//   Widget build(BuildContext context) {
//     return AppClickableWidget(
//       onTap: () {
//         onTap(index);
//       },
//       onHover: (bool val) {},
//       child: Column(
//         children: [
//           Text(
//             heading,
//             style: TextStyle(
//               fontSize: FontSize.s14,
//               fontWeight: grpIndex == index
//                   ? FontWeight.w700
//                   : FontWeight.w500,
//               color: grpIndex == index
//                   ? ColorManager.blueprime
//                   : ColorManager.mediumgrey,
//             ),
//           ),
//           LayoutBuilder(
//             builder: (context, constraints) {
//               final textPainter = TextPainter(
//                 text: TextSpan(
//                   text: heading,
//                   style: TextStyle(
//                     fontSize: FontSize.s14,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 textDirection: TextDirection.ltr,
//               )..layout();
//
//               final textWidth = textPainter.size.width;
//
//               return Container(
//                 margin: const EdgeInsets.symmetric(vertical: 5),
//                 height: 2,
//                 width: textWidth + 20, // Adjust padding around text
//                 color: grpIndex == index
//                     ? ColorManager.blueprime
//                     : Colors.transparent,
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
