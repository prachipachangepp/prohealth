import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:open_file/open_file.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/login_resources/login_flow_theme_const.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/google_aotopromt_api_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/whitelabelling_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/whitelabelling_modal/whitelabelling_modal_.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/company_identity_screen.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../../hr_module/register/confirmation_constant.dart';
import '../../../widgets/button_constant.dart';
import '../../../widgets/dialogue_template.dart';
import '../../../widgets/text_form_field_const.dart';
typedef BackButtonCallBack = void Function(bool val);
class WhitelabellingScreen extends StatefulWidget {
  final String officeId;
  final BackButtonCallBack onPressedCancel;
  WhitelabellingScreen({super.key, required this.officeId,required this.onPressedCancel});

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
    addressController.removeListener(_onAddressChanged);

    super.dispose();
  }

  String fileName = "No Chosen";
  String? _previewImageUrl;
  dynamic filePath;

  List<PlatformFile>? pickedMobileFiles;
  List<PlatformFile>? pickedWebFiles;
  Future<void> pickMobileLogo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom, // Custom type to specify allowed extensions
      allowedExtensions: [
        'png',
        'jpg',
        'jpeg',
      ], // Restrict to PNG, JPG, and JPEG
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
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  Future<void> pickWebLogo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type:
          FileType.custom, // Use custom file type to specify allowed extensions
      allowedExtensions: [
        'png',
        'jpg',
        'jpeg',
      ], // Restrict to PNG, JPG, and JPEG
    );

    if (result != null) {
      pickedWebFiles = result.files;
      filePath = result.files.first.bytes;
      _webFilesStreamController.add(pickedWebFiles!);
    } else {
      // Handle the case where the user cancels the picker or no valid files are selected
    }
  }

  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }

  List<String> _suggestions = [];
  @override
  void initState() {
    super.initState();
    //fetchData();
    addressController.addListener(_onAddressChanged);
  }

  ValueNotifier<List<String>> _suggestionsNotifier = ValueNotifier([]);
