import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/user.dart';
import 'package:prohealth/data/api_data/establishment_data/user/user_modal.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/documents_child/widgets/const_field.dart';
import 'package:prohealth/presentation/widgets/widgets/constant_textfield/const_textfield.dart';

import '../../../../app/resources/color.dart';
import '../../../../app/services/api/managers/establishment_manager/company_identrity_manager.dart';
import '../../../../app/services/api_sm/company_identity/add_doc_company_manager.dart';
import '../../../../data/api_data/establishment_data/company_identity/company_identity_data_.dart';
import '../../hr_module/manage/widgets/custom_icon_button_constant.dart';

class SeeAllScreen extends StatefulWidget {
  const SeeAllScreen({super.key});

  @override
  State<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  late CompanyIdentityManager _companyManager;
  final StreamController<List<CompanyModel>> _controller = StreamController<List<CompanyModel>>();
  TextEditingController userIdController= TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController companyIdController = TextEditingController();
  final StreamController<List<UserModal>> _companyUsersList = StreamController<List<UserModal>>();
  final PageController _pageController = PageController();
  late int currentPage;
  late int itemsPerPage;
  late List<String> items;
  bool showStreamBuilder = true;
  bool showManageScreen = false;
  bool showWhitelabellingScreen = false; // New state variable for Whitelabelling

  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 5;
    items = List.generate(20, (index) => 'Item ${index + 1}');
    _companyManager = CompanyIdentityManager();
    getUser(context).then((data) {
      _companyUsersList.add(data);
    }).catchError((error) {
      // Handle error
    });
  }

  void toggleView(bool showStream) {
    setState(() {
      showStreamBuilder = showStream;
      showManageScreen = false;
      showWhitelabellingScreen = false;
    });
  }

  void showManageScreenFunction() {
    setState(() {
      showManageScreen = true;
      showWhitelabellingScreen = false;
    });
  }

  void showWhitelabellingScreenFunction() {
    setState(() {
      showWhitelabellingScreen = true;
      showManageScreen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Column(
            children: [
              Container(
                height: 30,
                margin: EdgeInsets.symmetric(horizontal: 50),
                decoration: BoxDecoration(
                  color: ColorManager.fmediumgrey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      AppString.srNo,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "User ID",
                      style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.white
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "First Name",
                      style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.white
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Last Name",
                      style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.white
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Role",
                      style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.white
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Email ID",
                      style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.white
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Company ID",
                      style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.white
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Action",
                      style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.white
                      ),
                    ),
                    SizedBox(width: 15),
                     // SizedBox(width: 1),
                  ],
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
                  (currentPage - 1) * itemsPerPage;
                  (currentPage * itemsPerPage) > totalItems
                      ? totalItems
                      : (currentPage * itemsPerPage);

                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                      String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Container(
                            padding: EdgeInsets.only(bottom: 5),
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
                              ],
                            ),
                            height: 56,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  formattedSerialNumber,
                                  style: GoogleFonts.firaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff686464),
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  snapshot.data![index].userId.toString(),
                                  style: GoogleFonts.firaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff686464),
                                  ),
                                ),
                                Text(
                                 snapshot.data![index].firstName,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.firaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff686464),
                                  ),
                                ),
                                Text(
                                  snapshot.data![index].lastName,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.firaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff686464),
                                  ),
                                ),
                                Text(
                                  snapshot.data![index].role,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.firaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff686464),
                                  ),
                                ),
                                Text(
                                  snapshot.data![index].email,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.firaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff686464),
                                  ),
                                ),
                                Text(
                                  snapshot.data![index].companyId.toString(),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.firaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff686464),
                                  ),
                                ),
                               Row(
                                 children: [
                                   InkWell(
                                     child: Container(
                                       height: 20,
                                       width: 50,
                                       decoration: BoxDecoration(
                                         borderRadius:  BorderRadius.circular(10),
                                           border: Border.all(color: Colors.blueAccent)
                                       ),
                                       child: Center(
                                         child: Text(
                                           "Edit",
                                           style: TextStyle(
                                             fontSize: 8),
                                                                            ),
                                       ),),
                                     onTap: (){
                                       showDialog(
                                         context: context,
                                         builder: (BuildContext context) {
                                           return AlertDialog(
                                               backgroundColor: Colors.white,
                                               content: Container(
                                                 height: 450,
                                                 width: 300,
                                                 child: Column(
                                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                   children: [
                                                     Row(
                                                       mainAxisAlignment: MainAxisAlignment.end,
                                                       crossAxisAlignment: CrossAxisAlignment.end,
                                                       children: [
                                                         IconButton(
                                                             onPressed: () {
                                                               Navigator.pop(context);
                                                             },
                                                             icon: Icon(Icons.close))
                                                       ],
                                                     ),
                                                     Column(
                                                       mainAxisAlignment:
                                                       MainAxisAlignment.spaceBetween,
                                                       children: [
                                                         HRManageTextField(
                                                           controller: userIdController,
                                                           keyboardType: TextInputType.phone,
                                                           text: "Last Name",
                                                           cursorHeight: 12,
                                                           labelText: "Last Name",
                                                           labelStyle: GoogleFonts.firaSans(
                                                               fontWeight: FontWeight.w500

                                                           ),
                                                           labelFontSize: 12,),
                                                        HRManageTextField(
                                                            controller: firstNameController,
                                                            keyboardType: TextInputType.phone,
                                                            text: "Last Name",
                                                            cursorHeight: 12,
                                                            labelText: "Last Name",
                                                            labelStyle: GoogleFonts.firaSans(
                                                              fontWeight: FontWeight.w500
                                                            ),
                                                            labelFontSize: 12,),
                                                         HRManageTextField(
                                                           controller: lastNameController,
                                                           keyboardType: TextInputType.phone,
                                                           text: "Last Name",
                                                           cursorHeight: 12,
                                                           labelText: "Last Name",
                                                           labelStyle: GoogleFonts.firaSans(
                                                               fontWeight: FontWeight.w500

                                                           ),
                                                           labelFontSize: 12,),
                                                         HRManageTextField(
                                                           controller: roleController,
                                                           keyboardType: TextInputType.phone,
                                                           text: "Last Name",
                                                           cursorHeight: 12,
                                                           labelText: "Last Name",
                                                           labelStyle: GoogleFonts.firaSans(
                                                               fontWeight: FontWeight.w500

                                                           ),
                                                           labelFontSize: 12,),
                                                         HRManageTextField(
                                                           controller: emailController,
                                                           keyboardType: TextInputType.phone,
                                                           text: "Last Name",
                                                           cursorHeight: 12,
                                                           labelText: "Last Name",
                                                           labelStyle: GoogleFonts.firaSans(
                                                               fontWeight: FontWeight.w500

                                                           ),
                                                           labelFontSize: 12,),
                                                         HRManageTextField(
                                                           controller: companyIdController,
                                                           keyboardType: TextInputType.phone,
                                                           text: "Last Name",
                                                           cursorHeight: 12,
                                                           labelText: "Last Name",
                                                           labelStyle: GoogleFonts.firaSans(
                                                               fontWeight: FontWeight.w500

                                                           ),
                                                           labelFontSize: 12,),
                                                       ],
                                                     ),
                                                     SizedBox(
                                                       height: 40,
                                                     ),
                                                     CustomElevatedButton(
                                                         width: 105,
                                                         height: 31,
                                                         text: 'Submit',
                                                         onPressed: () async{
                                                           // await addNewOffice(
                                                           //     context,
                                                           //     nameController.text,
                                                           //     addressController.text,
                                                           //     emailController.text,
                                                           //     mobNumController.text,
                                                           //     secNumController.text
                                                           // );
                                                           // companyOfficeListGet(context,11,1,6).then((data) {
                                                           //   _companyIdentityController.add(data);
                                                           // }).catchError((error) {
                                                           // });
                                                           Navigator.pop(context);
                                                         })
                                                   ],
                                                 ),
                                               ));
                                         },
                                       );
                                     },
                                   ),
                                   SizedBox(
                                     width: 2,
                                   ),
                                   Container(
                                     height: 20,
                                     width: 50,
                                     decoration: BoxDecoration(
                                         borderRadius:  BorderRadius.circular(10),
                                         border: Border.all(color: Colors.blueAccent)
                                     ),
                                     child: Center(
                                       child: Text("Delete",style: TextStyle(
                                         fontSize: 8
                                       ),),
                                     ),
                                   )
                                 ],
                               )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
                return Scaffold();
              },
            )

          ),
        ],
      ),
    );
  }
}
