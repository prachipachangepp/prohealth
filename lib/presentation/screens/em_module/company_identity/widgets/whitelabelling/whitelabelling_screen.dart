import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/whitelabelling_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/whitelabelling_modal/whitelabelling_modal_.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/company_identity_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../widgets/button_constant.dart';
import '../../../widgets/text_form_field_const.dart';

class WhitelabellingScreen extends StatefulWidget {
  WhitelabellingScreen({super.key});

  @override
  State<WhitelabellingScreen> createState() => _WhitelabellingScreenState();
}

class _WhitelabellingScreenState extends State<WhitelabellingScreen> {
  TextEditingController nameController = TextEditingController();
  // TextEditingController secfaxController = TextEditingController();

  TextEditingController addressController = TextEditingController();
  TextEditingController secNumberController = TextEditingController();
  TextEditingController primNumController = TextEditingController();
  TextEditingController altNumController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController hcoNumController = TextEditingController();
  TextEditingController medicareController = TextEditingController();
  TextEditingController npiNumController = TextEditingController();
  TextEditingController faxController = TextEditingController();

  ///
  TextEditingController addressCtlr = TextEditingController();
  TextEditingController nameCtlr = TextEditingController();

  TextEditingController secNumberCtlr = TextEditingController();
  TextEditingController primNumCtlr = TextEditingController();
  TextEditingController altNumCtlr = TextEditingController();
  TextEditingController emailCtlr = TextEditingController();
  TextEditingController hcoNumCtlr = TextEditingController();
  TextEditingController medicareCtlr = TextEditingController();
  TextEditingController npiNumCtlr = TextEditingController();
  TextEditingController faxCtlr = TextEditingController();
  final StreamController<List<PlatformFile>> _mobileFilesStreamController =
      StreamController<List<PlatformFile>>.broadcast();
  final StreamController<List<PlatformFile>> _webFilesStreamController =
      StreamController<List<PlatformFile>>.broadcast();
  final StreamController<List<WhiteLabellingCompanyDetailModal>> _controller =
      StreamController<List<WhiteLabellingCompanyDetailModal>>();
  @override
  void dispose() {
    _mobileFilesStreamController.close();
    _webFilesStreamController.close();

    super.dispose();
  }

