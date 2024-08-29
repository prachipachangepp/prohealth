import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/whitelabelling_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/whitelabelling_modal/whitelabelling_modal_.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/company_identity_screen.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../../hr_module/register/confirmation_constant.dart';
import '../../../widgets/button_constant.dart';
import '../../../widgets/text_form_field_const.dart';
class WhitelabellingScreen extends StatefulWidget {
  final String officeId;
  WhitelabellingScreen({super.key, required this.officeId});

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
  // final MaskedTextController secNumberCtlr = MaskedTextController(mask: '(000) 000-0000');
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
  String? _previewImageUrl;
  dynamic filePath;


  List<PlatformFile>? pickedMobileFiles;
  List<PlatformFile>? pickedWebFiles;

  ///old
  // Future<void> pickMobileLogo() async {
  //   FilePickerResult? result =
  //       await FilePicker.platform.pickFiles(allowMultiple: true);
  //   if (result != null) {
  //     pickedMobileFiles = result.files;
  //     filePath = result.files.first.bytes;
  //     _mobileFilesStreamController.add(pickedMobileFiles!);
  //     // type: FileType.image,
  //     // allowMultiple: false,
  //   }
  // }
  Future<void> pickMobileLogo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom, // Custom type to specify allowed extensions
      allowedExtensions: ['png', 'jpg', 'jpeg'], // Restrict to PNG, JPG, and JPEG
    );

    if (result != null) {
      pickedMobileFiles = result.files;
      filePath = result.files.first.bytes;
      _mobileFilesStreamController.add(pickedMobileFiles!);
    } else {
      // User canceled the picker or no valid files selected
      // You can handle this scenario if needed
    }
  }


  var maskFormatter = new MaskTextInputFormatter(
      mask: '+# (###) ###-##-##',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );


  Future<void> pickWebLogo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom, // Use custom file type to specify allowed extensions
      allowedExtensions: ['png', 'jpg', 'jpeg'], // Restrict to PNG, JPG, and JPEG
    );

    if (result != null) {
      pickedWebFiles = result.files;
      filePath = result.files.first.bytes;
      _webFilesStreamController.add(pickedWebFiles!);
    } else {
      // Handle the case where the user cancels the picker or no valid files are selected
    }
  }
