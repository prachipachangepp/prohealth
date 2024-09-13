import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/user.dart';
import 'package:prohealth/data/api_data/establishment_data/all_from_hr/all_from_hr_data.dart';
import 'package:prohealth/data/api_data/establishment_data/user/user_modal.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/popup_const.dart';

import '../../../../app/resources/color.dart';
import '../../../../app/resources/font_manager.dart';
import '../../../../app/resources/theme_manager.dart';
import '../../../../app/services/api/managers/establishment_manager/all_from_hr_manager.dart';
import '../../../../data/api_data/establishment_data/company_identity/company_identity_data_.dart';
import '../../../widgets/establishment_text_const/text_widget_const.dart';
import '../../../widgets/widgets/constant_textfield/const_textfield.dart';
import '../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';
import '../../hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: AppSize.s30,
                  width: AppSize.s130,
                  child: CustomIconButton(
                    icon: Icons.add,
                    text: 'Create User',
                    onPressed: () async {
                      userIdController.clear();
                      firstNameController.clear();
                      lastNameController.clear();
                      roleController.clear();
                      emailController.clear();
                      companyIdController.clear();
                      passwordController.clear();
                      if (selectedDeptId == null) {
                        setState(() {
                          selectedDeptId = firstDeptId;
                        });
                      }
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialog(
                            title: "Create User ",
                            userIdController: userIdController,
                            lastNameController: lastNameController,
                            emailController: emailController,
                            firstNameController: firstNameController,
                            roleController: roleController,
                            passwordController: passwordController,
                            companyIdController: companyIdController,
                            onSubmit: () async {
                              await createUserPost(
                                  context,
                                  // userIdController.text,
                                  firstNameController.text,
                                  lastNameController.text,
                                  selectedDeptId!, // roleController.text,
                                  emailController.text,
                                  // 1, // int.parse(companyIdController.text),
                                  passwordController.text);
                              getUser(context).then((data) {
                                _companyUsersList.add(data);
                              }).catchError((error) {});
                              Navigator.pop(context);
                              firstNameController.clear();
                              lastNameController.clear();
                              roleController.clear();
                              emailController.clear();
                              companyIdController.clear();
                              passwordController.clear();
                            },
                            child: FutureBuilder<List<HRHeadBar>>(
                              future: companyHRHeadApi(context, deptId),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                    alignment: Alignment.center,
                                    child:
                                        loadingText, // Display a loading indicator
                                  );
                                }
                                if (snapshot.hasData &&
                                    snapshot.data!.isEmpty) {
                                  return Center(
                                    child: Text(
                                      ErrorMessageString.noroleAdded,
                                      style: CustomTextStylesCommon.commonStyle(
                                        fontWeight: FontWeightManager.medium,
                                        fontSize: FontSize.s12,
                                        color: ColorManager.mediumgrey,
                                      ),
                                    ),
                                  );
                                }
                                if (snapshot.hasData) {
                                  // Extract dropdown items from snapshot
                                  List<String> dropDownServiceList = snapshot
                                      .data!
                                      .map((dept) => dept.deptName!)
                                      .toList();
                                  String? firstDeptName =
                                      snapshot.data!.isNotEmpty
                                          ? snapshot.data![0].deptName
                                          : null;
                                  int? firstDeptId = snapshot.data!.isNotEmpty
                                      ? snapshot.data![0].deptId
                                      : null;

                                  if (selectedDeptName == null &&
                                      dropDownServiceList.isNotEmpty) {
                                    selectedDeptName = firstDeptName;
                                    selectedDeptId = firstDeptId;
                                  }

                                  return HRManageDropdown(
                                    controller: TextEditingController(
                                        text: selectedDeptName ?? ''),
                                    labelText: "Select Department",
                                    labelStyle: GoogleFonts.firaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: ColorManager.mediumgrey,
                                    ),
                                    labelFontSize: 12,
                                    items: dropDownServiceList,
                                    onChanged: (val) {
                                      setState(() {
                                        selectedDeptName = val;
                                        // Find the corresponding department ID from the snapshot
                                        selectedDeptId = snapshot.data!
                                            .firstWhere(
                                                (dept) => dept.deptName == val)
                                            .deptId;
                                      });
                                    },
                                  );
                                }
                                return const SizedBox(); // Return an empty widget in case of no data
                              },
                            ),
                            // FutureBuilder<List<HRHeadBar>>(
                            //   future: companyHRHeadApi(context, deptId),
                            //   builder: (context, snapshot) {
                            //     if (snapshot.connectionState ==
                            //         ConnectionState.waiting) {
                            //       return Container(
                            //         // width: 180,
                            //         // height: 30,
                            //         alignment: Alignment.center,
                            //         child: loadingText,
                            //       );
                            //     }
                            //     if (snapshot.hasData && snapshot.data!.isEmpty) {
                            //       return Center(
                            //         child: Text(
                            //           ErrorMessageString.noroleAdded,
                            //           style: CustomTextStylesCommon.commonStyle(
                            //             fontWeight: FontWeightManager.medium,
                            //             fontSize: FontSize.s12,
                            //             color: ColorManager.mediumgrey,
                            //           ),
                            //         ),
                            //       );
                            //     }
                            //     if (snapshot.hasData) {
                            //       List<DropdownMenuItem<String>>
                            //       dropDownServiceList = [];
                            //       for (var dept in snapshot.data!) {
                            //         dropDownServiceList.add(
                            //           DropdownMenuItem<String>(
                            //             value: dept.deptName,
                            //             child: Text(dept.deptName ?? ''),
                            //           ),
                            //         );
                            //       }
                            //       if (dropDownServiceList.isNotEmpty) {
                            //         firstDeptId = snapshot.data![0].deptId;
                            //       }
                            //
                            //       if (selectedDeptName == null &&
                            //           dropDownServiceList.isNotEmpty) {
                            //         selectedDeptName =
                            //             dropDownServiceList[0].value;
                            //         selectedDeptId = firstDeptId;
                            //       }
                            //
                            //       return CICCDropdown(
                            //         width: 300,
                            //         initialValue: selectedDeptName,
                            //         onChange: (val) {
                            //           setState(() {
                            //             selectedDeptName = val;
                            //             for (var dept in snapshot.data!) {
                            //               if (dept.deptName == val) {
                            //                 selectedDeptId =
                            //                     dept.deptId;
                            //               }
                            //             }
                            //           });
                            //         },
                            //         items: dropDownServiceList,
                            //       );
                            //     }
                            //     return const SizedBox();
                            //   },
                            // ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Container(
                  height: AppSize.s30,
                  //margin: EdgeInsets.symmetric(horizontal: 50),
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
                            padding: const EdgeInsets.only(left: 100.0),
                            child: const Text(
                              AppString.srNo,
                              style: TextStyle(
                                fontSize: FontSize.s12,
                                fontWeight: FontWeightManager.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 65.0),
                            child: Text(
                              "User ID",
                              style: GoogleFonts.firaSans(
                                  fontSize: FontSize.s12,
                                  fontWeight: FontWeightManager.bold,
                                  color: ColorManager.white),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              AppString.fname,
                              style: GoogleFonts.firaSans(
                                  fontSize: FontSize.s12,
                                  fontWeight: FontWeightManager.bold,
                                  color: ColorManager.white),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 40.0),
                            child: Text(
                              AppString.lname,
                              textAlign: TextAlign.start,
                              style: GoogleFonts.firaSans(
                                  fontSize: FontSize.s12,
                                  fontWeight: FontWeightManager.bold,
                                  color: ColorManager.white),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            AppString.role,
                            style: GoogleFonts.firaSans(
                                fontSize: FontSize.s12,
                                fontWeight: FontWeightManager.bold,
                                color: ColorManager.white),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            AppString.email,
                            textAlign: TextAlign.start,
                            style: GoogleFonts.firaSans(
                                fontSize: FontSize.s12,
                                fontWeight: FontWeightManager.bold,
                                color: ColorManager.white),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: Text(
                              AppString.actions,
                              textAlign: TextAlign.start,
                              style: GoogleFonts.firaSans(
                                  fontSize: FontSize.s12,
                                  fontWeight: FontWeightManager.bold,
                                  color: ColorManager.white),
                            ),
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
                        style: TextStyle(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.medium,
                          color: Colors.grey,
                        ),
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
                                    //margin: EdgeInsets.symmetric(horizontal: 50),
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
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              50),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              formattedSerialNumber,
                                              style: GoogleFonts.firaSans(
                                                fontSize: FontSize.s10,
                                                fontWeight:
                                                    FontWeightManager.bold,
                                                color: ColorManager.granitegray,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              user.userId.toString(),
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.firaSans(
                                                fontSize: FontSize.s10,
                                                fontWeight:
                                                    FontWeightManager.bold,
                                                color: ColorManager.granitegray,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              user.firstName,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.firaSans(
                                                fontSize: FontSize.s10,
                                                fontWeight:
                                                    FontWeightManager.bold,
                                                color: ColorManager.granitegray,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Text(
                                                user.lastName,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.firaSans(
                                                  fontSize: FontSize.s10,
                                                  fontWeight:
                                                      FontWeightManager.bold,
                                                  color:
                                                      ColorManager.granitegray,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 50.0),
                                              child: Text(
                                                user.role,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.firaSans(
                                                  fontSize: FontSize.s10,
                                                  fontWeight:
                                                      FontWeightManager.bold,
                                                  color:
                                                      ColorManager.granitegray,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 100.0),
                                              child: Text(
                                                user.email,
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.firaSans(
                                                  fontSize: FontSize.s10,
                                                  fontWeight:
                                                      FontWeightManager.bold,
                                                  color:
                                                      ColorManager.granitegray,
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Expanded(
                                          //   flex: 2,
                                          //   child: Text(
                                          //     user.companyId.toString(),
                                          //     textAlign: TextAlign.center,
                                          //     style: GoogleFonts.firaSans(
                                          //       fontSize: FontSize.s10,
                                          //       fontWeight:
                                          //           FontWeightManager.bold,
                                          //       color: ColorManager.granitegray,
                                          //     ),
                                          //   ),
                                          // ),
                                          Expanded(
                                            flex: 1,
                                            child: Row(
                                              children: [
                                                /// Edit button
                                                InkWell(
                                                  child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            30,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            25,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: ColorManager
                                                              .bluebottom),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Edit",
                                                        style: GoogleFonts
                                                            .firaSans(
                                                                fontSize:
                                                                    FontSize
                                                                        .s10),
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return

                                                            ///
                                                            FutureBuilder<
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
                                                            userIdController =
                                                                TextEditingController(
                                                                    text: snapshotPrefill
                                                                            .data!
                                                                            .userId
                                                                            .toString() ??
                                                                        "0");
                                                            firstNameController =
                                                                TextEditingController(
                                                                    text: snapshotPrefill
                                                                            .data!
                                                                            .firstName ??
                                                                        " ");
                                                            lastNameController =
                                                                TextEditingController(
                                                                    text: snapshotPrefill
                                                                            .data!
                                                                            .lastName ??
                                                                        "");
                                                            emailController =
                                                                TextEditingController(
                                                                    text: snapshotPrefill
                                                                            .data!
                                                                            .email ??
                                                                        " ");
                                                            companyIdController =
                                                                TextEditingController(
                                                                    text: snapshotPrefill
                                                                            .data!
                                                                            .companyId
                                                                            .toString() ??
                                                                        "0");
                                                            return EditUserPopUp(
                                                              title:
                                                                  "Edit User ",
                                                              userIdController:
                                                                  userIdController,
                                                              lastNameController:
                                                                  lastNameController,
                                                              emailController:
                                                                  emailController,
                                                              firstNameController:
                                                                  firstNameController,
                                                              roleController:
                                                                  roleController,
                                                              companyIdController:
                                                                  companyIdController,
                                                              onSubmit:
                                                                  () async {
                                                                await updateUserPatch(
                                                                  context,
                                                                  user.userId,
                                                                  firstNameController
                                                                      .text,
                                                                  lastNameController
                                                                      .text,
                                                                  selectedDeptId ??
                                                                      snapshotPrefill
                                                                          .data!
                                                                          .deptId,
                                                                  emailController
                                                                      .text,
                                                                  null,
                                                                  selectedDeptName
                                                                      .toString(),
                                                                );
                                                                // print('password:::::::::::${passwordController.text}');
                                                                // print('Dept id:::::::::::${selectedDeptId}');
                                                                getUser(context)
                                                                    .then(
                                                                        (data) {
                                                                  _companyUsersList
                                                                      .add(
                                                                          data);
                                                                }).catchError(
                                                                        (error) {
                                                                  // Handle error
                                                                });
                                                                Navigator.pop(
                                                                    context);
                                                                firstNameController
                                                                    .clear();
                                                                lastNameController
                                                                    .clear();
                                                                roleController
                                                                    .clear();
                                                                emailController
                                                                    .clear();
                                                                companyIdController
                                                                    .clear();
                                                              },
                                                              // passwordController: passwordController,
                                                              ///Role
                                                              child: FutureBuilder<
                                                                  List<
                                                                      HRHeadBar>>(
                                                                future:
                                                                    companyHRHeadApi(
                                                                        context,
                                                                        deptId),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  if (snapshot
                                                                          .connectionState ==
                                                                      ConnectionState
                                                                          .waiting) {
                                                                    return Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          loadingText, // Display a loading indicator
                                                                    );
                                                                  }
                                                                  if (snapshot
                                                                          .hasData &&
                                                                      snapshot
                                                                          .data!
                                                                          .isEmpty) {
                                                                    return Center(
                                                                      child:
                                                                          Text(
                                                                        ErrorMessageString
                                                                            .noroleAdded,
                                                                        style: CustomTextStylesCommon
                                                                            .commonStyle(
                                                                          fontWeight:
                                                                              FontWeightManager.medium,
                                                                          fontSize:
                                                                              FontSize.s12,
                                                                          color:
                                                                              ColorManager.mediumgrey,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                  if (snapshot
                                                                      .hasData) {
                                                                    List<String>
                                                                        dropDownServiceList =
                                                                        snapshot
                                                                            .data!
                                                                            .map((dept) =>
                                                                                dept.deptName)
                                                                            .toList();
                                                                    String? firstDeptName = snapshot
                                                                            .data!
                                                                            .isNotEmpty
                                                                        ? snapshot.data![0].deptName ??
                                                                            ""
                                                                        : " ";
                                                                    int? firstDeptId = snapshot
                                                                            .data!
                                                                            .isNotEmpty
                                                                        ? snapshot.data![0].deptId ??
                                                                            0
                                                                        : 0;

                                                                    if (selectedDeptName ==
                                                                            null &&
                                                                        dropDownServiceList
                                                                            .isNotEmpty) {
                                                                      selectedDeptName =
                                                                          firstDeptName;
                                                                      selectedDeptId =
                                                                          firstDeptId;
                                                                    }
                                                                    return HRManageDropdown(
                                                                      controller:
                                                                          TextEditingController(
                                                                              text: selectedDeptName ?? ''),
                                                                      labelText:
                                                                          "Select Department",
                                                                      labelStyle:
                                                                          GoogleFonts
                                                                              .firaSans(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: ColorManager
                                                                            .mediumgrey,
                                                                      ),
                                                                      labelFontSize:
                                                                          12,
                                                                      items:
                                                                          dropDownServiceList,
                                                                      onChanged:
                                                                          (val) {
                                                                        for (var a
                                                                            in snapshot.data!) {
                                                                          if (a.deptName ==
                                                                              val) {
                                                                            selectedDeptName =
                                                                                val;
                                                                            selectedDeptId =
                                                                                snapshot.data!.firstWhere((dept) => dept.deptName == val).deptId;
                                                                          }
                                                                        }
                                                                        setState(
                                                                            () {
                                                                          print(
                                                                              "deptID :::::::${selectedDeptId}");
                                                                        });
                                                                      },
                                                                    );
                                                                  }
                                                                  return const SizedBox();
                                                                },
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                                SizedBox(width: AppSize.s10),

                                                /// Delete button
                                                InkWell(
                                                  onTap: () async {
                                                    await showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          DeletePopup(
                                                        title: 'Delete User',
                                                        onCancel: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        onDelete: () {
                                                          setState(() async {
                                                            await deleteUser(
                                                                context,
                                                                user.userId);
                                                            getUser(context)
                                                                .then((data) {
                                                              _companyUsersList
                                                                  .add(data);
                                                            }).catchError(
                                                                    (error) {
                                                              // Handle error
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                        },
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            30,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            25,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: ColorManager
                                                              .bluebottom),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        AppString.delete,
                                                        style: GoogleFonts
                                                            .firaSans(
                                                                fontSize:
                                                                    FontSize
                                                                        .s10),
                                                      ),
                                                    ),
                                                  ),
                                                ),
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