  String fileName = "No Chosen";
  //
  // void pickFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();
  //
  //   if (result != null) {
  //     setState(() {
  //       fileName = result.files.single.name;
  //     });
  //   } else {
  //     // User canceled the picker
  //     setState(() {
  //       fileName = "No Chosen";
  //     });
  //   }
  // }
  List<PlatformFile>? pickedMobileFiles;
  List<PlatformFile>? pickedWebFiles;
  Future<void> pickMobileLogo() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      pickedMobileFiles = result.files;
      _mobileFilesStreamController.add(pickedMobileFiles!);
    }
  }

  Future<void> pickWebLogo() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      pickedWebFiles = result.files;
      _webFilesStreamController.add(pickedWebFiles!);
    }
  }

  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Logos",
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.medium,
                        color: ColorManager.mediumgrey,
                      )),
                  // SizedBox(width: MediaQuery.of(context).size.width / 5),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 4.3),
                    child: Text("Details",
                        style: GoogleFonts.firaSans(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeightManager.medium,
                          color: ColorManager.mediumgrey,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 2.2),
                    child: Container(
                      height: 30,
                      width: 90,
                      child: CustomButton(
                        text: "Save",
                        onPressed: () {},
                      ),
                    ),
                  ),
                  // SizedBox(width: MediaQuery.of(context).size.width / 5),
                  Padding(
                    padding: EdgeInsets.only(left: 20
                        // MediaQuery.of(context).size.width/3
                        ),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CustomIconButton(
                          icon: Icons.edit_outlined,
                          text: "Edit Details",
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  content: Container(
                                    height: 350,
                                    width: 950,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(Icons.close),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Company App Logo",
                                                        style: GoogleFonts
                                                            .firaSans(
                                                          fontSize:
                                                              FontSize.s12,
                                                          fontWeight:
                                                              FontWeightManager
                                                                  .bold,
                                                          color:
                                                              Color(0xff686464),
                                                        )),

                                                    ///main
                                                    Container(
                                                      width: 354,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              "Upload Immunization Records from PDF",
                                                              style: GoogleFonts.firaSans(
                                                                  fontSize: 9,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Color(
                                                                      0xff686464))),

                                                          ///sub container
                                                          StreamBuilder<
                                                              List<
                                                                  PlatformFile>>(
                                                            stream:
                                                                _mobileFilesStreamController
                                                                    .stream,
                                                            builder: (context,
                                                                snapshot) {
                                                              return Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Container(
                                                                    width: 150,
                                                                    height: 30,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border: Border.all(
                                                                          color:
                                                                              Colors.grey),
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(10)),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        InkWell(
                                                                          onTap:
                                                                              pickMobileLogo,
                                                                          child:
                                                                              Container(
                                                                            color:
                                                                                Color(0xffD9D9D9),
                                                                            child:
                                                                                Text(
                                                                              "Choose File",
                                                                              style: GoogleFonts.firaSans(
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: Colors.grey,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        if (snapshot
                                                                            .hasData)
                                                                          ...snapshot
                                                                              .data!
                                                                              .map((file) => InkWell(
                                                                                    child: Container(
                                                                                      padding: EdgeInsets.only(bottom: 15),
                                                                                      // height: 30,
                                                                                      // width: 90,
                                                                                      child: Text(
                                                                                        file.name,
                                                                                        textAlign: TextAlign.start,
                                                                                        style: GoogleFonts.firaSans(
                                                                                          fontSize: 10,
                                                                                          fontWeight: FontWeight.w500,
                                                                                          color: Colors.grey,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    onTap: () => openFile(file),
                                                                                  ))
                                                                              .toList(),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          ),

                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SMTextFConst(
                                                  controller: nameController,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  text: AppStringEM.companyName,
                                                ),
                                                SizedBox(height: AppSize.s4),
                                                SMTextFConst(
                                                  controller:
                                                      secNumberController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  text: AppStringEM.secNum,
                                                ),
                                                SizedBox(height: AppSize.s4),
                                                SMTextFConst(
                                                  controller: faxController,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  text: AppStringEM.fax,
                                                ),
                                                SizedBox(height: AppSize.s4),
                                                SMTextFConst(
                                                  controller: addressController,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  text: AppStringEM.address,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Company Web Logo",
                                                        style: GoogleFonts
                                                            .firaSans(
                                                          fontSize:
                                                              FontSize.s12,
                                                          fontWeight:
                                                              FontWeightManager
                                                                  .bold,
                                                          color:
                                                              Color(0xff686464),
                                                        )),
                                                    Container(
                                                      width: 354,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              "Upload Immunization Records from PDF",
                                                              style: GoogleFonts.firaSans(
                                                                  fontSize: 9,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Color(
                                                                      0xff686464))),

                                                          ///sub container
                                                          StreamBuilder<
                                                              List<
                                                                  PlatformFile>>(
                                                            stream:
                                                                _webFilesStreamController
                                                                    .stream,
                                                            builder: (context,
                                                                snapshot) {
                                                              return Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Container(
                                                                    width: 150,
                                                                    height: 30,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border: Border.all(
                                                                          color:
                                                                              Colors.grey),
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(10)),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        InkWell(
                                                                          onTap:
                                                                              pickWebLogo,
                                                                          child:
                                                                              Container(
                                                                            color:
                                                                                Color(0xffD9D9D9),
                                                                            child:
                                                                                Text(
                                                                              "Choose File",
                                                                              style: GoogleFonts.firaSans(
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: Colors.grey,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        if (snapshot
                                                                            .hasData)
                                                                          ...snapshot
                                                                              .data!
                                                                              .map((file) => InkWell(
                                                                                    child: Container(
                                                                                      padding: EdgeInsets.only(bottom: 15),
                                                                                      // height: 30,
                                                                                      // width: 90,
                                                                                      child: Text(
                                                                                        file.name,
                                                                                        textAlign: TextAlign.start,
                                                                                        style: GoogleFonts.firaSans(
                                                                                          fontSize: 10,
                                                                                          fontWeight: FontWeight.w500,
                                                                                          color: Colors.grey,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    onTap: () => openFile(file),
                                                                                  ))
                                                                              .toList(),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SMTextFConst(
                                                  controller: primNumController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  text: AppStringEM.primNum,
                                                ),
                                                SizedBox(height: AppSize.s4),
                                                SMTextFConst(
                                                  controller: altNumController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  text: AppStringEM
                                                      .alternatephone,
                                                ),
                                                SizedBox(height: AppSize.s4),
                                                SMTextFConst(
                                                  controller: emailController,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  text: AppStringEM.primarymail,
                                                ),
                                                SizedBox(
                                                  width: 354,
                                                  height: 30,
                                                ),
                                                SizedBox(
                                                  width: 354,
                                                  height: 30,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: CustomElevatedButton(
                                          width: 105,
                                          height: 31,
                                          text: 'Submit',
                                          onPressed: () async {
                                            await postWhitelabellingAdd(
                                              context,
                                              0,
                                              '',
                                              primNumController.text,
                                              secNumberController.text,
                                              faxController.text,
                                              emailController.text,
                                              altNumController.text,
                                              nameController.text,
                                              addressController.text,
                                            );
                                            Navigator.pop(context);
                                          }),
                                    )
                                  ],
                                );
                              },
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 320,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorManager.blueprime,
                        ),
                        borderRadius:
                        BorderRadius.all(Radius.circular(20))),
                    child: StreamBuilder<WhiteLabellingCompanyDetailModal>(
                      stream: Stream.fromFuture(getWhiteLabellingData(context, 1)),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data!;
                          var appLogo = data.logos.firstWhere((logo) => logo.type == 'app',
                              orElse: () => WLLogoModal(
                                  companyLogoId: 3,
                                  companyId: 1,
                                  url: 'https://symmetry-image.s3.us-west-2.amazonaws.com/fd32e5b5-192d-4c13-a80a-f2a5e337f537-complogo2.jpg',
                                  type: ''));
                          var webLogo = data.logos.firstWhere((logo) => logo.type == 'web',
                              orElse: () => WLLogoModal(
                                  companyLogoId: 4,
                                  companyId: 1,
                                  url: 'https://symmetry-image.s3.us-west-2.amazonaws.com/8ba4e2e2-1a95-42ca-b15b-5b6cb71a1417-complogo1.jpg',
                                  type: ''));
                          var mainLogo = data.logos.firstWhere((logo) => logo.type == 'main',
                              orElse: () => WLLogoModal(
                                  companyLogoId: 4,
                                  companyId: 1,
                                  url: 'https://symmetry-image.s3.us-west-2.amazonaws.com/8ba4e2e2-1a95-42ca-b15b-5b6cb71a1417-complogo1.jpg',
                                  type: ''));

                          return Column(
                            children: [
                              Container(
                                height: 100,
                                child: mainLogo.url.isNotEmpty
                                    ? Image.asset(
                                  'images/formainlogoprohealth.png',
                                  // mainLogo.url,
                                  fit: BoxFit.cover,
                                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                    return Center(
                                      child: Icon(Icons.error, color: Colors.red),
                                    );
                                  },
                                )
                                    : Container(),
                              ),
                              Container(
                                height: 100,
                                child: webLogo.url.isNotEmpty
                                    ? Image.network(
                                  "https://symmetry-image.s3.us-west-2.amazonaws.com/8ba4e2e2-1a95-42ca-b15b-5b6cb71a1417-complogo1.jpg",
                                  // webLogo.url,
                                  fit: BoxFit.cover,
                                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                    return Center(
                                      child: Icon(Icons.error, color: Colors.red),
                                    );
                                  },
                                )
                                    : Container(),
                              ),
                              Container(
                                height: 100,
                                child:
                                appLogo.url.isNotEmpty
                                    ? Image.network(
                                      'https://symmetry-image.s3.us-west-2.amazonaws.com/fd32e5b5-192d-4c13-a80a-f2a5e337f537-complogo2.jpg',
                                  fit: BoxFit.cover,
                                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                    return Center(
                                      child: Icon(Icons.error, color: Colors.red),
                                    );
                                  },
                                )
                                    : Container(),
                              ),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                ),

                  ///old
                  // Expanded(
                //   flex: 2,
                //   child:
                //   StreamBuilder<WhiteLabellingCompanyDetailModal>(
                //     stream: Stream.fromFuture(
                //         getWhiteLabellingData(context, 1)),
                //     builder: (context, snapshot) {
                //       if (snapshot.hasData) {
                //         var data = snapshot.data!;
                //         var appLogo = data.logos.firstWhere((logo) => logo.type == 'app',
                //             orElse: () => WLLogoModal(companyLogoId: 3,
                //                 companyId: 1, url:
                //                 'https://symmetry-image.s3.us-west-2.amazonaws.com/fd32e5b5-192d-4c13-a80a-f2a5e337f537-complogo2.jpg',
                //                 type: ''));
                //         var webLogo = data.logos.firstWhere((logo) => logo.type == 'web',
                //             orElse: () => WLLogoModal(companyLogoId: 4,
                //                 companyId: 1, url:
                //                 'https://symmetry-image.s3.us-west-2.amazonaws.com/8ba4e2e2-1a95-42ca-b15b-5b6cb71a1417-complogo1.jpg',
                //                 type: ''));
                //         var mainLogo = data.logos.firstWhere((logo) => logo.type == 'main',
                //             orElse: () => WLLogoModal(companyLogoId: 4, companyId: 1,
                //                 url: 'https://symmetry-image.s3.us-west-2.amazonaws.com/8ba4e2e2-1a95-42ca-b15b-5b6cb71a1417-complogo1.jpg', type: ''));
                //         return Column(
                //           children: [
                //             Expanded(
                //               flex: 1,
                //               child: mainLogo.url.isNotEmpty
                //                   ? Image.network(mainLogo.url)
                //                   : Container(),
                //             ),
                //             Expanded(
                //               flex: 1,
                //               child: webLogo.url.isNotEmpty
                //                   ? Image.network(webLogo.url)
                //                   : Container(),
                //             ),
                //             Expanded(
                //               flex: 1,
                //               child: appLogo.url.isNotEmpty
                //                   ? Image.network(appLogo.url)
                //                   : Container(),
                //             ),
                //           ],
                //         );
                //       } else if (snapshot.hasError) {
                //         return Text('Error: ${snapshot.error}');
                //       } else {
                //         return Center(child: CircularProgressIndicator());
                //       }
                //     },
                //   ),
                // ),
                  ///
                  // Column(
                  //   children: [
                  //     Container(
                  //       width: 290,
                  //       margin: const EdgeInsets.all(15.0),
                  //       padding: const EdgeInsets.all(3.0),
                  //       decoration: BoxDecoration(
                  //           border: Border.all(color: ColorManager.blueprime),
                  //           borderRadius:
                  //               BorderRadius.all(Radius.circular(20))),
                  //       height: 260,
                  //       // color: ColorManager.green,
                  //       child: Column(
                  //         children: [
                  //           Expanded(
                  //             flex: 1,
                  //             child: Image.asset(
                  //               "images/formainlogoprohealth.png",
                  //               // height: 60,
                  //               //   width: 120,
                  //             ),
                  //           ),
                  //           Expanded(
                  //             flex: 1,
                  //             child: Image.asset(
                  //               "images/forwebprohealth.png",
                  //               // height: 60,
                  //               // width: 120,
                  //             ),
                  //           ),
                  //           Expanded(
                  //             flex: 1,
                  //             child: Image.asset(
                  //               "images/forappprohealth.png",
                  //               // height: 60,
                  //               // width: 120,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorManager.blueprime,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        height: 320,
                        // color: ColorManager.red,
                        child: StreamBuilder<WhiteLabellingCompanyDetailModal>(
                            stream: Stream.fromFuture(
                                getWhiteLabellingData(context, 1)),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var data = snapshot.data!;
                                nameController.text = data.companyDetail.name;
                                secNumberController.text = data.contactDetail.secondaryPhone;
                                faxController.text = data.contactDetail.primaryFax;
                                addressController.text = data.companyDetail.address;
                                primNumController.text = data.contactDetail.primaryPhone;
                                altNumController.text = data.contactDetail.alternativePhone;
                                emailController.text = data.contactDetail.email;
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }

                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      EditTextField(
                                        controller: nameController,
                                        keyboardType: TextInputType.text,
                                        text: AppStringEM.companyName,
                                      ),
                                      SizedBox(height: AppSize.s4),
                                      EditTextField(
                                        controller: secNumberController,
                                        keyboardType: TextInputType.number,
                                        text: AppStringEM.secNum,
                                      ),
                                      SizedBox(height: AppSize.s4),
                                      EditTextField(
                                        controller: faxController,
                                        keyboardType: TextInputType.text,
                                        text: AppStringEM.fax,
                                      ),
                                      SizedBox(height: AppSize.s4),
                                      EditTextField(
                                        controller: addressController,
                                        keyboardType: TextInputType.text,
                                        text: "Street Address",
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      EditTextField(
                                        controller: primNumController,
                                        keyboardType: TextInputType.number,
                                        text: AppStringEM.primNum,
                                      ),
                                      SizedBox(height: AppSize.s4),
                                      EditTextField(
                                        controller: altNumController,
                                        keyboardType: TextInputType.number,
                                        text: AppStringEM.alternatephone,
                                      ),
                                      SizedBox(height: AppSize.s4),
                                      EditTextField(
                                        controller: emailController,
                                        keyboardType: TextInputType.text,
                                        text: AppStringEM.primarymail,
                                      ),
                                      SizedBox(
                                        width: 354,
                                        height: 30,
                                      )
                                    ],
                                  ),
                                ],
                              );
                            }),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
