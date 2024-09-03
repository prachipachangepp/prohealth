// import 'dart:async';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/app/resources/color.dart';
// import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
// import 'package:prohealth/app/resources/font_manager.dart';
// import 'package:prohealth/app/resources/value_manager.dart';
// import 'package:prohealth/app/services/api/managers/establishment_manager/whitelabelling_manager.dart';
// import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
// import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
// import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
// import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
//
// class EditWhiteLabellingPopup extends StatefulWidget {
//  final TextEditingController addressController;
//  final TextEditingController secNumberController;
//  final TextEditingController primNumController;
//  final TextEditingController altNumController;
//  final TextEditingController emailController;
//  final TextEditingController hcoNumController;
//  final TextEditingController medicareController;
//  final TextEditingController npiNumController;
//  final TextEditingController faxController;
//  final VoidCallback onPressed;
//  final VoidCallback pickLogoMobile;
//  final VoidCallback pickWebLogo;
//   EditWhiteLabellingPopup({super.key, required this.addressController, required this.secNumberController, required this.primNumController, required this.altNumController, required this.emailController, required this.hcoNumController, required this.medicareController, required this.npiNumController, required this.faxController, required this.onPressed, required this.pickLogoMobile, required this.pickWebLogo});
//
//   @override
//   State<EditWhiteLabellingPopup> createState() => _EditWhiteLabellingPopupState();
// }
//
// class _EditWhiteLabellingPopupState extends State<EditWhiteLabellingPopup> {
//   final StreamController<List<PlatformFile>> _mobileFilesStreamController =
//   StreamController<List<PlatformFile>>.broadcast();
//   final StreamController<List<PlatformFile>> _webFilesStreamController =
//   StreamController<List<PlatformFile>>.broadcast();
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(8),
//           topRight: Radius.circular(8),
//           bottomRight: Radius.circular(8),
//           bottomLeft: Radius.circular(8),
//         ),
//       ),
//
//       backgroundColor: Colors.white,
//       child: StatefulBuilder(
//         builder: (BuildContext context, void Function(void Function()) setState) {
//           return Container(
//             height: 440,
//             width: 820,
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment:
//                 MainAxisAlignment.center,
//                 crossAxisAlignment:
//                 CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     height: 40,
//                     width: 820,
//                     padding: EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                       color: ColorManager.blueprime,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(8),
//                         topRight: Radius.circular(8),
//                       ),
//                     ),
//                     child: Row(
//                       // mainAxisAlignment: MainAxisAlignment.end,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left:30),
//                           child: Text(
//                             'Edit White Labelling',
//                             textAlign: TextAlign.center,
//                             style: GoogleFonts.firaSans(
//                               fontSize: 13,
//                               fontWeight:
//                               FontWeightManager.semiBold,
//                               color: ColorManager.white,
//                               decoration: TextDecoration.none,
//                             ),
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           icon: Icon(Icons.close,
//                             color: ColorManager.white,),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20,),
//                   Row(
//                     mainAxisAlignment:
//                     MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Column(
//                         mainAxisAlignment:
//                         MainAxisAlignment.center,
//                         children: [
//                           Column(
//                             mainAxisAlignment:
//                             MainAxisAlignment.start,
//                             crossAxisAlignment:
//                             CrossAxisAlignment.start,
//                             children: [
//                               ///company app logo title
//                               Text("Company App Logo",
//                                   style: GoogleFonts
//                                       .firaSans(
//                                     fontSize:
//                                     FontSize.s12,
//                                     fontWeight:
//                                     FontWeightManager
//                                         .bold,
//                                     color:
//                                     Color(0xff686464),
//                                   )),
//                               SizedBox(height: 5,),
//                               ///main
//                               Container(
//
//                                 width: 354,
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                       color: Colors.grey),
//                                   borderRadius:
//                                   BorderRadius.all(
//                                       Radius.circular(
//                                           10)),
//                                   // color: Colors.green,
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment
//                                       .start,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(horizontal:5),
//                                       child: Text(
//                                           "Upload Immunization Records from PDF",
//                                           style: GoogleFonts.firaSans(
//                                               fontSize: 9,
//                                               fontWeight:
//                                               FontWeight
//                                                   .w500,
//                                               color: Color(0xff686464))),
//                                     ),
//
//                                     ///sub container
//                                     StreamBuilder<List<PlatformFile>>(
//                                       stream: _mobileFilesStreamController.stream,
//                                       builder: (context,
//                                           snapshot) {
//                                         return Padding(
//                                           padding: const EdgeInsets.all(3.0),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                             MainAxisAlignment
//                                                 .spaceAround,
//                                             children: [
//                                               Container(
//                                                 width: 170,
//                                                 height: 30,
//                                                 decoration:
//                                                 BoxDecoration(
//                                                   border: Border.all(
//                                                       color:
//                                                       Colors.grey),
//                                                   borderRadius:
//                                                   BorderRadius.all(
//                                                       Radius.circular(10)),
//                                                   // color: Colors.pink
//                                                 ),
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.all(1.0),
//                                                   child: Row(
//                                                     mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceAround,
//                                                     children: [
//                                                       InkWell(
//                                                         onTap:
//                                                         pickMobileLogo,
//                                                         child:
//                                                         Container(
//                                                           color:
//                                                           Color(0xffD9D9D9),
//                                                           child:
//                                                           Text(
//                                                             "Choose File",
//                                                             style: GoogleFonts.firaSans(
//                                                               fontSize: 10,
//                                                               fontWeight: FontWeight.w500,
//                                                               color: Colors.grey,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       // SizedBox(width: 2,),
//                                                       if (snapshot
//                                                           .hasData)
//                                                         ...snapshot
//                                                             .data!
//                                                             .map((file) => InkWell(
//                                                           child: Container(
//                                                             // padding: EdgeInsets.only(t: 15),
//                                                             height: 30,
//                                                             width: 90,
//                                                             child: Text(
//                                                               file.name.substring(0,10) + "...",
//                                                               textAlign: TextAlign.center,
//                                                               style: GoogleFonts.firaSans(
//                                                                 fontSize: 10,
//                                                                 fontWeight: FontWeight.w500,
//                                                                 color: Colors.grey,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           onTap: () => openFile(file),
//                                                         ))
//                                                             .toList(),
//                                                     ],
//                                                   ),
//                                                 ),
//
//                                               ),
//                                             ],
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: AppSize.s15),
//                           SMTextFConst(
//                             controller: widget.nameController,
//                             keyboardType:
//                             TextInputType.text,
//                             text: AppStringEM.companyName,
//                           ),
//                           SizedBox(height: AppSize.s15),
//                           SMTextFConstPhone(
//                             controller: widget.secNumberController,
//                             keyboardType: TextInputType.phone,
//                             text: AppStringEM.secNum,
//                             enable: true,
//                           ),
//
//                           // text: 'Phone Number',
//                           //  icon: Icon(Icons.phone),
//                           //  enable: true,
//                           //  validator: (value) {
//                           //    // Add your validation logic here
//                           //    return null;
//                           //  },
//
//                           // SMTextFConst(
//                           //
//                           //   controller:
//                           //       secNumberController,
//                           //   keyboardType:
//                           //       TextInputType.phone,
//                           //   text: AppStringEM.secNum,
//                           // ),
//                           SizedBox(height:AppSize.s15),
//                           SMTextFConst(
//                             controller: widget.faxController,
//                             keyboardType:
//                             TextInputType.text,
//                             text: AppStringEM.fax,
//                           ),
//                           SizedBox(height: AppSize.s15),
//                           SMTextFConst(
//                             controller: widget.emailController,
//                             keyboardType:
//                             TextInputType.text,
//                             text: AppStringEM.primarymail,
//                           ),
//                         ],
//                       ),
//                       Column(
//                         mainAxisAlignment:
//                         MainAxisAlignment.center,
//                         children: [
//                           Column(
//                             mainAxisAlignment:
//                             MainAxisAlignment.start,
//                             crossAxisAlignment:
//                             CrossAxisAlignment.start,
//                             children: [
//                               ///Company Web Logo title,
//                               Text("Company Web Logo",
//                                   style: GoogleFonts
//                                       .firaSans(
//                                     fontSize:
//                                     FontSize.s12,
//                                     fontWeight:
//                                     FontWeightManager
//                                         .bold,
//                                     color:
//                                     Color(0xff686464),
//                                   )),
//                               SizedBox(height: 5,),
//                               Container(
//                                 width: 354,
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                       color: Colors.grey),
//                                   borderRadius:
//                                   BorderRadius.all(
//                                       Radius.circular(
//                                           10)),
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment
//                                       .start,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                                       child: Text(
//                                           "Upload Immunization Records from PDF",
//                                           style: GoogleFonts.firaSans(
//                                               fontSize: 9,
//                                               fontWeight:
//                                               FontWeight
//                                                   .w500,
//                                               color: Color(
//                                                   0xff686464))),
//                                     ),
//                                     ///sub container
//                                     StreamBuilder<
//                                         List<PlatformFile>>(
//                                       stream: _webFilesStreamController.stream,
//                                       builder: (context, snapshot) {
//                                         return Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment
//                                               .spaceAround,
//                                           children: [
//                                             Container(
//                                               width: 150,
//                                               height: 30,
//                                               decoration:
//                                               BoxDecoration(
//                                                 border: Border.all(
//                                                     color:
//                                                     Colors.grey),
//                                                 borderRadius:
//                                                 BorderRadius.all(
//                                                     Radius.circular(10)),
//                                               ),
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                 MainAxisAlignment
//                                                     .spaceAround,
//                                                 children: [
//                                                   InkWell(
//                                                     onTap:
//                                                     pickWebLogo,
//                                                     child:
//                                                     Container(
//                                                       color:
//                                                       Color(0xffD9D9D9),
//                                                       child:
//                                                       Text(
//                                                         "Choose File",
//                                                         style: GoogleFonts.firaSans(
//                                                           fontSize: 10,
//                                                           fontWeight: FontWeight.w500,
//                                                           color: Colors.grey,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   if (snapshot
//                                                       .hasData)
//                                                     ...snapshot
//                                                         .data!
//                                                         .map((file) => InkWell(
//                                                       child: Container(
//                                                         padding: EdgeInsets.only(bottom: 15),
//                                                         // height: 30,
//                                                         // width: 90,
//                                                         child: Text(
//                                                           file.name.substring(0,10) + "..",
//                                                           textAlign: TextAlign.start,
//                                                           style: GoogleFonts.firaSans(
//                                                             fontSize: 10,
//                                                             fontWeight: FontWeight.w500,
//                                                             color: Colors.grey,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       onTap: () => openFile(file),
//                                                     ))
//                                                         .toList(),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         );
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: AppSize.s15),
//                           // SMTextFConst(
//                           //   controller: primNumController,
//                           //   keyboardType: TextInputType.number,
//                           //   text: AppStringEM.primNum,
//                           // ),
//                           SMTextFConstPhone(
//                             controller: widget.primNumController,
//                             // codecontroller: primNumController,
//                             keyboardType: TextInputType.phone,
//                             text: 'Primary Phone Number',
//                           ),
//                           SizedBox(height: AppSize.s15),
//                           SMTextFConstPhone(
//                             controller: widget.altNumController,
//                             keyboardType:
//                             TextInputType.number,
//                             text: AppStringEM
//                                 .alternatephone,
//                           ),
//                           SizedBox(height: AppSize.s15),
//                           // AddressSearchField(
//                           //   controller: addressController,
//                           //   searchHint: AppStringEM.headofficeaddress,
//                           //   onSuggestionSelected: (AddressSearchModel suggestion) {
//                           //     // Handle what happens when a suggestion is selected
//                           //     addressController.text = suggestion.label;
//                           //   },
//                           //   noResultsText: 'No results found',
//                           //   searchStyle: TextStyle(
//                           //     fontSize: 16,
//                           //     color: Colors.black,
//                           //   ),
//                           //   suggestionStyle: TextStyle(
//                           //     fontSize: 14,
//                           //     color: Colors.grey,
//                           //   ),
//                           //   decoration: InputDecoration(
//                           //     labelText: AppStringEM.headofficeaddress,
//                           //     border: OutlineInputBorder(
//                           //       borderRadius: BorderRadius.circular(8),
//                           //     ),
//                           //   ),
//                           // ),
//                           ///
//                           SMTextFConst(
//                             controller: widget.addressController,
//                             keyboardType:
//                             TextInputType.text,
//                             text: AppStringEM.headofficeaddress,
//                           ),
//                           if (_suggestions.isNotEmpty)
//                             Container(
//                               height: 100,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(8),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black26,
//                                     blurRadius: 4,
//                                     offset: Offset(0, 2),
//                                   ),
//                                 ],
//                               ),
//                               child: ListView.builder(
//                                 shrinkWrap: true,
//                                 itemCount: _suggestions.length,
//                                 itemBuilder: (context, index) {
//                                   return ListTile(
//                                     title: Text(_suggestions[index],style: GoogleFonts.firaSans(
//                                       fontSize: FontSize.s12,
//                                       fontWeight: FontWeight.w700,
//                                       color: ColorManager.mediumgrey,
//                                       decoration: TextDecoration.none,
//                                     ),),
//                                     onTap: () {
//                                       widget.addressController.text = _suggestions[index];
//                                       setState(() {
//                                         _suggestions.clear();
//                                       });
//                                     },
//                                   );
//                                 },
//                               ),
//                             ),
//                           SizedBox(
//                             width: 354,
//                             height: 30,
//                           ),
//                           SizedBox(
//                             width: 354,
//                             height: 30,
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                   Align(
//                     alignment: Alignment.bottomRight,
//                     child: Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           CustomButtonTransparent(
//                             width: 105,
//                             height: 35,
//                             text: "Cancel",
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                           ),
//                           SizedBox(width: 10),
//                           CustomElevatedButton(
//                             width: 105,
//                             height: 35,
//                             text: 'Submit',
//                             onPressed: () async {
//                               await postWhitelabellingAdd(
//                                 context,
//                                 widget.officeId,
//                                 primNumController.text,
//                                 secNumberController.text,
//                                 faxController.text,
//                                 faxController.text,
//                                 altNumController.text,
//                                 emailController.text,
//                                 nameController.text,
//                                 addressController.text,
//                               );
//                               await uploadWebAndAppLogo(context: context, type: "web", documentFile: filePath, documentName: fileName);
//                               Navigator.pop(context);
//                               showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) {
//                                   return EditSuccessPopup(message: 'Submitted Successfully',);
//                                 },
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
