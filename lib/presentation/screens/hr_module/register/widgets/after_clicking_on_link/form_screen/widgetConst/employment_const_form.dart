// import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:prohealth/presentation/screens/hr_module/register/taxtfield_constant.dart';
//
// class EmploymentConstForm extends StatelessWidget {
//   final VoidCallback onRemove;
//   final TextEditingController finalPositionController;
//   final TextEditingController startDateController;
//   final TextEditingController endDateController;
//   final TextEditingController employerController;
//   final TextEditingController reasonForLeavingController;
//   final TextEditingController supervisorNameController;
//   final TextEditingController supervisorMobileNumberController;
//   final TextEditingController cityController;
//   final bool isChecked;
//   final bool loading;
//   final List<String> fileNames;
//   final Future<XFile> Function(Uint8List bytes, String name) convertBytesToXFile;
//   final void Function(Uint8List? bytes) setFilePath;
//   final void Function(String name) setFileName;
//
//   const EmploymentConstForm({
//     super.key,
//     required this.onRemove,
//     required this.finalPositionController,
//     required this.startDateController,
//     required this.endDateController,
//     required this.employerController,
//     required this.reasonForLeavingController,
//     required this.supervisorNameController,
//     required this.supervisorMobileNumberController,
//     required this.cityController,
//     required this.isChecked,
//     required this.loading,
//     required this.fileNames,
//     required this.convertBytesToXFile,
//     required this.setFilePath,
//     required this.setFileName,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 166.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//           Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             IconButton(
//               icon: const Icon(Icons.remove_circle, color: Colors.red),
//               onPressed: onRemove,
//             ),
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: Text(
//                 'Upload your resume as a docx or pdf with a maximum size of 2 mb',
//                 style: GoogleFonts.firaSans(
//                   fontSize: 14.0,
//                   fontWeight: FontWeight.w500,
//                   color: Color(0xff686464),
//                 ),
//               ),
//             ),
//             SizedBox(width: MediaQuery.of(context).size.width / 20),
//             ElevatedButton.icon(
//               onPressed: () async {
//                 FilePickerResult? result = await FilePicker.platform.pickFiles();
//                 if (result != null) {
//                   try {
//                     Uint8List? bytes = result.files.first.bytes;
//                     XFile xFile = await convertBytesToXFile(bytes!, result.files.first.name);
//                     setFilePath(bytes);
//                     setFileName(result.files.first.name);
//                     // Assume _fileNames is managed outside
//                     // Update state with the new file names if needed
//                   } catch (e) {
//                     print(e);
//                   }
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xff50B5E5),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//               ),
//               icon: Icon(Icons.upload, color: Colors.white),
//               label: Text(
//                 'Upload File',
//                 style: GoogleFonts.firaSans(
//                   fontSize: 14.0,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             loading
//                 ? SizedBox(
//               width: 25.0,
//               height: 25.0,
//               child: CircularProgressIndicator(
//                 color: Color(0xff50B5E5), // Replace with appropriate color
//               ),
//             )
//                 : fileNames.isNotEmpty
//                 ? Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: fileNames.map((fileName) => Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   'File picked: $fileName',
//                   style: GoogleFonts.firaSans(
//                     fontSize: 12.0,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff686464),
//                   ),
//                 ),
//               )).toList(),
//             )
//                 : SizedBox(),
//           ],
//         ),
//         SizedBox(height: MediaQuery.of(context).size.height / 30),
//         Column(
//           children: [
//             Text(
//               'Employment #0',
//               style: GoogleFonts.firaSans(
//                 fontSize: 14.0,
//                 fontWeight: FontWeight.w700,
//                 color: Color(0xff686464),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: MediaQuery.of(context).size.height / 20),
//         Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//         Expanded(
//         child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//         SizedBox(height: MediaQuery.of(context).size.height / 30),
//     Text(
//     'Final Position Title',
//     style: GoogleFonts.firaSans(
//     fontSize: 10.0,
//     fontWeight: FontWeight.w400,
//     color: Color(0xff686464),
//     ),
//     ),
//     SizedBox(height: MediaQuery.of(context).size.height / 60),
//     CustomTextFieldRegister(
//     controller: finalPositionController,
//     hintText: 'Enter Text',
//     hintStyle: GoogleFonts.firaSans(
//     fontSize: 10.0,
//     fontWeight: FontWeight.w400,
//     color: Color(0xff9B9B9B),
//     ),
//     height: 32.0,
//     ),
//     SizedBox(height: MediaQuery.of(context).size.height / 40),
//     Text(
//     'Start Date',
//     style: GoogleFonts.firaSans(
//     fontSize: 10.0,
//     fontWeight: FontWeight.w400,
//     color: Color(0xff686464),
//     ),
//     ),
//     SizedBox(height: MediaQuery.of(context).size.height / 60),
//     CustomTextFieldRegister(
//     controller: startDateController,
//     hintText: 'dd-mm-yyyy',
//     hintStyle: GoogleFonts.firaSans(
//     fontSize: 10.0,
//     fontWeight: FontWeight.w400,
//     color: Color(0xff9B9B9B),
//     ),
//     height: 32.0,
//     suffixIcon: IconButton(
//     icon: Icon(
//     Icons.calendar_month_outlined,
//     color: Color(0xff50B5E5),
//     size: 16,
//     ),
//     onPressed: () async {
//     DateTime? pickedDate = await showDatePicker(
//     context: context,
//     initialDate: DateTime.now(),
//     firstDate: DateTime(2000),
//     lastDate: DateTime(2101),
//     );
//     if (pickedDate != null) {
//     startDateController.text = "${pickedDate.toLocal()}".split(' ')[0];
//     }
//     },
//     ),
//     ),
//     SizedBox(height: MediaQuery.of(context).size.height / 40),
//     Text(
//     'End Date',
//     style: GoogleFonts.firaSans(
//     fontSize: 10.0,
//     fontWeight: FontWeight.w400,
//     color: Color(0xff686464),
//     ),
//     ),
//     SizedBox(height: MediaQuery.of(context).size.height / 60),
//     CustomTextFieldRegister(
//     controller: endDateController,
//     hintText: 'dd-mm-yyyy',
//     hintStyle: GoogleFonts.firaSans(
//     fontSize: 10.0,
//     fontWeight: FontWeight.w400,
//     color: Color(0xff9B9B9B),
//     ),
//     height: 32.0,
//     suffixIcon: IconButton(
//     icon: Icon(
//     Icons.calendar_month_outlined,
//     color: Color(0xff50B5E5),
//     size: 16,
//     ),
//     onPressed: () async {
//     DateTime? pickedDate = await showDatePicker(
//     context: context,
//     initialDate: DateTime.now(),
//     firstDate: DateTime(2000),
//     lastDate: DateTime(2101),
//     );
//     if (pickedDate != null || isChecked) {
//     endDateController.text = "${pickedDate?.toLocal()}".split(' ')[0];
//     }
//     },
//     ),
//     ),
//     Row(
//     children: [
//     Checkbox(
//     activeColor: Color(0xff50B5E5),
//     value: isChecked,
//     onChanged: (bool? value) {
//     // Use a callback to handle the checkbox state change
//     // e.g., handleCheckboxChange(value);
//     },
//     ),
//     Text(
//     'Currently work here',
//     style: GoogleFonts.firaSans(
//     fontSize: 10.0,
//     fontWeight: FontWeight.w400,
//     color: Color(0xff686464),
//     ),
//     ),
//     ],
//     ),
//     SizedBox(height: MediaQuery.of(context).size.height / 40),
//     Text(
//     'Employer',
//     style: GoogleFonts.firaSans(
//     fontSize: 10.0,
//     fontWeight: FontWeight.w400,
//     color: Color(0xff686464),
//     ),
//     ),
//     SizedBox(height: MediaQuery.of(context).size.height / 60),
//     CustomTextFieldRegister(
//     controller: employerController,
//     hintText: 'Enter Text',
//       hintStyle: GoogleFonts.firaSans(
//       fontSize: 10.0,
//       fontWeight: FontWeight.w400,
//       color: Color(0xff9B9B9B),
//     ),
//       height: 32.0,
//     ),
//               SizedBox(height: MediaQuery.of(context).size.height / 40),
//               Text(
//                 'Reason for Leaving',
//                 style: GoogleFonts.firaSans(
//                   fontSize: 10.0,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xff686464),
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 60),
//               CustomTextFieldRegister(
//                 controller: reasonForLeavingController,
//                 hintText: 'Enter Text',
//                 hintStyle: GoogleFonts.firaSans(
//                   fontSize: 10.0,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xff9B9B9B),
//                 ),
//                 height: 32.0,
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 40),
//               Text(
//                 'Last Supervisor’s Name',
//                 style: GoogleFonts.firaSans(
//                   fontSize: 10.0,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xff686464),
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 60),
//               CustomTextFieldRegister(
//                 controller: supervisorNameController,
//                 hintText: 'Enter Text',
//                 hintStyle: GoogleFonts.firaSans(
//                   fontSize: 10.0,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xff9B9B9B),
//                 ),
//                 height: 32.0,
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 40),
//               Text(
//                 'Supervisor’s Mobile Number',
//                 style: GoogleFonts.firaSans(
//                   fontSize: 10.0,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xff686464),
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 60),
//               CustomTextFieldRegister(
//                 controller: supervisorMobileNumberController,
//                 hintText: 'Enter Text',
//                 hintStyle: GoogleFonts.firaSans(
//                   fontSize: 10.0,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xff9B9B9B),
//                 ),
//                 height: 32.0,
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 40),
//               Text(
//                 'City',
//                 style: GoogleFonts.firaSans(
//                   fontSize: 10.0,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xff686464),
//                 ),
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height / 60),
//               CustomTextFieldRegister(
//                 controller: cityController,
//                 hintText: 'Enter Text',
//                 hintStyle: GoogleFonts.firaSans(
//                   fontSize: 10.0,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xff9B9B9B),
//                 ),
//                 height: 32.0,
//               ),
//             ],
//         ),
//         ),
//               SizedBox(width: MediaQuery.of(context).size.width / 20),
//               // Continue with other widgets if needed
//             ],
//         ),
//             SizedBox(height: MediaQuery.of(context).size.height / 20),
//             const Divider(
//               color: Colors.grey,
//               thickness: 2.0,
//             ),
//           ],
//         ),
//     );
//   }
// }
