import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/add_employee/clinical_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/register_manager/main_register_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/register_manager/register_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/add_employee/clinical.dart';
import 'package:prohealth/presentation/screens/hr_module/register/register_enroll_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/after_clicking_on_link/on_boarding_welcome.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/register_row_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../app/resources/font_manager.dart';
import '../../../../data/api_data/establishment_data/user/user_modal.dart';
import '../../../../data/api_data/hr_module_data/register_data/main_register_screen_data.dart';
import '../../em_module/see_all_screen/widgets/popup_const.dart';
import '../manage/widgets/custom_icon_button_constant.dart';
import 'confirmation_constant.dart';

///saloni
class RegisterScreen extends StatefulWidget {
  final VoidCallback onBackPressed;
  final Function() onRefresh;

  const RegisterScreen({
    Key? key,
    required this.onRefresh,
    required this.onBackPressed,
  }) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final StreamController<List<RegisterDataCompID>> registerController =
      StreamController<List<RegisterDataCompID>>();
  late int currentPage;
  late int itemsPerPage;
  late List<String> items;

  /// register enroll user
  TextEditingController newUserFirstNameController = TextEditingController();
  TextEditingController newUserLastNameController = TextEditingController();
  TextEditingController newUserEmailController = TextEditingController();
  TextEditingController newUserPasswordController = TextEditingController();

  /// Enroll
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController positionController = TextEditingController();

