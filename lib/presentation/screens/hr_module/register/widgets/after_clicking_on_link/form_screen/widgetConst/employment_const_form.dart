// import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
//
// class EmploymentConstForm extends StatelessWidget {
//   final VoidCallback onRemove;
//
//   const EmploymentConstForm({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 166.0, right: 166),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.remove_circle,
//                     color: Colors.red),
//                 onPressed: widget.onRemove,
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(
//                   'Upload your resume as a docx or pdf with a maximum size of 2 mb',
//                   style: GoogleFonts.firaSans(
//                     fontSize: 14.0,
//                     fontWeight: FontWeight.w500,
//                     color: Color(0xff686464),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                   width: MediaQuery.of(context).size.width / 20),
//               ElevatedButton.icon(
//                 onPressed: () async {
//                   FilePickerResult? result =
//                   await FilePicker.platform.pickFiles();
//                   if (result != null) {
//                     try {
//                       Uint8List? bytes = result.files.first.bytes;
//                       XFile xFile = await convertBytesToXFile(
//                           bytes!, result.files.first.name);
//                       finalPath = result.files.first.bytes;
//                       fileName = result.files.first.name;
//                       setState(() {
//                         _fileNames.addAll(result.files
//                             .map((file) => file.name!));
//                         _loading = false;
//                       });
//                     } catch (e) {
//                       print(e);
//                     }
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xff50B5E5),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                 ),
//                 icon: Icon(Icons.upload, color: Colors.white),
//                 label: Text(
//                   'Upload File',
//                   style: GoogleFonts.firaSans(
//                     fontSize: 14.0,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               _loading
//                   ? SizedBox(
//                 width: 25,
//                 height: 25,
//                 child: CircularProgressIndicator(
//                   color: ColorManager
//                       .blueprime, // Loader color
//                   // Loader size
//                 ),
//               )
//                   : _fileNames.isNotEmpty
//                   ? Column(
//                 crossAxisAlignment:
//                 CrossAxisAlignment.start,
//                 children: _fileNames
//                     .map((fileName) => Padding(
//                   padding:
//                   const EdgeInsets.all(8.0),
//                   child: Text(
//                     'File picked: $fileName',
//                     style: GoogleFonts.firaSans(
//                         fontSize: 12.0,
//                         fontWeight:
//                         FontWeight.w400,
//                         color:
//                         Color(0xff686464)),
//                   ),
//                 ))
//                     .toList(),
//               )
//                   : SizedBox(),
//
//               ///
//             ],
//           ),
//           SizedBox(
//               height: MediaQuery.of(context).size.height / 30),
//           Column(
//             children: [
//               Text(
//                 'Employment #0',
//                 style: GoogleFonts.firaSans(
//                     fontSize: 14.0,
//                     fontWeight: FontWeight.w700,
//                     color: Color(0xff686464)),
//               ),
//             ],
//           ),
//           SizedBox(
//               height: MediaQuery.of(context).size.height / 20),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                         height:
//                         MediaQuery.of(context).size.height /
//                             30),
//                     Text(
//                       'Final Position Title',
//                       style: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff686464)),
//                     ),
//                     SizedBox(
//                         height:
//                         MediaQuery.of(context).size.height /
//                             60),
//                     CustomTextFieldRegister(
//                       controller: newFormFinalPositionController,
//                       hintText: 'Enter Text',
//                       hintStyle: GoogleFonts.firaSans(
//                         fontSize: 10.0,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff9B9B9B),
//                       ),
//                       height: 32,
//                     ),
//                     SizedBox(
//                         height:
//                         MediaQuery.of(context).size.height /
//                             40),
//                     Text(
//                       'Start Date',
//                       style: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff686464)),
//                     ),
//                     SizedBox(
//                         height:
//                         MediaQuery.of(context).size.height /
//                             60),
//                     CustomTextFieldRegister(
//                       controller: newFormStartDateController,
//                       hintText: 'dd-mm-yyyy',
//                       hintStyle: GoogleFonts.firaSans(
//                         fontSize: 10.0,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff9B9B9B),
//                       ),
//                       height: 32,
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           Icons.calendar_month_outlined,
//                           color: Color(0xff50B5E5),
//                           size: 16,
//                         ),
//                         onPressed: () async {
//                           DateTime? pickedDate =
//                           await showDatePicker(
//                             context: context,
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime(2000),
//                             lastDate: DateTime(2101),
//                           );
//                           if (pickedDate != null) {
//                             newFormStartDateController.text =
//                             "${pickedDate.toLocal()}"
//                                 .split(' ')[0];
//                           }
//                         },
//                       ),
//                     ),
//                     SizedBox(
//                         height:
//                         MediaQuery.of(context).size.height /
//                             40),
//                     Text(
//                       'End Date',
//                       style: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff686464)),
//                     ),
//                     SizedBox(
//                         height:
//                         MediaQuery.of(context).size.height /
//                             60),
//                     CustomTextFieldRegister(
//                       controller: newFormEndDateController,
//                       hintText: 'dd-mm-yyyy',
//                       hintStyle: GoogleFonts.firaSans(
//                         fontSize: 10.0,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff9B9B9B),
//                       ),
//                       height: 32,
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           Icons.calendar_month_outlined,
//                           color: Color(0xff50B5E5),
//                           size: 16,
//                         ),
//                         onPressed: () async {
//                           DateTime? pickedDate =
//                           await showDatePicker(
//                             context: context,
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime(2000),
//                             lastDate: DateTime(2101),
//                           );
//                           if (pickedDate != null ||
//                               isChecked == true) {
//                             newFormEndDateController.text =
//                             "${pickedDate?.toLocal()}"
//                                 .split(' ')[0];
//                           }
//                         },
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Checkbox(
//                           activeColor: Color(0xff50B5E5),
//                           value: isChecked,
//                           onChanged: (bool? value) {
//                             setState(() {
//                               isChecked = value!;
//                               if (isChecked) {
//                                 newFormEndDateController.clear();
//                               }
//                             });
//                           },
//                         ),
//                         Text(
//                           'Currently work here',
//                           style: GoogleFonts.firaSans(
//                               fontSize: 10.0,
//                               fontWeight: FontWeight.w400,
//                               color: Color(0xff686464)),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                         height:
//                         MediaQuery.of(context).size.height /
//                             40),
//                     Text(
//                       'Employer',
//                       style: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff686464)),
//                     ),
//                     SizedBox(
//                         height:
//                         MediaQuery.of(context).size.height /
//                             60),
//                     CustomTextFieldRegister(
//                       controller: newFormEmployerController,
//                       hintText: 'Enter Text',
//                       hintStyle: GoogleFonts.firaSans(
//                         fontSize: 10.0,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff9B9B9B),
//                       ),
//                       height: 32,
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                   width: MediaQuery.of(context).size.width / 20),
//               Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                           height: MediaQuery.of(context).size.height /
//                               40),
//                       Text(
//                         'Reason for Leaving',
//                         style: GoogleFonts.firaSans(
//                             fontSize: 10.0,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xff686464)),
//                       ),
//                       SizedBox(
//                           height: MediaQuery.of(context).size.height /
//                               60),
//                       CustomTextFieldRegister(
//                         controller: newFormReasonForLeavingController,
//                         hintText: 'Enter Text',
//                         hintStyle: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff9B9B9B),
//                         ),
//                         height: 32,
//                       ),
//                       SizedBox(
//                           height: MediaQuery.of(context).size.height /
//                               40),
//                       Text(
//                         'Last Supervisor’s Name',
//                         style: GoogleFonts.firaSans(
//                             fontSize: 10.0,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xff686464)),
//                       ),
//                       SizedBox(
//                           height: MediaQuery.of(context).size.height /
//                               60),
//                       CustomTextFieldRegister(
//                         controller: newFormSupervisorNameController,
//                         hintText: 'Enter Text',
//                         hintStyle: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff9B9B9B),
//                         ),
//                         height: 32,
//                       ),
//                       SizedBox(
//                           height: MediaQuery.of(context).size.height /
//                               40),
//                       Text(
//                         'Supervisor’s Mobile Number',
//                         style: GoogleFonts.firaSans(
//                             fontSize: 10.0,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xff686464)),
//                       ),
//                       SizedBox(
//                           height: MediaQuery.of(context).size.height /
//                               60),
//                       CustomTextFieldRegister(
//                         controller: newFormSupervisorMobileNumberController,
//                         hintText: 'Enter Text',
//                         hintStyle: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff9B9B9B),
//                         ),
//                         height: 32,
//                       ),
//                       SizedBox(
//                           height: MediaQuery.of(context).size.height /
//                               40),
//                       Text(
//                         'City',
//                         style: GoogleFonts.firaSans(
//                             fontSize: 10.0,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xff686464)),
//                       ),
//                       SizedBox(
//                           height: MediaQuery.of(context).size.height /
//                               60),
//                       CustomTextFieldRegister(
//                         controller: newFormCityController,
//                         hintText: 'Enter Text',
//                         hintStyle: GoogleFonts.firaSans(
//                           fontSize: 10.0,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff9B9B9B),
//                         ),
//                         height: 32,
//                       ),
//                     ],
//                   )),
//             ],
//           ),
//           SizedBox(
//               height: MediaQuery.of(context).size.height / 20),
//           const Divider(
//             color: Colors.grey,
//             thickness: 2,
//           )
//         ],
//       ),
//     );
//   }
// }
