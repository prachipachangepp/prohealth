// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image_picker_web/image_picker_web.dart';
// import 'package:intl/intl.dart';
// import 'package:prohealth/app/services/token/token_manager.dart';
// import 'package:prohealth/presentation/screens/hr_module/add_employee/widget/clinical.dart';
// import 'package:shimmer/shimmer.dart';
// import '../../../../../app/resources/color.dart';
// import '../../../../../app/resources/value_manager.dart';
// import '../../../../../app/services/api/managers/hr_module_manager/add_employee/clinical_manager.dart';
// import '../../../../../data/api_data/hr_module_data/add_employee/clinical.dart';
// import '../../../../widgets/widgets/constant_textfield/const_textfield.dart';
// import '../../manage/widgets/custom_icon_button_constant.dart';
// import 'mcq_widget_add-employee.dart';
// import 'dart:convert';
//
// import 'dart:typed_data';
// import 'dart:html' as html;
// import 'package:http_parser/http_parser.dart';
// import 'package:http/http.dart'as http;
//
// ///prachi
// class AdministartionTab extends StatefulWidget {
//   @override
//   State<AdministartionTab> createState() => _AdministartionTabState();
// }
//
// class _AdministartionTabState extends State<AdministartionTab> {
//   final TextEditingController _sale1Controller = TextEditingController();
//   final TextEditingController _workemailController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _firstnameController = TextEditingController();
//   final TextEditingController _personalnoController = TextEditingController();
//   final TextEditingController _lastnameController = TextEditingController();
//   final TextEditingController _worknoController = TextEditingController();
//   final TextEditingController _dateofbirthController = TextEditingController();
//   final TextEditingController _personalemailController =
//   TextEditingController();
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
//
//   String? _fileName;
//   DateTime? selectedDate;
//   late DateTime _selectedDate;
//   List<DateTime?> dobList = [];
//   List<String> _personalEmails = [];
//   bool _isLoading = true;
//   late Future<List<HRAddEmployeeGet>> _futureData;
//
//
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
//
//   List<String> _socialSecurityNumbers = [];
//
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
//
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
//         final pickedFile = await _picker.pickImage(
//             source: ImageSource.gallery, imageQuality: 80);
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
//       var dio = Dio();
//       var headers = {
//         'accept': 'application/json',
//         'Content-Type': 'application/json',
//         'Authorization': TokenManager.getAccessToken().toString(),
//         // 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjcsImlhdCI6MTcyMTcwNzEzOCwiZXhwIjoxNzIxNzkzNTM4fQ.u3c4AwTnB32u-iRdohzt7RZtrefcMw94W2gznKpwbeQ'
//       };
//
//       var formData = FormData.fromMap({
//         'image': kIsWeb
//             ? MultipartFile.fromBytes(webImage!, filename: 'upload.png')
//             : await MultipartFile.fromFile(image!.path, filename: 'upload.png'),
//         'employeeId': 2,
//         'code': 'code 1',
//         'userId': 4,
//         'firstName': 'sujata',
//         'lastName': 'bhalke',
//         'departmentId': 19,
//         'employeeTypeId': 2,
//         'expertise': 'therapy',
//         'cityId': 3,
//         'countryId': null,
//         'zoneId': 15,
//         'SSNNbr': 'string',
//         'primaryPhoneNbr': '9988776655',
//         'secondryPhoneNbr': '9090909090',
//         'workPhoneNbr': '5566778899',
//         'regOfficId': '11',
//         'personalEmail': 's@gmail.com',
//         'workEmail': 'sb@gmail.com',
//         'address': 'Las vegas',
//         'dateOfBirth': '1994-05-03T07:37:48.476Z',
//         'emergencyContact': '1122334455',
//         'employment': 'therapist',
//         'covreage': 'full coverage',
//         'gender': 'female',
//         'status': 'active',
//         'service': 'Home health',
//         'imgurl': image,
//         // 'https://symmetry-office-document.s3.us-west-2.amazonaws.com/documents/d1beb820-6dee-4204-afed-0760cdd4263b-ladyphoto.jpg',
//         'resumeurl': 'https://symmetry-office-document.s3.us-west-2.amazonaws.com/documents/baee5e03-bf5b-4e73-befd-2d55603681bb-Menu%20Add%20Employee%20.txt',
//         'onboardingStatus': 'activee',
//         'createdAt': '2024-07-23T04:35:18.076Z',
//         'companyId': 5,
//         'terminationFlag': null,
//         'approved': true,
//         'dateofTermination': null,
//         'dateofResignation': null,
//         'rehirable': null,
//         'finalAddress': null,
//         'type': null,
//         'reason': null,
//         'finalPayCheck': null,
//         'checkDate': null,
//         'grossPay': null,
//         'netPay': null,
//         'methods': null,
//         'materials': null,
//         'dateofHire': null,
//         'position': null,
//         'driverLicenceNbr': null,
//         'race': null,
//         'rating': null,
//       });
//
//       var response = await dio.post(
//         'http://50.112.139.35:3000/employees/attach-photo/2',
//         data: formData,
//         options: Options(
//           headers: headers,
//           contentType: 'multipart/form-data',
//         ),
//       );
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         setState(() {
//           uploadStatus = "Image uploaded successfully!";
//         });
//       } else {
//         setState(() {
//           uploadStatus =
//           "Failed to upload image: ${response.statusCode} - ${response
//               .statusMessage}";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         uploadStatus = "Error uploading image: $e";
//         print('$e',);
//       });
//     } finally {
//       setState(() {
//         showSpinner = false;
//       });
//     }
//   }
//
//     @override
//     void initState() {
//       super.initState();
//       // _fetchData();
//       _futureData = HrAddEmployeeget(context);
//     }
//     Future<void> _fetchData() async {
//       try {
//         List<HRAddEmployeeGet> data = await HrAddEmployeeget(context);
//         setState(() {
//           _personalEmails = data
//               .map((e) => e.personalEmail)
//               .where((email) => email != null)
//               .cast<String>()
//               .toList();
//           _isLoading = false;
//         });
//       } catch (e) {
//         setState(() {
//           _isLoading = false;
//         });
//         print('Error fetching data: $e');
//       }
//     }
//
//
//     @override
//     Widget build(BuildContext context) {
//       double containerHeight1 = MediaQuery.of(context).size.height * 0.32;
//       // double containerHeight2 = 100;
//       // MediaQuery.of(context).size.height * 0.2;
//       double textFieldWidth = 200;
//       double textFieldHeight = 38;
//       FocusNode _focusNode = FocusNode();
//
//       return SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Container(
//           height: 700,
//           width: 400,
//           child: Column(
//             children: [
//               ///upload photo button
//               Expanded(
//                 child: Container(
//                   // color: Colors.pink,
//                   // height: 40,
//                   width: MediaQuery
//                       .of(context)
//                       .size
//                       .width / 1,
//                   child: Center(
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: <Widget>[
//                           GestureDetector(
//                             onTap: getImage,
//                             child: Container(
//                               child: image == null && webImage == null
//                                   ? Center(child: Container(
//                                 width: 125,
//                                 height: 30,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(12),
//                                     border: Border.all(
//                                         color: ColorManager.primary,
//                                         style: BorderStyle.solid,
//                                         width: 1.0,)),
//                                   child: Center(child: Text('Pick Photo',
//                                     style: GoogleFonts.firaSans(
//                                         fontWeight: FontWeight.w700, fontSize: 12,color: ColorManager.primary
//                                     ),
//                                   ))))
//                                   : Container(
//                                 child: Center(
//                                   child: kIsWeb
//                                       ? Image.memory(
//                                     webImage!,
//                                     height: 40,
//                                     width: 40,
//                                     fit: BoxFit.cover,
//                                   )
//                                       : Image.file(
//                                     image!,
//                                     height: 40,
//                                     width: 40,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 5),
//                           CustomButton(
//                            width: 125,
//                            height: 30,
//                            onPressed: uploadImage, text: 'Upload Photo',
//                             style: GoogleFonts.firaSans(
//                             fontSize: 12.0,
//                             fontWeight: FontWeight.w700
//                           ),
//                          )
//                         ]),
//                   ),
//                 ),
//               ),
//
//               ///
//               // if (_fileName != null)
//               //   Padding(
//               //     padding: EdgeInsets.only(right: 8.0),
//               //     child: Text(
//               //       _fileName!,
//               //       style: TextStyle(
//               //         fontFamily: 'FiraSans',
//               //         fontSize: 12,
//               //         fontWeight: FontWeight.w700,
//               //         color: Colors.black,
//               //       ),
//               //     ),
//               //   ),
//               // ElevatedButton.icon(
//               //   onPressed: () async {
//               //     FilePickerResult? result = await FilePicker.platform.pickFiles(
//               //       type: FileType.image,
//               //       allowMultiple: false,
//               //     );
//               //
//               //     if (result != null) {
//               //       PlatformFile file = result.files.first;
//               //       setState(() {
//               //         _fileName = file.name;
//               //       });
//               //       print('File path: ${file.path}');
//               //     }
//               //   },
//               //   icon: Icon(
//               //     Icons.file_upload_outlined,
//               //     color: Colors.white,
//               //   ),
//               //   label: Text(
//               //     'Upload Photo',
//               //     textAlign: TextAlign.center,
//               //     style: TextStyle(
//               //       fontFamily: 'FiraSans',
//               //       fontSize: 12,
//               //       fontWeight: FontWeight.w700,
//               //       color: Colors.white,
//               //     ),
//               //   ),
//               //   style: ElevatedButton.styleFrom(
//               //     backgroundColor: Color(0xff1696C8),
//               //     shape: RoundedRectangleBorder(
//               //       borderRadius: BorderRadius.circular(12),
//               //     ),
//               //   ),
//               // ),
//               ///first container
//               Expanded(
//                 flex: 2,
//                 child: Material(
//                   elevation: 4,
//                   borderRadius: BorderRadius.circular(10),
//                   child: Container(
//                     // height: 200,
//                     width: MediaQuery.of(context).size.width / 1,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(
//                         width: 1,
//                         color: Color(0xffB7B7B7),
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Expanded(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 ///position
//                                 FutureBuilder<List<AEClinicalDiscipline>>(
//                                   future: HrAddEmplyClinicalDisciplinApi(context,1),
//                                   builder: (context, snapshot) {
//                                     if (snapshot.connectionState ==
//                                         ConnectionState.waiting) {
//                                       return Shimmer.fromColors(
//                                         baseColor: Colors.grey[300]!,
//                                         highlightColor: Colors.grey[100]!,
//                                         child: Padding(
//                                           padding:
//                                           const EdgeInsets.symmetric(horizontal: 7),
//                                           child: Container(
//                                             width: AppSize.s250,
//                                             height: AppSize.s40,
//                                             decoration: BoxDecoration(
//                                                 color: ColorManager.faintGrey),
//                                           ),
//                                         ),
//                                       );
//                                     }
//                                     if (snapshot.hasData) {
//                                       List<String> dropDownList = [];
//                                       for (var i in snapshot.data!) {
//                                         dropDownList.add(i.empType!);
//                                       }
//                                       return CustomDropdownTextField(
//                                         labelText: 'Position',
//                                         labelStyle: GoogleFonts.firaSans(
//                                           fontSize: 12,
//                                           color: Color(0xff575757),
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                         labelFontSize: 10,
//                                         items: dropDownList,
//                                         onChanged: (newValue) {
//                                           for (var a in snapshot.data!) {
//                                             if (a.empType == newValue) {
//                                               // int docType = a.employeeTypesId;
//                                               // Do something with docType
//                                             }
//                                           }
//                                         },
//                                       );
//                                     } else {
//                                       return const Offstage();
//                                     }
//                                   },
//                                 ),
//
//                                 ///social security
//                                 FutureBuilder<List<HRAddEmployeeGet>>(
//                                   future: _futureData,
//                                   builder: (context, snapshot) {
//                                     if (snapshot.connectionState ==
//                                         ConnectionState.waiting) {
//                                       return Shimmer.fromColors(
//                                         baseColor: Colors.grey[300]!,
//                                         highlightColor: Colors.grey[100]!,
//                                         child: Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 7),
//                                           child: Container(
//                                             width: AppSize.s250,
//                                             height: AppSize.s40,
//                                             decoration: BoxDecoration(
//                                                 color: ColorManager.faintGrey),
//                                           ),
//                                         ),
//                                       );
//                                     }
//
//                                     if (snapshot.hasData) {
//                                       if (_socialSecurityNumbers.isEmpty) {
//                                         _saveSSNBrData();
//                                         print("ssNBR");
//                                       }
//
//                                       return Autocomplete<String>(
//                                         optionsBuilder:
//                                             (TextEditingValue textEditingValue) {
//                                           if (textEditingValue.text.isEmpty) {
//                                             return const Iterable<String>.empty();
//                                           } else {
//                                             return _socialSecurityNumbers
//                                                 .where((String option) {
//                                               return option
//                                                   .contains(textEditingValue.text);
//                                             });
//                                           }
//                                         },
//                                         optionsViewBuilder: (BuildContext context,
//                                             AutocompleteOnSelected<String> onSelected,
//                                             Iterable<String> options) {
//                                           return Align(
//                                             alignment: Alignment.topLeft,
//                                             child: Material(
//                                               shape: const RoundedRectangleBorder(
//                                                 borderRadius: BorderRadius.vertical(
//                                                     bottom: Radius.circular(4.0)),
//                                               ),
//                                               child: Container(
//                                                 width: textFieldWidth,
//                                                 constraints:
//                                                 BoxConstraints(maxHeight: 200.0),
//                                                 child: ListView.builder(
//                                                   padding: EdgeInsets.zero,
//                                                   itemCount: options.length,
//                                                   itemBuilder: (BuildContext context,
//                                                       int index) {
//                                                     final String option =
//                                                     options.elementAt(index);
//                                                     return ListTile(
//                                                       title: Text(
//                                                         option,
//                                                         style: GoogleFonts.firaSans(
//                                                           fontSize: 12,
//                                                           color: Color(0xff575757),
//                                                           fontWeight: FontWeight.w400,
//                                                         ),
//                                                       ),
//                                                       onTap: () {
//                                                         onSelected(option);
//                                                       },
//                                                     );
//                                                   },
//                                                 ),
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                         fieldViewBuilder: (BuildContext context,
//                                             TextEditingController ctlrSocialSecurity,
//                                             FocusNode focusNode,
//                                             VoidCallback onFieldSubmitted) {
//                                           return CustomTextField(
//                                             width: textFieldWidth,
//                                             height: textFieldHeight,
//                                             cursorHeight: 20,
//                                             labelText: 'Social Security No',
//                                             controller: ctlrSocialSecurity,
//                                             suffixIcon: Icon(
//                                               Icons.remove_red_eye_outlined,
//                                               color: Colors.blue,
//                                               size: 14,
//                                             ),
//                                             focusNode: focusNode,
//                                           );
//                                         },
//                                       );
//                                     } else if (snapshot.hasError) {
//                                       return Text("Error: ${snapshot.error}");
//                                     } else {
//                                       return const Offstage();
//                                     }
//                                   },
//                                 ),
//
//
//
//
//                                 ///work email
//                                 CustomTextField(
//                                   width: textFieldWidth,
//                                   height: textFieldHeight,
//                                   cursorHeight: 22,
//                                   labelText: 'Work Email',
//                                   controller: ctlrWorkEmail,
//                                 ),
//                                 ///work email
//                                 // FutureBuilder<List<HRAddEmployeeGet>>(
//                                 //   future: HrAddEmployeeget(context),
//                                 //   builder: (context, snapshot) {
//                                 //     if (snapshot.connectionState ==
//                                 //         ConnectionState.waiting) {
//                                 //       return Shimmer.fromColors(
//                                 //         baseColor: Colors.grey[300]!,
//                                 //         highlightColor: Colors.grey[100]!,
//                                 //         child: Padding(
//                                 //           padding:
//                                 //               const EdgeInsets.symmetric(horizontal: 7),
//                                 //           child: Container(
//                                 //             width: AppSize.s250,
//                                 //             height: AppSize.s40,
//                                 //             decoration: BoxDecoration(
//                                 //                 color: ColorManager.faintGrey),
//                                 //           ),
//                                 //         ),
//                                 //       );
//                                 //     }
//                                 //
//                                 //     if (snapshot.hasData) {
//                                 //       List<String> personalEmail = snapshot.data!
//                                 //           .map(
//                                 //             (e) => e.personalEmail,
//                                 //           )
//                                 //           .where((email) => email != null)
//                                 //           .cast<String>()
//                                 //           .toList();
//                                 //       print("Personal Emails: $personalEmail,");
//                                 //
//                                 //       return Autocomplete<String>(
//                                 //         optionsBuilder:
//                                 //             (TextEditingValue textEditingValue) {
//                                 //           if (textEditingValue.text.isEmpty) {
//                                 //             return const Iterable<String>.empty();
//                                 //           } else {
//                                 //             return personalEmail.where((String option) {
//                                 //               return option
//                                 //                   .contains(textEditingValue.text);
//                                 //             });
//                                 //           }
//                                 //         },
//                                 //         optionsViewBuilder: (BuildContext context,
//                                 //             AutocompleteOnSelected<String> onSelected,
//                                 //             Iterable<String> options) {
//                                 //           return Align(
//                                 //             alignment: Alignment.topLeft,
//                                 //             child: Material(
//                                 //               shape: const RoundedRectangleBorder(
//                                 //                 borderRadius: BorderRadius.vertical(
//                                 //                     bottom: Radius.circular(4.0)),
//                                 //               ),
//                                 //               child: Container(
//                                 //                 width: 300,
//                                 //                 constraints:
//                                 //                     BoxConstraints(maxHeight: 200.0),
//                                 //                 child: ListView.builder(
//                                 //                   padding: EdgeInsets.zero,
//                                 //                   itemCount: options.length,
//                                 //                   itemBuilder: (BuildContext context,
//                                 //                       int index) {
//                                 //                     final String option =
//                                 //                         options.elementAt(index);
//                                 //                     return ListTile(
//                                 //                       title: Text(
//                                 //                         option,
//                                 //                         style: GoogleFonts.firaSans(
//                                 //                           fontSize: 12,
//                                 //                           color: Color(0xff575757),
//                                 //                           fontWeight: FontWeight.w400,
//                                 //                         ),
//                                 //                       ),
//                                 //                       onTap: () {
//                                 //                         onSelected(option);
//                                 //                       },
//                                 //                     );
//                                 //                   },
//                                 //                 ),
//                                 //               ),
//                                 //             ),
//                                 //           );
//                                 //         },
//                                 //         fieldViewBuilder: (BuildContext context,
//                                 //             TextEditingController ctlrWorkEmail,
//                                 //             FocusNode focusNode,
//                                 //             VoidCallback onFieldSubmitted) {
//                                 //           return CustomTextField(
//                                 //             width: textFieldWidth,
//                                 //             height: textFieldHeight,
//                                 //             cursorHeight: 22,
//                                 //             labelText: 'Work Email',
//                                 //             labelStyle: GoogleFonts.firaSans(
//                                 //               fontSize: 12,
//                                 //               color: Color(0xff575757),
//                                 //               fontWeight: FontWeight.w400,
//                                 //             ),
//                                 //             controller: ctlrWorkEmail,
//                                 //             focusNode: focusNode,
//                                 //             labelFontSize: 12,
//                                 //           );
//                                 //         },
//                                 //       );
//                                 //     } else {
//                                 //       return const Offstage();
//                                 //     }
//                                 //   },
//                                 // ),
//
//                               ],
//                             )),
//                         Expanded(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 ///first name
//                                 CustomTextField(
//                                   width: textFieldWidth,
//                                   height: textFieldHeight,
//                                   cursorHeight: 20,
//                                   labelText: 'First Name',
//                                   controller: ctlrfirstName,
//                                 ),
//
//                                 ///
//                                 // ///first name
//                                 // FutureBuilder<List<HRAddEmployeeGet>>(
//                                 //   future: HrAddEmployeeget(context),
//                                 //   builder: (context, snapshot) {
//                                 //     if (snapshot.connectionState ==
//                                 //         ConnectionState.waiting) {
//                                 //       return Shimmer.fromColors(
//                                 //         baseColor: Colors.grey[300]!,
//                                 //         highlightColor: Colors.grey[100]!,
//                                 //         child: Padding(
//                                 //           padding:
//                                 //               const EdgeInsets.symmetric(horizontal: 7),
//                                 //           child: Container(
//                                 //             width: AppSize.s250,
//                                 //             height: AppSize.s40,
//                                 //             decoration: BoxDecoration(
//                                 //                 color: ColorManager.faintGrey),
//                                 //           ),
//                                 //         ),
//                                 //       );
//                                 //     }
//                                 //     if (snapshot.hasData) {
//                                 //       List<String> firstNames = snapshot.data!
//                                 //           .map((e) => e.firstName)
//                                 //           .where((name) => name != null)
//                                 //           .cast<String>()
//                                 //           .toList();
//                                 //       return Autocomplete<String>(
//                                 //         optionsBuilder:
//                                 //             (TextEditingValue textEditingValue) {
//                                 //           if (textEditingValue.text.isEmpty) {
//                                 //             return const Iterable<String>.empty();
//                                 //           } else {
//                                 //             return firstNames.where((String option) {
//                                 //               return option.toLowerCase().contains(
//                                 //                   textEditingValue.text.toLowerCase());
//                                 //             });
//                                 //           }
//                                 //         },
//                                 //         optionsViewBuilder: (BuildContext context,
//                                 //             AutocompleteOnSelected<String> onSelected,
//                                 //             Iterable<String> options) {
//                                 //           return Align(
//                                 //             alignment: Alignment.topLeft,
//                                 //             child: Material(
//                                 //               shape: const RoundedRectangleBorder(
//                                 //                 borderRadius: BorderRadius.vertical(
//                                 //                     bottom: Radius.circular(4.0)),
//                                 //               ),
//                                 //               child: Container(
//                                 //                 width: textFieldWidth,
//                                 //                 constraints:
//                                 //                     BoxConstraints(maxHeight: 200.0),
//                                 //                 child: ListView.builder(
//                                 //                   padding: EdgeInsets.zero,
//                                 //                   itemCount: options.length,
//                                 //                   itemBuilder: (BuildContext context,
//                                 //                       int index) {
//                                 //                     final String option =
//                                 //                         options.elementAt(index);
//                                 //                     return ListTile(
//                                 //                       title: Text(
//                                 //                         option,
//                                 //                         style: GoogleFonts.firaSans(
//                                 //                           fontSize: 12,
//                                 //                           color: Color(0xff575757),
//                                 //                           fontWeight: FontWeight.w400,
//                                 //                         ),
//                                 //                       ),
//                                 //                       onTap: () {
//                                 //                         onSelected(option);
//                                 //                       },
//                                 //                     );
//                                 //                   },
//                                 //                 ),
//                                 //               ),
//                                 //             ),
//                                 //           );
//                                 //         },
//                                 //         fieldViewBuilder: (BuildContext context,
//                                 //             TextEditingController ctlrfirstName,
//                                 //             FocusNode focusNode,
//                                 //             VoidCallback onFieldSubmitted) {
//                                 //           return CustomTextField(
//                                 //             width: textFieldWidth,
//                                 //             height: textFieldHeight,
//                                 //             cursorHeight: 20,
//                                 //             labelText: 'First Name',
//                                 //             labelStyle: GoogleFonts.firaSans(
//                                 //               fontSize: 12,
//                                 //               color: Color(0xff575757),
//                                 //               fontWeight: FontWeight.w400,
//                                 //             ),
//                                 //             controller: ctlrfirstName,
//                                 //             focusNode: focusNode,
//                                 //             labelFontSize: 12,
//                                 //           );
//                                 //         },
//                                 //       );
//                                 //     } else {
//                                 //       return const Offstage();
//                                 //     }
//                                 //   },
//                                 // ),
//
//
//
//                                 ///primary phone no
//                                 CustomTextField(
//                                   width: textFieldWidth,
//                                   height: textFieldHeight,
//                                   cursorHeight: 22,
//                                   labelText: 'Primary Phone No',
//                                   controller: ctlrprimeNo,
//                                 ),
//                                 // ///personal phone no
//                                 // FutureBuilder<List<HRAddEmployeeGet>>(
//                                 //   future: HrAddEmployeeget(context),
//                                 //   builder: (context, snapshot) {
//                                 //     if (snapshot.connectionState ==
//                                 //         ConnectionState.waiting) {
//                                 //       return Shimmer.fromColors(
//                                 //         baseColor: Colors.grey[300]!,
//                                 //         highlightColor: Colors.grey[100]!,
//                                 //         child: Padding(
//                                 //           padding:
//                                 //               const EdgeInsets.symmetric(horizontal: 7),
//                                 //           child: Container(
//                                 //             width: AppSize.s250,
//                                 //             height: AppSize.s40,
//                                 //             decoration: BoxDecoration(
//                                 //                 color: ColorManager.faintGrey),
//                                 //           ),
//                                 //         ),
//                                 //       );
//                                 //     }
//                                 //
//                                 //     if (snapshot.hasData) {
//                                 //       List<String> primeNo = snapshot.data!
//                                 //           .map((e) => e.primeNo)
//                                 //           .where((number) => number != null)
//                                 //           .cast<String>()
//                                 //           .toList();
//                                 //       print("Personal Phone No: $primeNo");
//                                 //
//                                 //       return Autocomplete<String>(
//                                 //         optionsBuilder:
//                                 //             (TextEditingValue textEditingValue) {
//                                 //           if (textEditingValue.text.isEmpty) {
//                                 //             return const Iterable<String>.empty();
//                                 //           } else {
//                                 //             return primeNo.where((String option) {
//                                 //               return option
//                                 //                   .contains(textEditingValue.text);
//                                 //             });
//                                 //           }
//                                 //         },
//                                 //         optionsViewBuilder: (BuildContext context,
//                                 //             AutocompleteOnSelected<String> onSelected,
//                                 //             Iterable<String> options) {
//                                 //           return Align(
//                                 //             alignment: Alignment.topLeft,
//                                 //             child: Material(
//                                 //               shape: const RoundedRectangleBorder(
//                                 //                 borderRadius: BorderRadius.vertical(
//                                 //                     bottom: Radius.circular(4.0)),
//                                 //               ),
//                                 //               child: Container(
//                                 //                 width: textFieldWidth,
//                                 //                 constraints:
//                                 //                     BoxConstraints(maxHeight: 200.0),
//                                 //                 child: ListView.builder(
//                                 //                   padding: EdgeInsets.zero,
//                                 //                   itemCount: options.length,
//                                 //                   itemBuilder: (BuildContext context,
//                                 //                       int index) {
//                                 //                     final String option =
//                                 //                         options.elementAt(index);
//                                 //                     return ListTile(
//                                 //                       title: Text(
//                                 //                         option,
//                                 //                         style: GoogleFonts.firaSans(
//                                 //                           fontSize: 12,
//                                 //                           color: Color(0xff575757),
//                                 //                           fontWeight: FontWeight.w400,
//                                 //                         ),
//                                 //                       ),
//                                 //                       onTap: () {
//                                 //                         onSelected(option);
//                                 //                       },
//                                 //                     );
//                                 //                   },
//                                 //                 ),
//                                 //               ),
//                                 //             ),
//                                 //           );
//                                 //         },
//                                 //         fieldViewBuilder: (BuildContext context,
//                                 //             TextEditingController ctlrprimeNo,
//                                 //             FocusNode focusNode,
//                                 //             VoidCallback onFieldSubmitted) {
//                                 //           return CustomTextField(
//                                 //             width: textFieldWidth,
//                                 //             height: textFieldHeight,
//                                 //             cursorHeight: 22,
//                                 //             labelText: 'Personal Phone No',
//                                 //             labelStyle: GoogleFonts.firaSans(
//                                 //               fontSize: 12,
//                                 //               color: Color(0xff575757),
//                                 //               fontWeight: FontWeight.w400,
//                                 //             ),
//                                 //             controller: ctlrprimeNo,
//                                 //             focusNode: focusNode,
//                                 //             labelFontSize: 12,
//                                 //           );
//                                 //         },
//                                 //       );
//                                 //     } else {
//                                 //       return const Offstage();
//                                 //     }
//                                 //   },
//                                 // ),
//
//
//                                 ///address
//                                 CustomTextField(
//                                   width: textFieldWidth,
//                                   height: textFieldHeight,
//                                   cursorHeight: 22,
//                                   labelText: 'Address',
//                                   controller: ctlrAddress,
//                                 ),
//                                 ///address
//                                 // FutureBuilder<List<HRAddEmployeeGet>>(
//                                 //   future: HrAddEmployeeget(context),
//                                 //   builder: (context, snapshot) {
//                                 //     if (snapshot.connectionState ==
//                                 //         ConnectionState.waiting) {
//                                 //       return Shimmer.fromColors(
//                                 //         baseColor: Colors.grey[300]!,
//                                 //         highlightColor: Colors.grey[100]!,
//                                 //         child: Padding(
//                                 //           padding:
//                                 //               const EdgeInsets.symmetric(horizontal: 7),
//                                 //           child: Container(
//                                 //             width: AppSize.s250,
//                                 //             height: AppSize.s40,
//                                 //             decoration: BoxDecoration(
//                                 //                 color: ColorManager.faintGrey),
//                                 //           ),
//                                 //         ),
//                                 //       );
//                                 //     }
//                                 //
//                                 //     if (snapshot.hasData) {
//                                 //       List<String> address = snapshot.data!
//                                 //           .map((e) => e.address)
//                                 //           .where((address) => address != null)
//                                 //           .cast<String>()
//                                 //           .toList();
//                                 //       print("Addresses: $address");
//                                 //       return Autocomplete<String>(
//                                 //         optionsBuilder:
//                                 //             (TextEditingValue textEditingValue) {
//                                 //           if (textEditingValue.text.isEmpty) {
//                                 //             return const Iterable<String>.empty();
//                                 //           } else {
//                                 //             return address.where((String option) {
//                                 //               return option.toLowerCase().contains(
//                                 //                   textEditingValue.text.toLowerCase());
//                                 //             });
//                                 //           }
//                                 //         },
//                                 //         optionsViewBuilder: (BuildContext context,
//                                 //             AutocompleteOnSelected<String> onSelected,
//                                 //             Iterable<String> options) {
//                                 //           return Align(
//                                 //             alignment: Alignment.topLeft,
//                                 //             child: Material(
//                                 //               shape: const RoundedRectangleBorder(
//                                 //                 borderRadius: BorderRadius.vertical(
//                                 //                     bottom: Radius.circular(4.0)),
//                                 //               ),
//                                 //               child: Container(
//                                 //                 width: 300,
//                                 //                 constraints:
//                                 //                     BoxConstraints(maxHeight: 200.0),
//                                 //                 child: ListView.builder(
//                                 //                   padding: EdgeInsets.zero,
//                                 //                   itemCount: options.length,
//                                 //                   itemBuilder: (BuildContext context,
//                                 //                       int index) {
//                                 //                     final String option =
//                                 //                         options.elementAt(index);
//                                 //                     return ListTile(
//                                 //                       title: Text(
//                                 //                         option,
//                                 //                         style: GoogleFonts.firaSans(
//                                 //                           fontSize: 12,
//                                 //                           color: Color(0xff575757),
//                                 //                           fontWeight: FontWeight.w400,
//                                 //                         ),
//                                 //                       ),
//                                 //                       onTap: () {
//                                 //                         onSelected(option);
//                                 //                       },
//                                 //                     );
//                                 //                   },
//                                 //                 ),
//                                 //               ),
//                                 //             ),
//                                 //           );
//                                 //         },
//                                 //         fieldViewBuilder: (BuildContext context,
//                                 //             TextEditingController ctlraddress,
//                                 //             FocusNode focusNode,
//                                 //             VoidCallback onFieldSubmitted) {
//                                 //           return CustomTextField(
//                                 //             width: textFieldWidth,
//                                 //             height: textFieldHeight,
//                                 //             cursorHeight: 22,
//                                 //             labelText: 'Address',
//                                 //             labelStyle: GoogleFonts.firaSans(
//                                 //               fontSize: 12,
//                                 //               color: Color(0xff575757),
//                                 //               fontWeight: FontWeight.w400,
//                                 //             ),
//                                 //             controller: ctlrAddress,
//                                 //             focusNode: focusNode,
//                                 //             labelFontSize: 12,
//                                 //           );
//                                 //         },
//                                 //       );
//                                 //     } else {
//                                 //       return const Offstage();
//                                 //     }
//                                 //   },
//                                 // ),
//                               ],
//                             )),
//                         Expanded(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//
//                                 ///last name
//                                 CustomTextField(
//                                   width: textFieldWidth,
//                                   height: textFieldHeight,
//                                   cursorHeight: 20,
//                                   labelText: 'Last Name',
//                                   controller: ctlrlastName,
//                                 ),
//                                 // ///last name
//                                 // FutureBuilder<List<HRAddEmployeeGet>>(
//                                 //   future: HrAddEmployeeget(context),
//                                 //   builder: (context, snapshot) {
//                                 //     if (snapshot.connectionState ==
//                                 //         ConnectionState.waiting) {
//                                 //       return Shimmer.fromColors(
//                                 //         baseColor: Colors.grey[300]!,
//                                 //         highlightColor: Colors.grey[100]!,
//                                 //         child: Padding(
//                                 //           padding:
//                                 //               const EdgeInsets.symmetric(horizontal: 7),
//                                 //           child: Container(
//                                 //             width: AppSize.s250,
//                                 //             height: AppSize.s40,
//                                 //             decoration: BoxDecoration(
//                                 //                 color: ColorManager.faintGrey),
//                                 //           ),
//                                 //         ),
//                                 //       );
//                                 //     }
//                                 //
//                                 //     if (snapshot.hasData) {
//                                 //       List<String> lastName = snapshot.data!
//                                 //           .map((e) => e.lastName)
//                                 //           .where((name) => name != null)
//                                 //           .cast<String>()
//                                 //           .toList();
//                                 //
//                                 //       return Autocomplete<String>(
//                                 //         optionsBuilder:
//                                 //             (TextEditingValue textEditingValue) {
//                                 //           if (textEditingValue.text.isEmpty) {
//                                 //             return const Iterable<String>.empty();
//                                 //           } else {
//                                 //             return lastName.where((String option) {
//                                 //               return option.toLowerCase().contains(
//                                 //                   textEditingValue.text.toLowerCase());
//                                 //             });
//                                 //           }
//                                 //         },
//                                 //         optionsViewBuilder: (BuildContext context,
//                                 //             AutocompleteOnSelected<String> onSelected,
//                                 //             Iterable<String> options) {
//                                 //           return Align(
//                                 //             alignment: Alignment.topLeft,
//                                 //             child: Material(
//                                 //               shape: const RoundedRectangleBorder(
//                                 //                 borderRadius: BorderRadius.vertical(
//                                 //                     bottom: Radius.circular(4.0)),
//                                 //               ),
//                                 //               child: Container(
//                                 //                 width: textFieldWidth,
//                                 //                 constraints:
//                                 //                     BoxConstraints(maxHeight: 200.0),
//                                 //                 child: ListView.builder(
//                                 //                   padding: EdgeInsets.zero,
//                                 //                   itemCount: options.length,
//                                 //                   itemBuilder: (BuildContext context,
//                                 //                       int index) {
//                                 //                     final String option =
//                                 //                         options.elementAt(index);
//                                 //                     return ListTile(
//                                 //                       title: Text(
//                                 //                         option,
//                                 //                         style: GoogleFonts.firaSans(
//                                 //                           fontSize: 12,
//                                 //                           color: Color(0xff575757),
//                                 //                           fontWeight: FontWeight.w400,
//                                 //                         ),
//                                 //                       ),
//                                 //                       onTap: () {
//                                 //                         onSelected(option);
//                                 //                       },
//                                 //                     );
//                                 //                   },
//                                 //                 ),
//                                 //               ),
//                                 //             ),
//                                 //           );
//                                 //         },
//                                 //         fieldViewBuilder: (BuildContext context,
//                                 //             TextEditingController ctlrlastName,
//                                 //             FocusNode focusNode,
//                                 //             VoidCallback onFieldSubmitted) {
//                                 //           return CustomTextField(
//                                 //             width: textFieldWidth,
//                                 //             height: textFieldHeight,
//                                 //             cursorHeight: 20,
//                                 //             labelText: 'Last Name',
//                                 //             labelStyle: GoogleFonts.firaSans(
//                                 //               fontSize: 12,
//                                 //               color: Color(0xff575757),
//                                 //               fontWeight: FontWeight.w400,
//                                 //             ),
//                                 //             controller: ctlrlastName,
//                                 //             focusNode: focusNode,
//                                 //             labelFontSize: 12,
//                                 //           );
//                                 //         },
//                                 //       );
//                                 //     } else {
//                                 //       return const Offstage();
//                                 //     }
//                                 //   },
//                                 // ),
//
//                                 ///work no
//                                 CustomTextField(
//                                   width: textFieldWidth,
//                                   height: textFieldHeight,
//                                   cursorHeight: 22,
//                                   labelText: 'Work Phone No',
//                                   controller: ctlrworkNo,
//                                 ),
//                                 // /// work phone no
//                                 // FutureBuilder<List<HRAddEmployeeGet>>(
//                                 //   future: HrAddEmployeeget(context),
//                                 //   builder: (context, snapshot) {
//                                 //     if (snapshot.connectionState ==
//                                 //         ConnectionState.waiting) {
//                                 //       return Shimmer.fromColors(
//                                 //         baseColor: Colors.grey[300]!,
//                                 //         highlightColor: Colors.grey[100]!,
//                                 //         child: Padding(
//                                 //           padding:
//                                 //               const EdgeInsets.symmetric(horizontal: 7),
//                                 //           child: Container(
//                                 //             width: AppSize.s250,
//                                 //             height: AppSize.s40,
//                                 //             decoration: BoxDecoration(
//                                 //                 color: ColorManager.faintGrey),
//                                 //           ),
//                                 //         ),
//                                 //       );
//                                 //     }
//                                 //
//                                 //     if (snapshot.hasData) {
//                                 //       List<String> workNo = snapshot.data!
//                                 //           .map((e) => e.workNo)
//                                 //           .where((number) => number != null)
//                                 //           .cast<String>()
//                                 //           .toList();
//                                 //
//                                 //       print("Primary Phone Numbers: $workNo");
//                                 //
//                                 //       return Autocomplete<String>(
//                                 //         optionsBuilder:
//                                 //             (TextEditingValue textEditingValue) {
//                                 //           if (textEditingValue.text.isEmpty) {
//                                 //             return const Iterable<String>.empty();
//                                 //           } else {
//                                 //             return workNo.where((String option) {
//                                 //               return option
//                                 //                   .contains(textEditingValue.text);
//                                 //             });
//                                 //           }
//                                 //         },
//                                 //         optionsViewBuilder: (BuildContext context,
//                                 //             AutocompleteOnSelected<String> onSelected,
//                                 //             Iterable<String> options) {
//                                 //           return Align(
//                                 //             alignment: Alignment.topLeft,
//                                 //             child: Material(
//                                 //               shape: const RoundedRectangleBorder(
//                                 //                 borderRadius: BorderRadius.vertical(
//                                 //                     bottom: Radius.circular(4.0)),
//                                 //               ),
//                                 //               child: Container(
//                                 //                 width: textFieldWidth,
//                                 //                 constraints:
//                                 //                     BoxConstraints(maxHeight: 200.0),
//                                 //                 child: ListView.builder(
//                                 //                   padding: EdgeInsets.zero,
//                                 //                   itemCount: options.length,
//                                 //                   itemBuilder: (BuildContext context,
//                                 //                       int index) {
//                                 //                     final String option =
//                                 //                         options.elementAt(index);
//                                 //                     return ListTile(
//                                 //                       title: Text(
//                                 //                         option,
//                                 //                         style: GoogleFonts.firaSans(
//                                 //                           fontSize: 12,
//                                 //                           color: Color(0xff575757),
//                                 //                           fontWeight: FontWeight.w400,
//                                 //                         ),
//                                 //                       ),
//                                 //                       onTap: () {
//                                 //                         onSelected(option);
//                                 //                       },
//                                 //                     );
//                                 //                   },
//                                 //                 ),
//                                 //               ),
//                                 //             ),
//                                 //           );
//                                 //         },
//                                 //         fieldViewBuilder: (BuildContext context,
//                                 //             TextEditingController ctlrsecNo,
//                                 //             FocusNode focusNode,
//                                 //             VoidCallback onFieldSubmitted) {
//                                 //           return CustomTextField(
//                                 //             width: textFieldWidth,
//                                 //             height: textFieldHeight,
//                                 //             cursorHeight: 22,
//                                 //             labelText: 'Secondary Phone No',
//                                 //             labelStyle: GoogleFonts.firaSans(
//                                 //               fontSize: 12,
//                                 //               color: Color(0xff575757),
//                                 //               fontWeight: FontWeight.w400,
//                                 //             ),
//                                 //             controller: ctlrsecNo,
//                                 //             focusNode: focusNode,
//                                 //             labelFontSize: 12,
//                                 //           );
//                                 //         },
//                                 //       );
//                                 //     } else {
//                                 //       return const Offstage();
//                                 //     }
//                                 //   },
//                                 // ),
//
//                                 ///date
//                                 SizedBox(
//                                   width: AppSize.s250,
//                                   height: AppSize.s40,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(AppPadding.p5),
//                                     child: TextFormField(
//                                       controller: ctlrDob,
//                                       readOnly: true,
//                                       style: GoogleFonts.firaSans(
//                                         fontSize: 12,
//                                         color: Color(0xff575757),
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                       decoration: InputDecoration(
//                                         labelText: 'Date of Birth',
//                                         labelStyle: GoogleFonts.firaSans(
//                                           fontSize: 12,
//                                           color: Color(0xff575757),
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                         contentPadding: EdgeInsets.only(
//                                             bottom: 8, top: 10, left: 8),
//                                         border: OutlineInputBorder(),
//                                         focusedBorder: OutlineInputBorder(
//                                           borderSide: BorderSide(color: Colors.black),
//                                         ),
//                                         suffixIcon: IconButton(
//                                           icon: Icon(
//                                             Icons.calendar_month_outlined,
//                                             size: 13,
//                                           ),
//                                           onPressed: () async {
//                                             final selectedDate = await showDatePicker(
//                                               context: context,
//                                               initialDate: DateTime.now(),
//                                               firstDate: DateTime(1900),
//                                               lastDate: DateTime.now(),
//                                             );
//                                             if (selectedDate != null) {
//                                               setState(() {
//                                                 this.selectedDate = selectedDate;
//                                                 ctlrDob.text = DateFormat('yyyy-MM-dd')
//                                                     .format(selectedDate);
//                                               });
//                                             }
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             )),
//                         Expanded(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 ///home office
//                                 FutureBuilder<List<AEClinicalDiscipline>>(
//                                   future: HrAddEmplyClinicalDisciplinApi(context, 1),
//                                   builder: (context, snapshot) {
//                                     if (snapshot.connectionState ==
//                                         ConnectionState.waiting) {
//                                       return Shimmer.fromColors(
//                                         baseColor: Colors.grey[300]!,
//                                         highlightColor: Colors.grey[100]!,
//                                         child: Padding(
//                                           padding:
//                                           const EdgeInsets.symmetric(horizontal: 7),
//                                           child: Container(
//                                             width: AppSize.s250,
//                                             height: AppSize.s40,
//                                             decoration: BoxDecoration(
//                                                 color: ColorManager.faintGrey),
//                                           ),
//                                         ),
//                                       );
//                                     }
//                                     if (snapshot.hasData) {
//                                       List<String> dropDownList = [];
//                                       for (var i in snapshot.data!) {
//                                         dropDownList.add(i.empType!);
//                                       }
//                                       return CustomDropdownTextField(
//                                         labelText: 'Home Office',
//                                         labelStyle: GoogleFonts.firaSans(
//                                           fontSize: 12,
//                                           color: Color(0xff575757),
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                         labelFontSize: 10,
//                                         items: dropDownList,
//                                         onChanged: (newValue) {
//                                           for (var a in snapshot.data!) {
//                                             if (a.empType == newValue) {
//                                               // int docType = a.employeeTypesId;
//                                               // Do something with docType
//                                             }
//                                           }
//                                         },
//                                       );
//                                     } else {
//                                       return const Offstage();
//                                     }
//                                   },
//                                 ),
//
//                                 ///personal email
//                                 ///personal email
//                                 CustomTextField(
//                                   width: textFieldWidth,
//                                   height: textFieldHeight,
//                                   cursorHeight: 22,
//                                   labelText: 'Personal Email',
//                                   controller: ctlrPersonalEmail,
//                                 ),
//                                 // ///personal email
//                                 // FutureBuilder<List<HRAddEmployeeGet>>(
//                                 //   future: HrAddEmployeeget(context),
//                                 //   builder: (context, snapshot) {
//                                 //     if (snapshot.connectionState ==
//                                 //         ConnectionState.waiting) {
//                                 //       return Shimmer.fromColors(
//                                 //         baseColor: Colors.grey[300]!,
//                                 //         highlightColor: Colors.grey[100]!,
//                                 //         child: Padding(
//                                 //           padding:
//                                 //               const EdgeInsets.symmetric(horizontal: 7),
//                                 //           child: Container(
//                                 //             width: AppSize.s250,
//                                 //             height: AppSize.s40,
//                                 //             decoration: BoxDecoration(
//                                 //                 color: ColorManager.faintGrey),
//                                 //           ),
//                                 //         ),
//                                 //       );
//                                 //     }
//                                 //
//                                 //     if (snapshot.hasData) {
//                                 //       List<String> personalEmail = snapshot.data!
//                                 //           .map(
//                                 //             (e) => e.personalEmail,
//                                 //           )
//                                 //           .where((email) => email != null)
//                                 //           .cast<String>()
//                                 //           .toList();
//                                 //       print("Personal Emails: $personalEmail,");
//                                 //
//                                 //       return Autocomplete<String>(
//                                 //         optionsBuilder:
//                                 //             (TextEditingValue textEditingValue) {
//                                 //           if (textEditingValue.text.isEmpty) {
//                                 //             return const Iterable<String>.empty();
//                                 //           } else {
//                                 //             return personalEmail.where((String option) {
//                                 //               return option
//                                 //                   .contains(textEditingValue.text);
//                                 //             });
//                                 //           }
//                                 //         },
//                                 //         optionsViewBuilder: (BuildContext context,
//                                 //             AutocompleteOnSelected<String> onSelected,
//                                 //             Iterable<String> options) {
//                                 //           return Align(
//                                 //             alignment: Alignment.topLeft,
//                                 //             child: Material(
//                                 //               shape: const RoundedRectangleBorder(
//                                 //                 borderRadius: BorderRadius.vertical(
//                                 //                     bottom: Radius.circular(4.0)),
//                                 //               ),
//                                 //               child: Container(
//                                 //                 width: 300,
//                                 //                 constraints:
//                                 //                     BoxConstraints(maxHeight: 200.0),
//                                 //                 child: ListView.builder(
//                                 //                   padding: EdgeInsets.zero,
//                                 //                   itemCount: options.length,
//                                 //                   itemBuilder: (BuildContext context,
//                                 //                       int index) {
//                                 //                     final String option =
//                                 //                         options.elementAt(index);
//                                 //                     return ListTile(
//                                 //                       title: Text(
//                                 //                         option,
//                                 //                         style: GoogleFonts.firaSans(
//                                 //                           fontSize: 12,
//                                 //                           color: Color(0xff575757),
//                                 //                           fontWeight: FontWeight.w400,
//                                 //                         ),
//                                 //                       ),
//                                 //                       onTap: () {
//                                 //                         onSelected(option);
//                                 //                       },
//                                 //                     );
//                                 //                   },
//                                 //                 ),
//                                 //               ),
//                                 //             ),
//                                 //           );
//                                 //         },
//                                 //         fieldViewBuilder: (BuildContext context,
//                                 //             TextEditingController ctlrWorkEmail,
//                                 //             FocusNode focusNode,
//                                 //             VoidCallback onFieldSubmitted) {
//                                 //           return CustomTextField(
//                                 //             width: textFieldWidth,
//                                 //             height: textFieldHeight,
//                                 //             cursorHeight: 22,
//                                 //             labelText: 'Work Email',
//                                 //             labelStyle: GoogleFonts.firaSans(
//                                 //               fontSize: 12,
//                                 //               color: Color(0xff575757),
//                                 //               fontWeight: FontWeight.w400,
//                                 //             ),
//                                 //             controller: ctlrWorkEmail,
//                                 //             focusNode: focusNode,
//                                 //             labelFontSize: 12,
//                                 //           );
//                                 //         },
//                                 //       );
//                                 //     } else {
//                                 //       return const Offstage();
//                                 //     }
//                                 //   },
//                                 // ),
//
//                                 CustomTextField(
//                                   width: textFieldWidth,
//                                   height: textFieldHeight,
//                                   cursorHeight: 22,
//                                   labelText: 'Emergency Phone No',
//                                   controller: ctlrEmContact,
//                                 )
//                                 // ///emergancy contact no
//                                 // FutureBuilder<List<HRAddEmployeeGet>>(
//                                 //   future: HrAddEmployeeget(context),
//                                 //   builder: (context, snapshot) {
//                                 //     if (snapshot.connectionState ==
//                                 //         ConnectionState.waiting) {
//                                 //       return Shimmer.fromColors(
//                                 //         baseColor: Colors.grey[300]!,
//                                 //         highlightColor: Colors.grey[100]!,
//                                 //         child: Padding(
//                                 //           padding:
//                                 //               const EdgeInsets.symmetric(horizontal: 7),
//                                 //           child: Container(
//                                 //             width: AppSize.s250,
//                                 //             height: AppSize.s40,
//                                 //             decoration: BoxDecoration(
//                                 //                 color: ColorManager.faintGrey),
//                                 //           ),
//                                 //         ),
//                                 //       );
//                                 //     }
//                                 //
//                                 //     if (snapshot.hasData) {
//                                 //       List<String> emgContact = snapshot.data!
//                                 //           .map((e) => e.emgContact)
//                                 //           .where((number) => number != null)
//                                 //           .cast<String>()
//                                 //           .toList();
//                                 //       print("Primary Phone Numbers: $emgContact");
//                                 //       return Autocomplete<String>(
//                                 //         optionsBuilder:
//                                 //             (TextEditingValue textEditingValue) {
//                                 //           if (textEditingValue.text.isEmpty) {
//                                 //             return const Iterable<String>.empty();
//                                 //           } else {
//                                 //             return emgContact.where((String option) {
//                                 //               return option
//                                 //                   .contains(textEditingValue.text);
//                                 //             });
//                                 //           }
//                                 //         },
//                                 //         optionsViewBuilder: (BuildContext context,
//                                 //             AutocompleteOnSelected<String> onSelected,
//                                 //             Iterable<String> options) {
//                                 //           return Align(
//                                 //             alignment: Alignment.topLeft,
//                                 //             child: Material(
//                                 //               shape: const RoundedRectangleBorder(
//                                 //                 borderRadius: BorderRadius.vertical(
//                                 //                     bottom: Radius.circular(4.0)),
//                                 //               ),
//                                 //               child: Container(
//                                 //                 width:
//                                 //                     textFieldWidth, // Adjust the width as needed
//                                 //                 constraints: BoxConstraints(
//                                 //                     maxHeight:
//                                 //                         200.0), // Optional: Adjust the max height
//                                 //                 child: ListView.builder(
//                                 //                   padding: EdgeInsets.zero,
//                                 //                   itemCount: options.length,
//                                 //                   itemBuilder: (BuildContext context,
//                                 //                       int index) {
//                                 //                     final String option =
//                                 //                         options.elementAt(index);
//                                 //                     return ListTile(
//                                 //                       title: Text(
//                                 //                         option,
//                                 //                         style: GoogleFonts.firaSans(
//                                 //                           fontSize: 12,
//                                 //                           color: Color(0xff575757),
//                                 //                           fontWeight: FontWeight.w400,
//                                 //                         ),
//                                 //                       ),
//                                 //                       onTap: () {
//                                 //                         onSelected(option);
//                                 //                       },
//                                 //                     );
//                                 //                   },
//                                 //                 ),
//                                 //               ),
//                                 //             ),
//                                 //           );
//                                 //         },
//                                 //         fieldViewBuilder: (BuildContext context,
//                                 //             TextEditingController controller6,
//                                 //             FocusNode focusNode,
//                                 //             VoidCallback onFieldSubmitted) {
//                                 //           return CustomTextField(
//                                 //             width: textFieldWidth,
//                                 //             height: textFieldHeight,
//                                 //             cursorHeight: 22,
//                                 //             labelText: 'Emergency Contact No',
//                                 //             labelStyle: GoogleFonts.firaSans(
//                                 //               fontSize: 12,
//                                 //               color: Color(0xff575757),
//                                 //               fontWeight: FontWeight.w400,
//                                 //             ),
//                                 //             controller: controller6,
//                                 //             focusNode: focusNode,
//                                 //             labelFontSize: 12,
//                                 //           );
//                                 //         },
//                                 //       );
//                                 //     } else {
//                                 //       return const Offstage();
//                                 //     }
//                                 //   },
//                                 // ),
//                               ],
//                             )),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//
//               ///second container
//               Expanded(
//                 flex: 1,
//                 child: Material(
//                   elevation: 4,
//                   borderRadius: BorderRadius.circular(10),
//                   child: Container(
//                     // height: 200,
//                       width: MediaQuery
//                           .of(context)
//                           .size
//                           .width / 1,
//                       padding: EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                           width: 1,
//                           color: Color(0xffB7B7B7),
//                         ),
//                       ),
//                       child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             McqWidget(
//                               title: 'Employment',
//                               fontSize: 14,
//                               items: [
//                                 'Full Time',
//                                 'Contract',
//                                 'Part Time',
//                                 'Per Diem'
//                               ],
//                               onChanged: (selectedIndex) {
//                                 print('Selected index: $selectedIndex');
//                                 _selectedItemIndex = selectedIndex;
//                               },
//                             ),
//                             McqWidget(
//                               title: 'Gender',
//                               fontSize: 14,
//                               items: [
//                                 'Male',
//                                 'Female',
//                                 'Other',
//                               ],
//                               onChanged: (int) {},
//                             ),
//                             McqWidget(
//                               title: 'Status',
//                               fontSize: 14,
//                               items: ['Active', 'Trainee', 'Inactive'],
//                               onChanged: (int) {},
//                             ),
//                           ])),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//
//               ///add button
//               Expanded(
//                 flex: 1,
//                 child: Container(
//                   // color: Colors.pink,
//                   // height: 50,
//                   width: MediaQuery
//                       .of(context)
//                       .size
//                       .width / 1,
//                   child: Center(
//                     child: CustomButton(
//                       width: 125,
//                       height: 33,
//                       text: 'Add Employee',
//                       style: TextStyle(
//                         fontFamily: 'FiraSans',
//                         fontSize: 12,
//                         fontWeight: FontWeight.w700,
//                       ),
//                       borderRadius: 12,
//                       onPressed: () {
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return ConfirmPopup(
//                               title: 'Confirm Add Employee',
//                               onCancel: () {
//                                 Navigator.pop(context);
//                               },
//                               onConfirm: () async {
//                                 Navigator.pop(context);
//                                 await addEmployeeClinical(
//                                     context,
//                                     1,
//                                     'E0727',
//                                     728,
//                                     ctlrfirstName.text,
//                                     ctlrlastName.text,
//                                     1,
//                                     1,
//                                     'Expertise',
//                                     1,
//                                     1,
//                                     1,
//                                     1,
//                                     'SSN123',
//                                     ctlrSocialSecurity.text,
//                                     ctlrprimeNo.text,
//                                     ctlrsecNo.text,
//                                     ctlrworkNo.text,
//                                     ctlrWorkEmail.text,
//                                     ctlrPersonalEmail.text,
//                                     ctlrAddress.text,
//                                     '2024-01-01',
//                                     ctlrEmContact.text,
//                                     'Coverage',
//                                     'Employment',
//                                     'Male',
//                                     'Active',
//                                     'Service',
//                                     'imgurl.com',
//                                     'resumeurl.com',
//                                     1,
//                                     true,
//                                     true,
//                                     'Onboarding',
//                                     'DL123',
//                                     '2024-01-01',
//                                     '2024-01-01',
//                                     '2024-01-01',
//                                     'Yes',
//                                     'Position',
//                                     '123 Final St',
//                                     '2024-01-01',
//                                     1,
//                                     'Type',
//                                     'Reason',
//                                     1,
//                                     1000,
//                                     'Method',
//                                     'Material',
//                                     'Race',
//                                     'rating',
//                                     "signatureURL"
//                                 );
//                                 print("Administration Employee Added");
//                                 ctlrfirstName.clear();
//                                 ctlrPersonalEmail.clear();
//                                 ctlrsecNo.clear();
//                                 ctlrWorkEmail.clear();
//                                 ctlrEmContact.clear();
//                                 ctlrDob.clear();
//                                 ctlrprimeNo.clear();
//                                 ctlrworkNo.clear();
//                                 ctlrlastName.clear();
//                                 ctlrSocialSecurity.clear();
//                               },
//                               title2: 'Are you sure you want to add this employee?',
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       );
//
//       //
//       //       /// first container
//       //       Row(
//       //         mainAxisAlignment: MainAxisAlignment.center,
//       //         children: [
//       //           Expanded(
//       //             child: Padding(
//       //               padding: EdgeInsets.symmetric(
//       //                   horizontal: MediaQuery.of(context).size.height / 70,
//       //                   vertical: 20
//       //               ),
//       //               child: Material(
//       //                 elevation: 4,
//       //                 borderRadius: BorderRadius.circular(20),
//       //                 child: Container(
//       //                   // width: containerWidth,
//       //                   height: containerHeight1,
//       //                   decoration: BoxDecoration(
//       //                     borderRadius: BorderRadius.circular(20),
//       //                     border: Border.all(
//       //                       width: 1,
//       //                       color: Color(0xffB7B7B7),
//       //                     ),
//       //                     color: Colors.white,
//       //                   ),
//       //                   child: Column(
//       //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//       //                     // crossAxisAlignment: CrossAxisAlignment.center,
//       //                     children: [
//       //                       Row(
//       //                         children: [
//       //                           Expanded(
//       //                             flex: 1,
//       //                             child: CustomDropdownTextField(
//       //                               labelText: 'Position',
//       //                               labelStyle: TextStyle(),
//       //                               labelFontSize:
//       //                                   MediaQuery.of(context).size.width / 99,
//       //                               items: ['A', 'B', 'C', 'D'],
//       //                             ),
//       //                           ),
//       //                           Expanded(
//       //                             flex: 1,
//       //                             child: CustomTextField(
//       //                               width: textFieldWidth,
//       //                               height: textFieldHeight,
//       //                               cursorHeight: 22,
//       //                               labelText: 'First Name',
//       //                               labelStyle: TextStyle(),
//       //                               controller: _addressController,
//       //                               focusNode: FocusNode(),
//       //                               labelFontSize:
//       //                                   MediaQuery.of(context).size.width / 99,
//       //                             ),
//       //                           ),
//       //                           Expanded(
//       //                             flex: 1,
//       //                             child: CustomTextField(
//       //                               width: textFieldWidth,
//       //                               height: textFieldHeight,
//       //                               cursorHeight: 22,
//       //                               labelText: 'Last Name',
//       //                               labelStyle: TextStyle(),
//       //                               controller: _dateofbirthController,
//       //                               focusNode: FocusNode(),
//       //                               labelFontSize:
//       //                                   MediaQuery.of(context).size.width / 99,
//       //                             ),
//       //                           ),
//       //                           Expanded(
//       //                             flex: 1,
//       //                             child: CustomDropdownTextField(
//       //                               labelText: 'Home Office',
//       //                               labelStyle: TextStyle(),
//       //                               labelFontSize:
//       //                                   MediaQuery.of(context).size.width / 99,
//       //                               items: ['A', 'B', 'C', 'D'],
//       //                             ),
//       //                           ),
//       //                         ],
//       //                       ),
//       //                       Row(
//       //                         children: [
//       //                           Expanded(
//       //                             flex: 1,
//       //                             child: CustomTextField(
//       //                               width: textFieldWidth,
//       //                               height: textFieldHeight,
//       //                               cursorHeight: 22,
//       //                               labelText: 'Social Security Number',
//       //                               labelStyle: TextStyle(),
//       //                               suffixIcon: Icon(
//       //                                 Icons.remove_red_eye_sharp,
//       //                                 color: Color(0xff50B5E5),
//       //                                 size:
//       //                                     MediaQuery.of(context).size.width / 99,
//       //                               ),
//       //                               controller: _sale1Controller,
//       //                               focusNode: FocusNode(),
//       //                               labelFontSize:
//       //                                   MediaQuery.of(context).size.width / 99,
//       //                             ),
//       //                           ),
//       //                           Expanded(
//       //                             flex: 1,
//       //                             child: CustomTextField(
//       //                               width: textFieldWidth,
//       //                               height: textFieldHeight,
//       //                               cursorHeight: 22,
//       //                               labelText: 'Personal Phone Number',
//       //                               labelStyle: TextStyle(),
//       //                               controller: _firstnameController,
//       //                               focusNode: FocusNode(),
//       //                               labelFontSize:
//       //                                   MediaQuery.of(context).size.width / 99,
//       //                             ),
//       //                           ),
//       //                           Expanded(
//       //                             flex: 1,
//       //                             child: CustomDropdownTextField(
//       //                               labelText: 'Work Phone No.',
//       //                               labelStyle: TextStyle(),
//       //                               labelFontSize:
//       //                                   MediaQuery.of(context).size.width / 99,
//       //                               items: ['A', 'B', 'C', 'D'],
//       //                             ),
//       //                           ),
//       //                           Expanded(
//       //                             flex: 1,
//       //                             child: CustomTextField(
//       //                               width: textFieldWidth,
//       //                               height: textFieldHeight,
//       //                               cursorHeight: 22,
//       //                               labelText: 'Personal Email',
//       //                               labelStyle: TextStyle(),
//       //                               controller: _lastnameController,
//       //                               focusNode: FocusNode(),
//       //                               labelFontSize:
//       //                                   MediaQuery.of(context).size.width / 99,
//       //                             ),
//       //                           ),
//       //                         ],
//       //                       ),
//       //                       Row(
//       //                         children: [
//       //                           CustomTextField(
//       //                             width: textFieldWidth,
//       //                             height: textFieldHeight,
//       //                             cursorHeight: 22,
//       //                             labelText: 'Work Email',
//       //                             labelStyle: TextStyle(),
//       //                             controller: _workemailController,
//       //                             focusNode: FocusNode(),
//       //                             labelFontSize:
//       //                                 MediaQuery.of(context).size.width / 99,
//       //                           ),
//       //                           CustomTextField(
//       //                               width: textFieldWidth,
//       //                               height: textFieldHeight,
//       //                               cursorHeight: 22,
//       //                               labelText: 'Address',
//       //                               labelStyle: TextStyle(),
//       //                               controller: _personalnoController,
//       //                               focusNode: FocusNode(),
//       //                               labelFontSize:
//       //                                   MediaQuery.of(context).size.width / 99),
//       //                           CustomTextField(
//       //                             width: textFieldWidth,
//       //                             height: textFieldHeight,
//       //                             cursorHeight: 22,
//       //                             labelText: 'Date of Birth',
//       //                             labelStyle: TextStyle(),
//       //                             controller: _personalemailController,
//       //                             focusNode: FocusNode(),
//       //                             labelFontSize:
//       //                                 MediaQuery.of(context).size.width / 99,
//       //                           ),
//       //                           CustomTextField(
//       //                             width: textFieldWidth,
//       //                             height: textFieldHeight,
//       //                             cursorHeight: 22,
//       //                             labelText: 'Emergency Contact No.',
//       //                             labelStyle: TextStyle(),
//       //                             controller: _worknoController,
//       //                             focusNode: FocusNode(),
//       //                             labelFontSize:
//       //                                 MediaQuery.of(context).size.width / 99,
//       //                           ),
//       //                         ],
//       //                       ),
//       //                     ],
//       //                   ),
//       //                 ),
//       //               ),
//       //             ),
//       //           ),
//       //         ],
//       //       ),
//       //       SizedBox(height: 10),
//       //       /// second Container
//       //       Row(
//       //         mainAxisAlignment: MainAxisAlignment.center,
//       //         crossAxisAlignment: CrossAxisAlignment.center,
//       //         children: [
//       //           Expanded(
//       //             child: Padding(
//       //               padding: EdgeInsets.symmetric(
//       //                   horizontal: MediaQuery.of(context).size.height / 70),
//       //               child: Material(
//       //                 elevation: 4,
//       //                 borderRadius: BorderRadius.circular(20),
//       //                 child: Container(
//       //                   // width: containerWidth,
//       //                   height: 100,
//       //                   // containerHeight2,
//       //                   decoration: BoxDecoration(
//       //                     borderRadius: BorderRadius.circular(20),
//       //                     border: Border.all(
//       //                       width: 1,
//       //                       color: Color(0xffB7B7B7),
//       //                     ),
//       //                     color: Colors.white,
//       //                   ),
//       //                   child: Row(
//       //                     crossAxisAlignment: CrossAxisAlignment.center,
//       //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//       //                     children: [
//       //                       Padding(
//       //                         padding: const EdgeInsets.only(top: 25.0),
//       //                         child: McqWidget(
//       //                           title: 'Employment',
//       //                           items: [
//       //                             'Full Time',
//       //                             'Contract',
//       //                             'Part Time',
//       //                             'Per Diem'
//       //                           ],
//       //                           onChanged: (selectedIndex) {
//       //                             print('Selected index: $selectedIndex');
//       //                             _selectedItemIndex = selectedIndex;
//       //                           },
//       //                         ),
//       //                       ),
//       //                       Padding(
//       //                         padding: const EdgeInsets.only(top: 25.0),
//       //                         child: McqWidget(
//       //                           title: 'Gender',
//       //                           items: [
//       //                             'Male',
//       //                             'Female',
//       //                             'Other',
//       //                           ],
//       //                           onChanged: (int) {},
//       //                         ),
//       //                       ),
//       //                       Padding(
//       //                         padding: const EdgeInsets.only(top: 25.0),
//       //                         child: McqWidget(
//       //                           title: 'Status',
//       //                           items: ['Active', 'Trainee', 'Inactive'],
//       //                           onChanged: (int) {},
//       //                         ),
//       //                       ),
//       //                     ],
//       //                   ),
//       //                 ),
//       //               ),
//       //             ),
//       //           ),
//       //         ],
//       //       ),
//       //       Padding(
//       //         padding: const EdgeInsets.all(8.0),
//       //         child: Row(
//       //           mainAxisAlignment: MainAxisAlignment.center,
//       //           crossAxisAlignment: CrossAxisAlignment.center,
//       //           children: [
//       //             CustomButton(
//       //                 width: 125,
//       //                 height: 33,
//       //                 text: 'Add Employee',
//       //                 style: TextStyle(
//       //                     fontFamily: 'FiraSans',
//       //                     fontSize: 12,
//       //                     fontWeight: FontWeight.w700),
//       //                 borderRadius: 12,
//       //                 onPressed: () {})
//       //           ],
//       //         ),
//       //       ),
//       //     ]),
//       //   ),
//       // );
//     }
//   }
// // /image upload
// //   File? image;
// //   Uint8List? webImage;
// //   final _picker = ImagePicker();
// //   bool showSpinner = false;
// //   String uploadStatus = "";
// //
// //   Future<void> getImage() async {
// //     try {
// //       if (kIsWeb) {
// //         var mediaData = await ImagePickerWeb.getImageAsBytes();
// //         if (mediaData != null) {
// //           setState(() {
// //             webImage = mediaData;
// //           });
// //         } else {
// //           print("No Image Selected");
// //         }
// //       } else {
// //         final pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
// //         if (pickedFile != null) {
// //           setState(() {
// //             image = File(pickedFile.path);
// //           });
// //         } else {
// //           print("No Image Selected");
// //         }
// //       }
// //     } catch (e) {
// //       print("Error picking image: $e");
// //     }
// //   }
// //
// //   Future<void> uploadImage() async {
// //     if (image == null && webImage == null) {
// //       setState(() {
// //         uploadStatus = "No image selected!";
// //       });
// //       return;
// //     }
// //
// //     setState(() {
// //       showSpinner = true;
// //     });
// //
// //     try {
// //       Dio dio = Dio();
// //       var formData = FormData.fromMap({
// //         "employeeId": 403,
// //         "code": "code 22",
// //         "userId": 402,
// //         "firstName": "sujata",
// //         "lastName": "bhalke",
// //         "departmentId": 19,
// //         "employeeTypeId": 2,
// //         "expertise": "therapy",
// //         "cityId": 3,
// //         "countryId": 1,
// //         "zoneId": 15,
// //         "SSNNbr": "string",
// //         "primaryPhoneNbr": "9988776655",
// //         "secondryPhoneNbr": "9090909090",
// //         "workPhoneNbr": "5566778899",
// //         "regOfficId": "11",
// //         "personalEmail": "s@gmail.com",
// //         "workEmail": "sb@gmail.com",
// //         "address": "Las vegas",
// //         "dateOfBirth": "1994-05-03T07:37:48.476Z",
// //         "emergencyContact": "1122334455",
// //         "employment": "therapist",
// //         "covreage": "full coverage",
// //         "gender": "female",
// //         "status": "active",
// //         "service": "Home health",
// //         "imgurl": image,
// //         // "https://symmetry-office-document.s3.us-west-2.amazonaws.com/documents/d1beb820-6dee-4204-afed-0760cdd4263b-ladyphoto.jpg",
// //         "resumeurl": "https://symmetry-office-document.s3.us-west-2.amazonaws.com/documents/baee5e03-bf5b-4e73-befd-2d55603681bb-Menu%20Add%20Employee%20.txt",
// //         "onboardingStatus": "activee",
// //         "createdAt": "2024-07-23T04:35:18.076Z",
// //         "companyId": 5,
// //         "terminationFlag": false,
// //         "approved": true,
// //         "dateofTermination": null,
// //         "dateofResignation": null,
// //         "rehirable": null,
// //         "finalAddress": null,
// //         "type": null,
// //         "reason": null,
// //         "finalPayCheck": null,
// //         "checkDate": null,
// //         "grossPay": null,
// //         "netPay": null,
// //         "methods": null,
// //         "materials": null,
// //         "dateofHire": null,
// //         "position": null,
// //         "driverLicenceNbr": null,
// //         "race": null,
// //         "rating": null,
// //         'files': [
// //           if (kIsWeb)
// //             MultipartFile.fromBytes(webImage!, filename: 'upload.png')
// //           else
// //             await MultipartFile.fromFile(image!.path, filename: 'upload.png'),
// //         ],
// //       });
// //
// //       var response = await dio.post(
// //         'http://50.112.139.35:3000/employees/attach-photo/2',
// //         data: formData,
// //         options: Options(
// //           headers: {
// //             'Authorization': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjcsImlhdCI6MTcyMTcwNzEzOCwiZXhwIjoxNzIxNzkzNTM4fQ.u3c4AwTnB32u-iRdohzt7RZtrefcMw94W2gznKpwbeQ'
// //           },
// //         ),
// //       );
// //
// //       if (response.statusCode == 200) {
// //         setState(() {
// //           uploadStatus = "Image uploaded successfully!";
// //         });
// //       } else {
// //         setState(() {
// //           uploadStatus = "Failed to upload image: ${response.statusCode} - ${response.statusMessage}";
// //           // uploadStatus = "Failed to upload image: ${response.statusCode} - ${response.statusMessage}";
// //
// //           print(response);
// //         });
// //       }
// //     } catch (e) {
// //       setState(() {
// //         uploadStatus = "Error uploading image: $e";
// //         print('$e');
// //       });
// //     } finally {
// //       setState(() {
// //         showSpinner = false;
// //       });
// //     }
// //   }