void fetchData()async{
  CompanyContactPrefill companyContactPrefill = await getCompanyContactPrefill(context);
}
  void _onAddressChanged() async {
    if (addressController.text.isEmpty) {
      _suggestionsNotifier.value = [];
      return;
    }

    // Fetch suggestions based on the addressController's text
    final suggestions = await fetchSuggestions(addressController.text);
    _suggestionsNotifier.value = suggestions;
  }

  bool _isEditing = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "Logos",
                      style: TextStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.mediumgrey,
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 4.2),
                  Expanded(
                    child: Text(
                      "Details",
                      style: TextStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.mediumgrey,
                      ),
                    ),
                  ),
                  // Row(
                  //   children: [
                      Container(
                        height: 30,
                        width: 90,
                        child: CustomButton(
                          borderRadius: 12,
                          style: BlueButtonTextConst.customTextStyle(context),
                          text: "Save",
                          onPressed: () async{
                            var response = await uploadWebAndAppLogo(
                                context: context,
                                type: "web",
                                documentFile: filePath,
                                documentName: fileName);
                            if(response.statusCode == 200 || response.statusCode == 201){
                              setState(() {
                                getWhiteLabellingData(context);
                              });
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return EditSuccessPopup(
                                    message:
                                    'Submitted Successfully',
                                  );
                                },
                              );
                            }
                            // showDialog(
                            //   context: context,
                            //   builder: (BuildContext context) {
                            //     return CCSuccessPopup();
                            //   },
                            // );
                          },
                        ),
                      ),
                      // SizedBox(width: 10,),
                      // Container(
                      //     height: 30,
                      //     width: 90,
                      //     child: ElevatedButton(
                      //       onPressed: (){widget.onPressedCancel(true);},
                      //       style: ElevatedButton.styleFrom(
                      //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      //         backgroundColor: ColorManager.white,
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(12),
                      //           side: const BorderSide(color: Color(0xFF50B5E5)),
                      //         ),
                      //       ),
                      //       child: Text(
                      //           'Cancel',
                      //           style: LoginFlowBase.customTextStyle(context)
                      //       ),
                      //     ),
                      //     // CustomeTransparentWhitelabeling(text: , onPressed: () {
                      //     //
                      //     //
                      //     // },)
                      // )
                  //   ],
                  // ),

                  SizedBox(width: MediaQuery.of(context).size.width / 50),
                  FutureBuilder(
                    future: getWhiteLabellingData(context),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return SizedBox();
                      }

                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: snapshot.data!.logos.isEmpty ? Column(
                            children: [
                              CustomIconButton(
                                  icon: Icons.edit_outlined,
                                  text: "Add Logo",
                                  onPressed: () async{
                                    pickWebLogo();

                                    //
                                    // CompanyContactPrefill companyContactPrefill = await getCompanyContactPrefill(context);
                                    // setState(() {
                                    //   _isEditing = !_isEditing;
                                    // });
                                    // showDialog(
                                    //   context: context,
                                    //   builder: (BuildContext context) {
                                    //     return DialogueTemplate(
                                    //       title: 'Edit White Labelling',
                                    //       height: 600,
                                    //       width:800,
                                    //       body: [
                                    //         Column(
                                    //           crossAxisAlignment: CrossAxisAlignment.start,
                                    //           mainAxisAlignment: MainAxisAlignment.start,
                                    //           children: [
                                    //             Row(
                                    //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    //               crossAxisAlignment: CrossAxisAlignment.start,
                                    //               children: [
                                    //                 Column(
                                    //                   crossAxisAlignment:
                                    //                   CrossAxisAlignment.start,
                                    //                   children: [
                                    //                     Column(
                                    //                       mainAxisAlignment:
                                    //                           MainAxisAlignment.start,
                                    //                       crossAxisAlignment:
                                    //                           CrossAxisAlignment.start,
                                    //                       children: [
                                    //                         ///company app logo title
                                    //                         Text(
                                    //                           "Company App Logo",
                                    //                           style: ConstTextFieldStyles
                                    //                               .customTextStyle(
                                    //                                   textColor: Color(
                                    //                                       0xff686464)),
                                    //                           // style: GoogleFonts
                                    //                           //     .firaSans(
                                    //                           //   fontSize:
                                    //                           //   FontSize.s12,
                                    //                           //   fontWeight:
                                    //                           //   FontWeight.w700,
                                    //                           //   color:
                                    //                           //   Color(0xff686464),
                                    //                           // ),
                                    //                         ),
                                    //                         SizedBox(
                                    //                           height: 5,
                                    //                         ),
                                    //
                                    //                         ///main
                                    //                         Container(
                                    //                           width: 354,
                                    //                           height: 50,
                                    //                           decoration: BoxDecoration(
                                    //                             border: Border.all(
                                    //                                 color: Colors.grey),
                                    //                             borderRadius:
                                    //                                 BorderRadius.all(
                                    //                                     Radius.circular(
                                    //                                         10)),
                                    //                             // color: Colors.green,
                                    //                           ),
                                    //                           child: Row(
                                    //                             mainAxisAlignment:
                                    //                                 MainAxisAlignment.start,
                                    //                             children: [
                                    //                               Padding(
                                    //                                 padding:
                                    //                                     const EdgeInsets
                                    //                                         .symmetric(
                                    //                                         horizontal: 5),
                                    //                                 child: Text(
                                    //                                     "Upload Immunization Records from PDF",
                                    //                                     style: TextStyle(
                                    //                                         fontSize: 9,
                                    //                                         fontWeight:
                                    //                                             FontWeight
                                    //                                                 .w500,
                                    //                                         color: Color(
                                    //                                             0xff686464))),
                                    //                               ),
                                    //
                                    //                               ///sub container
                                    //                               StreamBuilder<
                                    //                                   List<PlatformFile>>(
                                    //                                 stream:
                                    //                                     _mobileFilesStreamController
                                    //                                         .stream,
                                    //                                 builder: (context,
                                    //                                     snapshot) {
                                    //                                   return Padding(
                                    //                                     padding:
                                    //                                         const EdgeInsets
                                    //                                             .all(3.0),
                                    //                                     child: Row(
                                    //                                       mainAxisAlignment:
                                    //                                           MainAxisAlignment
                                    //                                               .spaceAround,
                                    //                                       children: [
                                    //                                         Container(
                                    //                                           width: 170,
                                    //                                           height: 30,
                                    //                                           decoration:
                                    //                                               BoxDecoration(
                                    //                                             border: Border.all(
                                    //                                                 color: Colors
                                    //                                                     .grey),
                                    //                                             borderRadius:
                                    //                                                 BorderRadius.all(
                                    //                                                     Radius.circular(10)),
                                    //                                             // color: Colors.pink
                                    //                                           ),
                                    //                                           child:
                                    //                                               Padding(
                                    //                                             padding:
                                    //                                                 const EdgeInsets
                                    //                                                     .all(
                                    //                                                     1.0),
                                    //                                             child: Row(
                                    //                                               mainAxisAlignment:
                                    //                                                   MainAxisAlignment
                                    //                                                       .spaceAround,
                                    //                                               children: [
                                    //                                                 InkWell(
                                    //                                                   onTap:
                                    //                                                       pickMobileLogo,
                                    //                                                   child:
                                    //                                                       Container(
                                    //                                                     color:
                                    //                                                         Color(0xffD9D9D9),
                                    //                                                     child:
                                    //                                                         Text(
                                    //                                                       "Choose File",
                                    //                                                       style: TextStyle(
                                    //                                                         fontSize: 10,
                                    //                                                         fontWeight: FontWeight.w500,
                                    //                                                         color: Colors.grey,
                                    //                                                       ),
                                    //                                                     ),
                                    //                                                   ),
                                    //                                                 ),
                                    //                                                 // SizedBox(width: 2,),
                                    //                                                 if (snapshot
                                    //                                                     .hasData)
                                    //                                                   ...snapshot
                                    //                                                       .data!
                                    //                                                       .map((file) => InkWell(
                                    //                                                             child: Container(
                                    //                                                               // padding: EdgeInsets.only(t: 15),
                                    //                                                               height: 30,
                                    //                                                               width: 90,
                                    //                                                               child: Text(
                                    //                                                                 file.name.substring(0, 10) + "...",
                                    //                                                                 textAlign: TextAlign.center,
                                    //                                                                 style: TextStyle(
                                    //                                                                   fontSize: 10,
                                    //                                                                   fontWeight: FontWeight.w500,
                                    //                                                                   color: Colors.grey,
                                    //                                                                 ),
                                    //                                                               ),
                                    //                                                             ),
                                    //                                                             onTap: () => openFile(file),
                                    //                                                           ))
                                    //                                                       .toList(),
                                    //                                               ],
                                    //                                             ),
                                    //                                           ),
                                    //                                         ),
                                    //                                       ],
                                    //                                     ),
                                    //                                   );
                                    //                                 },
                                    //                               ),
                                    //                             ],
                                    //                           ),
                                    //                         ),
                                    //                       ],
                                    //                     ),
                                    //                     SizedBox(height: AppSize.s15),
                                    //                     FirstSMTextFConst(
                                    //                       controller: nameController,
                                    //                       keyboardType: TextInputType.text,
                                    //                       text: AppStringEM.companyName,
                                    //                     ),
                                    //                     SizedBox(height: AppSize.s15),
                                    //                     SMTextFConstPhone(
                                    //                       controller: secNumberController,
                                    //                       keyboardType: TextInputType.phone,
                                    //                       text: AppStringEM.secNum,
                                    //                       enable: true,
                                    //                     ),
                                    //
                                    //                     // text: 'Phone Number',
                                    //                     //  icon: Icon(Icons.phone),
                                    //                     //  enable: true,
                                    //                     //  validator: (value) {
                                    //                     //    // Add your validation logic here
                                    //                     //    return null;
                                    //                     //  },
                                    //
                                    //                     // SMTextFConst(
                                    //                     //
                                    //                     //   controller:
                                    //                     //       secNumberController,
                                    //                     //   keyboardType:
                                    //                     //       TextInputType.phone,
                                    //                     //   text: AppStringEM.secNum,
                                    //                     // ),
                                    //                     SizedBox(height: AppSize.s15),
                                    //                     SMTextFConst(
                                    //                       controller: faxController,
                                    //                       keyboardType: TextInputType.text,
                                    //                       text: AppStringEM.fax,
                                    //                     ),
                                    //                     SizedBox(height: AppSize.s15),
                                    //                     SMTextFConst(
                                    //                       controller: emailController,
                                    //                       keyboardType: TextInputType.text,
                                    //                       text: AppStringEM.primarymail,
                                    //                     ),
                                    //                   ],
                                    //                 ),
                                    //                 Column(
                                    //                   crossAxisAlignment: CrossAxisAlignment.start,
                                    //                   mainAxisAlignment: MainAxisAlignment.start,
                                    //                   children: [
                                    //                     Column(
                                    //                       mainAxisAlignment:
                                    //                           MainAxisAlignment.start,
                                    //                       crossAxisAlignment:
                                    //                           CrossAxisAlignment.start,
                                    //                       children: [
                                    //                         ///Company Web Logo title,
                                    //                         Text(
                                    //                           "Company Web Logo",
                                    //                           style: ConstTextFieldStyles
                                    //                               .customTextStyle(
                                    //                                   textColor: Color(
                                    //                                       0xff686464)),
                                    //                         ),
                                    //                         SizedBox(
                                    //                           height: 5,
                                    //                         ),
                                    //                         Container(
                                    //                           width: 354,
                                    //                           height: 50,
                                    //                           decoration: BoxDecoration(
                                    //                             border: Border.all(
                                    //                                 color: Colors.grey),
                                    //                             borderRadius:
                                    //                                 BorderRadius.all(
                                    //                                     Radius.circular(
                                    //                                         10)),
                                    //                           ),
                                    //                           child: Row(
                                    //                             mainAxisAlignment:
                                    //                                 MainAxisAlignment.start,
                                    //                             children: [
                                    //                               Padding(
                                    //                                 padding:
                                    //                                     const EdgeInsets
                                    //                                         .symmetric(
                                    //                                         horizontal: 10),
                                    //                                 child: Text(
                                    //                                     "Upload Immunization Records from PDF",
                                    //                                     style: TextStyle(
                                    //                                         fontSize: 9,
                                    //                                         fontWeight:
                                    //                                             FontWeight
                                    //                                                 .w500,
                                    //                                         color: Color(
                                    //                                             0xff686464))),
                                    //                               ),
                                    //
                                    //                               ///sub container
                                    //                               StreamBuilder<
                                    //                                   List<PlatformFile>>(
                                    //                                 stream:
                                    //                                     _webFilesStreamController
                                    //                                         .stream,
                                    //                                 builder: (context,
                                    //                                     snapshot) {
                                    //                                   return Row(
                                    //                                     mainAxisAlignment:
                                    //                                         MainAxisAlignment
                                    //                                             .spaceAround,
                                    //                                     children: [
                                    //                                       Container(
                                    //                                         width: 150,
                                    //                                         height: 30,
                                    //                                         decoration:
                                    //                                             BoxDecoration(
                                    //                                           border: Border.all(
                                    //                                               color: Colors
                                    //                                                   .grey),
                                    //                                           borderRadius:
                                    //                                               BorderRadius.all(
                                    //                                                   Radius.circular(
                                    //                                                       10)),
                                    //                                         ),
                                    //                                         child: Row(
                                    //                                           mainAxisAlignment:
                                    //                                               MainAxisAlignment
                                    //                                                   .spaceAround,
                                    //                                           children: [
                                    //                                             InkWell(
                                    //                                               onTap:
                                    //                                                   pickWebLogo,
                                    //                                               child:
                                    //                                                   Container(
                                    //                                                 color: Color(
                                    //                                                     0xffD9D9D9),
                                    //                                                 child:
                                    //                                                     Text(
                                    //                                                   "Choose File",
                                    //                                                   style:
                                    //                                                       TextStyle(
                                    //                                                     fontSize:
                                    //                                                         10,
                                    //                                                     fontWeight:
                                    //                                                         FontWeight.w500,
                                    //                                                     color:
                                    //                                                         Colors.grey,
                                    //                                                   ),
                                    //                                                 ),
                                    //                                               ),
                                    //                                             ),
                                    //                                             if (snapshot
                                    //                                                 .hasData)
                                    //                                               ...snapshot
                                    //                                                   .data!
                                    //                                                   .map((file) =>
                                    //                                                       InkWell(
                                    //                                                         child: Container(
                                    //                                                           padding: EdgeInsets.only(bottom: 15),
                                    //                                                           // height: 30,
                                    //                                                           // width: 90,
                                    //                                                           child: Text(
                                    //                                                             file.name.substring(0, 10) + "..",
                                    //                                                             textAlign: TextAlign.start,
                                    //                                                             style: TextStyle(
                                    //                                                               fontSize: 10,
                                    //                                                               fontWeight: FontWeight.w500,
                                    //                                                               color: Colors.grey,
                                    //                                                             ),
                                    //                                                           ),
                                    //                                                         ),
                                    //                                                         onTap: () => openFile(file),
                                    //                                                       ))
                                    //                                                   .toList(),
                                    //                                           ],
                                    //                                         ),
                                    //                                       ),
                                    //                                     ],
                                    //                                   );
                                    //                                 },
                                    //                               ),
                                    //                             ],
                                    //                           ),
                                    //                         ),
                                    //                       ],
                                    //                     ),
                                    //                     SizedBox(height: AppSize.s22),
                                    //                     // SMTextFConst(
                                    //                     //   controller: primNumController,
                                    //                     //   keyboardType: TextInputType.number,
                                    //                     //   text: AppStringEM.primNum,
                                    //                     // ),
                                    //                     SMTextFConstPhone(
                                    //                       controller: primNumController,
                                    //                       // codecontroller: primNumController,
                                    //                       keyboardType: TextInputType.phone,
                                    //                       text: 'Primary Phone Number',
                                    //                     ),
                                    //                     SizedBox(height: AppSize.s17),
                                    //                     SMTextFConstPhone(
                                    //                       controller: altNumController,
                                    //                       keyboardType:
                                    //                           TextInputType.number,
                                    //                       text: AppStringEM.alternatephone,
                                    //                     ),
                                    //                     SizedBox(height: AppSize.s15),
                                    //                     // AddressSearchField(
                                    //                     //   controller: addressController,
                                    //                     //   searchHint: AppStringEM.headofficeaddress,
                                    //                     //   onSuggestionSelected: (AddressSearchModel suggestion) {
                                    //                     //     // Handle what happens when a suggestion is selected
                                    //                     //     addressController.text = suggestion.label;
                                    //                     //   },
                                    //                     //   noResultsText: 'No results found',
                                    //                     //   searchStyle: TextStyle(
                                    //                     //     fontSize: 16,
                                    //                     //     color: Colors.black,
                                    //                     //   ),
                                    //                     //   suggestionStyle: TextStyle(
                                    //                     //     fontSize: 14,
                                    //                     //     color: Colors.grey,
                                    //                     //   ),
                                    //                     //   decoration: InputDecoration(
                                    //                     //     labelText: AppStringEM.headofficeaddress,
                                    //                     //     border: OutlineInputBorder(
                                    //                     //       borderRadius: BorderRadius.circular(8),
                                    //                     //     ),
                                    //                     //   ),
                                    //                     // ),
                                    //                     ///
                                    //                     SMTextFConst(
                                    //                       controller: addressController,
                                    //                       keyboardType: TextInputType.text,
                                    //                       text:
                                    //                           AppStringEM.headofficeaddress,
                                    //                     ),
                                    //                     ValueListenableBuilder<
                                    //                         List<String>>(
                                    //                       valueListenable:
                                    //                           _suggestionsNotifier,
                                    //                       builder: (context, suggestions,
                                    //                           child) {
                                    //                         if (suggestions.isEmpty)
                                    //                           return SizedBox.shrink();
                                    //                         return Container(
                                    //                           width: 300,
                                    //                           decoration: BoxDecoration(
                                    //                             color: Colors.white,
                                    //                             borderRadius:
                                    //                                 BorderRadius.circular(
                                    //                                     8),
                                    //                             boxShadow: [
                                    //                               BoxShadow(
                                    //                                 color: Colors.black26,
                                    //                                 blurRadius: 4,
                                    //                                 offset: Offset(0, 2),
                                    //                               ),
                                    //                             ],
                                    //                           ),
                                    //                           child: ListView.builder(
                                    //                             //scrollDirection: Axis.vertical,
                                    //                             shrinkWrap: true,
                                    //                             itemCount:
                                    //                                 suggestions.length,
                                    //                             itemBuilder:
                                    //                                 (context, index) {
                                    //                               return ListTile(
                                    //                                 title: Text(
                                    //                                   suggestions[index],
                                    //                                   style: AllPopupHeadings
                                    //                                       .customTextStyle(
                                    //                                           context),
                                    //                                 ),
                                    //                                 onTap: () {
                                    //                                   addressController
                                    //                                           .text =
                                    //                                       suggestions[
                                    //                                           index];
                                    //                                   _suggestionsNotifier
                                    //                                       .value = [];
                                    //                                 },
                                    //                               );
                                    //                             },
                                    //                           ),
                                    //                         );
                                    //                       },
                                    //                     ),
                                    //                     // SizedBox(
                                    //                     //   width: 354,
                                    //                     //   height: 30,
                                    //                     // ),
                                    //                     // SizedBox(
                                    //                     //   width: 354,
                                    //                     //   height: 30,
                                    //                     // )
                                    //                   ],
                                    //                 ),
                                    //               ],
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       ],
                                    //       bottomButtons: Row(
                                    //         mainAxisAlignment: MainAxisAlignment.center,
                                    //         children: [
                                    //           CustomButtonTransparent(
                                    //             width: 105,
                                    //             height: 35,
                                    //             text: "Cancel",
                                    //             onPressed: () {
                                    //               Navigator.pop(context);
                                    //             },
                                    //           ),
                                    //           SizedBox(width: 10),
                                    //           CustomElevatedButton(
                                    //             width: 105,
                                    //             height: 35,
                                    //             text: 'Submit',
                                    //             onPressed: () async {
                                    //               companyContactPrefill.companyContactID == 0 ?
                                    //              await postCompanyContact(
                                    //                 context,
                                    //                 // widget.officeId,
                                    //                 primNumController.text,
                                    //                 secNumberController.text,
                                    //                 faxController.text,
                                    //                 faxController.text,
                                    //                 altNumController.text,
                                    //                 emailController.text,
                                    //                 // nameController.text,
                                    //                 // addressController.text,
                                    //               ):
                                    //                await patchWhitelabellingCompanyContact(
                                    //                 context,
                                    //                 // widget.officeId,
                                    //                 primNumController.text,
                                    //                 secNumberController.text,
                                    //                 faxController.text,
                                    //                 faxController.text,
                                    //                 altNumController.text,
                                    //                 emailController.text,
                                    //                 // nameController.text,
                                    //                 // addressController.text,
                                    //               );
                                    //               await uploadWebAndAppLogo(
                                    //                   context: context,
                                    //                   type: "web",
                                    //                   documentFile: filePath,
                                    //                   documentName: fileName);
                                    //               Navigator.pop(context);
                                    //               showDialog(
                                    //                 context: context,
                                    //                 builder: (BuildContext context) {
                                    //                   return EditSuccessPopup(
                                    //                     message:
                                    //                         'Submitted Successfully',
                                    //                   );
                                    //                 },
                                    //               );
                                    //             },
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     );
                                    //   },
                                    // );
                                  }),
                              // SizedBox(height: 2,),
                              // Text(fileName,style:DocumentTypeDataStyle.customTextStyle(context),)
                            ],
                          ):SizedBox()
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 2, //2
                    child: Container(
                     // color: Colors.greenAccent,
                      height: 320,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorManager.blueprime,

                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child:

                          ///old code
                          FutureBuilder<WhiteLabellingCompanyDetailModal>(
                        future: getWhiteLabellingData(context),
                        builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasData) {
                            print("Image url ${snapshot.data!.logos[0].url}");
                            var data = snapshot.data!;
                            //List<String> allLogo = snapshot.data!.logos[0].url;
                            // var appLogo = data.logos.firstWhere(
                            //     (logo) => logo.type == 'logo',
                            //     orElse: () => WLLogoModal(
                            //         companyLogoId: snapshot.data!.logos[0].companyLogoId,
                            //         url:
                            //         snapshot.data!.logos[0].url,
                            //         type: snapshot.data!.logos[0].type, companyId: snapshot.data!.logos[0].companyId));
                            // var webLogo = data.logos.firstWhere(
                            //     (logo) => logo.type == 'web',
                            //     orElse: () => WLLogoModal(
                            //         companyLogoId: snapshot.data!.logos[0].companyLogoId,
                            //         companyId: snapshot.data!.logos[0].companyId,
                            //         url:
                            //         snapshot.data!.logos[0].url,
                            //         type: snapshot.data!.logos[0].type));
                            // var mainLogo = data.logos.firstWhere(
                            //     (logo) => logo.type == 'main',
                            //     orElse: () => WLLogoModal(
                            //         companyLogoId: snapshot.data!.logos[0].companyLogoId,
                            //         companyId: snapshot.data!.logos[0].companyId,
                            //         url:
                            //         snapshot.data!.logos[0].url,
                            //         type: snapshot.data!.logos[0].type));
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 100,
                                  child: snapshot.data!.logos.isNotEmpty
                                      ? CachedNetworkImage(
                                    imageUrl: snapshot.data!.logos[0].url,
                                    placeholder: (context, url) => SizedBox(
                                        height:25,
                                        width:25,
                                        ),
                                    errorWidget: (context, url, error) => Image.asset("images/forappprohealth.png"),
                                    fit: BoxFit.cover, // Ensure the image fits inside the circle
                                    height: 100, // Adjust image height for proper fit// Adjust image width for proper fit
                                  )
                                      : Container(),
                                ),
                                // Container(
                                //   height: 100,
                                //   child: snapshot.data!.logos[0].url.isNotEmpty
                                //       ?
                                //   CachedNetworkImage(
                                //     imageUrl: snapshot.data!.logos[0].url,
                                //     placeholder: (context, url) => SizedBox(
                                //         height:25,
                                //         width:25,
                                //         ),
                                //     errorWidget: (context, url, error) => Image.asset("images/forappprohealth.png"),
                                //     fit: BoxFit.cover, // Ensure the image fits inside the circle
                                //     height: 100, // Adjust image height for proper fit// Adjust image width for proper fit
                                //   )
                                //   // Image.network(
                                //   //         "https://symmetry-image.s3.us-west-2.amazonaws.com/8ba4e2e2-1a95-42ca-b15b-5b6cb71a1417-complogo1.jpg",
                                //   //         // webLogo.url,
                                //   //         fit: BoxFit.cover,
                                //   //         errorBuilder: (BuildContext context,
                                //   //             Object exception,
                                //   //             StackTrace? stackTrace) {
                                //   //           return Center(
                                //   //             child: Icon(Icons.error,
                                //   //                 color: Colors.red),
                                //   //           );
                                //   //         },
                                //   //       )
                                //       : Container(),
                                // ),
                                // Container(
                                //   height: 100,
                                //   child: snapshot.data!.logos[0].url.isNotEmpty
                                //       ? CachedNetworkImage(
                                //       imageUrl: snapshot.data!.logos[0].url,
                                //       placeholder: (context, url) => SizedBox(
                                //         height:25,
                                //           width:25,
                                //           ),
                                //       errorWidget: (context, url, error) => Image.asset("images/forappprohealth.png"),
                                //       fit: BoxFit.cover, // Ensure the image fits inside the circle
                                //       height: 100, // Adjust image height for proper fit// Adjust image width for proper fit
                                //       )
                                //   // Image.network(
                                //   //   //'images/forappprohealth.png',
                                //   //   "${snapshot.data!.logos[0].url}",
                                //   //   fit: BoxFit.cover,
                                //   // )
                                //   // Image.network(
                                //   //         'https://symmetry-image.s3.us-west-2.amazonaws.com/fd32e5b5-192d-4c13-a80a-f2a5e337f537-complogo2.jpg',
                                //   //         fit: BoxFit.cover,
                                //   //         errorBuilder: (BuildContext context,
                                //   //             Object exception,
                                //   //             StackTrace? stackTrace) {
                                //   //           return Center(
                                //   //             child: Icon(Icons.error,
                                //   //                 color: Colors.red),
                                //   //           );
                                //   //         },
                                //   //       )
                                //       : Container(),
                                // ),
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 35,
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
                                // color: Colors.orange
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          height: 320,
                          width: 1100,
                          // color: ColorManager.red,
                          child: FutureBuilder<
                                  WhiteLabellingCompanyDetailModal>(
                              future: getWhiteLabellingData(context),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.hasData) {
                                  var data = snapshot.data!;
                                  print(
                                      "NameController : ${data.companyDetail.name}");
                                  nameController = TextEditingController(
                                      text: data.companyDetail.name);
                                  secNumberController.text =
                                      data.contactDetail.secondaryPhone;
                                  faxController.text =
                                      data.contactDetail.primaryFax;
                                  addressController.text =
                                      data.companyDetail.address;
                                  primNumController.text =
                                      data.contactDetail.primaryPhone;
                                  altNumController.text =
                                      data.contactDetail.alternativePhone;
                                  emailController.text =
                                      data.contactDetail.email;
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          EditTextField(
                                            enabled: _isEditing,
                                            controller: nameController,
                                            keyboardType: TextInputType.text,
                                            text: AppStringEM.companyName,
                                          ),
                                          SizedBox(height: AppSize.s9),
                                          EditTextFieldPhone(
                                            controller: secNumberController,
                                            keyboardType: TextInputType.number,
                                            text: AppStringEM.secNum,
                                            enabled: _isEditing,
                                          ),
                                          SizedBox(height: AppSize.s9),
                                          EditTextField(
                                            controller: faxController,
                                            keyboardType: TextInputType.text,
                                            text: AppStringEM.fax,
                                            enabled: _isEditing,
                                          ),
                                          SizedBox(height: AppSize.s9),
                                          EditTextField(
                                            controller: emailController,
                                            keyboardType: TextInputType.text,
                                            text: AppStringEM.primarymail,
                                            enabled: _isEditing,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          EditTextFieldPhone(
                                            controller: primNumController,
                                            keyboardType: TextInputType.number,
                                            text: AppStringEM.primNum,
                                            enabled: _isEditing,
                                          ),
                                          SizedBox(height: AppSize.s9),
                                          EditTextFieldPhone(
                                            controller: altNumController,
                                            keyboardType: TextInputType.number,
                                            text: AppStringEM.alternatephone,
                                            enabled: _isEditing,
                                          ),
                                          SizedBox(height: AppSize.s9),
                                          EditTextField(
                                            controller: addressController,
                                            keyboardType: TextInputType.text,
                                            text: "Street Address",
                                            enabled: _isEditing,
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
