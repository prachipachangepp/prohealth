// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image_picker_web/image_picker_web.dart';
// import 'package:intl/intl.dart';
// import 'package:shimmer/shimmer.dart';
// import '../../../../../app/resources/color.dart';
// import '../../../../../app/resources/value_manager.dart';
// import '../../../../../app/services/api/managers/hr_module_manager/add_employee/clinical_manager.dart';
// import '../../../../../data/api_data/hr_module_data/add_employee/clinical.dart';
// import '../../../../widgets/widgets/constant_textfield/const_textfield.dart';
// import '../../manage/widgets/custom_icon_button_constant.dart';
// import 'clinical.dart';
// import 'mcq_widget_add-employee.dart';
// import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
// import 'package:flutter/material.dart';
// import 'dart:io' show File;
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
//
// ///prachi
// class SalesTab extends StatefulWidget {
//   @override
//   State<SalesTab> createState() => _SalesTabState();
// }
//
// class _SalesTabState extends State<SalesTab> {
//   final TextEditingController _sale1Controller = TextEditingController();
//   final TextEditingController _workemailController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _firstnameController = TextEditingController();
//   final TextEditingController _personalnoController = TextEditingController();
//   final TextEditingController _lastnameController = TextEditingController();
//   final TextEditingController _worknoController = TextEditingController();
//   final TextEditingController _dateofbirthController = TextEditingController();
//   final TextEditingController _personalemailController =
//       TextEditingController();
//   final TextEditingController ctlrfirstName = TextEditingController();
//   final TextEditingController ctlrlastName = TextEditingController();
//   final TextEditingController ctlrSocialSecurity = TextEditingController();
//   final TextEditingController ctlrprimeNo = TextEditingController();
//   final TextEditingController ctlrsecNo = TextEditingController();
//   final TextEditingController ctlrworkNo = TextEditingController();
//   final TextEditingController ctlrCountry = TextEditingController();
//   final TextEditingController ctlrPersonalEmail = TextEditingController();
//   final TextEditingController ctlrWorkEmail = TextEditingController();
//   final TextEditingController ctlrAddress = TextEditingController();
//   final TextEditingController ctlrEmContact = TextEditingController();
//   final TextEditingController ctlrDob = TextEditingController();
//
//   int? _selectedItemIndex;
//
//   String? _fileName;
//   DateTime? selectedDate;
//   late DateTime _selectedDate;
//   List<DateTime?> dobList = [];
//   late Future<List<HRAddEmployeeGet>> _futureData;
//   Future<void> selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate,
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//         ctlrDob.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
//       });
//     }
//   }
//   List<String> _socialSecurityNumbers = [];
//   ///ssnbr
//   Future<void> _saveSSNBrData() async {
//     try {
//       final data = await _futureData;
//       setState(() {
//         _socialSecurityNumbers = data
//             .map((e) => e.ssnnBr)
//             .where((number) => number != null)
//             .cast<String>()
//             .toList();
//       });
//     } catch (e) {
//       // Handle error
//       print("Error fetching data: $e");
//     }
//   }
//   ///upload img
//   File? image;
//   Uint8List? webImage;
//   final _picker = ImagePicker();
//   bool showSpinner = false;
//   String uploadStatus = "";
//
//   Future<void> getImage() async {
//     try {
//       if (kIsWeb) {
//         var mediaData = await ImagePickerWeb.getImageAsBytes();
//         if (mediaData != null) {
//           setState(() {
//             webImage = mediaData;
//           });
//         } else {
//           print("No Image Selected");
//         }
//       } else {
//         final pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
//         if (pickedFile != null) {
//           setState(() {
//             image = File(pickedFile.path);
//           });
//         } else {
//           print("No Image Selected");
//         }
//       }
//     } catch (e) {
//       print("Error picking image: $e");
//     }
//   }
//
//   Future<void> uploadImage() async {
//     if (image == null && webImage == null) {
//       setState(() {
//         uploadStatus = "No image selected!";
//       });
//       return;
//     }
//
//     setState(() {
//       showSpinner = true;
//     });
//
//     try {
//       var request = http.MultipartRequest('POST', Uri.parse('http://50.112.139.35:3000/employees/attach-photo/2'));
//       if (kIsWeb) {
//         request.files.add(http.MultipartFile.fromBytes('image', webImage!, filename: 'upload.png'));
//       } else {
//         request.files.add(await http.MultipartFile.fromPath('image', image!.path));
//       }
//
//       var response = await request.send();
//
//       if (response.statusCode == 200) {
//         setState(() {
//           uploadStatus = "Image uploaded successfully!";
//         });
//       } else {
//         final responseBody = await response.stream.bytesToString();
//         setState(() {
//           uploadStatus = "Failed to upload image: ${response.statusCode} - $responseBody";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         uploadStatus = "Error uploading image: $e";
//       });
//     } finally {
//       setState(() {
//         showSpinner = false;
//       });
//     }
//   }
//
//   ///
//   // File? image ;
//   // final _picker = ImagePicker();
//   // bool showSpinner = false;
//   //
//   // Future getImage() async {
//   //   final pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
//   //
//   //   if(pickedFile ! = null){
//   //     image = File(pickedFile.path);
//   //     setState(() {
//   //
//   //     });
//   //   } else {
//   //       print("No Image Selected");
//   //   }
//   // }
//   //
//   // File? image;
//   // final _picker = ImagePicker();
//   // bool showSpinner = false;
//   //
//   // Future getImage() async {
//   //   final pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
//   //
//   //   if (pickedFile != null) {
//   //     image = File(pickedFile.path);
//   //     setState(() {});
//   //   } else {
//   //     print("No Image Selected");
//   //   }
//   // }
//   //
//   // Future<void> uploadImage () async {
//   //   // setState(() {
//   //   //   showSpinner  = true;
//   //   // });
//   //   var Stream = new http.ByteStream(image!.openRead());
//   //   Stream.cast();
//   //
//   //   var length = await image!.length();
//   //
//   //   var uri = Uri.parse('http://50.112.139.35:3000/employees/attach-photo/2');
//   //
//   //   var request = new http.MultipartRequest('POST', uri);
//   //
//   //   request.fields['file'] = 'Static title' ;
//   //
//   //   var multipart = new http.MultipartFile('file', Stream, length);
//   //
//   //   request.files.add(multipart);
//   //
//   //   var response = await request.send();
//   //
//   //   if(response.statusCode == 200){
//   //     print("Image Uploaded");
//   //   } else{
//   //     print("Failed");
//   //   }
//   // }
//   @override
//   void initState() {
//     super.initState();
//     // _fetchData();
//     _futureData = HrAddEmployeeget(context);
//   }
//
//   // Future<void> _fetchData() async {
//   //   try {
//   //     List<HRAddEmployeeGet> data = await HrAddEmployeeget(context);
//   //     setState(() {
//   //       _personalEmails = data
//   //           .map((e) => e.personalEmail)
//   //           .where((email) => email != null)
//   //           .cast<String>()
//   //           .toList();
//   //       _isLoading = false;
//   //     });
//   //   } catch (e) {
//   //     setState(() {
//   //       _isLoading = false;
//   //     });
//   //     print('Error fetching data: $e');
//   //   }
//   // }
//   @override
//   Widget build(BuildContext context) {
//     double containerHeight1 = MediaQuery.of(context).size.height * 0.32;
//     // double containerHeight2 = 100;
//     // MediaQuery.of(context).size.height * 0.2;
//     double textFieldWidth = 200;
//     double textFieldHeight = 38;
//     FocusNode _focusNode = FocusNode();
//     return SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child: Container(
//         height: 700,
//         width: 400,
//         child: Column(
//           children: [
//             ///upload photo button
//             Expanded(
//               child: Container(
//                 // color: Colors.pink,
//                 // height: 40,
//                 width: MediaQuery.of(context).size.width / 1,
//                 child:
//                 Center(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: <Widget>[
//                       GestureDetector(
//                         onTap: getImage,
//                         child: Container(
//                           child: image == null && webImage == null
//                               ? Center(child: Container(
//                               width: 125,
//                               height: 30,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                                 border: Border.all(
//                                   color: ColorManager.primary,
//                                   style: BorderStyle.solid,
//                                   width: 1.0,
//                                 ),
//                               ),
//                               child: Center(child: Text('Pick Photo', style: GoogleFonts.firaSans(
//                                 fontWeight: FontWeight.w700, fontSize: 12,color: ColorManager.primary
//                               ),
//                               )
//                               )
//                           )
//                           )
//                               : Container(
//                             child: Center(
//                               child: kIsWeb
//                                   ? Image.memory(
//                                 webImage!,
//                                 height: 40,
//                                 width: 40,
//                                 fit: BoxFit.cover,
//                               )
//                                   : Image.file(
//                                 image!,
//                                 height: 40,
//                                 width: 40,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 5),
//                      CustomButton(
//                        width: 125,
//                        height: 30,
//                        onPressed: uploadImage, text: 'Upload Photo',
//                        style: GoogleFonts.firaSans(
//                            fontSize: 12.0,
//                            fontWeight: FontWeight.w700
//                        ),),
//                       SizedBox(height: 10),
//                       showSpinner ? CircularProgressIndicator() : Text(uploadStatus),
//                     ],
//                   ),
//                 ),
//                 // Column(
//                 //   children: [
//                 //     GestureDetector(
//                 //       onTap: () {
//                 //         getImage();
//                 //       },
//                 //       child: Container(
//                 //         child:  image == null ? Center(child: Text('Pick Image'),)
//                 //             :
//                 //       Container(
//                 //         child: Center(
//                 //           child: Image.file(File(image!.path).absolute,
//                 //           height: 40,
//                 //             width: 40,
//                 //             fit: BoxFit.cover,
//                 //           ),
//                 //         ),
//                 //       ),
//                 //       ),
//                 //     ), SizedBox(
//                 //       height: 10,
//                 //
//                 //     ),
//                 //     GestureDetector(
//                 //       onTap: (){
//                 //        uploadImage();
//                 //       },
//                 //       child:
//                 //       Container(
//                 //         height: 30,
//                 //         width: 80,
//                 //         color: Colors.lightBlue,
//                 //         child: Center(child: Text("Uploaded", style: TextStyle(
//                 //           color: Colors.white,
//                 //         ),)),
//                 //       ),
//                 //     )
//                 //   ],
//                 // )
//                 ///
//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.end,
//                 //   children: [
//                 //     if (_fileName != null)
//                 //       Padding(
//                 //         padding: EdgeInsets.only(right: 8.0),
//                 //         child: Text(
//                 //           _fileName!,
//                 //           style: TextStyle(
//                 //             fontFamily: 'FiraSans',
//                 //             fontSize: 12,
//                 //             fontWeight: FontWeight.w700,
//                 //             color: Colors.black,
//                 //           ),
//                 //         ),
//                 //       ),
//                 //     ElevatedButton.icon(
//                 //       onPressed: () async {
//                 //         FilePickerResult? result = await FilePicker.platform.pickFiles(
//                 //           type: FileType.image,
//                 //           allowMultiple: false,
//                 //         );
//                 //
//                 //         if (result != null) {
//                 //           PlatformFile file = result.files.first;
//                 //           setState(() {
//                 //             _fileName = file.name;
//                 //           });
//                 //           print('File path: ${file.path}');
//                 //         }
//                 //       },
//                 //       icon: Icon(
//                 //         Icons.file_upload_outlined,
//                 //         color: Colors.white,
//                 //       ),
//                 //       label: Text(
//                 //         'Upload Photo',
//                 //         textAlign: TextAlign.center,
//                 //         style: TextStyle(
//                 //           fontFamily: 'FiraSans',
//                 //           fontSize: 12,
//                 //           fontWeight: FontWeight.w700,
//                 //           color: Colors.white,
//                 //         ),
//                 //       ),
//                 //       style: ElevatedButton.styleFrom(
//                 //         backgroundColor: Color(0xff1696C8),
//                 //         shape: RoundedRectangleBorder(
//                 //           borderRadius: BorderRadius.circular(12),
//                 //         ),
//                 //       ),
//                 //     ),
//                 //   ],
//                 // )
//               ),
//             ),
//       SizedBox(height: 10,),
//             ///first container
//             Expanded(
//               flex: 2,
//               child: Material(
//                 elevation: 4,
//                 borderRadius: BorderRadius.circular(10),
//                 child: Container(
//                   // height: 200,
//                   width: MediaQuery.of(context).size.width / 1,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(
//                       width: 1,
//                       color: Color(0xffB7B7B7),
//                     ),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Expanded(
//                           child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           ///position
//                           FutureBuilder<List<AEClinicalDiscipline>>(
//                             future: HrAddEmplyClinicalDisciplinApi(context,1),
//                             builder: (context, snapshot) {
//                               if (snapshot.connectionState ==
//                                   ConnectionState.waiting) {
//                                 return Shimmer.fromColors(
//                                   baseColor: Colors.grey[300]!,
//                                   highlightColor: Colors.grey[100]!,
//                                   child: Padding(
//                                     padding:
//                                     const EdgeInsets.symmetric(horizontal: 7),
//                                     child: Container(
//                                       width: AppSize.s250,
//                                       height: AppSize.s40,
//                                       decoration: BoxDecoration(
//                                           color: ColorManager.faintGrey),
//                                     ),
//                                   ),
//                                 );
//                               }
//                               if (snapshot.hasData) {
//                                 List<String> dropDownList = [];
//                                 for (var i in snapshot.data!) {
//                                   dropDownList.add(i.empType!);
//                                 }
//                                 return CustomDropdownTextField(
//                                   labelText: 'Position',
//                                   labelStyle: GoogleFonts.firaSans(
//                                     fontSize: 12,
//                                     color: Color(0xff575757),
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                   labelFontSize: 10,
//                                   items: dropDownList,
//                                   onChanged: (newValue) {
//                                     for (var a in snapshot.data!) {
//                                       if (a.empType == newValue) {
//                                         // int docType = a.employeeTypesId;
//                                         // Do something with docType
//                                       }
//                                     }
//                                   },
//                                 );
//                               } else {
//                                 return const Offstage();
//                               }
//                             },
//                           ),
//
//                          // /social security
//                           FutureBuilder<List<HRAddEmployeeGet>>(
//                             future: _futureData,
//                             builder: (context, snapshot) {
//                               if (snapshot.connectionState ==
//                                   ConnectionState.waiting) {
//                                 return Shimmer.fromColors(
//                                   baseColor: Colors.grey[300]!,
//                                   highlightColor: Colors.grey[100]!,
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 7),
//                                     child: Container(
//                                       width: AppSize.s250,
//                                       height: AppSize.s40,
//                                       decoration: BoxDecoration(
//                                           color: ColorManager.faintGrey),
//                                     ),
//                                   ),
//                                 );
//                               }
//
//                               if (snapshot.hasData) {
//                                 if (_socialSecurityNumbers.isEmpty) {
//                                   _saveSSNBrData();
//                                   print("ssNBR");
//                                 }
//
//                                 return Autocomplete<String>(
//                                   optionsBuilder:
//                                       (TextEditingValue textEditingValue) {
//                                     if (textEditingValue.text.isEmpty) {
//                                       return const Iterable<String>.empty();
//                                     } else {
//                                       return _socialSecurityNumbers
//                                           .where((String option) {
//                                         return option
//                                             .contains(textEditingValue.text);
//                                       });
//                                     }
//                                   },
//                                   optionsViewBuilder: (BuildContext context,
//                                       AutocompleteOnSelected<String> onSelected,
//                                       Iterable<String> options) {
//                                     return Align(
//                                       alignment: Alignment.topLeft,
//                                       child: Material(
//                                         shape: const RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.vertical(
//                                               bottom: Radius.circular(4.0)),
//                                         ),
//                                         child: Container(
//                                           width: textFieldWidth,
//                                           constraints:
//                                           BoxConstraints(maxHeight: 200.0),
//                                           child: ListView.builder(
//                                             padding: EdgeInsets.zero,
//                                             itemCount: options.length,
//                                             itemBuilder: (BuildContext context,
//                                                 int index) {
//                                               final String option =
//                                               options.elementAt(index);
//                                               return ListTile(
//                                                 title: Text(
//                                                   option,
//                                                   style: GoogleFonts.firaSans(
//                                                     fontSize: 12,
//                                                     color: Color(0xff575757),
//                                                     fontWeight: FontWeight.w400,
//                                                   ),
//                                                 ),
//                                                 onTap: () {
//                                                   onSelected(option);
//                                                 },
//                                               );
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                   fieldViewBuilder: (BuildContext context,
//                                       TextEditingController ctlrSocialSecurity,
//                                       FocusNode focusNode,
//                                       VoidCallback onFieldSubmitted) {
//                                     return CustomTextField(
//                                       width: textFieldWidth,
//                                       height: textFieldHeight,
//                                       cursorHeight: 20,
//                                       labelText: 'Social Security No',
//                                       labelStyle: GoogleFonts.firaSans(
//                                         fontSize: 12,
//                                         color: Color(0xff575757),
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                       controller: ctlrSocialSecurity,
//                                       suffixIcon: Icon(
//                                         Icons.remove_red_eye_outlined,
//                                         color: Colors.blue,
//                                         size: 14,
//                                       ),
//                                       focusNode: focusNode,
//                                       labelFontSize: 12,
//                                     );
//                                   },
//                                 );
//                               } else if (snapshot.hasError) {
//                                 return Text("Error: ${snapshot.error}");
//                               } else {
//                                 return const Offstage();
//                               }
//                             },
//                           ),
//
//                           ///work email
//                           CustomTextField(
//                             width: textFieldWidth,
//                             height: textFieldHeight,
//                             cursorHeight: 22,
//                             labelText: 'Work Email',
//                             labelStyle: GoogleFonts.firaSans(
//                               fontSize: 12,
//                               color: Color(0xff575757),
//                               fontWeight: FontWeight.w400,
//                             ),
//                             controller: ctlrWorkEmail,
//                             labelFontSize: 12,
//                           ),
//                           ///work email
//                         ],
//                       )),
//                       Expanded(
//                           child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           ///first name
//                           CustomTextField(
//                             width: textFieldWidth,
//                             height: textFieldHeight,
//                             cursorHeight: 20,
//                             labelText: 'First Name',
//                             labelStyle: GoogleFonts.firaSans(
//                               fontSize: 12,
//                               color: Color(0xff575757),
//                               fontWeight: FontWeight.w400,
//                             ),
//                             controller: ctlrfirstName,
//                             labelFontSize: 12,
//                           ),
//                           ///primary phone no
//                           CustomTextField(
//                             width: textFieldWidth,
//                             height: textFieldHeight,
//                             cursorHeight: 22,
//                             labelText: 'Primary Phone No',
//                             labelStyle: GoogleFonts.firaSans(
//                               fontSize: 12,
//                               color: Color(0xff575757),
//                               fontWeight: FontWeight.w400,
//                             ),
//                             controller: ctlrprimeNo,
//                             labelFontSize: 12,
//                           ),
//                           ///address
//                           CustomTextField(
//                             width: textFieldWidth,
//                             height: textFieldHeight,
//                             cursorHeight: 22,
//                             labelText: 'Address',
//                             labelStyle: GoogleFonts.firaSans(
//                               fontSize: 12,
//                               color: Color(0xff575757),
//                               fontWeight: FontWeight.w400,
//                             ),
//                             controller: ctlrAddress,
//                             labelFontSize: 12,
//                           ),
//                         ],
//                       )),
//                       Expanded(
//                           child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//
//                           ///last name
//                           CustomTextField(
//                             width: textFieldWidth,
//                             height: textFieldHeight,
//                             cursorHeight: 20,
//                             labelText: 'Last Name',
//                             labelStyle: GoogleFonts.firaSans(
//                               fontSize: 12,
//                               color: Color(0xff575757),
//                               fontWeight: FontWeight.w400,
//                             ),
//                             controller: ctlrlastName,
//                             labelFontSize: 12,
//                           ),
//                           ///work no
//                           CustomTextField(
//                             width: textFieldWidth,
//                             height: textFieldHeight,
//                             cursorHeight: 22,
//                             labelText: 'Work Phone No',
//                             labelStyle: TextStyle(
//                               fontSize: 12,
//                               color: Color(0xff575757),
//                               fontWeight: FontWeight.w400,
//                             ),
//                             controller: ctlrworkNo,
//                             labelFontSize: 12,
//                           ),
//                           ///date
//                           SizedBox(
//                             width: AppSize.s250,
//                             height: AppSize.s40,
//                             child: Padding(
//                               padding: const EdgeInsets.all(AppPadding.p5),
//                               child: TextFormField(
//                                 controller: ctlrDob,
//                                 readOnly: true,
//                                 style: GoogleFonts.firaSans(
//                                   fontSize: 12,
//                                   color: Color(0xff575757),
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                                 decoration: InputDecoration(
//                                   labelText: 'Date of Birth',
//                                   labelStyle: GoogleFonts.firaSans(
//                                     fontSize: 12,
//                                     color: Color(0xff575757),
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                   contentPadding: EdgeInsets.only(
//                                       bottom: 8, top: 10, left: 8),
//                                   border: OutlineInputBorder(),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(color: Colors.black),
//                                   ),
//                                   suffixIcon: IconButton(
//                                     icon: Icon(
//                                       Icons.calendar_month_outlined,
//                                       size: 13,
//                                     ),
//                                     onPressed: () async {
//                                       final selectedDate = await showDatePicker(
//                                         context: context,
//                                         initialDate: DateTime.now(),
//                                         firstDate: DateTime(1900),
//                                         lastDate: DateTime.now(),
//                                       );
//                                       if (selectedDate != null) {
//                                         setState(() {
//                                           this.selectedDate = selectedDate;
//                                           ctlrDob.text = DateFormat('yyyy-MM-dd')
//                                               .format(selectedDate);
//                                         });
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       )),
//                       Expanded(
//                           child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           ///home office
//                           FutureBuilder<List<AEClinicalDiscipline>>(
//                             future: HrAddEmplyClinicalDisciplinApi(context, 1),
//                             builder: (context, snapshot) {
//                               if (snapshot.connectionState ==
//                                   ConnectionState.waiting) {
//                                 return Shimmer.fromColors(
//                                   baseColor: Colors.grey[300]!,
//                                   highlightColor: Colors.grey[100]!,
//                                   child: Padding(
//                                     padding:
//                                         const EdgeInsets.symmetric(horizontal: 7),
//                                     child: Container(
//                                       width: AppSize.s250,
//                                       height: AppSize.s40,
//                                       decoration: BoxDecoration(
//                                           color: ColorManager.faintGrey),
//                                     ),
//                                   ),
//                                 );
//                               }
//                               if (snapshot.hasData) {
//                                 List<String> dropDownList = [];
//                                 for (var i in snapshot.data!) {
//                                   dropDownList.add(i.empType!);
//                                 }
//                                 return CustomDropdownTextField(
//                                   labelText: 'Home Office',
//                                   labelStyle: GoogleFonts.firaSans(
//                                     fontSize: 12,
//                                     color: Color(0xff575757),
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                   labelFontSize: 10,
//                                   items: dropDownList,
//                                   onChanged: (newValue) {
//                                     for (var a in snapshot.data!) {
//                                       if (a.empType == newValue) {
//                                         // int docType = a.employeeTypesId;
//                                         // Do something with docType
//                                       }
//                                     }
//                                   },
//                                 );
//                               } else {
//                                 return const Offstage();
//                               }
//                             },
//                           ),
//                           ///personal email
//                           CustomTextField(
//                             width: textFieldWidth,
//                             height: textFieldHeight,
//                             cursorHeight: 22,
//                             labelText: 'Personal Email',
//                             labelStyle: GoogleFonts.firaSans(
//                               fontSize: 12,
//                               color: Color(0xff575757),
//                               fontWeight: FontWeight.w400,
//                             ),
//                             controller: ctlrPersonalEmail,
//                             labelFontSize: 12,
//                           ),
//                           ///EM Contact no
//                           CustomTextField(
//                             width: textFieldWidth,
//                             height: textFieldHeight,
//                             cursorHeight: 22,
//                             labelText: 'Emergency Phone No',
//                             labelStyle: GoogleFonts.firaSans(
//                               fontSize: 12,
//                               color: Color(0xff575757),
//                               fontWeight: FontWeight.w400,
//                             ),
//                             controller: ctlrEmContact,
//                             labelFontSize: 12,
//                           )
//                         ],
//                       )),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             ///second container
//             Expanded(
//               flex: 1,
//               child: Material(
//                 elevation: 4,
//                 borderRadius: BorderRadius.circular(10),
//                 child: Container(
//                     // height: 200,
//                     width: MediaQuery.of(context).size.width / 1,
//                     padding: EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(
//                         width: 1,
//                         color: Color(0xffB7B7B7),
//                       ),
//                     ),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           McqWidget(
//                             title: 'Employment',
//                             fontSize: 14.0,
//                             items: [
//                               'Full Time',
//                               'Contract',
//                               'Part Time',
//                               'Per Diem'
//                             ],
//                             onChanged: (selectedIndex) {
//                               print('Selected index: $selectedIndex');
//                               _selectedItemIndex = selectedIndex;
//                             },
//                           ),
//                           McqWidget(
//                             title: 'Gender',
//                             fontSize: 14.0,
//                             items: [
//                               'Male',
//                               'Female',
//                               'Other',
//                             ],
//                             onChanged: (int) {},
//                           ),
//                           McqWidget(
//                             title: 'Status',
//                             fontSize: 14.0,
//                             items: ['Active', 'Trainee', 'Inactive'],
//                             onChanged: (int) {},
//                           ),
//                         ])),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//
//             ///add button
//             Expanded(
//               flex: 1,
//               child: Container(
//                 // color: Colors.pink,
//                 // height: 50,
//                 width: MediaQuery.of(context).size.width / 1,
//                 child: Center(
//                   child: CustomButton(
//                     width: 125,
//                     height: 33,
//                     text: 'Add Employee',
//                     style: TextStyle(
//                       fontFamily: 'FiraSans',
//                       fontSize: 12,
//                       fontWeight: FontWeight.w700,
//                     ),
//                     borderRadius: 12,
//                     onPressed: () {
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return ConfirmPopup(
//                             title: 'Confirm Add Employee',
//                             onCancel: () {
//                               Navigator.pop(context);
//                             },
//                             onConfirm: () async {
//                               Navigator.pop(context);
//                               await addEmployeeClinical(
//                                 context,
//                                 1,
//                                 'E075',
//                                 75,
//                                 ctlrfirstName.text,
//                                 ctlrlastName.text,
//                                 1,
//                                 1,
//                                 'Expertise',
//                                 1,
//                                 1,
//                                 1,
//                                 1,
//                                 'SSN123',
//                                 ctlrSocialSecurity.text,
//                                 ctlrprimeNo.text,
//                                 ctlrsecNo.text,
//                                 ctlrworkNo.text,
//                                 ctlrWorkEmail.text,
//                                 ctlrPersonalEmail.text,
//                                 ctlrAddress.text,
//                                 '2024-01-01',
//                                 ctlrEmContact.text,
//                                 'Coverage',
//                                 'Employment',
//                                 'Male',
//                                 'Active',
//                                 'Service',
//                                 'imgurl.com',
//                                 'resumeurl.com',
//                                 1,
//                                 true,
//                                 true,
//                                 'Onboarding',
//                                 'DL123',
//                                 '2024-01-01',
//                                 '2024-01-01',
//                                 '2024-01-01',
//                                 'Yes',
//                                 'Position',
//                                 '123 Final St',
//                                 '2024-01-01',
//                                 1,
//                                 'Type',
//                                 'Reason',
//                                 1,
//                                 1000,
//                                 'Method',
//                                 'Material',
//                                 'Race',
//                                   'rating',
//                                   "signatureURL"
//                               );
//                               print("Sales Employee Added");
//                               ctlrfirstName.clear();
//                               ctlrPersonalEmail.clear();
//                               ctlrsecNo.clear();
//                               ctlrWorkEmail.clear();
//                               ctlrEmContact.clear();
//                               ctlrDob.clear();
//                               ctlrprimeNo.clear();
//                               ctlrworkNo.clear();
//                               ctlrlastName.clear();
//                               ctlrSocialSecurity.clear();
//
//                             }, title2:  'Are you sure you want to add this employee?',
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