  /// Enroll
  TextEditingController userIdController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController companyIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final StreamController<List<UserModal>> _companyUsersList = StreamController<List<UserModal>>();
  String _selectedValue = 'Sort';
  List<RegisterDataCompID> allData = [];

  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 20;
    items = List.generate(20, (index) => 'Item ${index + 1}');
    fetchData();
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      // Optionally show a snackbar or dialog to notify the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Copied to clipboard',
                style: TableHeading.customTextStyle(context))),
      );
    });
  }

  Future<void> fetchData() async {
    try {
      List<RegisterDataCompID> data = await GetRegisterByCompId(context);
      setState(() {
        allData = data;
      });
      registerController.add(data);
    } catch (error) {
      // Handle error
    }
  }

  bool _isLoading = false;

  var deptId = 0;
  int? firstDeptId;
  String? selectedDeptName;
  int? selectedDeptId;

  //
  // final PageController _pageController = PageController();
  // int _currentIndex = 0;
  //
  // void _goBack() {
  //   if (_currentIndex > 0) {
  //     _pageController.previousPage(
  //       duration: Duration(milliseconds: 300),
  //       curve: Curves.easeIn,
  //     );
  //     setState(() {
  //       _currentIndex--;
  //     });
  //   }
  // }
  //

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        // Remove mainAxisAlignment if it's not needed
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: Container(
                      child: Row(
                        children: [
                          InkWell(
                            onTap: widget.onBackPressed,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_back,
                                  size: 20,
                                  color: ColorManager.mediumgrey,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100,vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Text(' To open this form click here :    ', style: DocumentTypeDataStyle.customTextStyle(context)),
                        SizedBox(width: 5,),
                        TextButton(
                          onPressed: () async {
                          // const url = "http://localhost:53372/#/onBordingWelcome";
                           const url = "${AppConfig.deployment}/#/onBordingWelcome";
                            //const url = "https://staging.symmetry.care/#/onBordingWelcome";
                      //     Navigator.push(context, MaterialPageRoute(builder: (_)=>OnBoardingWelcome()));
                            //const url = "${AppConfig.deployment}/#/onBordingWelcome";
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Text(
                              'https://prohealth.symmetry.care/register',
                            style: RegisterLinkDataStyle.customTextStyle(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                Column(
                  children: [
                    Container(
                      width: 300,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          /// Select Dropdown button
                          buildDropdownButton(context),
                          SizedBox(width: 10),


                          /// Enroll Button
                          Container(
                            height: AppSize.s30,
                            width: AppSize.s140,
                            child: CustomIconButton(
                              icon: Icons.add,
                              text: 'Enroll User',
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDialog(
                                      title: "Enroll User",
                                      lastNameController: newUserLastNameController,
                                      emailController: newUserEmailController,
                                      firstNameController: newUserFirstNameController,
                                      passwordController: newUserPasswordController,
                                      onCancel: () {
                                        setState(() {
                                          fetchData();
                                        });
                                      },
                                    );
                                  },
                                );
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSize.s10),
          // StreamBuilder to load and display user data
          StreamBuilder<List<RegisterDataCompID>>(
            stream: registerController.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 150),
                  child: Center(
                    child: CircularProgressIndicator(color: ColorManager.blueprime),
                  ),
                );
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 150),
                  child: Center(
                    child: Text("No user available!", style: AllNoDataAvailable.customTextStyle(context)),
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: ListView.builder(
                  shrinkWrap: true, // Ensures the ListView takes only the space it needs
                  physics: NeverScrollableScrollPhysics(), // Disables scrolling inside the ListView, let SingleChildScrollView handle it
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: buildDatContainer(snapshot.data![index]),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }




  // @override
  // Widget build(BuildContext context) {
  //   return SingleChildScrollView(
  //     child: Column(
  //       //  mainAxisAlignment: MainAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Column(
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.only(left: 35),
  //                   child: Container(
  //                     child: Row(
  //                       children: [
  //                         InkWell(
  //                             onTap: widget.onBackPressed,
  //                             // widget.backButtonCallBack(true);
  //                             // Navigator.pop(context);
  //                             // _pageController.animateToPage(1,
  //                             //     duration: Duration(milliseconds: 500),
  //                             //     curve: Curves.ease);
  //                             child: Row(
  //                               children: [
  //                                 Icon(
  //                                   Icons.arrow_back,
  //                                   size: 20,
  //                                   color: ColorManager.mediumgrey,
  //                                 ),
  //                               ],
  //                             )),
  //                       ],
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             ),
  //             Column(
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.only(right: 36.0),
  //                   child: Container(
  //                     width: 300,
  //                     color: Colors.white,
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       children: [
  //                         ///Enroll Button
  //                         Container(
  //                           height: AppSize.s30,
  //                           width: AppSize.s140,
  //                           child: CustomIconButton(
  //                             icon: Icons.add,
  //                             text: 'Enroll User',
  //                             onPressed: () async {
  //                               await showDialog(
  //                                 context: context,
  //                                 builder: (BuildContext context) {
  //                                   return CustomDialog(
  //                                     title: "Enroll User",
  //                                     //userIdController: userIdController,
  //                                     lastNameController:
  //                                         newUserLastNameController,
  //                                     emailController: newUserEmailController,
  //                                     firstNameController:
  //                                         newUserFirstNameController,
  //                                     // roleController: roleController,
  //                                     passwordController:
  //                                         newUserPasswordController,
  //                                     onCancel: () {
  //                                       //widget.onRefresh();
  //                                       setState(() {
  //                                         fetchData();
  //                                       });
  //                                     },
  //                                   );
  //                                 },
  //                               );
  //                               setState(() {});
  //                             },
  //                           ),
  //                         ),
  //
  //                         SizedBox(
  //                           width: 10,
  //                         ),
  //
  //                         /// Select Dropdown button
  //                         buildDropdownButton(context),
  //                         // const SizedBox(width: 50),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.only(left: 20),
  //           child: Row(
  //             children: [
  //
  //
  //               Text('To open this form click here :',
  //                   style:
  //                   DocumentTypeDataStyle.customTextStyle(context)),
  //              // SizedBox(width: MediaQuery.of(context).size.width / 20),
  //               TextButton(
  //                 onPressed: () async {
  //                   //html.window.open('/onBordingWelcome',"_blank");
  //                   // const url = "http://localhost:59589/#/onBordingWelcome";
  //                   const url = "${AppConfig.deployment}/#/onBordingWelcome";
  //                   //const url = "https://staging.symmetry.care/#/onBordingWelcome";
  //                   //Navigator.push(context, MaterialPageRoute(builder: (_)=>OnBoardingWelcome()));
  //                   if (await canLaunch(url)) {
  //                     await launch(url);
  //                   } else {
  //                     throw 'Could not launch $url';
  //                   }
  //                 },
  //                 child: Text(
  //                 'https://prohealth.symmetry.care/register',
  //                   style: RegisterLinkDataStyle.customTextStyle(
  //                       context),
  //                 ),
  //               ),
  //               // data.status == 'Notopen'
  //               //     ? const Text('')
  //               //     : InkWell(
  //               //     onTap: () {
  //               //       _copyToClipboard(
  //               //           "${AppConfig.deployment}/#/onBordingWelcome");
  //               //     },
  //               //     child: Icon(
  //               //       Icons.copy,
  //               //       size: 15,
  //               //       color: ColorManager.mediumgrey,
  //               //     )),
  //             ],
  //           ),
  //         ),
  //         const SizedBox(height: AppSize.s20),
  //         StreamBuilder<List<RegisterDataCompID>>(
  //           stream: registerController.stream,
  //           builder: (context, snapshot) {
  //             if (snapshot.connectionState == ConnectionState.waiting) {
  //               return Padding(
  //                 padding: const EdgeInsets.symmetric(vertical: 150),
  //                 child: Center(
  //                   child: CircularProgressIndicator(
  //                     color: ColorManager.blueprime,
  //                   ),
  //                 ),
  //               );
  //             }
  //
  //             if (!snapshot.hasData || snapshot.data!.isEmpty) {
  //               return Padding(
  //                 padding: const EdgeInsets.symmetric(vertical: 150),
  //                 child: Center(
  //                   child: Text(
  //                     "No user available!",
  //                     style: AllNoDataAvailable.customTextStyle(context),
  //                   ),
  //                 ),
  //               );
  //             }
  //
  //             // Replace Wrap with ListView.builder
  //             return Expanded(
  //               child: ListView.builder(
  //                 itemCount: snapshot.data!.length,
  //                 itemBuilder: (context, index) {
  //                   return buildDatContainer(snapshot.data![index]);
  //                 },
  //               ),
  //             );
  //           },
  //         )
  //
  //       ],
  //     ),
  //   );
  // }

  Widget buildDropdownButton(BuildContext context) {
    final Map<String, String> displayTextMap = {
      'Sort': 'Sort',
      'Opened': 'Opened',
      'Notopen': 'Not Opened',
      'Partial': 'Partial',
      'Completed': 'Completed',
    };

    return Column(
      children: [
        DropdownButton2<String>(
          value: _selectedValue,
          onChanged: (String? newValue) {
            setState(() {
              _selectedValue = newValue!;
              filterData();
            });
          },
          style: TransparentButtonTextConst.customTextStyle(context),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_drop_down,
              color: Color(0xff50B5E5),
            ),
          ),
          // iconSize: 20,
          underline: const SizedBox(),
          buttonStyleData: ButtonStyleData(
            height: 31,
            width: 130,
            padding:
                const EdgeInsets.symmetric(horizontal: 8), // Internal padding.
            elevation: 2, // Shadow depth.
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xff50B5E5), width: 1.2),
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff000000).withOpacity(0.25),
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            overlayColor: WidgetStateProperty.all(
                Colors.grey.withOpacity(0.1)), // Background color when pressed.
          ),

          /// buttonPadding: const EdgeInsets.symmetric(horizontal: 8),
          // dropdownMaxHeight: 200,
          // dropdownDecoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(12),
          //   color: Colors.white,
          // ),
          // itemPadding: const EdgeInsets.symmetric(horizontal: 8), // Updated padding
          selectedItemBuilder: (context) =>
              displayTextMap.keys.map((String value) {
            return Align(
              alignment: Alignment.center,
              child: Text(displayTextMap[value]!),
            );
          }).toList(),
          items: displayTextMap.keys.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(displayTextMap[value]!),
            );
          }).toList(),
        ),
      ],
    );
  }

  void filterData() {
    String selectedStatus = _selectedValue.trim().toLowerCase();

    if (selectedStatus == 'sort') {
      registerController.add(allData);
    } else {
      List<RegisterDataCompID> filteredData = allData.where((data) {
        String dataStatus = data.status.trim().toLowerCase();
        bool matches = dataStatus == selectedStatus;
        print("Checking ${data.status}: $matches");
        return matches;
      }).toList();
      registerController.add(filteredData);
    }
  }

  // Widget buildDataContainer(RegisterDataCompID data) {
  //   return Container(
  //     width: MediaQuery.of(context).size.width / 2.2,
  //     decoration: BoxDecoration(
  //       border: Border.all(
  //         color: const Color(0xff51B5E6),
  //         width: 0.5,
  //       ),
  //       color: Colors.white,
  //       borderRadius: const BorderRadius.all(Radius.circular(12)),
  //     ),
  //     height: 163,
  //     child: Padding(
  //       padding: EdgeInsets.symmetric(
  //         horizontal: MediaQuery.of(context).size.width / 80,
  //         vertical: MediaQuery.of(context).size.height / 120,
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.only(left: 10),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.end,
  //                   children: [
  //                     Text(
  //                       data.firstName.capitalizeFirst!,
  //                       style: DefineWorkWeekStyle.customTextStyle(context),
  //                     ),
  //                     SizedBox(
  //                       width: 4,
  //                     ),
  //                     Text(
  //                       data.lastName.capitalizeFirst!,
  //                       style: DefineWorkWeekStyle.customTextStyle(context),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: [
  //                   data.status == 'Notopen'
  //                       ? Text(
  //                           'Not Opened',
  //                           style:
  //                               DocumentTypeDataStyle.customTextStyle(context),
  //                         )
  //                       : Text('Status',
  //                           style:
  //                               DocumentTypeDataStyle.customTextStyle(context)),
  //                   SizedBox(width: MediaQuery.of(context).size.width / 100),
  //                   data.status == 'Notopen'
  //                       ? const SizedBox(width: 10)
  //                       : Container(
  //                           width: 10.0,
  //                           height: 15.0,
  //                           decoration: BoxDecoration(
  //                             color: data.status == 'Opened'
  //                                 ? const Color(0xff51B5E6)
  //                                 : data.status == 'Partial'
  //                                     ? const Color(0xffCA8A04)
  //                                     : const Color(0xffB4DB4C),
  //                             shape: BoxShape.circle,
  //                           ),
  //                         ),
  //                   SizedBox(width: 5),
  //                   data.status == 'Notopen'
  //                       ? const SizedBox(width: 10)
  //                       : Text(data.status,
  //                           style: ConstTextFieldStyles.customTextStyle(
  //                             textColor: data.status == 'Opened'
  //                                 ? Color(0xff51B5E6)
  //                                 : data.status == 'Partial'
  //                                     ? Color(0xffCA8A04)
  //                                     : data.status == 'Completed'
  //                                         ? Color(0xffB4DB4C)
  //                                         : ColorManager.rednew,
  //                           )),
  //                 ],
  //               ),
  //             ],
  //           ),
  //           Padding(
  //             padding: EdgeInsets.only(
  //               left: MediaQuery.of(context).size.width / 130,
  //               top: MediaQuery.of(context).size.height / 120,
  //             ),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 SizedBox(height: MediaQuery.of(context).size.height / 60),
  //                 CustomRow(
  //                   icon: Icons.email_outlined,
  //                   text1: 'Email',
  //                   text2: data.email,
  //                 ),
  //                 SizedBox(height: MediaQuery.of(context).size.height / 60),
  //
  //                 ///link
  //                 Row(
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.only(top: 2.0),
  //                       child: Icon(Icons.link,
  //                           size: 15, color: ColorManager.mediumgrey),
  //                     ),
  //                     SizedBox(width: MediaQuery.of(context).size.width / 40),
  //                     Text('Link',
  //                         style:
  //                             DocumentTypeDataStyle.customTextStyle(context)),
  //                     SizedBox(width: MediaQuery.of(context).size.width / 20),
  //                     data.status == 'Notopen'
  //                         ? const Text('')
  //                         : TextButton(
  //                             onPressed: () async {
  //                               //html.window.open('/onBordingWelcome',"_blank");
  //                              // const url = "http://localhost:59589/#/onBordingWelcome";
  //                          const url = "${AppConfig.deployment}/#/onBordingWelcome";
  //                               //const url = "https://staging.symmetry.care/#/onBordingWelcome";
  //                              //Navigator.push(context, MaterialPageRoute(builder: (_)=>OnBoardingWelcome()));
  //                               if (await canLaunch(url)) {
  //                                 await launch(url);
  //                               } else {
  //                                 throw 'Could not launch $url';
  //                               }
  //                             },
  //                             child: Text(
  //                               data.link!,
  //                               style: RegisterLinkDataStyle.customTextStyle(
  //                                   context),
  //                             ),
  //                           ),
  //                     data.status == 'Notopen'
  //                         ? const Text('')
  //                         : InkWell(
  //                             onTap: () {
  //                               _copyToClipboard(
  //                                   "${AppConfig.deployment}/#/onBordingWelcome");
  //                             },
  //                             child: Icon(
  //                               Icons.copy,
  //                               size: 15,
  //                               color: ColorManager.mediumgrey,
  //                             )),
  //                   ],
  //                 ),
  //                 data.status == 'Notopen'
  //                     ? Row(
  //                         mainAxisAlignment: MainAxisAlignment.end,
  //                         children: [
  //                           Container(
  //                             width: AppSize.s110,
  //                             margin:
  //                                 const EdgeInsets.only(right: AppMargin.m5),
  //                             child: CustomIconButton(
  //                               text: AppString.enroll,
  //                               onPressed: () async {
  //                                 List<AEClinicalDiscipline> passData =
  //                                     await HrAddEmplyClinicalDisciplinApi(
  //                                         context,    );
  //                                 showDialog(
  //                                   context: context,
  //                                   builder: (_) => FutureBuilder<
  //                                       RegisterDataUserIDPrefill>(
  //                                     future: getRegisterEnrollPrefillUserId(
  //                                         context, data.userId),
  //                                     builder: (context, snapshotPrefill) {
  //                                       if (snapshotPrefill.connectionState ==
  //                                           ConnectionState.waiting) {
  //                                         return Center(
  //                                           child: CircularProgressIndicator(
  //                                               color: ColorManager.blueprime),
  //                                         );
  //                                       }
  //                                       var firstName = snapshotPrefill
  //                                           .data!.firstName
  //                                           .toString();
  //                                       firstNameController =
  //                                           TextEditingController(
  //                                               text: firstName);
  //
  //                                       var lastName = snapshotPrefill
  //                                           .data!.lastName
  //                                           .toString();
  //                                       lastNameController =
  //                                           TextEditingController(
  //                                               text: lastName);
  //
  //                                       var email = snapshotPrefill.data!.email
  //                                           .toString();
  //                                       emailController =
  //                                           TextEditingController(text: email);
  //
  //                                       return RegisterEnrollPopup(
  //                                         employeeId: data.employeeId,
  //                                         firstName: firstNameController,
  //                                         lastName: lastNameController,
  //                                         email: emailController,
  //                                         userId: snapshotPrefill.data!.userId,
  //                                         role: snapshotPrefill.data!.role,
  //                                         status: snapshotPrefill.data!.status,
  //                                         depId: snapshotPrefill.data!.departmentId,
  //                                         onPressed: () {
  //                                           Navigator.pop(context);
  //                                         },
  //                                         onReferesh: () {
  //                                           setState(() {
  //                                             fetchData();
  //                                           });
  //                                         },
  //                                         aEClinicalDiscipline: passData,
  //                                       );
  //                                     },
  //                                   ),
  //                                 );
  //                               },
  //                             ),
  //                           ),
  //                         ],
  //                       )
  //                     : const SizedBox(width: 10),
  //                 data.status == 'Partial'
  //                     ? Row(
  //                         mainAxisAlignment: MainAxisAlignment.end,
  //                         crossAxisAlignment: CrossAxisAlignment.end,
  //                         children: [
  //                           Container(
  //                             width: AppSize.s100,
  //                             margin:
  //                                 const EdgeInsets.only(right: AppMargin.m5),
  //                             child: CustomIconButton(
  //                               text: 'Activate',
  //                               onPressed: () async {
  //                                 showDialog(
  //                                     context: context,
  //                                     builder: (BuildContext context) {
  //                                       return ConfirmationPopup(
  //                                         loadingDuration: _isLoading,
  //                                         onCancel: () {
  //                                           Navigator.pop(context);
  //                                         },
  //                                         onConfirm: () async {
  //                                           setState(() {
  //                                             _isLoading = true;
  //                                           });
  //
  //                                           try {
  //                                             var response =
  //                                                 await changeStatusUserPatch(
  //                                                     context, data.employeeId);
  //                                             fetchData();
  //                                             Navigator.pop(context);
  //                                           } catch (e) {
  //                                             print(
  //                                                 "Error during Onboarding: $e");
  //                                             // ScaffoldMessenger.of(context).showSnackBar(
  //                                             //   SnackBar(content: Text('Onboarding failed: $e')),
  //                                             // );
  //                                           } finally {
  //                                             setState(() {
  //                                               _isLoading = false;
  //                                             });
  //                                           }
  //                                         },
  //                                         title: 'Confirm Activation',
  //                                         containerText:
  //                                             'Do you really want to complete?',
  //                                       );
  //                                     });
  //                               },
  //                             ),
  //                           )
  //                         ],
  //                       )
  //                     : const SizedBox(width: 10),
  //                 data.status == 'Completed'
  //                     ? Row(
  //                         mainAxisAlignment: MainAxisAlignment.end,
  //                         crossAxisAlignment: CrossAxisAlignment.end,
  //                         children: [
  //                           Container(
  //                             width: AppSize.s100,
  //                             margin:
  //                                 const EdgeInsets.only(right: AppMargin.m5),
  //                             child: CustomIconButton(
  //                               text: 'Onboard',
  //                               onPressed: () async {
  //                                 showDialog(
  //                                     context: context,
  //                                     builder: (BuildContext context) {
  //                                       return ConfirmationPopup(
  //                                         loadingDuration: _isLoading,
  //                                         onCancel: () {
  //                                           Navigator.pop(context);
  //                                         },
  //                                         onConfirm: () async {
  //                                           setState(() {
  //                                             _isLoading = true;
  //                                           });
  //
  //                                           try {
  //                                             var response =
  //                                                 await onboardingUserPatch(
  //                                                     context, data.employeeId);
  //                                             if (response.statusCode == 200 ||
  //                                                 response.statusCode == 201) {
  //                                               // ScaffoldMessenger.of(context).showSnackBar(
  //                                               //     SnackBar(content: Text('Employee Onboarded'),backgroundColor: Colors.green,)
  //                                               // );
  //                                               fetchData();
  //                                               Navigator.pop(context);
  //                                             } else {
  //                                               // ScaffoldMessenger.of(context).showSnackBar(
  //                                               //     SnackBar(content: Text('Something went wrong!'),backgroundColor: Colors.red,)
  //                                               // );
  //                                               Navigator.pop(context);
  //                                             }
  //                                           } catch (e) {
  //                                             print(
  //                                                 "Error during Onboarding: $e");
  //                                             // ScaffoldMessenger.of(context).showSnackBar(
  //                                             //   SnackBar(content: Text('Onboarding failed: $e')),
  //                                             // );
  //                                           } finally {
  //                                             setState(() {
  //                                               _isLoading = false;
  //                                             });
  //                                           }
  //                                         },
  //                                         title: 'Confirm Onboarding',
  //                                         containerText:
  //                                             'Do you really want to onboard?',
  //                                       );
  //                                     });
  //                               },
  //                             ),
  //                           )
  //                         ],
  //                       )
  //                     : const SizedBox(width: 10),
  //                 data.status == 'Opened'
  //                     ? Row(
  //                   mainAxisAlignment: MainAxisAlignment.end,
  //                   crossAxisAlignment: CrossAxisAlignment.end,
  //                   children: [
  //                     Container(
  //                       color: Colors.red,
  //                       height: AppSize.s30,
  //                       // margin:
  //                       // const EdgeInsets.only(right: AppMargin.m5),
  //                       // child: CustomIconButton(
  //                       //   text: 'Onboard',
  //                       //   onPressed: () async {
  //                       //     showDialog(
  //                       //         context: context,
  //                       //         builder: (BuildContext context) {
  //                       //           return ConfirmationPopup(
  //                       //             loadingDuration: _isLoading,
  //                       //             onCancel: () {
  //                       //               Navigator.pop(context);
  //                       //             },
  //                       //             onConfirm: () async {
  //                       //               setState(() {
  //                       //                 _isLoading = true;
  //                       //               });
  //                       //
  //                       //               try {
  //                       //                 var response =
  //                       //                 await onboardingUserPatch(
  //                       //                     context, data.employeeId);
  //                       //                 if (response.statusCode == 200 ||
  //                       //                     response.statusCode == 201) {
  //                       //                   // ScaffoldMessenger.of(context).showSnackBar(
  //                       //                   //     SnackBar(content: Text('Employee Onboarded'),backgroundColor: Colors.green,)
  //                       //                   // );
  //                       //                   fetchData();
  //                       //                   Navigator.pop(context);
  //                       //                 } else {
  //                       //                   // ScaffoldMessenger.of(context).showSnackBar(
  //                       //                   //     SnackBar(content: Text('Something went wrong!'),backgroundColor: Colors.red,)
  //                       //                   // );
  //                       //                   Navigator.pop(context);
  //                       //                 }
  //                       //               } catch (e) {
  //                       //                 print(
  //                       //                     "Error during Onboarding: $e");
  //                       //                 // ScaffoldMessenger.of(context).showSnackBar(
  //                       //                 //   SnackBar(content: Text('Onboarding failed: $e')),
  //                       //                 // );
  //                       //               } finally {
  //                       //                 setState(() {
  //                       //                   _isLoading = false;
  //                       //                 });
  //                       //               }
  //                       //             },
  //                       //             title: 'Confirm Onboarding',
  //                       //             containerText:
  //                       //             'Do you really want to onboard?',
  //                       //           );
  //                       //         });
  //                       //   },
  //                       // ),
  //                     )
  //                   ],
  //                 )
  //                     : const SizedBox(width: 10),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }





  ////
  Widget buildDatContainer(RegisterDataCompID data) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: const Color(0xff51B5E6),
        //   width: 0.5,
        // ),
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey
                .withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      height: 80,

      child: Column(
       //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///status
              Container(
                  width: AppSize.s90,
                  height: AppSize.s20,
                  decoration: BoxDecoration(
                    color:data.status == 'Opened'
                        ? Color(0xff1696C8)
                        : data.status == 'Partial'
                        ? Color(0xffCA8A04)
                        : data.status == 'Completed'
                        ? Color(0xff52A889)
                        : Color(0xffC30404),
                    borderRadius: BorderRadius.only(
                        topLeft:
                        Radius.circular(12)),),
                  child: Center(
                    child:

                    data.status == 'Notopen'
                        ? Text(
                      'Not Opened',
                      textAlign: TextAlign.center,
                      style: CustomTextStylesCommon.commonStyle(
                          color: ColorManager.white,
                          fontSize: FontSize.s12,
                          fontWeight: FontWeight.w600),
                    ):Text(
                        data.status,
                        textAlign: TextAlign.center,
                        style: CustomTextStylesCommon.commonStyle(
                            color: ColorManager.white,
                            fontSize: FontSize.s12,
                            fontWeight: FontWeight.w600)),
                  )),
            ],
          ),
          SizedBox(height: AppSize.s10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Expanded(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         data.firstName.capitalizeFirst!,
              //         style: DefineWorkWeekStyle.customTextStyle(context),
              //       ),
              //       SizedBox(width: MediaQuery.of(context).size.width/70),
              //       Text(
              //         data.lastName.capitalizeFirst!,
              //         style: DefineWorkWeekStyle.customTextStyle(context),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(width: 5,),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CustomRowname(   text1: data.firstName.capitalizeFirst!,
                    text2: data.lastName.capitalizeFirst!,),
                ),
              ), Expanded(
                flex: 1,
                child: CustomRownew(   text1: 'Role :',
                  text2: data.role,),
              ),
              Expanded(
                flex: 1,
                child: CustomRownew(   text1: 'Email :',
                  text2: data.email,),
              ),
              // Row(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(top: 2.0),
              //       child: Icon(Icons.link,
              //           size: 15, color: ColorManager.mediumgrey),
              //     ),
              //     SizedBox(width: MediaQuery.of(context).size.width / 40),
              //     Text('Link',
              //         style:
              //         DocumentTypeDataStyle.customTextStyle(context)),
              //     SizedBox(width: MediaQuery.of(context).size.width / 20),
              //     data.status == 'Notopen'
              //         ? const Text('')
              //         : TextButton(
              //       onPressed: () async {
              //         //html.window.open('/onBordingWelcome',"_blank");
              //         // const url = "http://localhost:59589/#/onBordingWelcome";
              //         const url = "${AppConfig.deployment}/#/onBordingWelcome";
              //         //const url = "https://staging.symmetry.care/#/onBordingWelcome";
              //         //Navigator.push(context, MaterialPageRoute(builder: (_)=>OnBoardingWelcome()));
              //         if (await canLaunch(url)) {
              //           await launch(url);
              //         } else {
              //           throw 'Could not launch $url';
              //         }
              //       },
              //       child: Text(
              //         data.link!,
              //         style: RegisterLinkDataStyle.customTextStyle(
              //             context),
              //       ),
              //     ),
              //     data.status == 'Notopen'
              //         ? const Text('')
              //         : InkWell(
              //         onTap: () {
              //           _copyToClipboard(
              //               "${AppConfig.deployment}/#/onBordingWelcome");
              //         },
              //         child: Icon(
              //           Icons.copy,
              //           size: 15,
              //           color: ColorManager.mediumgrey,
              //         )),
              //   ],
              // ),
              Expanded(
                child: Column(
                  
                  children: [
                    data.status == 'Notopen'
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: AppSize.s110,
                          margin:
                          const EdgeInsets.only(right: AppMargin.m5),
                          child: CustomIconButton(
                            text: AppString.enroll,
                            onPressed: () async {
                              List<AEClinicalDiscipline> passData =
                              await HrAddEmplyClinicalDisciplinApi(
                                  context, data.deptId! );
                              showDialog(
                                context: context,
                                builder: (_) => FutureBuilder<
                                    RegisterDataUserIDPrefill>(
                                  future: getRegisterEnrollPrefillUserId(
                                      context, data.userId),
                                  builder: (context, snapshotPrefill) {
                                    if (snapshotPrefill.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                            color: ColorManager.blueprime),
                                      );
                                    }
                                    var firstName = snapshotPrefill
                                        .data!.firstName
                                        .toString();
                                    firstNameController =
                                        TextEditingController(
                                            text: firstName);
                    
                                    var lastName = snapshotPrefill
                                        .data!.lastName
                                        .toString();
                                    lastNameController =
                                        TextEditingController(
                                            text: lastName);
                    
                                    var email = snapshotPrefill.data!.email
                                        .toString();
                                    emailController =
                                        TextEditingController(text: email);
                    
                                    return RegisterEnrollPopup(
                                      employeeId: data.employeeId,
                                      firstName: firstNameController,
                                      lastName: lastNameController,
                                      email: emailController,
                                      userId: snapshotPrefill.data!.userId,
                                      role: snapshotPrefill.data!.role,
                                      status: snapshotPrefill.data!.status,
                                      // depid :snapshotPrefill.data!.
                                        depId:snapshotPrefill.data!.departmentId,
                    
                                        onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      onReferesh: () {
                                        setState(() {
                                          fetchData();
                                        });
                                      },
                                      aEClinicalDiscipline: passData,
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                        : const SizedBox(width: 10),
                    data.status == 'Partial'
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: AppSize.s110,
                          margin:
                          const EdgeInsets.only(right: AppMargin.m5),
                          child: CustomIconButton(
                            text: 'Activate',
                            onPressed: () async {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ConfirmationPopup(
                                      loadingDuration: _isLoading,
                                      onCancel: () {
                                        Navigator.pop(context);
                                      },
                                      onConfirm: () async {
                                        setState(() {
                                          _isLoading = true;
                                        });
                    
                                        try {
                                          var response =
                                          await changeStatusUserPatch(
                                              context, data.employeeId);
                                          fetchData();
                                          Navigator.pop(context);
                                        } catch (e) {
                                          print(
                                              "Error during Onboarding: $e");
                                          // ScaffoldMessenger.of(context).showSnackBar(
                                          //   SnackBar(content: Text('Onboarding failed: $e')),
                                          // );
                                        } finally {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                        }
                                      },
                                      title: 'Confirm Activation',
                                      containerText:
                                      'Do you really want to complete?',
                                    );
                                  });
                            },
                          ),
                        )
                      ],
                    )
                        : const SizedBox(width: 10),
                    data.status == 'Completed'
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: AppSize.s110,
                          margin: const EdgeInsets.only(right: AppMargin.m5),
                          child: CustomIconButton(
                            text: 'Onboard',
                            onPressed: () async {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ConfirmationPopup(
                                      loadingDuration: _isLoading,
                                      onCancel: () {
                                        Navigator.pop(context);
                                      },
                                      onConfirm: () async {
                                        setState(() {
                                          _isLoading = true;
                                        });
                    
                                        try {
                                          var response =
                                          await onboardingUserPatch(
                                              context, data.employeeId);
                                          if (response.statusCode == 200 ||
                                              response.statusCode == 201) {
                                            // ScaffoldMessenger.of(context).showSnackBar(
                                            //     SnackBar(content: Text('Employee Onboarded'),backgroundColor: Colors.green,)
                                            // );
                                            fetchData();
                                            Navigator.pop(context);
                                          } else {
                                            // ScaffoldMessenger.of(context).showSnackBar(
                                            //     SnackBar(content: Text('Something went wrong!'),backgroundColor: Colors.red,)
                                            // );
                                            Navigator.pop(context);
                                          }
                                        } catch (e) {
                                          print(
                                              "Error during Onboarding: $e");
                                          // ScaffoldMessenger.of(context).showSnackBar(
                                          //   SnackBar(content: Text('Onboarding failed: $e')),
                                          // );
                                        } finally {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                        }
                                      },
                                      title: 'Confirm Onboarding',
                                      containerText:
                                      'Do you really want to onboard?',
                                    );
                                  });
                            },
                          ),
                        )
                    
                      ],
                    )
                        : const SizedBox(width: 10),
                    data.status == 'Opened'
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          //color: Colors.red,
                          height: AppSize.s30,
                          // margin:
                          // const EdgeInsets.only(right: AppMargin.m5),
                          // child: CustomIconButton(
                          //   text: 'Onboard',
                          //   onPressed: () async {
                          //     showDialog(
                          //         context: context,
                          //         builder: (BuildContext context) {
                          //           return ConfirmationPopup(
                          //             loadingDuration: _isLoading,
                          //             onCancel: () {
                          //               Navigator.pop(context);
                          //             },
                          //             onConfirm: () async {
                          //               setState(() {
                          //                 _isLoading = true;
                          //               });
                          //
                          //               try {
                          //                 var response =
                          //                 await onboardingUserPatch(
                          //                     context, data.employeeId);
                          //                 if (response.statusCode == 200 ||
                          //                     response.statusCode == 201) {
                          //                   // ScaffoldMessenger.of(context).showSnackBar(
                          //                   //     SnackBar(content: Text('Employee Onboarded'),backgroundColor: Colors.green,)
                          //                   // );
                          //                   fetchData();
                          //                   Navigator.pop(context);
                          //                 } else {
                          //                   // ScaffoldMessenger.of(context).showSnackBar(
                          //                   //     SnackBar(content: Text('Something went wrong!'),backgroundColor: Colors.red,)
                          //                   // );
                          //                   Navigator.pop(context);
                          //                 }
                          //               } catch (e) {
                          //                 print(
                          //                     "Error during Onboarding: $e");
                          //                 // ScaffoldMessenger.of(context).showSnackBar(
                          //                 //   SnackBar(content: Text('Onboarding failed: $e')),
                          //                 // );
                          //               } finally {
                          //                 setState(() {
                          //                   _isLoading = false;
                          //                 });
                          //               }
                          //             },
                          //             title: 'Confirm Onboarding',
                          //             containerText:
                          //             'Do you really want to onboard?',
                          //           );
                          //         });
                          //   },
                          // ),
                          width: 110,
                          margin:
                          const EdgeInsets.only(right: AppMargin.m5),
                        )
                      ],
                    )
                        : const SizedBox(width: 10),
                  ],
                ),
              ),
