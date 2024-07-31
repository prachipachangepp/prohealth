import 'package:flutter/material.dart';

import '../../../widgets/app_bar/app_bar.dart';
import '../../hr_module/manage/widgets/bottom_row.dart';

class SMDesktopScreen extends StatelessWidget {
  const SMDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Column(
          children: [
            const ApplicationAppBar(headingText: "Scheduling Manager"),
            ///2nd  buttons
            // Container(
            //   margin: const EdgeInsets.symmetric(vertical: AppPadding.p20, horizontal: AppPadding.p20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //           Obx(
            //                 () => CustomTitleButton(
            //               height: 30,
            //               width: 100,
            //               onPressed: () {
            //                 //companyAll(context);
            //                 myController.selectButton(0);
            //                 _pageController.animateToPage(0,
            //                     duration: Duration(milliseconds: 500),
            //                     curve: Curves.ease);
            //               },
            //               text: 'Dashboard',
            //               isSelected: myController.selectedIndex.value == 0,
            //             ),
            //           ),
            //           SizedBox(
            //             width: 10,
            //           ),
            //           Obx(
            //                 () => CustomTitleButton(
            //               height: 30,
            //               width: 140,
            //               onPressed: () {
            //                 // uploadCompanyLogoApi(context, 5, "employ");
            //                 companyByIdApi(context,);
            //                 // companyDetailsApi(context,5);
            //                 myController.selectButton(1);
            //                 _pageController.animateToPage(1,
            //                     duration: Duration(milliseconds: 500),
            //                     curve: Curves.ease);
            //               },
            //               text: 'Company Identity',
            //               isSelected: myController.selectedIndex.value == 1,
            //             ),
            //           ),
            //
            //           SizedBox(
            //             width: 15,
            //           ),
            //           Obx(
            //                 () => Material(
            //               elevation: 4,
            //               borderRadius: BorderRadius.all(Radius.circular(12)),
            //               child: CustomDropdownButton(
            //                 height: 30,
            //                 width: 170,
            //                 items: [
            //                   DropdownMenuItem<String>(
            //                     value: 'Select a module',
            //                     child: Text(
            //                       'Select a module',
            //                       textAlign: TextAlign.center,
            //                       style: GoogleFonts.firaSans(
            //                           fontSize: FontSize.s12,
            //                           fontWeight: FontWeight.w700,
            //                           color: ColorManager.textPrimaryColor
            //                         // color: isSelected ? Colors.white : Colors.black,
            //                       ),
            //                     ),
            //                   ),
            //                   DropdownMenuItem<String>(
            //                     value: 'HR',
            //                     child: Text(
            //                       'HR',
            //                       textAlign: TextAlign.center,
            //                       style: GoogleFonts.firaSans(
            //                           fontSize: FontSize.s12,
            //                           fontWeight: FontWeight.w700,
            //                           color: ColorManager.textPrimaryColor
            //                         // color: isSelected ? Colors.white : Colors.black,
            //                       ),
            //                     ),
            //                     onTap: () {
            //                       if (myController.selectedIndex.value != 2) {
            //                         myController.selectButton(2);
            //                         _pageController.animateToPage(
            //                           2,
            //                           duration: Duration(milliseconds: 500),
            //                           curve: Curves.ease,
            //                         );
            //                       }
            //                     },
            //                   ),
            //                   DropdownMenuItem<String>(
            //                     value: 'All from HR',
            //                     child: Padding(
            //                       padding: EdgeInsets.only(left: 20),
            //                       child: Text(
            //                         'All from HR',
            //                         textAlign: TextAlign.center,
            //                         style: GoogleFonts.firaSans(
            //                             fontSize: FontSize.s12,
            //                             fontWeight: FontWeight.w400,
            //                             color: ColorManager.textPrimaryColor
            //                           // color: isSelected ? Colors.white : Colors.black,
            //                         ),
            //                       ),
            //                     ),
            //                     onTap: () {
            //                       if (myController.selectedIndex.value != 2) {
            //                         myController.selectButton(2);
            //                         _pageController.animateToPage(
            //                           2,
            //                           duration: Duration(milliseconds: 500),
            //                           curve: Curves.ease,
            //                         );
            //                       }
            //                     },
            //                   ),
            //                   DropdownMenuItem<String>(
            //                     value: 'Work Schedule',
            //                     child: Padding(
            //                       padding: EdgeInsets.only(left: 20),
            //                       child: Text(
            //                         'Work Schedule',
            //                         textAlign: TextAlign.center,
            //                         style: GoogleFonts.firaSans(
            //                             fontSize: FontSize.s12,
            //                             fontWeight: FontWeight.w400,
            //                             color: ColorManager.textPrimaryColor
            //                           // color: isSelected ? Colors.white : Colors.black,
            //                         ),
            //                       ),
            //                     ),
            //                     onTap: () {
            //                       if (myController.selectedIndex.value != 3) {
            //                         myController.selectButton(3);
            //                         _pageController.animateToPage(
            //                           3,
            //                           duration: Duration(milliseconds: 500),
            //                           curve: Curves.ease,
            //                         );
            //                       }
            //                     },
            //                   ),
            //                   DropdownMenuItem<String>(
            //                     value: 'Employee Documents',
            //                     child: Padding(
            //                       padding: EdgeInsets.only(left: 20),
            //                       child: Text(
            //                         'Employee Documents',
            //                         textAlign: TextAlign.center,
            //                         style: GoogleFonts.firaSans(
            //                             fontSize: FontSize.s12,
            //                             fontWeight: FontWeight.w400,
            //                             color: ColorManager.textPrimaryColor
            //                           // color: isSelected ? Colors.white : Colors.black,
            //                         ),
            //                       ),
            //                     ),
            //                     onTap: () {
            //                       if (myController.selectedIndex.value != 4) {
            //                         myController.selectButton(4);
            //                         _pageController.animateToPage(
            //                           4,
            //                           duration: Duration(milliseconds: 500),
            //                           curve: Curves.ease,
            //                         );
            //                       }
            //                     },
            //                   ),
            //                   DropdownMenuItem<String>(
            //                     value: 'Finance',
            //                     child: Text(
            //                       'Finance',
            //                       textAlign: TextAlign.center,
            //                       style: GoogleFonts.firaSans(
            //                           fontSize: FontSize.s12,
            //                           fontWeight: FontWeight.w700,
            //                           color: ColorManager.textPrimaryColor
            //                         // color: isSelected ? Colors.white : Colors.black,
            //                       ),
            //                     ),
            //                     onTap: () {
            //                       if (myController.selectedIndex.value != 5) {
            //                         myController.selectButton(5);
            //                         _pageController.animateToPage(
            //                           5,
            //                           duration: Duration(milliseconds: 500),
            //                           curve: Curves.ease,
            //                         );
            //                       }
            //                     },
            //                   ),
            //                   DropdownMenuItem<String>(
            //                     value: 'Pay Rates',
            //                     child: Padding(
            //                       padding: EdgeInsets.only(left: 20),
            //                       child: Text(
            //                         'Pay Rates',
            //                         textAlign: TextAlign.center,
            //                         style: GoogleFonts.firaSans(
            //                             fontSize: FontSize.s12,
            //                             fontWeight: FontWeight.w400,
            //                             color: ColorManager.textPrimaryColor
            //                           // color: isSelected ? Colors.white : Colors.black,
            //                         ),
            //                       ),
            //                     ),
            //                     onTap: () {
            //                       if (myController.selectedIndex.value != 5) {
            //                         myController.selectButton(5);
            //                         _pageController.animateToPage(
            //                           5,
            //                           duration: Duration(milliseconds: 500),
            //                           curve: Curves.ease,
            //                         );
            //                       }
            //                     },
            //                   ),
            //                 ],
            //                 selectedItem: myController.selectedIndex.value == 2
            //                     ? 'HR'
            //                     : myController.selectedIndex.value == 3
            //                     ? 'Work Schedule'
            //                     : myController.selectedIndex.value == 4
            //                     ? 'Employee Documents'
            //                     : myController.selectedIndex.value == 5
            //                     ? 'Finance'
            //                     : 'Select a module',
            //                 onChanged: (newValue) {
            //                   // Not needed for this implementation
            //                 },
            //               ),
            //             ),
            //           ),
            //
            //           SizedBox(
            //             width: 15,
            //           ),
            //         ],
            //       ),
            //
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.end,
            //         crossAxisAlignment: CrossAxisAlignment.end,
            //         children: [
            //           Obx(
            //                 () => CustomTitleButton(
            //               height: 30,
            //               width: 100,
            //               onPressed: () {
            //                 //companyAll(context);
            //                 myController.selectButton(6);
            //                 _pageController.animateToPage(6,
            //                     duration: Duration(milliseconds: 500),
            //                     curve: Curves.ease);
            //               },
            //               text: 'See All',
            //               isSelected: myController.selectedIndex.value == 6,
            //             ),
            //           ),
            //         ],
            //       )
            //     ],
            //   ),
            // ),
            // Expanded(
            //   flex: 8,
            //   child: PageView(
            //     controller: _pageController,
            //     physics: NeverScrollableScrollPhysics(),
            //     children: [
            //       Container(color: ColorManager.white),
            //       CompanyIdentityScreen(),
            //       HrScreen(),
            //       ManageWorkSchedule(),
            //       ManageEmployDocument(),
            //
            //       FinanceScreen(),
            //
            //       SeeAllScreen(),
            //
            //       // WhitelabellingScreen()
            //     ],
            //   ),
            // ),

            BottomBarRow()
          ],
        ),
      ]),
    );
  }
}

//