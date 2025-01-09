import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/user.dart';
import 'package:prohealth/app/services/token/token_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/company_identity_data_.dart';
import 'package:prohealth/data/api_data/establishment_data/user/user_modal.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import 'package:prohealth/presentation/screens/em_module/see_all_screen/see_all_provider.dart';
import 'package:prohealth/presentation/screens/em_module/see_all_screen/see_all_provider.dart';
import 'package:prohealth/presentation/screens/em_module/see_all_screen/see_all_provider.dart';
import 'package:prohealth/presentation/screens/em_module/see_all_screen/see_all_provider.dart';

import 'package:prohealth/presentation/screens/em_module/see_all_screen/widgets/popup_const.dart';
import 'package:prohealth/presentation/screens/em_module/see_all_screen/widgets/user_create_provider.dart';
import 'package:prohealth/presentation/screens/em_module/see_all_screen/widgets/user_delete_provider.dart';
import 'package:prohealth/presentation/screens/em_module/see_all_screen/widgets/user_edit_provider.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/error_popups/delete_success_popup.dart';
import 'package:prohealth/presentation/widgets/widgets/profile_bar/widget/pagination_widget.dart';
import 'package:provider/provider.dart';

import 'see_all_provider.dart';

///see all screen using provider
// class SeeAllScreen extends StatelessWidget {
//   final int itemsPerPage = 10;
//
//   @override
//   Widget build(BuildContext context) {
//     // Fetch data when the widget is first built
//     // Future.microtask(() => Provider.of<SeeAllProvider>(context, listen: false).getUser());
//     Future.microtask(() => Provider.of<SeeAllProvider>(context, listen: false).fetchUser(context));
//     // Access the provider using context.watch or context.read
//     final userCreationProvider = context.watch<UserCreationProvider>();
//     final paginationProvider = context.watch<SeeAllPaginationProvider>();
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: EdgeInsets.symmetric(
//             horizontal: MediaQuery.of(context).size.width / 24),
//         child: Column(
//           children: [
//             ///
//             Padding(
//               padding: const EdgeInsets.only(right: AppPadding.p30),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Container(
//                     height: AppSize.s30,
//                     width: AppSize.s150,
//                     child: CustomIconButton(
//                       icon: Icons.add,
//                       text: 'Create User',
//                       onPressed: () async {
//                         final provider = Provider.of<UserCreationProvider>(
//                             context,
//                             listen: false);
//                         provider
//                             .clearForm(); // Clear the form before showing the dialog
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return CustomDialoghSEE(
//                               title: "Create User",
//                               firstNameController: provider.firstNameController,
//                               lastNameController: provider.lastNameController,
//                               emailController: provider.emailController,
//                               passwordController: provider.passwordController,
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 10),
//             Column(
//               children: [
//                 Container(
//                   height: AppSize.s30,
//                   margin: EdgeInsets.symmetric(horizontal: 30),
//                   decoration: BoxDecoration(
//                     color: ColorManager.fmediumgrey,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 1),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Expanded(
//                           flex: 2,
//                           child: Padding(
//                             padding:
//                                 const EdgeInsets.only(left: AppPadding.p90),
//                             child: Text(
//                               AppString.srNo,
//                               style: TableHeading.customTextStyle(context),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Padding(
//                             padding:
//                                 const EdgeInsets.only(left: AppPadding.p60),
//                             child: Text(
//                               AppString.userId,
//                               style: TableHeading.customTextStyle(context),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Padding(
//                             padding:
//                                 const EdgeInsets.only(left: AppPadding.p20),
//                             child: Text(
//                               AppString.fname,
//                               style: TableHeading.customTextStyle(context),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Padding(
//                             padding:
//                                 const EdgeInsets.only(right: AppPadding.p40),
//                             child: Text(
//                               AppString.lname,
//                               textAlign: TextAlign.start,
//                               style: TableHeading.customTextStyle(context),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             AppString.role,
//                             style: TableHeading.customTextStyle(context),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Text(
//                             AppString.email,
//                             textAlign: TextAlign.start,
//                             style: TableHeading.customTextStyle(context),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: Padding(
//                               padding:
//                                   const EdgeInsets.only(left: AppPadding.p40),
//                               child: Text(
//                                 AppString.actions,
//                                 textAlign: TextAlign.start,
//                                 style: TableHeading.customTextStyle(context),
//                               )),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: AppSize.s10),
//               ],
//             ),
//             Expanded(
//               child: Consumer<SeeAllProvider>(
//                 builder: (context, seeAllProviderState, child) {
//                   return StreamBuilder<List<UserModal>>(
//                     stream: seeAllProviderState.userStream,
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(child: CircularProgressIndicator());
//                       }
//                       if (snapshot.hasError) {
//                         return Center(child: Text('Error: ${snapshot.error}'));
//                       }
//                       if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                         return Center(child: Text('No Data Available'));
//                       }
//
//                       List<UserModal> sortedData = snapshot.data!;
//                       sortedData.sort((a, b) => b.userId.compareTo(a.userId));
//
//                       // Update PaginationProvider's items
//                       final paginationProvider =
//                       Provider.of<SeeAllPaginationProvider>(context, listen: false);
//                       paginationProvider.updateItems(sortedData);
//
//                       // Get current page data
//                       List<UserModal> paginatedData = paginationProvider.currentPageItems;
//
//                       return Column(
//                           children: [
//                             Expanded(
//                                 child: ListView.builder(
//                                     itemCount: paginatedData.length,
//                                     itemBuilder: (context, index) {
//                                       int globalSerialNumber = (paginationProvider.currentPage - 1) *
//                                           paginationProvider.itemsPerPage +
//                                           index +
//                                           1;
//
//                                       String formattedSerialNumber =
//                                       globalSerialNumber.toString().padLeft(2, '0');
//
//                                       UserModal user = paginatedData[index];
//
//                                       return Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                         SizedBox(height: 5),
//                                         Container(
//                                             margin: EdgeInsets.symmetric(
//                                                 horizontal: 30),
//                                             decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               borderRadius:
//                                                   BorderRadius.circular(4),
//                                               boxShadow: [
//                                                 BoxShadow(
//                                                   color: Colors.grey
//                                                       .withOpacity(0.5),
//                                                   spreadRadius: 1,
//                                                   blurRadius: 4,
//                                                   offset: Offset(0, 2),
//                                                 ),
//                                               ],
//                                             ),
//                                             height: 56,
//                                             child: Padding(
//                                                 padding: EdgeInsets.symmetric(
//                                                     horizontal: 10),
//                                                 child: Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceEvenly,
//                                                     children: [
//                                                       Expanded(
//                                                           flex: 1,
//                                                           child: Text(
//                                                               formattedSerialNumber,
//                                                               style: TableSubHeading
//                                                                   .customTextStyle(
//                                                                       context),
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .center)),
//                                                       Expanded(
//                                                           flex: 1,
//                                                           child: Text(
//                                                             user.userId
//                                                                 .toString(),
//                                                             textAlign: TextAlign
//                                                                 .center,
//                                                             style: TableSubHeading
//                                                                 .customTextStyle(
//                                                                     context),
//                                                           )),
//                                                       Expanded(
//                                                           flex: 1,
//                                                           child: Text(
//                                                             user.firstName,
//                                                             textAlign: TextAlign
//                                                                 .center,
//                                                             style: TableSubHeading
//                                                                 .customTextStyle(
//                                                                     context),
//                                                           )),
//                                                       Expanded(
//                                                           flex: 1,
//                                                           child: Padding(
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                     .only(
//                                                                     left: 20),
//                                                             child: Text(
//                                                               user.lastName,
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .center,
//                                                               style: TableSubHeading
//                                                                   .customTextStyle(
//                                                                       context),
//                                                             ),
//                                                           )),
//                                                       Expanded(
//                                                           flex: 1,
//                                                           child: Padding(
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                     .only(
//                                                                     left: 50),
//                                                             child: Text(
//                                                               user.role,
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .center,
//                                                               style: TableSubHeading
//                                                                   .customTextStyle(
//                                                                       context),
//                                                             ),
//                                                           )),
//                                                       Expanded(
//                                                           flex: 2,
//                                                           child: Padding(
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                     .only(
//                                                                     left: 100),
//                                                             child: Text(
//                                                               user.email,
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .start,
//                                                               style: TableSubHeading
//                                                                   .customTextStyle(
//                                                                       context),
//                                                             ),
//                                                           )),
//                                                       InkWell(
//                                                         child: Container(
//                                                           height: MediaQuery.of(context).size.height / 30,
//                                                           width: MediaQuery.of(context).size.width / 25,
//                                                           decoration: BoxDecoration(
//                                                             borderRadius: BorderRadius.circular(10),
//                                                             border: Border.all(color: ColorManager.bluebottom),
//                                                           ),
//                                                           child: Center(
//                                                             child: Text(
//                                                               "Edit",
//                                                               style: TextStyle(
//                                                                 fontSize: FontSize.s12,
//                                                                 fontWeight: FontWeight.w500,
//                                                                 color: ColorManager.mediumgrey,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         onTap: () async {
//                                                           final editUserProvider = Provider.of<EditUserProvider>(context, listen: false);
//
//                                                           // Fetch prefill data before opening the dialog
//                                                           await editUserProvider.fetchPrefillData(context, user.userId);
//
//                                                           // Check if prefill data is available
//                                                           if (editUserProvider.prefillData != null) {
//                                                             // Show dialog only after the data is fetched
//                                                             showDialog(
//                                                               context: context,
//                                                               builder: (BuildContext context) {
//                                                                 return EditUserPopUp(
//                                                                   title: "Edit User",
//                                                                   deptName: 'Select Department',
//                                                                   userId: user.userId,
//                                                                   firstname: editUserProvider.firstNameController.text,
//                                                                   lastname: editUserProvider.lastNameController.text,
//                                                                   email: editUserProvider.emailController.text,
//                                                                   departmentId: editUserProvider.prefillData!.deptId,
//                                                                   department: editUserProvider.prefillData!.department,
//                                                                 );
//                                                               },
//                                                             );
//                                                           } else {
//                                                             // Handle the case where prefill data is not available (optional)
//                                                             print("Error: Prefill data not found");
//                                                           }
//                                                         },
//                                                       ),
//
//                                                       SizedBox(
//                                                           width: AppSize.s10),
//                                                       /// Delete button
//                                                       // Delete button
//                                                       // if (userLogin != user.email)
//                                                       InkWell(
//                                                         onTap: () {
//                                                           showDialog(
//                                                             context: context,
//                                                             builder: (context) {
//                                                               return Consumer<DeleteUserPopupProvider>(
//                                                                 builder: (context, deleteUserPopupProvider, child) {
//                                                                   return DeleteUserPopup(
//                                                                     title: "Delete User",
//                                                                     isLoading: deleteUserPopupProvider.isLoading,
//                                                                     onCancel: () {
//                                                                       Navigator.pop(context);
//                                                                     },
//                                                                     onConfirm: () async {
//                                                                       // Set loading to true
//                                                                       deleteUserPopupProvider.setLoading(true);
//
//                                                                       try {
//                                                                         // Perform the deletion
//                                                                         await deleteUserPopupProvider.deleteUser(context, user.userId);
//
//                                                                         // Use addPostFrameCallback to ensure this happens after the build phase
//                                                                         WidgetsBinding.instance.addPostFrameCallback((_) async {
//                                                                           await seeAllProviderState.fetchUser(context);
//                                                                           // Future.microtask(() => Provider.of<SeeAllProvider>(context, listen: false).fetchUser(context));
// // Refresh user list
//
//                                                                           // Close the dialog and show success popup
//                                                                           Navigator.pop(context);
//                                                                             showDialog(
//                                                                             context: context,
//                                                                             builder: (context) => DeleteSuccessPopup(),
//                                                                           );
//                                                                         });
//                                                                       } finally {
//                                                                         // Set loading to false after the operation is complete
//                                                                         deleteUserPopupProvider.setLoading(false);
//                                                                       }
//                                                                     },
//
//                                                                   );
//                                                                 },
//                                                               );
//                                                             },
//                                                           );
//                                                         },
//                                                         child: Container(
//                                                           height: MediaQuery.of(context).size.height / 30,
//                                                           width: MediaQuery.of(context).size.width / 25,
//                                                           decoration: BoxDecoration(
//                                                             borderRadius: BorderRadius.circular(10),
//                                                             border: Border.all(color: ColorManager.bluebottom),
//                                                           ),
//                                                           child: Center(
//                                                             child: Text(
//                                                               AppString.delete,
//                                                               style: TextStyle(
//                                                                 fontSize: FontSize.s12,
//                                                                 fontWeight: FontWeight.w500,
//                                                                 color: ColorManager.mediumgrey,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//
//
//
//
//                                                     ])))
//                                       ]);
//                                 }))
//                       ]);
//                     },
//                   );
//                 },
//               ),
//             ),
//
//             ///Pagination
//             PaginationnControlsWidget()
//           ],
//         ),
//       ),
//     );
//   }
// }



///old no bugs
class SeeAllScreen extends StatefulWidget {
  const SeeAllScreen({super.key});

  @override
  State<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  final StreamController<List<CompanyModel>> _controller =
      StreamController<List<CompanyModel>>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController userIdController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController companyIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final StreamController<List<UserModal>> _companyUsersList =
      StreamController<List<UserModal>>();
  final PageController _pageController = PageController();

  // late int currentPage;
  // late int itemsPerPage;
  late List<String> items;
  bool showStreamBuilder = true;
  bool showManageScreen = false;
  bool showWhitelabellingScreen = false;
  bool firstNameValid = true;
  bool lastNameValid = true;
  bool roleValid = true;
  bool emailValid = true;
  bool passwordValid = true;
  bool companyIdValid = true;
  bool isLoading = false;
  bool _isLoading = false;
  bool _showErrorMessage = false;
  bool isButtonEnabled = false;
  String? userLogin;

  Future<String> isUserLoggedIn() async {
    userLogin = await TokenManager.getEmail();
    print('???????????????????????????????? see all $userLogin');
    return userLogin!;
  }


  void handleSubmit() async {
    try {
      await createUserPost(
          context,
          firstNameController.text,
          lastNameController.text,
          selectedDeptId!, // roleController.text,
          emailController.text,
          // int.parse(companyIdController.text),
          passwordController.text);
      // Handle response here
      firstNameController.clear();
      lastNameController.clear();
      roleController.clear();
      emailController.clear();
      companyIdController.clear();
      passwordController.clear();
      print('Form validated and submitted!');
    } catch (error) {
      // Handle error here
      print('Error: $error');
    } finally {
      Future.delayed(Duration(seconds: 2), () {
        print('Submit action completed!');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    isUserLoggedIn();
    getUser(context).then((data) {
      _companyUsersList.add(data);
    }).catchError((error) {
      // Handle error
    });
    userIdController.addListener(_checkFields);
    firstNameController.addListener(_checkFields);
    lastNameController.addListener(_checkFields);
    roleController.addListener(_checkFields);
    emailController.addListener(_checkFields);
    companyIdController.addListener(_checkFields);
  }

  void _checkFields() {
    setState(() {
      isButtonEnabled = userIdController.text.isNotEmpty &&
          firstNameController.text.isNotEmpty &&
          lastNameController.text.isNotEmpty &&
          roleController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          companyIdController.text.isNotEmpty;
    });
  }

  bool _validateForm() {
    // Validate all text fields
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        roleController.text.isEmpty ||
        emailController.text.isEmpty ||
        companyIdController.text.isEmpty ||
        passwordController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    userIdController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    roleController.dispose();
    emailController.dispose();
    companyIdController.dispose();
    super.dispose();
  }

  int currentPage = 1;
  final int itemsPerPage = 10;
  final int totalPages = 5;

  void onPageNumberPressed(int pageNumber) {
    setState(() {
      currentPage = pageNumber;
    });
  }

  var deptId = 1;
  int? firstDeptId;
  String? selectedDeptName;
  int? selectedDeptId;
  // String? selectedDeptName;
  // int? selectedDeptId;
  @override

  ///old
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 24),
        child: Column(
          children: [
            ///Create User Button
            Padding(
              padding: const EdgeInsets.only(right: AppPadding.p30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: AppSize.s30,
                    width: AppSize.s150,
                    child: CustomIconButton(
                      icon: Icons.add,
                      text: 'Create User',
                      onPressed: () async {
                        lastNameController.clear();
                        emailController.clear();
                        firstNameController.clear();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialogSEE(
                              title: "Create User",
                              //userIdController: userIdController,
                              lastNameController: lastNameController,
                              emailController: emailController,
                              firstNameController: firstNameController,
                              // roleController: roleController,
                              passwordController: passwordController,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppSize.s10,
            ),
            Column(
              children: [
                Container(
                  height: AppSize.s30,
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    color: ColorManager.fmediumgrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: AppPadding.p90),
                            child:  Text(
                              AppString.srNo,
                              style:TableHeading.customTextStyle(context),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: AppPadding.p60),
                            child: Text(
                              AppString.userId,
                              style:TableHeading.customTextStyle(context),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: AppPadding.p20),
                            child: Text(
                              AppString.fname,
                              style:TableHeading.customTextStyle(context),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(right: AppPadding.p40),
                            child: Text(
                              AppString.lname,
                              textAlign: TextAlign.start,
                              style:TableHeading.customTextStyle(context),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            AppString.role,
                            style:TableHeading.customTextStyle(context),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            AppString.email,
                            textAlign: TextAlign.start,
                            style:TableHeading.customTextStyle(context),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left:AppPadding.p40),
                            child: Text(
                              AppString.actions,
                              textAlign: TextAlign.start,
                              style:TableHeading.customTextStyle(context),)
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: AppSize.s10),
              ],
            ),
            Expanded(
              child: StreamBuilder<List<UserModal>>(
                stream: _companyUsersList.stream,
                builder: (BuildContext context, snapshot) {
                  getUser(context).then((data) {
                      _companyUsersList.add(data);
                    }).catchError((error) {});
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    );
                  }
                  if (snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        ErrorMessageString.noUser, // "No Data!",
                        style: AllNoDataAvailable.customTextStyle(context),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    List<UserModal> sortedData = snapshot.data!;
                    sortedData.sort((a, b) => b.userId.compareTo(a.userId));
                    int totalItems = sortedData.length;
                    int totalPages = (totalItems / itemsPerPage).ceil();
                    List<UserModal> paginatedData = sortedData
                        .skip((currentPage - 1) * itemsPerPage)
                        .take(itemsPerPage)
                        .toList();
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: paginatedData.length,
                            itemBuilder: (context, index) {
                              int serialNumber =
                                  index + 1 + (currentPage - 1) * itemsPerPage;
                              String formattedSerialNumber =
                                  serialNumber.toString().padLeft(2, '0');
                              UserModal user = paginatedData[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: AppPadding.p30),
                                    decoration: BoxDecoration(
                                      color: ColorManager.white,
                                      borderRadius: BorderRadius.circular(4),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                        BoxShadow(
                                          color: Colors.blue.withOpacity(0.5),
                                          offset: Offset(-4, 0),
                                        ),
                                      ],
                                    ),
                                    height: AppSize.s56,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context).size.width / 50),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              formattedSerialNumber,
                                              style: TableSubHeading.customTextStyle(context),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              user.userId.toString(),
                                              textAlign: TextAlign.center,
                                              style:  TableSubHeading.customTextStyle(context),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              user.firstName,
                                              textAlign: TextAlign.center,
                                              style:  TableSubHeading.customTextStyle(context),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: AppPadding.p20),
                                              child: Text(
                                                user.lastName,
                                                textAlign: TextAlign.center,
                                                style:  TableSubHeading.customTextStyle(context),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: AppPadding.p50),
                                              child: Text(
                                                user.role,
                                                textAlign: TextAlign.center,
                                                style:  TableSubHeading.customTextStyle(context),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: AppPadding.p100),
                                              child: Text(
                                                user.email,
                                                textAlign: TextAlign.start,
                                                style:  TableSubHeading.customTextStyle(context),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                /// Edit button
                                                InkWell(
                                                  child: Container(
                                                    height: MediaQuery.of(context).size.height / 30,
                                                    width: MediaQuery.of(context).size.width / 25,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      border: Border.all(color: ColorManager.bluebottom),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Edit",
                                                        style: TextStyle(fontSize: FontSize.s12,fontWeight:FontWeight.w500,color: ColorManager.mediumgrey),
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                      context) {
                                                        return FutureBuilder<
                                                            UserModalPrefill>(
                                                          future:
                                                          getUserPrefill(
                                                              context,
                                                              user.userId),
                                                          builder: (context,
                                                              snapshotPrefill) {
                                                            if (snapshotPrefill
                                                                .connectionState ==
                                                                ConnectionState
                                                                    .waiting) {
                                                              return Center(
                                                                child: CircularProgressIndicator(
                                                                    color: ColorManager
                                                                        .blueprime),
                                                              );
                                                            }
                                                            firstNameController = TextEditingController(text: snapshotPrefill.data!.firstName ?? " ");
                                                            lastNameController = TextEditingController(text: snapshotPrefill.data!.lastName ?? "");
                                                            emailController = TextEditingController(text: snapshotPrefill.data!.email ?? " ");
                                                            companyIdController = TextEditingController(text: snapshotPrefill.data!.companyId.toString() ?? "0");
                                                            return EditUserPopUp(
                                                              title:
                                                              "Edit User ",
                                                              ///Role
                                                              deptName: 'Select Department',
                                                              userId: user.userId,
                                                              firstname: user.firstName,
                                                              lastname: user.lastName,
                                                              email:user.email, departmentId: snapshotPrefill.data!.deptId, department: snapshotPrefill.data!.department,
                                                            );
                                                          },
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                                SizedBox(width: AppSize.s10),

                                                /// Delete button
                                                if (userLogin != user.email )
                                                  InkWell(
                                                  onTap: ()  {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          StatefulBuilder(
                                                            builder: (BuildContext context, void Function(void Function()) setState) {
                                                              return DeletePopup(
                                                                  title: "Delete User",
                                                                  loadingDuration: _isLoading,
                                                                  onCancel: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  }, onDelete:
                                                                  () async {
                                                                setState(() {
                                                                  _isLoading = true;
                                                                });
                                                                try {await deleteUser(context, user.userId);
                                                                  getUser(context).then((data) {
                                                                    _companyUsersList.add(data);
                                                                  }).catchError((error) {
                                                                        // Handle error
                                                                  });
                                                                Navigator.pop(context);
                                                                showDialog(context: context, builder: (context) => DeleteSuccessPopup());

                                                                } finally {
                                                                  setState(() {
                                                                    _isLoading = false;
                                                                  });
                                                                }
                                                              });
                                                            },
                                                          ),
                                                    );
                                                  },
                                                  child: Container(
                                                    height: MediaQuery.of(context).size.height / 30,
                                                    width: MediaQuery.of(context).size.width / 25,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      border: Border.all(color: ColorManager.bluebottom),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        AppString.delete,
                                                        style:  TextStyle(fontSize: FontSize.s12,fontWeight:FontWeight.w500,color: ColorManager.mediumgrey),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        PaginationControlsWidget(
                          currentPage: currentPage,
                          items: snapshot.data!,
                          itemsPerPage: itemsPerPage,
                          onPreviousPagePressed: () {
                            setState(() {
                              currentPage =
                                  currentPage > 1 ? currentPage - 1 : 1;
                            });
                          },
                          onPageNumberPressed: (pageNumber) {
                            setState(() {
                              currentPage = pageNumber;
                            });
                          },
                          onNextPagePressed: () {
                            setState(() {
                              currentPage = currentPage < totalPages
                                  ? currentPage + 1
                                  : totalPages;
                            });
                          },
                        )
                      ],
                    );
                  }
                  return Scaffold();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
