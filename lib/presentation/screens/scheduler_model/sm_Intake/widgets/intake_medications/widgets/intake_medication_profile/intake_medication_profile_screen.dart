import 'package:flutter/material.dart';

class IntakeMedicationProfileScreen extends StatefulWidget {

  const IntakeMedicationProfileScreen({super.key});

  @override
  State<IntakeMedicationProfileScreen> createState() => _IntakeMedicationProfileScreenState();
}

class _IntakeMedicationProfileScreenState extends State<IntakeMedicationProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}

///dont delete ui created by saloni
// Widget build(BuildContext context) {
//   return SingleChildScrollView(
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 50.0),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               ///add button
//               Container(
//                 height: AppSize.s32,
//                 width: AppSize.s105,
//                 child: SchedularIconButtonConst(
//                   text: AppString.add_new,
//                   icon: Icons.add,
//                   onPressed: () async {
//                   },
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20,),
//           Column(
//             children: [
//               Container(
//                 height: 500,
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: Expanded(
//                   // child: StreamBuilder<List<IntakeNotesMiscData>>(
//                   //   stream: noteMiscController.stream,
//                   //   builder: (context, snapshot) {
//                   //     getIntakeNoteMiscByPatientsID(context,
//                   //         patientId: widget.patientId)
//                   //         .then((data) {
//                   //       noteMiscController.add(data);
//                   //     }).catchError((error) {
//                   //       // Handle error
//                   //     });
//                   //     if (snapshot.connectionState ==
//                   //         ConnectionState.waiting) {
//                   //       return Center(
//                   //           child: CircularProgressIndicator(
//                   //             color: ColorManager.blueprime,
//                   //           ));
//                   //     }
//                   //     if (snapshot.data!.isEmpty) {
//                   //       return Center(
//                   //         child: Text(
//                   //           AppString.dataNotFound,
//                   //           style: AllNoDataAvailable.customTextStyle(context),
//                   //         ),
//                   //       );
//                   //     }
//                   //     if (snapshot.hasData) {
//                   //  return
//                   child:   ListView.builder(
//                     itemCount: 10,//snapshot.data!.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       // final note = snapshot.data![index];
//                       // // var note = snapshot.data![index];
//                       // var fileUrl = note.docUrl;
//                       // final fileExtension = fileUrl.split('/').last;
//                       //
//                       // Widget fileWidget;
//                       //
//                       // if (['jpg', 'jpeg', 'png', 'gif'].contains(fileExtension)) {
//                       //   fileWidget = Image.network(
//                       //     fileUrl,
//                       //     fit: BoxFit.cover,
//                       //     errorBuilder: (context, error, stackTrace) {
//                       //       return Icon(
//                       //         Icons.broken_image,
//                       //         size: 45,
//                       //         color: ColorManager.faintGrey,
//                       //       );
//                       //     },
//                       //   );
//                       // }
//                       // else if (['pdf', 'doc', 'docx'].contains(fileExtension)) {
//                       //   fileWidget = Icon(
//                       //     Icons.description,
//                       //     size: 45,
//                       //     color: ColorManager.faintGrey,
//                       //   );
//                       // }
//                       // else {
//                       //   fileWidget = Icon(
//                       //     Icons.insert_drive_file,
//                       //     size: 45,
//                       //     color: ColorManager.faintGrey,
//                       //   );
//                       // }
//                       return Column(
//                         children: [
//                           Container(
//                             height: AppSize.s65,
//                             decoration: BoxDecoration(
//                               color: ColorManager.white,
//                               borderRadius: BorderRadius.circular(8.0),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: ColorManager.black.withOpacity(0.2),
//                                   spreadRadius: 1,
//                                   blurRadius: 5,
//                                   offset: Offset(0, 4),
//                                 ),
//                               ],
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Expanded(
//                                   child: Row(
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.only(left: 10.0),
//                                         child: Container(
//                                             color: ColorManager.blueprime,
//                                             height: AppSize.s45,
//                                             width: AppSize.s65,
//                                             child: Image.asset("images/sm/eye_outline.png")
//                                           // Icon(
//                                           //   Icons.remove_red_eye_outlined,
//                                           //   color: ColorManager.white,
//                                           //   size: AppSize.s24,
//                                           // ),
//                                         ),
//                                       ),
//                                       SizedBox(width: 20),
//                                       Padding(
//                                         padding: const EdgeInsets.only(bottom: 4,top: 2),
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                           children: [
//                                             Text(
//                                               "NanDoc",
//                                               //'ID: ${snapshot.data![index].miscNoteId}',
//                                               style:TableSubHeading.customTextStyle(context),
//                                             ),
//                                             //SizedBox(height:AppSize.s2 ),
//                                             Text(
//                                                 "Pdf name",
//                                                 //snapshot.data![index].docType,
//                                                 style:AllPopupHeadings.customTextStyle(context)
//                                             ),
//
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Expanded(flex: 2,
//                                     child: Container(
//                                       child:  Row(
//                                         crossAxisAlignment: CrossAxisAlignment.center,
//                                         mainAxisAlignment: MainAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                               "Expires on",
//                                               //snapshot.data![index].docType,
//                                               style:AllPopupHeadings.customTextStyle(context)
//                                           ),
//                                           Text(
//                                               "14/12/00",
//                                               //snapshot.data![index].docType,
//                                               style:AllPopupHeadings.customTextStyle(context)
//                                           ),
//                                         ],
//                                       ),
//                                     )),
//                                 Expanded(
//                                   //flex: 2,
//                                   child: Row(
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       IconButton(
//                                         icon: Icon(
//                                             size: 20,
//                                             Icons.history,
//                                             color: ColorManager.blueprime
//                                         ),
//                                         onPressed: () {},
//                                       ),
//                                       IconButton(
//                                           icon: Icon(
//                                               size: 20,
//                                               Icons.print_outlined,
//                                               color:  ColorManager.blueprime
//                                           ),
//                                           onPressed: () async {}
//                                         // {
//                                         //   final pdf = pw.Document();
//                                         //
//                                         //   final miscNotes = snapshot.data!;
//                                         //
//                                         //   miscNotes.forEach((note) {
//                                         //     pdf.addPage(
//                                         //       pw.Page(
//                                         //         build: (pw.Context context) => pw.Column(
//                                         //           mainAxisAlignment: pw.MainAxisAlignment.start,
//                                         //           crossAxisAlignment: pw.CrossAxisAlignment.start,
//                                         //           children: [
//                                         //             pw.Text(
//                                         //               'Miscellaneous Note',
//                                         //               style: pw.TextStyle(
//                                         //                 fontSize: FontSize.s18,
//                                         //                 fontWeight: pw.FontWeight.bold,
//                                         //               ),
//                                         //             ),
//                                         //             pw.Divider(),
//                                         //             pw.SizedBox(height: AppSize.s20),
//                                         //             pw.Table(
//                                         //               border: pw.TableBorder.all(),
//                                         //               children: [
//                                         //                 pw.TableRow(
//                                         //                   children: [
//                                         //                     pw.Padding(
//                                         //                       padding: pw.EdgeInsets.all(8.0),
//                                         //                       child: pw.Text(
//                                         //                         'Misc ID',
//                                         //                         style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//                                         //                       ),
//                                         //                     ),
//                                         //                     pw.Padding(
//                                         //                       padding: pw.EdgeInsets.all(8.0),
//                                         //                       child: pw.Text('${note.miscNoteId}'),
//                                         //                     ),
//                                         //                   ],
//                                         //                 ),
//                                         //                 pw.TableRow(
//                                         //                   children: [
//                                         //                     pw.Padding(
//                                         //                       padding: pw.EdgeInsets.all(8.0),
//                                         //                       child: pw.Text(
//                                         //                         'Patient ID',
//                                         //                         style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//                                         //                       ),
//                                         //                     ),
//                                         //                     pw.Padding(
//                                         //                       padding: pw.EdgeInsets.all(8.0),
//                                         //                       child: pw.Text('${note.patientId}'),
//                                         //                     ),
//                                         //                   ],
//                                         //                 ),
//                                         //                 pw.TableRow(
//                                         //                   children: [
//                                         //                     pw.Padding(
//                                         //                       padding: pw.EdgeInsets.all(8.0),
//                                         //                       child: pw.Text(
//                                         //                         'Doc Type ID',
//                                         //                         style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//                                         //                       ),
//                                         //                     ),
//                                         //                     pw.Padding(
//                                         //                       padding: pw.EdgeInsets.all(8.0),
//                                         //                       child: pw.Text('${note.docTypeId}'),
//                                         //                     ),
//                                         //                   ],
//                                         //                 ),
//                                         //                 pw.TableRow(
//                                         //                   children: [
//                                         //                     pw.Padding(
//                                         //                       padding: pw.EdgeInsets.all(8.0),
//                                         //                       child: pw.Text(
//                                         //                         'Doc Type',
//                                         //                         style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//                                         //                       ),
//                                         //                     ),
//                                         //                     pw.Padding(
//                                         //                       padding: pw.EdgeInsets.all(8.0),
//                                         //                       child: pw.Text(note.docType.isNotEmpty ? note.docType : 'N/A'),
//                                         //                     ),
//                                         //                   ],
//                                         //                 ),
//                                         //                 pw.TableRow(
//                                         //                   children: [
//                                         //                     pw.Padding(
//                                         //                       padding: pw.EdgeInsets.all(8.0),
//                                         //                       child: pw.Text(
//                                         //                         'Doc URL',
//                                         //                         style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//                                         //                       ),
//                                         //                     ),
//                                         //                     pw.Padding(
//                                         //                       padding: pw.EdgeInsets.all(8.0),
//                                         //                       child: pw.Text(note.docUrl.isNotEmpty ? note.docUrl : 'N/A'),
//                                         //                     ),
//                                         //                   ],
//                                         //                 ),
//                                         //                 pw.TableRow(
//                                         //                   children: [
//                                         //                     pw.Padding(
//                                         //                       padding: pw.EdgeInsets.all(8.0),
//                                         //                       child: pw.Text(
//                                         //                         'Name',
//                                         //                         style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//                                         //                       ),
//                                         //                     ),
//                                         //                     pw.Padding(
//                                         //                       padding: pw.EdgeInsets.all(8.0),
//                                         //                       child: pw.Text(note.name.isNotEmpty ? note.name : 'N/A'),
//                                         //                     ),
//                                         //                   ],
//                                         //                 ),
//                                         //                 pw.TableRow(
//                                         //                   children: [
//                                         //                     pw.Padding(
//                                         //                       padding: pw.EdgeInsets.all(8.0),
//                                         //                       child: pw.Text(
//                                         //                         'Created At',
//                                         //                         style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//                                         //                       ),
//                                         //                     ),
//                                         //                     pw.Padding(
//                                         //                       padding: pw.EdgeInsets.all(8.0),
//                                         //                       child: pw.Text(note.createdAt.isNotEmpty ? note.createdAt : 'N/A'),
//                                         //                     ),
//                                         //                   ],
//                                         //                 ),
//                                         //                 pw.TableRow(
//                                         //                   children: [
//                                         //                     pw.Padding(
//                                         //                       padding: pw.EdgeInsets.all(8.0),
//                                         //                       child: pw.Text(
//                                         //                         'Expiry Date',
//                                         //                         style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//                                         //                       ),
//                                         //                     ),
//                                         //                     pw.Padding(
//                                         //                       padding: pw.EdgeInsets.all(8.0),
//                                         //                       child: pw.Text(note.expDate.isNotEmpty ? note.expDate : 'N/A'),
//                                         //                     ),
//                                         //                   ],
//                                         //                 ),
//                                         //               ],
//                                         //             ),
//                                         //           ],
//                                         //         ),
//                                         //       ),
//                                         //     );
//                                         //   });
//                                         //
//                                         //   await Printing.layoutPdf(
//                                         //     onLayout: (PdfPageFormat format) async => pdf.save(),
//                                         //   );
//                                         // },
//                                       ),
//                                       ///download button
//                                       IconButton(
//                                         icon: Icon(
//                                           size: 20,
//                                           Icons
//                                               .file_download_outlined,
//                                           color: ColorManager.blueprime,
//                                         ),
//                                         onPressed: () {
//                                           // print("FileExtension:${fileExtension}");
//                                           // DowloadFile().downloadPdfFromBase64(fileExtension,"MicNotes.pdf");
//                                           // downloadFile(fileUrl);
//                                           // // DowloadFile().downloadPdfFromBase64(fileExtension,"Compensation");
//
//
//                                         },
//                                       ),
//
//                                       IconButton(
//                                         onPressed: () {
//                                           // showDialog(
//                                           //   context: context,
//                                           //   builder: (context) =>
//                                           //       StatefulBuilder(
//                                           //         builder: (BuildContext
//                                           //         context, void Function(
//                                           //                 void
//                                           //                 Function())
//                                           //             setState) {
//                                           //           return DeletePopup(
//                                           //             title:
//                                           //             'Delete Miscellaneous Note',
//                                           //             loadingDuration:
//                                           //             _isLoading,
//                                           //             onCancel: () {
//                                           //               Navigator.pop(
//                                           //                   context);
//                                           //             },
//                                           //             onDelete:
//                                           //                 () async {
//                                           //               setState(() {
//                                           //                 _isLoading =
//                                           //                 true;
//                                           //               });
//                                           //               try {
//                                           //                 await deleteMiscNoteAPI(
//                                           //                     context,
//                                           //                     snapshot
//                                           //                         .data![
//                                           //                     index]
//                                           //                         .miscNoteId!);
//                                           //                 setState(
//                                           //                         () async {
//                                           //                       getIntakeNoteMiscByPatientsID(
//                                           //                           context,
//                                           //                           patientId: widget
//                                           //                               .patientId)
//                                           //                           .then(
//                                           //                               (data) {
//                                           //                             noteMiscController
//                                           //                                 .add(
//                                           //                                 data);
//                                           //                           }).catchError(
//                                           //                               (error) {
//                                           //                             // Handle error
//                                           //                           });
//                                           //                       Navigator.pop(
//                                           //                           context);
//                                           //                     });
//                                           //               } finally {
//                                           //                 setState(() {
//                                           //                   _isLoading =
//                                           //                   false;
//                                           //                 });
//                                           //               }
//                                           //             },
//                                           //           );
//                                           //         },
//                                           //       ),
//                                           // );
//                                         },
//                                         icon: Icon(
//                                           Icons.delete_outline,
//                                           size: 20,
//                                           color: ColorManager.rednew,
//                                         ),
//                                       ),
//                                       SizedBox(width: 20),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 10,),
//                         ],
//                       );
//                     },
//                   ),
//                   //     }
//                   //     return Offstage();
//                   //   },
//                   // ),
//                 ),
//               ),
//             ],
//           ),
//
//         ],
//       ),
//     ),
//   );
// }