import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/user.dart';
import 'package:prohealth/data/api_data/establishment_data/user/user_modal.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/popup_const.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/const_field.dart';
import 'package:prohealth/presentation/widgets/widgets/constant_textfield/const_textfield.dart';

import '../../../../app/resources/color.dart';
import '../../../../app/services/api/managers/establishment_manager/company_identrity_manager.dart';
import '../../../../app/services/api_sm/company_identity/add_doc_company_manager.dart';
import '../../../../data/api_data/establishment_data/company_identity/company_identity_data_.dart';
import '../../hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../login_module/login/widgets/login_web.dart';
import '../manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';

class SeeAllScreen extends StatefulWidget {
  const SeeAllScreen({super.key});

  @override
  State<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  late CompanyIdentityManager _companyManager;
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
  late int currentPage;
  late int itemsPerPage;
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

  @override
  Widget build(BuildContext context) {
    int currentPage = 1;
    final int itemsPerPage = 20;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width/25,
                  bottom: MediaQuery.of(context).size.width/120,),
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back,size: 15,),
                      Text('Go Back',style: GoogleFonts.firaSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.mediumgrey),
                      ),
                    ],
                  ),
                ),
              ),
              ///Create USer
              Padding(
                padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/25,
                bottom: MediaQuery.of(context).size.width/120,
                ),
                child: Container(
                  height: 30,
                  width: 130,
                  child: CustomIconButton(
                    icon: Icons.add,
                    text: 'Create User',
                    onPressed: () async{
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
                          onSubmit: ()
                          async {
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
                            }).catchError((error) {
                            });
                            Navigator.pop(context);
                            // print("::::::::${firstNameController.text}");
                            //  print("::::::::${lastNameController.text}");
                            //  print("::::::::${roleController.text}");
                            //  print("::::::::${emailController.text}");
                            //  print("::::::::${companyIdController.text}");
                            //  print("::::::::${passwordController.text}");
                            firstNameController.clear();
                            lastNameController.clear();
                            roleController.clear();
                            emailController.clear();
                            companyIdController.clear();
                            passwordController.clear();
                            print('Form validated and submitted!');
                          },

                        );
                      },
                    );
                  },

                  ),
                ),
              )
            ],
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
                        child: Text(
                          "User ID",
                          style: GoogleFonts.firaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.white),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "First Name",
                          style: GoogleFonts.firaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.white),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Last Name",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.firaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.white),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Role",
                          style: GoogleFonts.firaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.white),
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
                        child: Text(
                          "Company ID",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.firaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.white),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Actions",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.firaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.white),
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
                // int totalItems = snapshot.data!.length;
                // (currentPage - 1) * itemsPerPage;
                // (currentPage * itemsPerPage) > totalItems
                //     ? totalItems
                //     : (currentPage * itemsPerPage);

                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    int serialNumber =
                        index + 1 + (currentPage - 1) * itemsPerPage;
                    String formattedSerialNumber =
                        serialNumber.toString().padLeft(2, '0');
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
                                color: Colors.blue.withOpacity(0.5), // Blue shadow color
                                // spreadRadius: 1,
                                // blurRadius: 4,
                                offset: Offset(-4, 0), // Offset to the left
                              ),
                            ],
                          ),
                          height: 56,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width / 50),
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
                                    snapshot.data![index].userId.toString(),
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
                                    snapshot.data![index].firstName,
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.firaSans(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff686464),
                                    ),
                                  ),
                                ),
                                // Expanded(
                                //     flex: 1,
                                //     child: Container()),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    snapshot.data![index].lastName,
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
                                    snapshot.data![index].role,
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
                                    snapshot.data![index].email,
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
                                  child: Text(
                                    snapshot.data![index].companyId.toString(),
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
                                      ///edit
                                      InkWell(
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              30,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              25,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: ColorManager.bluebottom)),
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
                                                future: getUserPrefill(context,snapshot.data![index].userId),
                                                builder: (context,snapshotPrefill) {
                                                  if(snapshotPrefill.connectionState == ConnectionState.waiting){
                                                    return Center(child: CircularProgressIndicator(color: ColorManager.blueprime,),);
                                                  }
                                                  var firstName = snapshotPrefill.data!.firstName;
                                                  var lastName = snapshotPrefill.data!.lastName;
                                                  //var userID = snapshotPrefill.data!.userId;
                                                  var role = snapshotPrefill.data!.role;
                                                  var email = snapshotPrefill.data!.email;
                                                  var companyId = snapshotPrefill.data!.companyId;
                                                  userIdController = TextEditingController(text:snapshotPrefill.data!.userId.toString());
                                                  firstNameController = TextEditingController(text: snapshotPrefill.data!.firstName.toString());
                                                  lastNameController = TextEditingController(text: snapshotPrefill.data!.lastName.toString());
                                                  //roleController = TextEditingController(text: snapshotPrefill.data!.role.toString());
                                                  emailController = TextEditingController(text: snapshotPrefill.data!.email.toString());
                                                  companyIdController = TextEditingController(text: snapshotPrefill.data!.companyId.toString());
                                                  return EditUserPopUp(
                                                    title: "Edit User ",
                                                    userIdController: userIdController,
                                                    lastNameController: lastNameController,
                                                    emailController: emailController,
                                                    firstNameController: firstNameController,
                                                    roleController: roleController,
                                                    // passwordController: passwordController,
                                                    companyIdController: companyIdController,
                                                    onSubmit:() async
                                                    {
                                                      await updateUserPatch(
                                                        context,
                                                        snapshot
                                                            .data![
                                                        index]
                                                            .userId,
                                                       firstName == firstNameController
                                                            .text ? firstName.toString() : firstNameController.text,
                                                       lastName == lastNameController
                                                            .text ? lastName.toString() : lastNameController.text,
                                                       role == roleController
                                                            .text ? role.toString() : roleController.text,
                                                       email == emailController
                                                            .text ? email.toString():emailController.text,
                                                       companyId == int.parse(
                                                            companyIdController
                                                                .text) ? companyId : int.parse(
                                                           companyIdController
                                                               .text),
                                                      );
                                                      getUser(context)
                                                          .then((data) {
                                                        _companyUsersList
                                                            .add(data);
                                                      }).catchError(
                                                              (error) {
                                                            // Handle error
                                                          });
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
                                                      Future.delayed(
                                                          Duration(
                                                              seconds:
                                                              2),
                                                              () {
                                                            print(
                                                                'Submit action completed!');
                                                          });
                                                      Navigator.pop(
                                                          context);
                                                    },

                                                  );
                                                }
                                              );
                                            },
                                          );
                                        },



                                        ///
                                        // onTap: () {
                                        //   showDialog(
                                        //     context: context,
                                        //     builder: (BuildContext context) {
                                        //       return AlertDialog(
                                        //           backgroundColor: Colors.white,
                                        //           content: Container(
                                        //             height: 440,
                                        //             width: 270,
                                        //             decoration: BoxDecoration(
                                        //                 borderRadius:
                                        //                     BorderRadius.all(
                                        //                         Radius.circular(
                                        //                             12))),
                                        //             child:
                                        //                 SingleChildScrollView(
                                        //               child: Column(
                                        //                 mainAxisAlignment:
                                        //                     MainAxisAlignment
                                        //                         .spaceAround,
                                        //                 children: [
                                        //                   Row(
                                        //                     mainAxisAlignment:
                                        //                         MainAxisAlignment
                                        //                             .end,
                                        //                     crossAxisAlignment:
                                        //                         CrossAxisAlignment
                                        //                             .end,
                                        //                     children: [
                                        //                       IconButton(
                                        //                           onPressed:
                                        //                               () {
                                        //                             Navigator.pop(
                                        //                                 context);
                                        //                           },
                                        //                           icon: Icon(Icons
                                        //                               .close))
                                        //                     ],
                                        //                   ),
                                        //                   Column(
                                        //                     mainAxisAlignment:
                                        //                         MainAxisAlignment
                                        //                             .spaceAround,
                                        //                     children: [
                                        //                       HRManageTextField(
                                        //                         controller:
                                        //                             userIdController,
                                        //                         keyboardType:
                                        //                             TextInputType
                                        //                                 .phone,
                                        //                         text: "User Id",
                                        //                         cursorHeight:
                                        //                             12,
                                        //                         labelText:
                                        //                             "User Id",
                                        //                         labelStyle: GoogleFonts.firaSans(
                                        //                             fontWeight:
                                        //                                 FontWeight
                                        //                                     .w500),
                                        //                         labelFontSize:
                                        //                             12,
                                        //                       ),
                                        //                       SizedBox(
                                        //                         height: 15,
                                        //                       ),
                                        //                       HRManageTextField(
                                        //                         controller:
                                        //                             firstNameController,
                                        //                         keyboardType:
                                        //                             TextInputType
                                        //                                 .phone,
                                        //                         text:
                                        //                             "First Name",
                                        //                         cursorHeight:
                                        //                             12,
                                        //                         labelText:
                                        //                             "First Name",
                                        //                         labelStyle: GoogleFonts.firaSans(
                                        //                             fontWeight:
                                        //                                 FontWeight
                                        //                                     .w500),
                                        //                         labelFontSize:
                                        //                             12,
                                        //                       ),
                                        //                       SizedBox(
                                        //                         height: 15,
                                        //                       ),
                                        //                       HRManageTextField(
                                        //                         controller:
                                        //                             lastNameController,
                                        //                         keyboardType:
                                        //                             TextInputType
                                        //                                 .phone,
                                        //                         text:
                                        //                             "Last Name",
                                        //                         cursorHeight:
                                        //                             12,
                                        //                         labelText:
                                        //                             "Last Name",
                                        //                         labelStyle: GoogleFonts.firaSans(
                                        //                             fontWeight:
                                        //                                 FontWeight
                                        //                                     .w500),
                                        //                         labelFontSize:
                                        //                             12,
                                        //                       ),
                                        //                       SizedBox(
                                        //                         height: 15,
                                        //                       ),
                                        //                       HRManageDropdown(
                                        //                         controller:
                                        //                             roleController,
                                        //                         labelText:
                                        //                             'Role',
                                        //                         labelStyle: GoogleFonts.firaSans(
                                        //                             fontWeight:
                                        //                                 FontWeight
                                        //                                     .w500),
                                        //                         labelFontSize:
                                        //                             12,
                                        //                         items: [
                                        //                           'Admin',
                                        //                           'Sales',
                                        //                           'Clinician'
                                        //                         ],
                                        //                       ),
                                        //                       SizedBox(
                                        //                         height: 15,
                                        //                       ),
                                        //                       HRManageTextField(
                                        //                         controller:
                                        //                             emailController,
                                        //                         keyboardType:
                                        //                             TextInputType
                                        //                                 .phone,
                                        //                         text:
                                        //                             "Email Id",
                                        //                         cursorHeight:
                                        //                             12,
                                        //                         labelText:
                                        //                             "Email Id",
                                        //                         labelStyle: GoogleFonts.firaSans(
                                        //                             fontWeight:
                                        //                                 FontWeight
                                        //                                     .w500),
                                        //                         labelFontSize:
                                        //                             12,
                                        //                       ),
                                        //                       SizedBox(
                                        //                         height: 15,
                                        //                       ),
                                        //                       HRManageTextField(
                                        //                         controller:
                                        //                             companyIdController,
                                        //                         keyboardType:
                                        //                             TextInputType
                                        //                                 .phone,
                                        //                         text:
                                        //                             "Company Id",
                                        //                         cursorHeight:
                                        //                             12,
                                        //                         labelText:
                                        //                             "Company Id",
                                        //                         labelStyle: GoogleFonts.firaSans(
                                        //                             fontWeight:
                                        //                                 FontWeight
                                        //                                     .w500),
                                        //                         labelFontSize:
                                        //                             12,
                                        //                       ),
                                        //                     ],
                                        //                   ),
                                        //                   SizedBox(
                                        //                     height: 40,
                                        //                   ),
                                        //                   ReusableLoadingButton(
                                        //                     text: 'Submit',
                                        //                     onPressed: () {
                                        //                       updateUserPatch(
                                        //                         context,
                                        //                         snapshot
                                        //                             .data![
                                        //                                 index]
                                        //                             .userId,
                                        //                         firstNameController
                                        //                             .text,
                                        //                         lastNameController
                                        //                             .text,
                                        //                         roleController
                                        //                             .text,
                                        //                         emailController
                                        //                             .text,
                                        //                         int.parse(
                                        //                             companyIdController
                                        //                                 .text),
                                        //                       );
                                        //                       getUser(context)
                                        //                           .then((data) {
                                        //                         _companyUsersList
                                        //                             .add(data);
                                        //                       }).catchError(
                                        //                               (error) {
                                        //                         // Handle error
                                        //                       });
                                        //                       firstNameController
                                        //                           .clear();
                                        //                       lastNameController
                                        //                           .clear();
                                        //                       roleController
                                        //                           .clear();
                                        //                       emailController
                                        //                           .clear();
                                        //                       companyIdController
                                        //                           .clear();
                                        //                       Future.delayed(
                                        //                           Duration(
                                        //                               seconds:
                                        //                                   2),
                                        //                           () {
                                        //                         print(
                                        //                             'Submit action completed!');
                                        //                       });
                                        //                       Navigator.pop(
                                        //                           context);
                                        //                     },
                                        //                     loadingDuration: 2,
                                        //                   ),
                                        //                 ],
                                        //               ),
                                        //             ),
                                        //           ));
                                        //     },
                                        //   );
                                        // },
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      ///delete
                                      InkWell(
                                        onTap: () async {
                                          await showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  DeletePopup(
                                                      title: 'Delete User',
                                                      onCancel: () {
                                                    Navigator.pop(context);
                                                  }, onDelete: () {
                                                    setState(() async {
                                                      await deleteUser(
                                                          context,
                                                          snapshot.data![index]
                                                              .userId);
                                                      getUser(context)
                                                          .then((data) {
                                                        _companyUsersList
                                                            .add(data);
                                                      }).catchError((error) {
                                                        // Handle error
                                                      });
                                                      Navigator.pop(context);
                                                    });
                                                  }));
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              30,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              25,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color:ColorManager.bluebottom)),
                                          child: Center(
                                            child: Text(
                                              "Delete",
                                              style: TextStyle(fontSize: 8),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                // Expanded(child: Container())
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
              return Scaffold();
            },
          )),
        ],
      ),
    );
  }
}