SizedBox(width: 20,)

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //     data.status == 'Notopen'
              //         ? Text(
              //       'Not Opened',
              //       style:
              //       DocumentTypeDataStyle.customTextStyle(context),
              //     )
              //         : Text('Status',
              //         style:
              //         DocumentTypeDataStyle.customTextStyle(context)),
              //     SizedBox(width: MediaQuery.of(context).size.width / 100),
              //     data.status == 'Notopen'
              //         ? const SizedBox(width: 10)
              //         : Container(
              //       width: 10.0,
              //       height: 15.0,
              //       decoration: BoxDecoration(
              //         color: data.status == 'Opened'
              //             ? const Color(0xff51B5E6)
              //             : data.status == 'Partial'
              //             ? const Color(0xffCA8A04)
              //             : const Color(0xffB4DB4C),
              //         shape: BoxShape.circle,
              //       ),
              //     ),
              //     SizedBox(width: 5),
              //     data.status == 'Notopen'
              //         ? const SizedBox(width: 10)
              //         : Text(data.status,
              //         style: ConstTextFieldStyles.customTextStyle(
              //           textColor: data.status == 'Opened'
              //               ? Color(0xff51B5E6)
              //               : data.status == 'Partial'
              //               ? Color(0xffCA8A04)
              //               : data.status == 'Completed'
              //               ? Color(0xffB4DB4C)
              //               : ColorManager.rednew,
              //         )),
              //   ],
              // ),
            ],
          ),
          // Padding(
          //   padding: EdgeInsets.only(
          //     left: MediaQuery.of(context).size.width / 130,
          //     top: MediaQuery.of(context).size.height / 120,
          //   ),
          //   child:
          //   Column(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       SizedBox(height: MediaQuery.of(context).size.height / 60),
          //       CustomRow(
          //         icon: Icons.email_outlined,
          //         text1: 'Email',
          //         text2: data.email,
          //       ),
          //       SizedBox(height: MediaQuery.of(context).size.height / 60),
          //
          //       ///link
          //       Row(
          //         children: [
          //           Padding(
          //             padding: const EdgeInsets.only(top: 2.0),
          //             child: Icon(Icons.link,
          //                 size: 15, color: ColorManager.mediumgrey),
          //           ),
          //           SizedBox(width: MediaQuery.of(context).size.width / 40),
          //           Text('Link',
          //               style:
          //               DocumentTypeDataStyle.customTextStyle(context)),
          //           SizedBox(width: MediaQuery.of(context).size.width / 20),
          //           data.status == 'Notopen'
          //               ? const Text('')
          //               : TextButton(
          //             onPressed: () async {
          //               //html.window.open('/onBordingWelcome',"_blank");
          //               // const url = "http://localhost:59589/#/onBordingWelcome";
          //               const url = "${AppConfig.deployment}/#/onBordingWelcome";
          //               //const url = "https://staging.symmetry.care/#/onBordingWelcome";
          //               //Navigator.push(context, MaterialPageRoute(builder: (_)=>OnBoardingWelcome()));
          //               if (await canLaunch(url)) {
          //                 await launch(url);
          //               } else {
          //                 throw 'Could not launch $url';
          //               }
          //             },
          //             child: Text(
          //               data.link!,
          //               style: RegisterLinkDataStyle.customTextStyle(
          //                   context),
          //             ),
          //           ),
          //           data.status == 'Notopen'
          //               ? const Text('')
          //               : InkWell(
          //               onTap: () {
          //                 _copyToClipboard(
          //                     "${AppConfig.deployment}/#/onBordingWelcome");
          //               },
          //               child: Icon(
          //                 Icons.copy,
          //                 size: 15,
          //                 color: ColorManager.mediumgrey,
          //               )),
          //         ],
          //       ),
          //       data.status == 'Notopen'
          //           ? Row(
          //         mainAxisAlignment: MainAxisAlignment.end,
          //         children: [
          //           Container(
          //             width: AppSize.s110,
          //             margin:
          //             const EdgeInsets.only(right: AppMargin.m5),
          //             child: CustomIconButton(
          //               text: AppString.enroll,
          //               onPressed: () async {
          //                 List<AEClinicalDiscipline> passData =
          //                 await HrAddEmplyClinicalDisciplinApi(
          //                     context, 1);
          //                 showDialog(
          //                   context: context,
          //                   builder: (_) => FutureBuilder<
          //                       RegisterDataUserIDPrefill>(
          //                     future: getRegisterEnrollPrefillUserId(
          //                         context, data.userId),
          //                     builder: (context, snapshotPrefill) {
          //                       if (snapshotPrefill.connectionState ==
          //                           ConnectionState.waiting) {
          //                         return Center(
          //                           child: CircularProgressIndicator(
          //                               color: ColorManager.blueprime),
          //                         );
          //                       }
          //                       var firstName = snapshotPrefill
          //                           .data!.firstName
          //                           .toString();
          //                       firstNameController =
          //                           TextEditingController(
          //                               text: firstName);
          //
          //                       var lastName = snapshotPrefill
          //                           .data!.lastName
          //                           .toString();
          //                       lastNameController =
          //                           TextEditingController(
          //                               text: lastName);
          //
          //                       var email = snapshotPrefill.data!.email
          //                           .toString();
          //                       emailController =
          //                           TextEditingController(text: email);
          //
          //                       return RegisterEnrollPopup(
          //                         employeeId: data.employeeId,
          //                         firstName: firstNameController,
          //                         lastName: lastNameController,
          //                         email: emailController,
          //                         userId: snapshotPrefill.data!.userId,
          //                         role: snapshotPrefill.data!.role,
          //                         status: snapshotPrefill.data!.status,
          //                         onPressed: () {
          //                           Navigator.pop(context);
          //                         },
          //                         onReferesh: () {
          //                           setState(() {
          //                             fetchData();
          //                           });
          //                         },
          //                         aEClinicalDiscipline: passData,
          //                       );
          //                     },
          //                   ),
          //                 );
          //               },
          //             ),
          //           ),
          //         ],
          //       )
          //           : const SizedBox(width: 10),
          //       data.status == 'Partial'
          //           ? Row(
          //         mainAxisAlignment: MainAxisAlignment.end,
          //         crossAxisAlignment: CrossAxisAlignment.end,
          //         children: [
          //           Container(
          //             width: AppSize.s100,
          //             margin:
          //             const EdgeInsets.only(right: AppMargin.m5),
          //             child: CustomIconButton(
          //               text: 'Activate',
          //               onPressed: () async {
          //                 showDialog(
          //                     context: context,
          //                     builder: (BuildContext context) {
          //                       return ConfirmationPopup(
          //                         loadingDuration: _isLoading,
          //                         onCancel: () {
          //                           Navigator.pop(context);
          //                         },
          //                         onConfirm: () async {
          //                           setState(() {
          //                             _isLoading = true;
          //                           });
          //
          //                           try {
          //                             var response =
          //                             await changeStatusUserPatch(
          //                                 context, data.employeeId);
          //                             fetchData();
          //                             Navigator.pop(context);
          //                           } catch (e) {
          //                             print(
          //                                 "Error during Onboarding: $e");
          //                             // ScaffoldMessenger.of(context).showSnackBar(
          //                             //   SnackBar(content: Text('Onboarding failed: $e')),
          //                             // );
          //                           } finally {
          //                             setState(() {
          //                               _isLoading = false;
          //                             });
          //                           }
          //                         },
          //                         title: 'Confirm Activation',
          //                         containerText:
          //                         'Do you really want to complete?',
          //                       );
          //                     });
          //               },
          //             ),
          //           )
          //         ],
          //       )
          //           : const SizedBox(width: 10),
          //       data.status == 'Completed'
          //           ? Row(
          //         mainAxisAlignment: MainAxisAlignment.end,
          //         crossAxisAlignment: CrossAxisAlignment.end,
          //         children: [
          //           Container(
          //             width: AppSize.s100,
          //             margin:
          //             const EdgeInsets.only(right: AppMargin.m5),
          //             child: CustomIconButton(
          //               text: 'Onboard',
          //               onPressed: () async {
          //                 showDialog(
          //                     context: context,
          //                     builder: (BuildContext context) {
          //                       return ConfirmationPopup(
          //                         loadingDuration: _isLoading,
          //                         onCancel: () {
          //                           Navigator.pop(context);
          //                         },
          //                         onConfirm: () async {
          //                           setState(() {
          //                             _isLoading = true;
          //                           });
          //
          //                           try {
          //                             var response =
          //                             await onboardingUserPatch(
          //                                 context, data.employeeId);
          //                             if (response.statusCode == 200 ||
          //                                 response.statusCode == 201) {
          //                               // ScaffoldMessenger.of(context).showSnackBar(
          //                               //     SnackBar(content: Text('Employee Onboarded'),backgroundColor: Colors.green,)
          //                               // );
          //                               fetchData();
          //                               Navigator.pop(context);
          //                             } else {
          //                               // ScaffoldMessenger.of(context).showSnackBar(
          //                               //     SnackBar(content: Text('Something went wrong!'),backgroundColor: Colors.red,)
          //                               // );
          //                               Navigator.pop(context);
          //                             }
          //                           } catch (e) {
          //                             print(
          //                                 "Error during Onboarding: $e");
          //                             // ScaffoldMessenger.of(context).showSnackBar(
          //                             //   SnackBar(content: Text('Onboarding failed: $e')),
          //                             // );
          //                           } finally {
          //                             setState(() {
          //                               _isLoading = false;
          //                             });
          //                           }
          //                         },
          //                         title: 'Confirm Onboarding',
          //                         containerText:
          //                         'Do you really want to onboard?',
          //                       );
          //                     });
          //               },
          //             ),
          //           )
          //         ],
          //       )
          //           : const SizedBox(width: 10),
          //       data.status == 'Opened'
          //           ? Row(
          //         mainAxisAlignment: MainAxisAlignment.end,
          //         crossAxisAlignment: CrossAxisAlignment.end,
          //         children: [
          //           Container(
          //             color: Colors.red,
          //             height: AppSize.s30,
          //             // margin:
          //             // const EdgeInsets.only(right: AppMargin.m5),
          //             // child: CustomIconButton(
          //             //   text: 'Onboard',
          //             //   onPressed: () async {
          //             //     showDialog(
          //             //         context: context,
          //             //         builder: (BuildContext context) {
          //             //           return ConfirmationPopup(
          //             //             loadingDuration: _isLoading,
          //             //             onCancel: () {
          //             //               Navigator.pop(context);
          //             //             },
          //             //             onConfirm: () async {
          //             //               setState(() {
          //             //                 _isLoading = true;
          //             //               });
          //             //
          //             //               try {
          //             //                 var response =
          //             //                 await onboardingUserPatch(
          //             //                     context, data.employeeId);
          //             //                 if (response.statusCode == 200 ||
          //             //                     response.statusCode == 201) {
          //             //                   // ScaffoldMessenger.of(context).showSnackBar(
          //             //                   //     SnackBar(content: Text('Employee Onboarded'),backgroundColor: Colors.green,)
          //             //                   // );
          //             //                   fetchData();
          //             //                   Navigator.pop(context);
          //             //                 } else {
          //             //                   // ScaffoldMessenger.of(context).showSnackBar(
          //             //                   //     SnackBar(content: Text('Something went wrong!'),backgroundColor: Colors.red,)
          //             //                   // );
          //             //                   Navigator.pop(context);
          //             //                 }
          //             //               } catch (e) {
          //             //                 print(
          //             //                     "Error during Onboarding: $e");
          //             //                 // ScaffoldMessenger.of(context).showSnackBar(
          //             //                 //   SnackBar(content: Text('Onboarding failed: $e')),
          //             //                 // );
          //             //               } finally {
          //             //                 setState(() {
          //             //                   _isLoading = false;
          //             //                 });
          //             //               }
          //             //             },
          //             //             title: 'Confirm Onboarding',
          //             //             containerText:
          //             //             'Do you really want to onboard?',
          //             //           );
          //             //         });
          //             //   },
          //             // ),
          //           )
          //         ],
          //       )
          //           : const SizedBox(width: 10),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
