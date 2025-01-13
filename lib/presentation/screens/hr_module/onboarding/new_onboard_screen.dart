import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/banking_tab.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/form_status.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/genaral_tab.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/qualification_tab.dart';
import '../../../../app/resources/color.dart';
import '../../../../app/resources/const_string.dart';
import '../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../app/resources/font_manager.dart';
import '../../../../app/resources/value_manager.dart';
import '../manage/widgets/bottom_row.dart';


class NewOnboardScreen extends StatefulWidget {
  final VoidCallback onBackPressed;
  const NewOnboardScreen({super.key, required this.onBackPressed, });

  @override
  State<NewOnboardScreen> createState() => _NewOnboardScreenState();
}

class _NewOnboardScreenState extends State<NewOnboardScreen> {
  final PageController _onboardPageController = PageController();
  int _selectedIndex = 0;
  int employeeIdCheck = 0;
  String employeeName = '';
  String imageUrl = '';
  int departmentId = 0;

  void _selectButton(int index, int employeeId, String name, String url, int deptId) {
    setState(() {
      _selectedIndex = index;
      employeeIdCheck = employeeId;
      employeeName = name;
      imageUrl = url;
      departmentId = deptId;
    });
    _onboardPageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void _handleBackButton(bool value) {
    if (value) {
      setState(() {
        _selectedIndex = 0;
      });
      _onboardPageController.jumpToPage(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingTabManage(
      managePageController: _onboardPageController,
      selectedIndex: _selectedIndex,
      selectButton: _selectButton,
      employeeId: employeeIdCheck,
      employeeName: employeeName,
      imageUrl: imageUrl,
      backButtonCallBack: _handleBackButton, onBackPressed: widget.onBackPressed, departmentId: departmentId,
    );
  }
}


///
typedef BackButtonCallBack = void Function(bool val);

class OnboardingTabManage extends StatefulWidget {
  final int departmentId;
  final PageController managePageController;
  final int selectedIndex;
  final int employeeId;
  final String employeeName;
  final String imageUrl;
  final BackButtonCallBack backButtonCallBack;
  final VoidCallback onBackPressed;
  final void Function(int,int, String, String, int) selectButton;
  OnboardingTabManage({super.key, required this.managePageController, required this.selectedIndex, required this.selectButton,
    required this.employeeId, required this.employeeName,required this.backButtonCallBack, required this.onBackPressed, required this.imageUrl, required this.departmentId,
  });

  @override
  State<OnboardingTabManage> createState() => _OnboardingTabManageState();
}

class _OnboardingTabManageState extends State<OnboardingTabManage> {
  final List<String> _categories = [
    // AppString.general,
    AppString.qualification,
    AppString.banking,
    AppString.healthRecord,
    AppString.acknowledgement,
    AppString.formStatus
  ];
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white ,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.selectedIndex == 0)
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: InkWell(
                      onTap: widget.onBackPressed,

                      child:Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            size: 20,
                            color: ColorManager.mediumgrey,

                          ),


                        ],
                      )
                  ),
                ),
              ],
            ),
          if (widget.selectedIndex == 0)
            SizedBox(height: 5,),
          if (widget.selectedIndex != 0)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///back
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: InkWell(
                        onTap: (){
                          widget.backButtonCallBack(true);
                        },
                        child:Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_back,
                              size: 20,
                              color: ColorManager.mediumgrey,

                            ),
                          ],
                        )
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (widget.selectedIndex != 0)
                              Padding(
                                padding: const EdgeInsets.only(bottom: AppPadding.p10,left: 1),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white,
                                      child:
                                      ClipOval(
                                        child: CachedNetworkImage(
                                          imageUrl: widget.imageUrl!,
                                          placeholder: (context, url) => CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              CircleAvatar(child: Image.asset("images/profilepic.png"),),
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: AppSize.s10,),
                                    Text(
                                      widget.employeeName,
                                      style: CompanyIdentityManageHeadings.customTextStyle(context),
                                    ),
                                  ],
                                ),
                              ),

                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Material(
                              elevation: 3,  // Set elevation to 0 to remove shadow
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: AppSize.s30,
                                width: MediaQuery.of(context).size.width / 1.68,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: ColorManager.blueprime,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: _categories
                                      .asMap()
                                      .entries
                                      .map(
                                        (entry) => InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      child: Container(
                                        height: AppSize.s30,
                                        width: MediaQuery.of(context).size.width / 8.42,
                                        padding: EdgeInsets.symmetric(vertical: 5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(18),
                                          color: widget.selectedIndex - 1 == entry.key
                                              ? Colors.white
                                              : null,
                                        ),
                                        child: Text(
                                          entry.value,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: FontSize.s14,
                                            fontWeight: FontWeight.w600,
                                            color: widget.selectedIndex - 1 == entry.key
                                                ? ColorManager.mediumgrey
                                                : ColorManager.white,
                                          ),
                                        ),
                                      ),
                                      onTap: () => widget.selectButton(
                                        entry.key + 1,
                                        widget.employeeId,
                                        widget.employeeName,
                                        widget.imageUrl,
                                        widget.departmentId,
                                      ),
                                    ),
                                  )
                                      .toList(),
                                ),
                              ),
                            ),
                          ],
                        )


                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //
                        //     Material(
                        //       elevation: 4,
                        //       borderRadius: BorderRadius.circular(20),
                        //       child: Container(
                        //         height: AppSize.s28,
                        //         width: MediaQuery.of(context).size.width / 1.68,
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(20),
                        //           color: ColorManager.blueprime,
                        //         ),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //           children: _categories
                        //               .asMap()
                        //               .entries
                        //               .map(
                        //                 (entry) => InkWell(
                        //               splashColor: Colors.transparent,
                        //               highlightColor: Colors.transparent,
                        //               hoverColor: Colors.transparent,
                        //               child: Container(
                        //                 height: AppSize.s30,
                        //                 width: MediaQuery.of(context).size.width / 8.42,
                        //                 padding: EdgeInsets.symmetric(vertical: 3),
                        //                 decoration: BoxDecoration(
                        //                   borderRadius: BorderRadius.circular(20),
                        //                   color: widget.selectedIndex - 1 == entry.key //color: widget.selectedIndex == entry.key
                        //                       ? Colors.white : null,
                        //                 ),
                        //                 child: Text(
                        //                   entry.value,
                        //                   textAlign: TextAlign.center,
                        //                   style: TextStyle(
                        //                     fontSize: FontSize.s14,
                        //                     fontWeight: FontWeight.w600,
                        //                     color: widget.selectedIndex - 1 == entry.key //color: widget.selectedIndex == entry.key
                        //                         ? ColorManager.mediumgrey
                        //                         : ColorManager.white,
                        //                   ),
                        //                 ),
                        //               ),
                        //               onTap: () => widget.selectButton(entry.key + 1,widget.employeeId, widget.employeeName,widget.imageUrl,widget.departmentId),  //onTap: () => widget.selectButton(entry.key),
                        //             ),
                        //           )
                        //               .toList(),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  if (widget.selectedIndex != 0)
                  Icon(
                    Icons.arrow_back,
                    size: 20,
                    color: ColorManager.white,

                  )
                  //   Padding(
                  //     padding: const EdgeInsets.only(bottom: AppPadding.p5),
                  //     child: Container(
                  //       //color: ColorManager.red,
                  //       child: Text(
                  //         widget.employeeName,
                  //         style: TextStyle(
                  //           fontSize: FontSize.s15,
                  //           color: ColorManager.white,
                  //           fontWeight: FontWeight.w700,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
            ),
          Expanded(
            flex: 10,
            child: PageView(
              controller: widget.managePageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                OnboardingGeneral(selectButton: widget.selectButton, goBackButtion: widget.onBackPressed),
                OnboardingQualification(employeeId: widget.employeeId, departmentId: widget.departmentId,),
                Banking(employeeId: widget.employeeId,),
                HealthRecord(employeeId: widget.employeeId,),
                Acknowledgement(employeeId: widget.employeeId,),
                FormStatusScreen(employeeId: widget.employeeId,),
              ],
            ),
          ),
          // BottomBarRow(),
        ],
      ),
    );
  }
}




