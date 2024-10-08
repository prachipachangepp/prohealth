// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../../../em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
// import '../../taxtfield_constant.dart';
// //
// // class ReferencesIndicator extends StatelessWidget {
// //   const ReferencesIndicator({
// //     super.key,
// //     required this.context,
// //   });
// //
// //   final BuildContext context;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       child: Padding(
// //         padding: const EdgeInsets.all(8.0),
// //         child: Column(children: [
// //           Center(
// //             child: Text(
// //               'References',
// //               style: GoogleFonts.firaSans(
// //                   fontSize: 18,
// //                   fontWeight: FontWeight.w700,
// //                   color: Color(0xff50B5E5)),
// //             ),
// //           ),
// //           SizedBox(height: MediaQuery.of(context).size.height / 60),
// //           Container(
// //             padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
// //             decoration: BoxDecoration(
// //               color: Color(0xFFE6F7FF),
// //               borderRadius: BorderRadius.circular(12),
// //             ),
// //             child: Expanded(
// //               child: Text(
// //                 'Please provide the names and contact information of three professional references who can speak to your work experience and qualifications. For each reference, Kindly include the following information:',
// //                 style: GoogleFonts.firaSans(
// //                   color: Color(0xFF686464),
// //                   fontSize: 12,
// //                   fontWeight: FontWeight.w500,
// //                 ),
// //               ),
// //             ),
// //           ),
// //           SizedBox(height: MediaQuery.of(context).size.height / 20),
// //           Padding(
// //             padding: const EdgeInsets.only(left: 166.0, right: 166),
// //             child: Column(
// //               children: [
// //                 Row(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       'Employment #1',
// //                       style: GoogleFonts.firaSans(
// //                           fontSize: 14.0,
// //                           fontWeight: FontWeight.w700,
// //                           color: Color(0xff686464)),
// //                     ),
// //                   ],
// //                 ),
// //                 SizedBox(height: MediaQuery.of(context).size.height / 20),
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.start,
// //                   children: [
// //                     Expanded(
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Text(
// //                             'Name',
// //                             style: GoogleFonts.firaSans(
// //                                 fontSize: 10.0,
// //                                 fontWeight: FontWeight.w400,
// //                                 color: Color(0xff686464)),
// //                           ),
// //                           SizedBox(
// //                               height: MediaQuery.of(context).size.height /
// //                                   60),
// //                           CustomTextFieldRegister(
// //                             hintText: 'Enter Text',
// //                             hintStyle: GoogleFonts.firaSans(
// //                               fontSize: 10.0,
// //                               fontWeight: FontWeight.w400,
// //                               color: Color(0xff9B9B9B),
// //                             ),
// //                             height: 32,
// //                           ),
// //                           Text(
// //                             'Title/Position',
// //                             style: GoogleFonts.firaSans(
// //                                 fontSize: 10.0,
// //                                 fontWeight: FontWeight.w400,
// //                                 color: Color(0xff686464)),
// //                           ),
// //                           SizedBox(
// //                               height: MediaQuery.of(context).size.height /
// //                                   60),
// //                           CustomTextFieldRegister(
// //                             hintText: 'Enter Text',
// //                             hintStyle: GoogleFonts.firaSans(
// //                               fontSize: 10.0,
// //                               fontWeight: FontWeight.w400,
// //                               color: Color(0xff9B9B9B),
// //                             ),
// //                             height: 32,
// //                           ),
// //                           Text(
// //                             'Company/ Organization',
// //                             style: GoogleFonts.firaSans(
// //                                 fontSize: 10.0,
// //                                 fontWeight: FontWeight.w400,
// //                                 color: Color(0xff686464)),
// //                           ),
// //                           SizedBox(
// //                               height: MediaQuery.of(context).size.height /
// //                                   60),
// //                           CustomTextFieldRegister(
// //                             hintText: 'Enter Text',
// //                             hintStyle: GoogleFonts.firaSans(
// //                               fontSize: 10.0,
// //                               fontWeight: FontWeight.w400,
// //                               color: Color(0xff9B9B9B),
// //                             ),
// //                             height: 32,
// //                           ),
// //                           Text(
// //                             'Mobile Number',
// //                             style: GoogleFonts.firaSans(
// //                                 fontSize: 10.0,
// //                                 fontWeight: FontWeight.w400,
// //                                 color: Color(0xff686464)),
// //                           ),
// //                           SizedBox(
// //                               height: MediaQuery.of(context).size.height /
// //                                   60),
// //                           CustomTextFieldRegister(
// //                             hintText: 'Enter Text',
// //                             hintStyle: GoogleFonts.firaSans(
// //                               fontSize: 10.0,
// //                               fontWeight: FontWeight.w400,
// //                               color: Color(0xff9B9B9B),
// //                             ),
// //                             height: 32,
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                     SizedBox(
// //                         width: MediaQuery.of(context).size.width / 20),
// //                     Expanded(
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Text(
// //                             'Email',
// //                             style: GoogleFonts.firaSans(
// //                                 fontSize: 10.0,
// //                                 fontWeight: FontWeight.w400,
// //                                 color: Color(0xff686464)),
// //                           ),
// //                           SizedBox(
// //                               height: MediaQuery.of(context).size.height /
// //                                   60),
// //                           CustomTextFieldRegister(
// //                             hintText: 'Enter Text',
// //                             hintStyle: GoogleFonts.firaSans(
// //                               fontSize: 10.0,
// //                               fontWeight: FontWeight.w400,
// //                               color: Color(0xff9B9B9B),
// //                             ),
// //                             height: 32,
// //                           ),
// //                           Text(
// //                             'How do you know this person ?',
// //                             style: GoogleFonts.firaSans(
// //                                 fontSize: 10.0,
// //                                 fontWeight: FontWeight.w400,
// //                                 color: Color(0xff686464)),
// //                           ),
// //                           SizedBox(
// //                               height: MediaQuery.of(context).size.height /
// //                                   60),
// //                           CustomTextFieldRegister(
// //                             hintText: 'Enter Text',
// //                             hintStyle: GoogleFonts.firaSans(
// //                               fontSize: 10.0,
// //                               fontWeight: FontWeight.w400,
// //                               color: Color(0xff9B9B9B),
// //                             ),
// //                             height: 32,
// //                           ),
// //                           Text(
// //                             'Length of Association',
// //                             style: GoogleFonts.firaSans(
// //                                 fontSize: 10.0,
// //                                 fontWeight: FontWeight.w400,
// //                                 color: Color(0xff686464)),
// //                           ),
// //                           SizedBox(
// //                               height: MediaQuery.of(context).size.height /
// //                                   60),
// //                           CustomTextFieldRegister(
// //                             //controller:,
// //                             hintText: 'Enter Text',
// //                             hintStyle: GoogleFonts.firaSans(
// //                               fontSize: 10.0,
// //                               fontWeight: FontWeight.w400,
// //                               color: Color(0xff9B9B9B),
// //                             ),
// //                             height: 32,
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 SizedBox(height: MediaQuery.of(context).size.height / 20),
// //                 Row(
// //                   children: [
// //                     Expanded(
// //                       child: Text(
// //                         "Please ensure that the references you provide are professional contacts who can provide insight into your skills, work ethic, and character ",
// //                         style: GoogleFonts.firaSans(
// //                           fontSize: 14.0,
// //                           fontWeight: FontWeight.w500,
// //                           color: Color(0xff686464),
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 SizedBox(height: MediaQuery.of(context).size.height / 20),
// //                 // Row(
// //                 //   mainAxisAlignment: MainAxisAlignment.start,
// //                 //   children: [
// //                 //     ElevatedButton.icon(
// //                 //       onPressed: () {
// //                 //         // Handle add education action
// //                 //       },
// //                 //       style: ElevatedButton.styleFrom(
// //                 //         backgroundColor: Color(0xff50B5E5),
// //                 //         // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
// //                 //         shape: RoundedRectangleBorder(
// //                 //           borderRadius: BorderRadius.circular(8.0),
// //                 //         ),
// //                 //       ),
// //                 //       icon: Icon(Icons.add, color: Colors.white),
// //                 //       label: Text(
// //                 //         'Add Education',
// //                         style: GoogleFonts.firaSans(
// //                           fontSize: 14.0,
// //                           fontWeight: FontWeight.w700,
// //                           color: Colors.white,
// //                         ),
// //                 //       ),
// //                 //     ),
// //                 //   ],
// //                 // ),
// //               ],
// //             ),
// //           ),
// //         ]),
// //       ),
// //     );
// //   }
// // }
// //
// //
// //
// //
// //
// // // import 'package:flutter/widgets.dart';
// // // import 'package:google_fonts/google_fonts.dart';
// // //
// // // import '../../../manage/widgets/bottom_row.dart';
// // // import '../../../manage/widgets/top_row.dart';
// // // import 'multi_step_form.dart';
// // //
// // // class FormScreenView extends StatelessWidget {
// // //   const FormScreenView({Key? key}) : super(key: key);
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: Colors.white,
// // //       appBar: PreferredSize(
// // //         preferredSize: Size.fromHeight(kToolbarHeight),
// // //         child: TopRowConstant(),
// // //       ),
// // //       body: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.stretch,
// // //         children: [
// // //           Padding(
// // //             padding: const EdgeInsets.all(16.0),
// // //             child: Text(
// // //               'Details',
// // //               textAlign: TextAlign.center,
// // //               style: GoogleFonts.firaSans(
// // //                 fontWeight: FontWeight.w700,
// // //                 fontSize: 18,
// // //                 color: Color(0xff50B5E5),
// // //               ),
// // //             ),
// // //           ),
// // //           Flexible(
// // //             child: LayoutBuilder(
// // //               builder: (context, constraints) {
// // //                 return SingleChildScrollView(
// // //                   // physics: AlwaysScrollableScrollPhysics(),
// // //                   child: Padding(
// // //                     padding: const EdgeInsets.all(16.0),
// // //                     child: Column(
// // //                       crossAxisAlignment: CrossAxisAlignment.stretch,
// // //                       children: [
// // //                         SingleChildScrollView(child: MultiStepForm()),
// // //                         // Add other form elements or widgets here
// // //                       ],
// // //                     ),
// // //                   ),
// // //                 );
// // //               },
// // //             ),
// // //           ),
// // //           const Row(
// // //             children: [BottomBarRow()],
// // //           )
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }
// Future<Padding> paddingG() async => Padding(
//     padding:
//     const EdgeInsets.only(left: 140, right: 140, top: 20),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 height: AppSize.s5,
//               ),
//               Text(
//                 "Upload Photo",
//                 style: GoogleFonts.firaSans(
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff686464)),
//               ),
//               SizedBox(
//                   height:
//                   MediaQuery.of(context).size.height / 60),
//               ElevatedButton.icon(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xff1696C8),
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 onPressed: () async {
//                   FilePickerResult? result =
//                   await FilePicker.platform.pickFiles(
//                     allowMultiple: false,
//                   );
//                   if (result != null) {
//                     PlatformFile file = result.files.first;
//                     print('File picked: ${file.name}');
//                   } else {
//                     // User canceled the picker
//                   }
//                 },
//                 label: Text(
//                   "Choose File",
//                   style: GoogleFonts.firaSans(
//                     fontSize: 14.0,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.white,
//                   ),
//                 ),
//                 icon: const Icon(Icons.file_upload_outlined),
//               ),
//               SizedBox(
//                   height:
//                   MediaQuery.of(context).size.height / 30),
//               Text(
//                 'Legal First Name',
//                 style: GoogleFonts.firaSans(
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff686464)),
//               ),
//               SizedBox(
//                   height:
//                   MediaQuery.of(context).size.height / 60),
//               CustomTextFieldRegister(
//                 hintText: 'Enter Text',
//                 hintStyle: GoogleFonts.firaSans(
//                   fontSize: 10.0,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xff9B9B9B),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter some text';
//                   }
//                   return null;
//                 },
//                 height: 32,
//               ),
//               SizedBox(
//                   height:
//                   MediaQuery.of(context).size.height / 30),
//               Text(
//                 'Legal Last Name',
//                 style: GoogleFonts.firaSans(
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff686464)),
//               ),
//               SizedBox(
//                   height:
//                   MediaQuery.of(context).size.height / 60),
//               CustomTextFieldRegister(
//                 hintText: 'Enter Text',
//                 hintStyle: GoogleFonts.firaSans(
//                   fontSize: 10.0,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xff9B9B9B),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter some text';
//                   }
//                   return null;
//                 },
//                 height: 32,
//               ),
//               SizedBox(
//                   height:
//                   MediaQuery.of(context).size.height / 30),
//               Text(
//                 'Social Security Number',
//                 style: GoogleFonts.firaSans(
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff686464)),
//               ),
//               SizedBox(
//                   height:
//                   MediaQuery.of(context).size.height / 60),
//               CustomTextFieldRegister(
//                 hintText: 'Enter Text',
//                 obscureText: !_passwordVisible,
//                 hintStyle: GoogleFonts.firaSans(
//                   fontSize: 10.0,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xff9B9B9B),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter some text';
//                   }
//                   return null;
//                 },
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                     color: Color(0xff50B5E5),
//                     size: 16,
//                     // Based on passwordVisible state choose the icon
//                     _passwordVisible
//                         ? Icons.visibility
//                         : Icons.visibility_off,
//                     //color: Theme.of(context).primaryColorDark,
//                   ),
//                   onPressed: () {
//                     // Update the state i.e. toogle the state of passwordVisible variable
//                     setState(() {
//                       _passwordVisible = !_passwordVisible;
//                     });
//                   },
//                 ),
//                 height: 32,
//               ),
//               SizedBox(
//                   height:
//                   MediaQuery.of(context).size.height / 30),
//               Text(
//                 'Personal Mobile Number',
//                 style: GoogleFonts.firaSans(
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff686464)),
//               ),
//               SizedBox(
//                   height:
//                   MediaQuery.of(context).size.height / 60),
//               CustomTextFieldRegister(
//                 hintText: 'Enter Text',
//                 hintStyle: GoogleFonts.firaSans(
//                   fontSize: 10.0,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xff9B9B9B),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter some text';
//                   }
//                   return null;
//                 },
//                 height: 32,
//               ),
//               SizedBox(
//                   height:
//                   MediaQuery.of(context).size.height / 30),
//               Text(
//                 'Personal Email',
//                 style: GoogleFonts.firaSans(
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff686464)),
//               ),
//               SizedBox(
//                   height:
//                   MediaQuery.of(context).size.height / 60),
//               CustomTextFieldRegister(
//                 hintText: 'Enter Text',
//                 hintStyle: GoogleFonts.firaSans(
//                   fontSize: 10.0,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xff9B9B9B),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter some text';
//                   }
//                   return null;
//                 },
//                 height: 32,
//               ),
//               SizedBox(
//                   height:
//                   MediaQuery.of(context).size.height / 30),
//               Text(
//                 'Driver’s License Number',
//                 style: GoogleFonts.firaSans(
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff686464)),
//               ),
//               SizedBox(
//                   height:
//                   MediaQuery.of(context).size.height / 60),
//               CustomTextFieldRegister(
//                 hintText: 'Enter Text',
//                 hintStyle: GoogleFonts.firaSans(
//                   fontSize: 10.0,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xff9B9B9B),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter some text';
//                   }
//                   return null;
//                 },
//                 height: 32,
//               ),
//             ],
//           ),
//         ),
//         SizedBox(width: MediaQuery.of(context).size.width / 15),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Gender",
//                 style: GoogleFonts.firaSans(
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff686464)),
//               ),
//               Container(
//                 width: 400,
//                 child: Row(
//                   children: [
//                     Expanded(
//                         child: CustomRadioListTile(
//                           title: 'Male',
//                           value: 'male',
//                           groupValue: _selectedType,
//                           onChanged: (value) {
//                             setState(() {
//                               _selectedType = value;
//                             });
//                           },
//                         )),
//                     Expanded(
//                         child: CustomRadioListTile(
//                           title: 'Female',
//                           value: 'Female',
//                           groupValue: _selectedType,
//                           onChanged: (value) {
//                             setState(() {
//                               _selectedType = value;
//                             });
//                           },
//                         )),
//                     Expanded(
//                         child: CustomRadioListTile(
//                           title: 'Other',
//                           value: 'Other',
//                           groupValue: _selectedType,
//                           onChanged: (value) {
//                             setState(() {
//                               _selectedType = value;
//                             });
//                           },
//                         )),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                   height:
//                   MediaQuery.of(context).size.height / 30),
//               Text(
//                 'DOB',
//                 style: GoogleFonts.firaSans(
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff686464)),
//               ),
//               SizedBox(
//                   height:
//                   MediaQuery.of(context).size.height / 60),
//               CustomTextFieldRegister(
//                 controller: _controller,
//                 hintText: 'dd-mm-yyyy',
//                 hintStyle: GoogleFonts.firaSans(
//                   fontSize: 10.0,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xff9B9B9B),
//                 ),
//                 height: 32,
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                     Icons.calendar_month_outlined,
//                     color: Color(0xff50B5E5),
//                     size: 16,
//                   ),
//                   onPressed: () async {
//                     DateTime? pickedDate = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(2000),
//                       lastDate: DateTime(2101),
//                     );
//                     if (pickedDate != null) {
//                       _controller.text =
//                       "${pickedDate.toLocal()}"
//                           .split(' ')[0];
//                     }
//                   },
//                 ),
//               ),
//               SizedBox(
//                   height:
//                   MediaQuery.of(context).size.height / 30),
//               Text(
//                 'Address',
//                 style: GoogleFonts.firaSans(
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff686464)),
//               ),
//               SizedBox(
//                   height:
//                   MediaQuery.of(context).size.height / 60),
//               CustomTextFieldRegister(
//                 hintText: 'Enter Text',
//                 hintStyle: GoogleFonts.firaSans(
//                   fontSize: 10.0,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xff9B9B9B),
//                 ),
//                 height: 32,
//               ),
//               SizedBox(
//                   height:
//                   MediaQuery.of(context).size.height / 60),
//               Text(
//                 "Race",
//                 style: GoogleFonts.firaSans(
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff686464)),
//               ),
//               Container(
//                 //width: 550,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: CustomRadioListTile(
//                         title: 'Asian',
//                         value: 'Asian',
//                         groupValue: _selectedType,
//                         onChanged: (value) {
//                           setState(() {
//                             _selectedType = value;
//                           });
//                         },
//                       ),
//                     ),
//                     Expanded(
//                       child: CustomRadioListTile(
//                         title: 'White',
//                         value: 'White',
//                         groupValue: _selectedType,
//                         onChanged: (value) {
//                           setState(() {
//                             _selectedType = value;
//                           });
//                         },
//                       ),
//                     ),
//                     Expanded(
//                       child: CustomRadioListTile(
//                         title: 'Hispanic or Latino',
//                         value: 'Hispanic or Latino',
//                         groupValue: _selectedType,
//                         onChanged: (value) {
//                           setState(() {
//                             _selectedType = value;
//                           });
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: CustomRadioListTile(
//                       title: 'Black or African American',
//                       value: 'Black or African American',
//                       groupValue: _selectedType,
//                       onChanged: (value) {
//                         setState(() {
//                           _selectedType = value;
//                         });
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: CustomRadioListTile(
//                       title: 'Other',
//                       value: 'Other',
//                       groupValue: _selectedType,
//                       onChanged: (value) {
//                         setState(() {
//                           _selectedType = value;
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                   height:
//                   MediaQuery.of(context).size.height / 30),
//               Text(
//                 'Type of Clinician',
//                 style: GoogleFonts.firaSans(
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff686464)),
//               ),
//               SizedBox(
//                   height:
//                   MediaQuery.of(context).size.height / 60),
//               Container(
//                 height: 32,
//                 child: DropdownButtonFormField<String>(
//                   decoration: InputDecoration(
//                     hintText: 'Select Clinician',
//                     hintStyle: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff9B9B9B),
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(4.0),
//                       borderSide:
//                       BorderSide(color: Colors.grey),
//                     ),
//                     contentPadding: EdgeInsets.symmetric(
//                         vertical: 10, horizontal: 10),
//                   ),
//                   value: _selectedClinician,
//                   icon: Icon(Icons.arrow_drop_down,
//                       color: Color(0xff9B9B9B)),
//                   iconSize: 24,
//                   elevation: 16,
//                   style: GoogleFonts.firaSans(
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff686464),
//                   ),
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       _selectedClinician = newValue;
//                     });
//                   },
//                   items: <String>[
//                     'Clinician 1',
//                     'Clinicin ',
//                     'Clinican',
//                     'Cliniian'
//                   ] // List of countries
//                       .map<DropdownMenuItem<String>>(
//                           (String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                 ),
//               ),
//               SizedBox(
//                   height:
//                   MediaQuery.of(context).size.height / 30),
//               Text(
//                 'Speciality',
//                 style: GoogleFonts.firaSans(
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff686464)),
//               ),
//               SizedBox(
//                   height:
//                   MediaQuery.of(context).size.height / 60),
//               Container(
//                 height: 32,
//                 child: DropdownButtonFormField<String>(
//                   decoration: InputDecoration(
//                     hintText: 'Select Speciality',
//                     hintStyle: GoogleFonts.firaSans(
//                       fontSize: 10.0,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff9B9B9B),
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(4.0),
//                       borderSide:
//                       BorderSide(color: Colors.grey),
//                     ),
//                     contentPadding: EdgeInsets.symmetric(
//                         vertical: 10, horizontal: 10),
//                   ),
//                   value: _selectedSpeciality,
//                   icon: Icon(Icons.arrow_drop_down,
//                       color: Color(0xff9B9B9B)),
//                   iconSize: 24,
//                   elevation: 16,
//                   style: GoogleFonts.firaSans(
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff686464),
//                   ),
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       _selectedSpeciality = newValue;
//                     });
//                   },
//                   items: <String>[
//                     'Speciality1',
//                     'Speciality2',
//                     'CSpeciality',
//                     'Speciality'
//                   ] // List of countries
//                       .map<DropdownMenuItem<String>>(
//                           (String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );