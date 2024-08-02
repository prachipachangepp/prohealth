// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../patient_info.dart';
//
// class EmergencyContactInfo extends StatefulWidget {
//   const EmergencyContactInfo({Key? key}) : super(key: key);
//
//   @override
//   _EmergencyContactInfoState createState() => _EmergencyContactInfoState();
// }
//
// class _EmergencyContactInfoState extends State<EmergencyContactInfo> {
//   bool isOptForCAHPSSurvey = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           width: MediaQuery.of(context).size.width * 0.9,
//           padding: EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.5),
//                 spreadRadius: 0,
//                 blurRadius: 10,
//                 offset: Offset(0, 5),
//               ),
//             ],
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Emergency Contact Information',
//                     style: GoogleFonts.firaSans(
//                         fontSize: 18, fontWeight: FontWeight.bold)),
//                 SizedBox(height: 20),
//                 _buildEmergencyContactSection(),
//                 SizedBox(height: 30),
//                 Text('Primary Care Giver',
//                     style: GoogleFonts.firaSans(
//                         fontSize: 18, fontWeight: FontWeight.bold)),
//                 SizedBox(height: 20),
//                 _buildPrimaryCareGiverSection(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildEmergencyContactSection() {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Flexible(child: SchedularTextField(labelText: 'Emergency Contact')),
//             SizedBox(width: 20),
//             Flexible(child: SchedularTextField(labelText: 'Telephone Number')),
//             SizedBox(width: 20),
//             Flexible(child: SchedularDropdown(labelText: 'Relationship', initialValue: 'Select One')),
//             SizedBox(width: 20),
//             Flexible(child: SchedularTextField(labelText: 'Emergency Contact Address')),
//           ],
//         ),
//         SizedBox(height: 20),
//         Row(
//           children: [
//             Flexible(child: SchedularTextField(labelText: 'City')),
//             SizedBox(width: 20),
//             Flexible(child: SchedularDropdown(labelText: 'State')),
//             SizedBox(width: 20),
//             Flexible(child: SchedularTextFieldWithButton(
//               labelText: 'Zip Code',
//               initialValue: '2656845121',
//               buttonText: 'View Zone',
//             )),
//             SizedBox(width: 20),
//             Flexible(child: SchedularDropdown(labelText: 'Priority/ Disaster Code')),
//           ],
//         ),
//         SizedBox(height: 20),
//         SchedularTextField(labelText: 'Comments'),
//         SizedBox(width: 35),
//         Flexible(
//             child: Container()), // Empty container for alignment
//         SizedBox(width: 35),
//         Flexible(
//             child: Container()),
//         SizedBox(width: 35),
//         Flexible(
//             child: Container()),
//       ],
//     );
//   }
//
//   Widget _buildPrimaryCareGiverSection() {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Flexible(child: SchedularDropdown(labelText: 'Prefix')),
//             SizedBox(width: 20),
//             Flexible(child: SchedularTextField(labelText: 'First Name', initialValue: 'Erica')),
//             SizedBox(width: 20),
//             Flexible(child: SchedularTextField(labelText: 'M.I.', initialValue: 'A')),
//             SizedBox(width: 20),
//             Flexible(child: SchedularTextField(labelText: 'Last Name')),
//           ],
//         ),
//         SizedBox(height: 20),
//         Row(
//           children: [
//             Flexible(child: SchedularTextField(labelText: 'Suffix')),
//             SizedBox(width: 20),
//             Flexible(
//               child: Row(
//                 children: [
//                   Checkbox(
//                     value: isOptForCAHPSSurvey,
//                     onChanged: (value) {
//                       setState(() {
//                         isOptForCAHPSSurvey = value!;
//                       });
//                     },
//                   ),
//                   Expanded(child: SchedularTextField(labelText: 'Opt for CAHPS Survey')),
//                 ],
//               ),
//             ),
//             SizedBox(width: 20),
//             Flexible(child: SchedularTextField(labelText: 'Address')),
//             SizedBox(width: 20),
//             Flexible(child: SchedularTextField(labelText: 'Suite/ Apt.')),
//           ],
//         ),
//         SizedBox(height: 20),
//         Row(
//           children: [
//             Flexible(child: SchedularTextField(labelText: 'City')),
//             SizedBox(width: 20),
//             Flexible(child: SchedularDropdown(labelText: 'State')),
//             SizedBox(width: 20),
//             Flexible(child: SchedularTextFieldWithButton(
//               labelText: 'Zip Code',
//               initialValue: '2656845121',
//               buttonText: 'View Zone',
//             )),
//             SizedBox(width: 20),
//             Flexible(child: SchedularTextField(labelText: 'Phone')),
//           ],
//         ),
//         SizedBox(height: 20),
//         Row(
//           children: [
//             Flexible(child: SchedularTextField(labelText: 'Cell')),
//             SizedBox(width: 20),
//             Flexible(child: SchedularTextField(labelText: 'Email')),
//             SizedBox(width: 20),
//             Flexible(child: SchedularDropdown(labelText: 'Relationship')),
//             SizedBox(width: 20),
//             Flexible(child: SchedularTextField(labelText: 'Additional Information')),
//           ],
//         ),
//       ],
//     );
//   }
// }