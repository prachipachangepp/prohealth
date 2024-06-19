import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/manage_button_screen.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/whitelabelling_screen.dart';

import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/services/api/managers/establishment_manager/company_identrity_manager.dart';
import '../../../../../../data/api_data/establishment_data/company_identity/company_identity_data_.dart';
import '../../../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../../../hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../../widgets/button_constant.dart';
import '../../../widgets/text_form_field_const.dart';

class CompanyIdentity extends StatefulWidget {
  const CompanyIdentity({Key? key}) : super(key: key);

  @override
  State<CompanyIdentity> createState() => _CompanyIdentityState();
}

class _CompanyIdentityState extends State<CompanyIdentity> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobNumController = TextEditingController();
  TextEditingController secNumController = TextEditingController();
  TextEditingController OptionalController = TextEditingController();
  late StreamController<List<CompanyIdentityModel>> _companyIdentityController;
  final PageController _pageController = PageController();
  late int currentPage;
  late int itemsPerPage;

  bool showStreamBuilder = true;
  bool showManageScreen = false;
  bool showWhitelabellingScreen =
      false; // New state variable for Whitelabelling

  void loadData() {}

  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 5;
  }

  String selectedOfficeID = '';
  String selectedOfficeName = '';

  void showManageScreenFunction({required String officeId, officeName}) {
    setState(() {
      selectedOfficeID = officeId;
      selectedOfficeName = officeName;
      showManageScreen = true;
      showStreamBuilder = false;
      showWhitelabellingScreen = false;
    });
  }

  void showWhitelabellingScreenFunction() {
    setState(() {
      showStreamBuilder = false;
      showWhitelabellingScreen = true;
      showManageScreen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _companyIdentityController = StreamController<List<CompanyIdentityModel>>();
    return Column(
      children: [
        if (!showManageScreen && !showWhitelabellingScreen)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  borderRadius: 12,
                  text: 'White-labelling',
                  style: CustomTextStylesCommon.commonStyle(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeightManager.bold,
                      color: ColorManager.white),
                  width: 120,
                  height: 30,
                  onPressed: showWhitelabellingScreenFunction,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 50),
                child: CustomIconButtonConst(
                  text: 'Add New Office',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            backgroundColor: Colors.white,
                            content: Container(
                              height: 450,
                              width: 300,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(Icons.close))
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SMTextFConst(
                                        controller: nameController,
                                        keyboardType: TextInputType.text,
                                        text: 'Name',
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      SMTextFConst(
                                        controller: addressController,
                                        keyboardType:
                                            TextInputType.streetAddress,
                                        text: 'Address',
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      SMTextFConst(
                                        controller: emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        text: 'Email',
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      SMTextFConst(
                                        controller: mobNumController,
                                        keyboardType: TextInputType.number,
                                        text: 'Primary Phone',
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      SMTextFConst(
                                        controller: secNumController,
                                        keyboardType: TextInputType.number,
                                        text: 'Secondary Phone',
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      SMTextFConst(
                                        controller: OptionalController,
                                        keyboardType: TextInputType.number,
                                        text: 'Alternative Phone',
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  CustomElevatedButton(
                                      width: 105,
                                      height: 31,
                                      text: 'Submit',
                                      onPressed: () async {
                                        await addNewOffice(
                                            context,
                                            nameController.text,
                                            addressController.text,
                                            emailController.text,
                                            mobNumController.text,
                                            secNumController.text);
                                        companyOfficeListGet(context, 11, 1, 6)
                                            .then((data) {
                                          _companyIdentityController.add(data);
                                        }).catchError((error) {});
                                        Navigator.pop(context);
                                      })
                                ],
                              ),
                            ));
                      },
                    );
                  },
                  icon: Icons.add,
                ),
              )
            ],
          ),
        if (!showManageScreen && !showWhitelabellingScreen)
          Expanded(
            child: showStreamBuilder
                ? FutureBuilder(
                    future: companyOfficeListGet(context, 11, 1, 6),
                    builder: (context, snap) {
                      if (snap.hasData) {
                        _companyIdentityController.add(snap.data!);

                        return StreamBuilder<List<CompanyIdentityModel>>(
                          stream: _companyIdentityController.stream,
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                ),
                              );
                            }
                            if (snapshot.data!.isEmpty) {
                              return const Center(
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
                                  int serialNumber = index +
                                      1 +
                                      (currentPage - 1) * itemsPerPage;
                                  String formattedSerialNumber =
                                      serialNumber.toString().padLeft(2, '0');
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 5),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 50),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        height: 56,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.menu_sharp,
                                                color: Color(0xff686464),
                                              ),
                                            ),
                                            Text(
                                              formattedSerialNumber,
                                              style: GoogleFonts.firaSans(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                                color: const Color(0xff686464),
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              snapshot.data![index].officeName
                                                  .toString(),
                                              style: GoogleFonts.firaSans(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                                color: const Color(0xff686464),
                                              ),
                                            ),
                                            Text(
                                              snapshot.data![index].address
                                                  .toString(),
                                              textAlign: TextAlign.end,
                                              style: GoogleFonts.firaSans(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                                color: const Color(0xff686464),
                                              ),
                                            ),
                                            CustomButtonTransparentSM(
                                              text: 'Manage',
                                              onPressed: () {
                                                print(snapshot
                                                    .data![index].officeId);
                                                print("Is office id");
                                                showManageScreenFunction(
                                                    officeId: snapshot
                                                        .data![index].officeId,
                                                    officeName: snapshot
                                                        .data![index]
                                                        .officeName);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                            return const Scaffold();
                          },
                        );
                      } else {
                        return const Text("No Data");
                      }
                    })
                : PageView(
                    controller: _pageController,
                    children: [
                      Container(
                        child: WhitelabellingScreen(),
                      ),
                    ],
                  ),
          ),
        if (showManageScreen)
          Expanded(
            child: ManageWidget(
              officeID: selectedOfficeID,
              officeName: selectedOfficeName,
              backButtonCallBack: (bool val) {
                if (val) {
                  setState(() {
                    showWhitelabellingScreen = false;
                    showManageScreen = false;
                    showStreamBuilder = true;
                  });
                }
              },
            ), // Replace with your actual ManageScreen widget
          ),
        if (showWhitelabellingScreen)
          Expanded(
            child:
                WhitelabellingScreen(), // Replace with your actual WhitelabellingScreen widget
          ),
      ],
    );
  }
}
