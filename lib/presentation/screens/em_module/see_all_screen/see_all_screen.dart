import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';

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
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobNumController = TextEditingController();
  TextEditingController secNumController = TextEditingController();
  TextEditingController OptionalController = TextEditingController();
  final StreamController<List<CompanyIdentityModel>> _companyIdentityController = StreamController<List<CompanyIdentityModel>>();
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
    companyOfficeListGet(context, 11, 1, 6).then((data) {
      _companyIdentityController.add(data);
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
                    Text(
                      "User ID",
                      style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.white
                      ),
                    ),
                    Text(
                      "First Name",
                      style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.white
                      ),
                    ),
                    Text(
                      "Address",
                      style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.white
                      ),
                    ),
                    Text(
                      "Last Name",
                      style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.white
                      ),
                    ),
                    Text(
                      "Role",
                      style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.white
                      ),
                    ),
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
                      "Action",
                      style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.white
                      ),
                    ),
                     // SizedBox(width: 1),
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
          Expanded(
            child: StreamBuilder<List<CompanyIdentityModel>>(
              stream: _companyIdentityController.stream,
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
                                  'User Id',
                                  style: GoogleFonts.firaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff686464),
                                  ),
                                ),
                                Text(
                                 'First Name',
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.firaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff686464),
                                  ),
                                ),
                                Text(
                                  'Last Name',
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.firaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff686464),
                                  ),
                                ),
                                Text(
                                  'Role',
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.firaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff686464),
                                  ),
                                ),
                                Text(
                                  'Email',
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.firaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff686464),
                                  ),
                                ),
                                Text(
                                  'Company ID',
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.firaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff686464),
                                  ),
                                ),
                               Row(
                                 children: [
                                   Container(
                                     height: 20,
                                     width: 50,
                                     decoration: BoxDecoration(
                                       borderRadius:  BorderRadius.circular(10),
                                         border: Border.all(color: Colors.blueAccent)
                                     ),
                                     child: Center(
                                       child: Text("Edit",style: TextStyle(
                                           fontSize: 8),
                                                                          ),
                                     ),),
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
