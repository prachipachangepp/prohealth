import 'package:url_launcher/url_launcher.dart';

Future<void> downloadFile(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}

/// image launcher code of ack onboarding

// class AcknowledgementTab extends StatefulWidget {
//   const AcknowledgementTab({Key? key}) : super(key: key);
//
//   @override
//   State<AcknowledgementTab> createState() => _AcknowledgementTabState();
// }
//
// class _AcknowledgementTabState extends State<AcknowledgementTab> {
//   final StreamController<List<OnboardingAckHealthData>> _controller = StreamController<List<OnboardingAckHealthData>>();
//   List<bool> _checked = [];
//
//   @override
//   void initState() {
//     super.initState();
//     getAckHealthRecord(context, 1, 10, 5).then((data) {
//       _controller.add(data);
//       _checked = List.generate(data.length, (_) => false);
//     }).catchError((error) {
//       // Handle error
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<List<OnboardingAckHealthData>>(
//       stream: _controller.stream,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(
//               color: ColorManager.blueprime,
//             ),
//           );
//         }
//         if (snapshot.hasError) {
//           return Center(
//             child: Text(
//               'Error: ${snapshot.error}',
//               style: TextStyle(color: Colors.red),
//             ),
//           );
//         }
//         if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return Center(
//             child: Text(
//               AppString.dataNotFound,
//               style: CustomTextStylesCommon.commonStyle(
//                 fontWeight: FontWeightManager.medium,
//                 fontSize: FontSize.s12,
//                 color: ColorManager.mediumgrey,
//               ),
//             ),
//           );
//         }
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Container(
//             height: MediaQuery.of(context).size.height / 2,
//             padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
//             decoration: BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.25),
//                   spreadRadius: 1,
//                   blurRadius: 4,
//                   offset: Offset(0, 5),
//                 ),
//               ],
//               color: Colors.white,
//               borderRadius: BorderRadius.all(Radius.circular(12)),
//             ),
//             child: WrapWidget(
//               childern: [
//               ...List.generate(snapshot.data!.length, (index) {
//                 final data = snapshot.data![index];
//                 final fileUrl = data.DocumentUrl;
//                 final fileExtension = fileUrl.split('.').last.toLowerCase();
//
//                 Widget fileWidget;
//
//                 if (['jpg', 'jpeg', 'png', 'gif'].contains(fileExtension)) {
//                   fileWidget = Image.network(
//                     fileUrl,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Icon(
//                         Icons.broken_image,
//                         size: 25,
//                         color: ColorManager.faintGrey,
//                       );
//                     },
//                   );
//                 } else if (['pdf', 'doc', 'docx'].contains(fileExtension)) {
//                   fileWidget = Center(
//                     child: Icon(
//                       Icons.description_outlined,
//                       size: 25,
//                       color: ColorManager.blueprime,
//                     ),
//                   );
//                 } else {
//                   fileWidget = Center(
//                     child: Icon(
//                       Icons.description_outlined,
//                       size: 25,
//                       color: ColorManager.blueprime,
//                     ),
//                   );
//                 }
//
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
//                       child: Container(
//                         width: AppSize.s500,
//                         child: Row(
//                           children: [
//                             Checkbox(
//                               value: _checked[index],
//                               onChanged: (bool? value) {
//                                 setState(() {
//                                   _checked[index] = value!;
//                                 });
//                               },
//                             ),
//                             GestureDetector(
//                               onTap: () => downloadFile(fileUrl),
//                               child: Container(
//                                 width: 62,
//                                 height: 45,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(4),
//                                   border: Border.all(width: 2, color: ColorManager.faintGrey),
//                                 ),
//                                 child: fileWidget,
//                               ),
//                             ),
//                             SizedBox(width: 10),
//                             Expanded(
//                               child: Text(
//                                 data.UploadDate,
//                                 style: AknowledgementStyleConst.customTextStyle(context),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               }),
//             Padding(
//               padding: const EdgeInsets.only(right: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//
//                   ///reject
//                   ElevatedButton(
//                     onPressed: () => showDialog(
//                         context: context,
//                         builder: (BuildContext context){
//                           return Dialog(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12.0),
//                             ),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20.0),
//                               ),
//                               height: 150.0,
//                               width: 300.0,
//                               child: Stack(
//                                 children: <Widget>[
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       color: ColorManager.bluebottom,
//                                       borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(8),
//                                         topRight: Radius.circular(8),
//                                       ),
//                                     ),
//                                     height: 35,
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.only(left: 10.0),
//                                           child: Text(
//                                             'Reject',
//                                             style: GoogleFonts.firaSans(
//                                               fontSize: FontSize.s12,
//                                               fontWeight: FontWeightManager.semiBold,
//                                               color: ColorManager.white,
//                                               decoration: TextDecoration.none,
//                                             ),
//                                           ),
//                                         ),
//                                         IconButton(
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                           },
//                                           icon: Icon(Icons.close, color: ColorManager.white),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Align(
//                                     alignment: Alignment.center,
//                                     child: Text(
//                                       "Do you really want to,\nreject this?",
//                                       textAlign: TextAlign.center,
//                                       style: GoogleFonts.firaSans(
//                                         fontSize: 14,
//                                         fontWeight: FontWeightManager.regular,
//                                         color: ColorManager.mediumgrey,
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(10),
//                                     child: Align(
//                                       alignment: Alignment.bottomCenter,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.center,
//                                         children: [
//                                           ElevatedButton(
//                                             onPressed: () {
//                                               Navigator.of(context).pop();
//                                             },
//                                             style: ElevatedButton.styleFrom(
//                                               backgroundColor: Colors.white,
//                                               foregroundColor: Color(0xff1696C8),
//                                               side: BorderSide(color: Color(0xff1696C8)),
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius: BorderRadius.circular(8),
//                                               ),
//                                             ),
//                                             child: Text(
//                                               'Cancel',
//                                               style: GoogleFonts.firaSans(
//                                                 fontSize: 10.0,
//                                                 fontWeight: FontWeight.w700,
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(width: MediaQuery.of(context).size.width / 75),
//                                           ElevatedButton(
//                                             onPressed: (){},
//                                             // onPressed: () async {
//                                             //   await rejectOnboardQualifyEmploymentPatch(context, snapshot.data![index].employmentId);
//                                             //   getOnboardingQualificationEmp(context, 1).then((data) {
//                                             //     qualificationempStreamController.add(data);
//                                             //   }).catchError((error) {});
//                                             //   Navigator.of(context).pop();
//                                             // },
//                                             style: ElevatedButton.styleFrom(
//                                               backgroundColor: Color(0xff1696C8),
//                                               foregroundColor: Colors.white,
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius: BorderRadius.circular(8),
//                                               ),
//                                             ),
//                                             child: Text(
//                                               'Yes',
//                                               style: GoogleFonts.firaSans(
//                                                 fontSize: 10.0,
//                                                 fontWeight: FontWeight.w700,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         }
//                     ),
//                     //_handleRejectSelected(snapshot.data!),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       foregroundColor: Color(0xff1696C8),
//                       side: BorderSide(color: Color(0xff1696C8)),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(
//                       'Reject',
//                       style: GoogleFonts.firaSans(
//                         fontSize: 10.0,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: MediaQuery.of(context).size.width / 75),
//                   ///approve
//                   ElevatedButton(
//                     onPressed: () => showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return Dialog(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                           ),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20.0),
//                             ),
//                             height: 150.0,
//                             width: 300.0,
//                             child: Stack(
//                               children: <Widget>[
//                                 Container(
//                                   decoration: BoxDecoration(
//                                     color: ColorManager.bluebottom,
//                                     borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(8),
//                                       topRight: Radius.circular(8),
//                                     ),
//                                   ),
//                                   height: 35,
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.only(left: 10.0),
//                                         child: Text(
//                                           'Approve',
//                                           style: GoogleFonts.firaSans(
//                                             fontSize: FontSize.s12,
//                                             fontWeight: FontWeightManager.semiBold,
//                                             color: ColorManager.white,
//                                             decoration: TextDecoration.none,
//                                           ),
//                                         ),
//                                       ),
//                                       IconButton(
//                                         onPressed: () {
//                                           Navigator.pop(context);
//                                         },
//                                         icon: Icon(Icons.close, color: ColorManager.white),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Align(
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                     "Do you really want to approve this?",
//                                     textAlign: TextAlign.center,
//                                     style: GoogleFonts.firaSans(
//                                       fontSize: 14,
//                                       fontWeight: FontWeightManager.regular,
//                                       color: ColorManager.mediumgrey,
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(10),
//                                   child: Align(
//                                     alignment: Alignment.bottomCenter,
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         ElevatedButton(
//                                           onPressed: () {
//                                             Navigator.of(context).pop();
//                                           },
//                                           style: ElevatedButton.styleFrom(
//                                             backgroundColor: Colors.white,
//                                             foregroundColor: Color(0xff1696C8),
//                                             side: BorderSide(color: Color(0xff1696C8)),
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius: BorderRadius.circular(8),
//                                             ),
//                                           ),
//                                           child: Text(
//                                             'Cancel',
//                                             style: GoogleFonts.firaSans(
//                                               fontSize: 10.0,
//                                               fontWeight: FontWeight.w700,
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(width: MediaQuery.of(context).size.width / 75),
//                                         ElevatedButton(
//                                           onPressed: (){},
//                                           // onPressed: () async {
//                                           //   await approveOnboardQualifyEmploymentPatch(context, snapshot.data![index].employmentId);
//                                           //   getOnboardingQualificationEmp(context, 1).then((data) {
//                                           //     qualificationempStreamController.add(data);
//                                           //   }).catchError((error) {});
//                                           //   Navigator.of(context).pop();
//                                           // },
//                                           style: ElevatedButton.styleFrom(
//                                             backgroundColor: Color(0xff1696C8),
//                                             foregroundColor: Colors.white,
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius: BorderRadius.circular(8),
//                                             ),
//                                           ),
//                                           child: Text(
//                                             'Yes',
//                                             style: GoogleFonts.firaSans(
//                                               fontSize: 10.0,
//                                               fontWeight: FontWeight.w700,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                     //_handleApproveSelected(snapshot.data!),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xff1696C8),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(
//                       'Approve',
//                       style: GoogleFonts.firaSans(
//                         fontSize: 10.0,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             ]
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.close();
//     super.dispose();
//   }
// }