////
}

///dont delete
// Widget buildDropdownButton(BuildContext context) {
//   return Column(
//     children: [
//       Container(
//         height: 31,
//         width: 130,
//         padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(color: const Color(0xff50B5E5), width: 1.2),
//           borderRadius: BorderRadius.circular(12.0),
//           boxShadow: [
//             BoxShadow(
//               color: const Color(0xff000000).withOpacity(0.25),
//               blurRadius: 2,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: DropdownButton<String>(
//           value: _selectedValue,
//           onChanged: (String? newValue) {
//             setState(() {
//               _selectedValue = newValue!;
//               filterData();
//             });
//           },
//           style: TransparentButtonTextConst.customTextStyle(context),
//           icon: const Icon(
//             Icons.arrow_drop_down,
//             color: Color(0xff50B5E5),
//           ),
//           iconSize: 20,
//           focusColor: Colors.transparent,
//           underline: const SizedBox(),
//           dropdownColor: Colors.white,
//           isDense: true,
//           selectedItemBuilder: (BuildContext context) {
//             return <String>[
//               'Sort',
//               'Opened',
//               'Notopen',
//               'Partial',
//               'Completed',
//             ].map<Widget>((String value) {
//               return Row(
//                 children: [
//                   Text(
//                     _selectedValue ?? 'Sort',
//                     style: TransparentButtonTextConst.customTextStyle(context),
//                   ),
//                   SizedBox(width: 6,)
//                 ],
//               );
//             }).toList();
//           },
//           items: _getDropdownItems(),
//         ),
//       ),
//     ],
//   );
// }

// List<DropdownMenuItem<String>> _getDropdownItems() {
//   List<String> items = ['Sort', 'Opened', 'Notopen', 'Partial', 'Completed'];
//
//   if (_selectedValue != null && items.contains(_selectedValue)) {
//     items.remove(_selectedValue);
//     items.insert(0, _selectedValue!);
//   }
//
//   return items.map<DropdownMenuItem<String>>((String value) {
//     return DropdownMenuItem<String>(
//       value: value,
//       child: Container(
//         alignment: Alignment.center,
//         child: Text(value),
//       ),
//     );
//   }).toList();
// }