///old
  // Future<void> pickWebLogo() async {
  //   FilePickerResult? result =
  //       await FilePicker.platform.pickFiles(allowMultiple: true);
  //   if (result != null) {
  //     pickedWebFiles = result.files;
  //     filePath = result.files.first.bytes;
  //     _webFilesStreamController.add(pickedWebFiles!);
  //   }
  // }

  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }
  //
  //  String bucketId = "symmetry-office-document";
  //  AwsS3Client s3client = AwsS3Client(
  //   region: "us-west-2",
  //   // host: "s3.eu-central-1.amazonaws.com",
  //   bucketId: "symmetry-office-document",
  //   accessKey: "AKIAU5UP6ITKKAGCXEXK",
  //   secretKey: "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",
  // );

  @override
  Widget build(BuildContext context) {

    // s3client.getObject(bucketId).then((response) {
    //   response.body;
    //   print('Response::${response.body}');
    // });

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
                  Text(
                    "Logos",
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeightManager.semiBold,
                      color: ColorManager.mediumgrey,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 4.3),
                  Expanded(
                    child: Text(
                      "Details",
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.mediumgrey,
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 90,
                    child: CustomButton(
                      borderRadius: 12,
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeightManager.bold,
                        color: ColorManager.white,
                        decoration: TextDecoration.none,
                      ),
                      text: "Save",
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CCSuccessPopup();
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 50),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CustomIconButton(
                          icon: Icons.edit_outlined,
                          text: "Edit Details",
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                    ),
                                  ),

                                  backgroundColor: Colors.white,
                                  child: Container(
                                    height: 440,
                                    width: 820,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 820,
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: ColorManager.blueprime,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                topRight: Radius.circular(8),
                                              ),
                                            ),
                                            child: Row(
                                              // mainAxisAlignment: MainAxisAlignment.end,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Edit White Labelling',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: 13,
                                                    fontWeight:
                                                    FontWeightManager.semiBold,
                                                    color: ColorManager.white,
                                                    decoration: TextDecoration.none,
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  icon: Icon(Icons.close,
                                                    color: ColorManager.white,),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 20,),
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
                                                      ///company app logo title
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
                                                      SizedBox(height: 5,),
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
                                                          // color: Colors.green,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal:5),
                                                              child: Text(
                                                                  "Upload Immunization Records from PDF",
                                                                  style: GoogleFonts.firaSans(
                                                                      fontSize: 9,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Color(0xff686464))),
                                                            ),

                                                            ///sub container
                                                            StreamBuilder<List<PlatformFile>>(
                                                              stream: _mobileFilesStreamController.stream,
                                                              builder: (context,
                                                                  snapshot) {
                                                                return Padding(
                                                                  padding: const EdgeInsets.all(3.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    children: [
                                                                      Container(
                                                                        width: 170,
                                                                        height: 30,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          border: Border.all(
                                                                              color:
                                                                                  Colors.grey),
                                                                          borderRadius:
                                                                              BorderRadius.all(
                                                                                  Radius.circular(10)),
                                                                              // color: Colors.pink
                                                                        ),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.all(1.0),
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
                                                                              // SizedBox(width: 2,),
                                                                              if (snapshot
                                                                                  .hasData)
                                                                                ...snapshot
                                                                                    .data!
                                                                                    .map((file) => InkWell(
                                                                                          child: Container(
                                                                                            // padding: EdgeInsets.only(t: 15),
                                                                                            height: 30,
                                                                                            width: 90,
                                                                                            child: Text(
                                                                                              file.name.substring(0,10) + "...",
                                                                                              textAlign: TextAlign.center,
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

                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: AppSize.s15),
                                                  SMTextFConst(
                                                    controller: nameController,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    text: AppStringEM.companyName,
                                                  ),
                                                  SizedBox(height: AppSize.s15),
                                                  // SMTextFConstPhone(
                                                  //   controller: secNumberController,
                                                  //   keyboardType: TextInputType.phone,
                                                  //   text: AppStringEM.secNum,
                                                  //   enable: true,
                                                  // ),

                                                   // text: 'Phone Number',
                                                    // icon: Icon(Icons.phone),
                                                    // enable: true,
                                                    // validator: (value) {
                                                    //   // Add your validation logic here
                                                    //   return null;
                                                    // },

                                                  SMTextFConst(

                                                    controller:
                                                        secNumberController,
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    text: AppStringEM.secNum,
                                                  ),
                                                  SizedBox(height:AppSize.s15),
                                                  SMTextFConst(
                                                    controller: faxController,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    text: AppStringEM.fax,
                                                  ),
                                                  SizedBox(height: AppSize.s15),
                                                  SMTextFConst(
                                                    controller: emailController,
                                                    keyboardType:
                                                    TextInputType.text,
                                                    text: AppStringEM.primarymail,
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
                                                      ///Company Web Logo title,
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
                                                      SizedBox(height: 5,),
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
                                                            Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                                              child: Text(
                                                                  "Upload Immunization Records from PDF",
                                                                  style: GoogleFonts.firaSans(
                                                                      fontSize: 9,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Color(
                                                                          0xff686464))),
                                                            ),
                                                            ///sub container
                                                            StreamBuilder<
                                                                List<PlatformFile>>(
                                                              stream: _webFilesStreamController.stream,
                                                              builder: (context, snapshot) {
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
                                                                                          file.name.substring(0,10) + "..",
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
                                                  SizedBox(height: AppSize.s15),
                                                  // SMTextFConst(
                                                  //   controller: primNumController,
                                                  //   keyboardType: TextInputType.number,
                                                  //   text: AppStringEM.primNum,
                                                  // ),
                                                  SMTextFConst(
                                                    controller: primNumController,
                                                    // codecontroller: primNumController,
                                                    keyboardType: TextInputType.phone,
                                                    text: 'Primary Phone Number',
                                                  ),
                                                  SizedBox(height: AppSize.s15),
                                                  SMTextFConst(
                                                    controller: altNumController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    text: AppStringEM
                                                        .alternatephone,
                                                  ),
                                                  SizedBox(height: AppSize.s15),
                                                  // AddressSearchField(
                                                  //   controller: addressController,
                                                  //   searchHint: AppStringEM.headofficeaddress,
                                                  //   onSuggestionSelected: (AddressSearchModel suggestion) {
                                                  //     // Handle what happens when a suggestion is selected
                                                  //     addressController.text = suggestion.label;
                                                  //   },
                                                  //   noResultsText: 'No results found',
                                                  //   searchStyle: TextStyle(
                                                  //     fontSize: 16,
                                                  //     color: Colors.black,
                                                  //   ),
                                                  //   suggestionStyle: TextStyle(
                                                  //     fontSize: 14,
                                                  //     color: Colors.grey,
                                                  //   ),
                                                  //   decoration: InputDecoration(
                                                  //     labelText: AppStringEM.headofficeaddress,
                                                  //     border: OutlineInputBorder(
                                                  //       borderRadius: BorderRadius.circular(8),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  ///
                                                  SMTextFConst(
                                                    controller: addressController,
                                                    keyboardType:
                                                    TextInputType.text,
                                                    text: AppStringEM.headofficeaddress,
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
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: Padding(
                                              padding: const EdgeInsets.all(15.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  CustomButtonTransparent(
                                                    width: 105,
                                                    height: 35,
                                                    text: "Cancel",
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  SizedBox(width: 10),
                                                  CustomElevatedButton(
                                                    width: 105,
                                                    height: 35,
                                                    text: 'Submit',
                                                    onPressed: () async {
                                                      await postWhitelabellingAdd(
                                                        context,
                                                        widget.officeId,
                                                        primNumController.text,
                                                        secNumberController.text,
                                                        faxController.text,
                                                        faxController.text,
                                                        altNumController.text,
                                                        emailController.text,
                                                        nameController.text,
                                                        addressController.text,
                                                      );
                                                      await uploadWebAndAppLogo(context: context, type: "web", documentFile: filePath, documentName: fileName);
                                                      Navigator.pop(context);
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return EditSuccessPopup(message: 'Submitted Successfully',);
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 2, //2
                    child: Container(
                      height: 320,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorManager.blueprime,
                          ),
                          borderRadius:
                          BorderRadius.all(Radius.circular(20))),
                      child:
                        ///old code
                      StreamBuilder<WhiteLabellingCompanyDetailModal>(
                        stream: Stream.fromFuture(getWhiteLabellingData(context)),
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
                                      ?     Image.network(
                          "https://symmetry-image.s3.us-west-2.amazonaws.com/8ba4e2e2-1a95-42ca-b15b-5b6cb71a1417-complogo1.jpg",
                          // webLogo.url,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return Center(
                          child: Icon(Icons.error, color: Colors.red),
                          );
                          },
                          )
                              : Container(),),
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
                  Expanded(
                    flex: 6, //6
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
                          child: FutureBuilder<WhiteLabellingCompanyDetailModal>(
                              future:
                                  getWhiteLabellingData(context),
                              builder: (context, snapshot) {
                                if(snapshot.connectionState == ConnectionState.waiting){
                                  return SizedBox();
                                }
                                if (snapshot.hasData) {
                                  var data = snapshot.data!;
                                  print("NameController : ${data.companyDetail.name}");
                                  nameController = TextEditingController(text:data.companyDetail.name);
                                  secNumberController.text = data.contactDetail.secondaryPhone;
                                  faxController.text = data.contactDetail.primaryFax;
                                  addressController.text = data.companyDetail.address;
                                  primNumController.text = data.contactDetail.primaryPhone;
                                  altNumController.text = data.contactDetail.alternativePhone;
                                  emailController.text = data.contactDetail.email;
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
                                          SizedBox(height: AppSize.s9),
                                          EditTextField(
                                            controller: secNumberController,
                                            keyboardType: TextInputType.number,
                                            text: AppStringEM.secNum,
                                          ),
                                          SizedBox(height: AppSize.s9),
                                          EditTextField(
                                            controller: faxController,
                                            keyboardType: TextInputType.text,
                                            text: AppStringEM.fax,
                                          ),
                                          SizedBox(height: AppSize.s9),
                                          EditTextField(
                                            controller: emailController,
                                            keyboardType: TextInputType.text,
                                            text: AppStringEM.primarymail,
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
                                          SizedBox(height: AppSize.s9),
                                          EditTextField(
                                            controller: altNumController,
                                            keyboardType: TextInputType.number,
                                            text: AppStringEM.alternatephone,
                                          ),
                                          SizedBox(height: AppSize.s9),

                                          EditTextField(
                                            controller: addressController,
                                            keyboardType: TextInputType.text,
                                            text: "Street Address",
                                          ),
                                          SizedBox(
                                            width: 354,
                                            height: 60,
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                }
                                return SizedBox();
                              }),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}














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
//
// void configureAmplify() async {
//   // Add Amplify plugins
//   Amplify.addPlugin(AmplifyStorageS3());
//
//   try {
//     await Amplify.configure(amplifyconfig);
//     print('Amplify configured successfully');
//   } catch (e) {
//     print('Error configuring Amplify: $e');
//   }
// }
//
//
// Future<String> getS3ImageUrl(String key) async {
//   try {
//     GetUrlResult result = await Amplify.Storage.getUrl(key: key);
//     return result.url;
//   } catch (e) {
//     print('Error getting URL: $e');
//     return '';
//   }
// }
//
// class ImageFetcher extends StatefulWidget {
//   @override
//   _ImageFetcherState createState() => _ImageFetcherState();
// }
//
// class _ImageFetcherState extends State<ImageFetcher> {
//   String? imageUrl;
//
//   @override
//   void initState() {
//     super.initState();
//     configureAmplify();
//     _fetchImageUrl();
//   }
//
//   void _fetchImageUrl() async {
//     String url = await getS3ImageUrl('your_image_key');
//     setState(() {
//       imageUrl = url;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('S3 Image Fetcher'),
//       ),
//       body: Center(
//         child: imageUrl != null
//             ? Image.network(imageUrl!)
//             : CircularProgressIndicator(),
//       ),
//     );
//   }
// }
//
//
// final region = 'us-west-2';
// final bucketId = 'your-bucket-id';
// final accessKey = 'your-access-key';
// final secretKey = 'your-secret-key';
//
// final s3client = S3(region: region, bucketId: bucketId, accessKey: accessKey, secretKey: secretKey);
//
// Future<String> getSignedUrl(String key) async {
//   try {
//     final url = s3client.getSignedUrl(key);
//     return url;
//   } catch (e) {
//     print('Error getting signed URL: $e');
//     return '';
//   }
// }