///
///
// Material(
// elevation: 4,
// borderRadius: BorderRadius.circular(20),
// color:  Colors.transparent,
// child: Container(
// height: AppSize.s30,
// width: MediaQuery.of(context).size.width / 1.68,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(20),
// color: ColorManager.blueprime,
// ),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: _categories
//     .asMap()
//     .entries
//     .map(
// (entry) => InkWell(
// splashColor: Colors.transparent,
// highlightColor: Colors.transparent,
// hoverColor: Colors.transparent,
// child: Container(
// height: AppSize.s32,
// width: MediaQuery.of(context).size.width / 8.41,
// padding: EdgeInsets.symmetric(vertical: 3),
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(18),
// color: widget.selectedIndex - 1 == entry.key //color: widget.selectedIndex == entry.key
// ? Colors.white : null,
// ),
// child: Text(
// entry.value,
// textAlign: TextAlign.center,
// style: TextStyle(
// fontSize: FontSize.s14,
// fontWeight: FontWeight.w600,
// color: widget.selectedIndex - 1 == entry.key //color: widget.selectedIndex == entry.key
// ? ColorManager.mediumgrey
//     : ColorManager.white,
// ),
// ),
// ),
// onTap: () => widget.selectButton(entry.key + 1,widget.employeeId, widget.employeeName,widget.imageUrl,widget.departmentId),  //onTap: () => widget.selectButton(entry.key),
// ),
// )
//     .toList(),
// ),
// ),
// ),
///