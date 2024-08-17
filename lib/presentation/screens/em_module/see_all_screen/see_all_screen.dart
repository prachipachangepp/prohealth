import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/user.dart';
import 'package:prohealth/data/api_data/establishment_data/user/user_modal.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/popup_const.dart';
import '../../../../app/resources/color.dart';
import '../../../../data/api_data/establishment_data/company_identity/company_identity_data_.dart';
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
          roleController.text,
          emailController.text,
          int.parse(companyIdController.text),
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

  @override
  ///old
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: MediaQuery
                  .of(context)
                  .size
                  .width / 25,
              bottom: MediaQuery
                  .of(context)
                  .size
                  .width / 120,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 30,
                  width: 130,
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
                                  roleController.text,
                                  emailController.text,
                                  int.parse(companyIdController.text),
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

                          );
                        },
                      );
                    },

                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                height: 30,
                margin: EdgeInsets.symmetric(horizontal: 50),
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
                          padding: const EdgeInsets.only(left: 20.0),
                          child: const Text(
                            AppString.srNo,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            "User ID",
                            style: GoogleFonts.firaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: ColorManager.white),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            "First Name",
                            style: GoogleFonts.firaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: ColorManager.white),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            "Last Name",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.firaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: ColorManager.white),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Text(
                            "Role",
                            style: GoogleFonts.firaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: ColorManager.white),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Email",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.firaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.white),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: Text(
                            "Company ID",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.firaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: ColorManager.white),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            "Actions",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.firaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: ColorManager.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
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
                      "No Data!",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  int totalItems = snapshot.data!.length;
                  int totalPages = (totalItems / itemsPerPage).ceil();
                  List<UserModal> paginatedData = snapshot.data!.skip((currentPage - 1) * itemsPerPage).take(itemsPerPage).toList();

                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: paginatedData.length,
                          itemBuilder: (context, index) {
                            int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                            String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                            UserModal user = paginatedData[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 50),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
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
                                  height: 56,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 50),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            formattedSerialNumber,
                                            style: GoogleFonts.firaSans(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xff686464),
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            user.userId.toString(),
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.firaSans(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xff686464),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            user.firstName,
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.firaSans(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xff686464),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            user.lastName,
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.firaSans(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xff686464),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            user.role,
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.firaSans(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xff686464),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            user.email,
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.firaSans(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xff686464),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            user.companyId.toString(),
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.firaSans(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xff686464),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Row(
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
                                                      style: TextStyle(fontSize: 8),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return FutureBuilder<UserModalPrefill>(
                                                        future: getUserPrefill(context, user.userId),
                                                        builder: (context, snapshotPrefill) {
                                                          if (snapshotPrefill.connectionState == ConnectionState.waiting) {
                                                            return Center(
                                                              child: CircularProgressIndicator(color: ColorManager.blueprime),
                                                            );
                                                          }
                                                          // Populate the controllers with the prefetched data
                                                          userIdController = TextEditingController(text: snapshotPrefill.data!.userId.toString());
                                                          firstNameController = TextEditingController(text: snapshotPrefill.data!.firstName);
                                                          lastNameController = TextEditingController(text: snapshotPrefill.data!.lastName);
                                                          emailController = TextEditingController(text: snapshotPrefill.data!.email);
                                                          companyIdController = TextEditingController(text: snapshotPrefill.data!.companyId.toString());
                                                          return EditUserPopUp(
                                                            title: "Edit User ",
                                                            userIdController: userIdController,
                                                            lastNameController: lastNameController,
                                                            emailController: emailController,
                                                            firstNameController: firstNameController,
                                                            roleController: roleController,
                                                            companyIdController: companyIdController,
                                                            onSubmit: () async {
                                                              await updateUserPatch(
                                                                context,
                                                                user.userId,
                                                                firstNameController.text,
                                                                lastNameController.text,
                                                                roleController.text,
                                                                emailController.text,
                                                                int.parse(companyIdController.text),
                                                              );
                                                              getUser(context).then((data) {
                                                                _companyUsersList.add(data);
                                                              }).catchError((error) {
                                                                // Handle error
                                                              });
                                                              Navigator.pop(context);
                                                              firstNameController.clear();
                                                              lastNameController.clear();
                                                              roleController.clear();
                                                              emailController.clear();
                                                              companyIdController.clear();
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                              SizedBox(width: 10),
                                              /// Delete button
                                              InkWell(
                                                onTap: () async {
                                                  await showDialog(
                                                    context: context,
                                                    builder: (context) => DeletePopup(
                                                      title: 'Delete User',
                                                      onCancel: () {
                                                        Navigator.pop(context);
                                                      },
                                                      onDelete: () {
                                                        setState(() async {
                                                          await deleteUser(context, user.userId);
                                                          getUser(context).then((data) {
                                                            _companyUsersList.add(data);
                                                          }).catchError((error) {
                                                            // Handle error
                                                          });
                                                          Navigator.pop(context);
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
                                                      "Delete",
                                                      style: TextStyle(fontSize: 8),
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
                            currentPage = currentPage > 1 ? currentPage - 1 : 1;
                          });
                        },
                        onPageNumberPressed: (pageNumber) {
                          setState(() {
                            currentPage = pageNumber;
                          });
                        },
                        onNextPagePressed: () {
                          setState(() {
                            currentPage = currentPage < totalPages ? currentPage + 1 : totalPages;
                          });
                        },
                      ),

                    ],
                  );
                }
                return Scaffold();
              },
            ),
          )
        ],
      ),
    );
  }
}
