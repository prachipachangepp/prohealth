import 'package:flutter/material.dart';

import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import '../../../../../widgets/constant_widgets/button_constant.dart';

class PhysicianOrder extends StatefulWidget {
  final int patientId;
  const PhysicianOrder({super.key, required this.patientId});

  @override
  State<PhysicianOrder> createState() => _PhysicianOrderState();
}

class _PhysicianOrderState extends State<PhysicianOrder> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100,vertical: 10),
      child: Column(
       children: [
         SizedBox(height: 70,),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Column(
               children: [
                 Row(
                   children: [
                     Container(
                       width: 300,
                       height: 30,


                       child: TextField(
                        // controller: _controller,
                         textCapitalization:
                         TextCapitalization.words,
                         style: TextStyle(fontSize: 12),
                         // onChanged: _search,
                         decoration: InputDecoration(
                             hintText: 'Search',
                             alignLabelWithHint: true,
                             hintStyle: TextStyle(
                               fontSize: FontSize.s14,
                               fontWeight: FontWeight.w500,
                               color: ColorManager.mediumgrey,
                             ),
                             border: OutlineInputBorder(
                                 borderRadius: BorderRadius.all(
                                     Radius.circular(20))),
                             prefixIcon: IconButton(
                               splashColor: Colors.transparent,
                               highlightColor: Colors.transparent,
                               hoverColor: Colors.transparent,
                               icon: Center(
                                 child: Icon(
                                   Icons.search,
                                   size: 18,
                                 ),
                               ),
                               onPressed: () {},
                             ),
                             contentPadding: EdgeInsets.symmetric(
                                 horizontal: 20, vertical: 5)),
                       ),

                     ),

                   ],
                 )
               ],
             ),
             Column(
               children: [
                 Container(
                   width: 130,
                   height: 35,
                   child: SchedularIconButtonConst(
                       text: 'Add Physician',
                     icon: Icons.add,
                     onPressed: () {}
                     // onPressed: () {}
                   ),
                 ),
               ],
             ),
           ],
         ),
         SizedBox(height: 50,),
         Container(
          // color: Colors.red,
height: 70,
           decoration: BoxDecoration(
             color: Colors.white,
             borderRadius:
             BorderRadius.circular(8),
             boxShadow: [
               BoxShadow(
                 color: Colors.grey
                     .withOpacity(0.5),
                 spreadRadius: 1,
                 blurRadius: 4,
                 offset: const Offset(0, 2),
               ),
             ],
           ),

           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Padding(
                 padding: const EdgeInsets.only(left: 20),
                 child: Row(
                   children: [
                     CircleAvatar(
                       child:
                       Image.asset('images/1.png'),
                     ),
                     SizedBox(width: AppSize.s7),
                     Text(
                       'Jeh Tiwari',
                       style:DocumentTypeDataStyle.customTextStyle(context),
                     ),
                   ],
                 ),
               ),
               Row(
                 children: [
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Icon(Icons.call,color: Colors.blueAccent,),
                   ),
                   Container(
                     width: 120,
                     child:Text("+49 4464646548",
                       style:DocumentTypeDataStyle.customTextStyle(context),) ,
                   )
                 ],
               ),
               Row(
                 children: [
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Icon(Icons.location_on_outlined),
                   ),
                   Container(
                     width: 200,

                     child:Text("Tufts International Center, 20 Sawyer Ave, Medford MA 02155 ",
                       textAlign: TextAlign.start,
                       style:DocumentTypeDataStyle.customTextStyle(context),
                     ) ,
                   )
                 ],
               ),
               Padding(
                 padding: const EdgeInsets.only(right: 20),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Container(
                       width: 200,
                       height: 40,
                       child: ElevatedButton.icon(onPressed: (){}, label: Text("Upload prescription", style: TransparentButtonTextConst.customTextStyle(context),),
                       icon: Icon(Icons.file_upload_outlined,color:ColorManager.blueprime ,),
                         style: ElevatedButton.styleFrom(backgroundColor: Colors.white,
                           elevation: 5,
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(12),
                             side: BorderSide(
                               color: ColorManager.bluebottom,
                               width: 1,
                             ),
                           ),),
                       ),
                     )
                   ],
                 ),
               ),



             ],
           ),
         ),
         SizedBox(height: MediaQuery.of(context).size.height / 25),
         Row(
           children: [
             Text("Treatment :",  style:DocumentTypeDataStyle.customTextStyle(context),),
             Padding(
               padding: const EdgeInsets.only(left: 8),
               child: Container(
                 width: 300,
                 height: 30,
                 decoration: BoxDecoration(
                   border: Border.all(color: Color(0xFFB1B1B1), width: 1),
                   borderRadius: BorderRadius.circular(8),
                 ),
                 child: TextFormField(
                   cursorHeight: 17,
                   cursorColor: Colors.black,
                   autovalidateMode: AutovalidateMode.onUserInteraction,
                   decoration: InputDecoration(
                     border: InputBorder.none,
                     contentPadding: EdgeInsets.only(bottom:18, left: AppPadding.p15),
                   ),
                   style: TableSubHeading.customTextStyle(context),
                 ),
               ),
             ),
           ],
         ),
         SizedBox(height: MediaQuery.of(context).size.height / 45),
         Expanded(
           child: Container(
             height: 400,
            // color: Colors.red,
             child: ListView.builder(
               itemCount: 3,
               itemBuilder: (BuildContext context, index) {


                 Widget fileWidget;



                 return Padding(
                   padding: const EdgeInsets.symmetric(
                       vertical: 8.0, horizontal: 0),
                   child: Column(
                     children: [
                       Container(
                         height: AppSize.s65,
                         // width: 1109, //1109
                         decoration: BoxDecoration(
                           color: ColorManager.white,
                           borderRadius:
                           BorderRadius.circular(8.0),
                           boxShadow: [
                             BoxShadow(
                               color: Colors.black
                                   .withOpacity(0.2),
                               spreadRadius: 1,
                               blurRadius: 5,
                               offset: Offset(0, 4),
                             ),
                           ],
                         ),
                         child: Row(
                           mainAxisAlignment:
                           MainAxisAlignment
                               .spaceBetween,
                           crossAxisAlignment:
                           CrossAxisAlignment.center,
                           children: [
                             Row(
                               children: [
                                 Padding(
                                   padding:
                                   const EdgeInsets.only(
                                       left: 10.0),
                                   child: Container(
                                     color:
                                     Color(0xff50B5E5),
                                     height: AppSize.s45,
                                     width: AppSize.s62,
                                     child: Icon(
                                       Icons
                                           .remove_red_eye_outlined,
                                       color: ColorManager
                                           .white,
                                       size: AppSize.s24,
                                     ),
                                   ),
                                 ),
                                 SizedBox(
                                     width: MediaQuery.of(
                                         context)
                                         .size
                                         .width /
                                         120),
                                 Padding(
                                   padding:
                                   const EdgeInsets.only(
                                       top: 11.5),
                                   child: Column(
                                     crossAxisAlignment:
                                     CrossAxisAlignment
                                         .start,
                                     children: [
                                       // Text(
                                       //  "",
                                       //   style: TextStyle(decoration: TextDecoration.none,
                                       //       fontSize:
                                       //       FontSize.s10,
                                       //       fontWeight: FontWeightManager.medium,
                                       //       color: ColorManager.textPrimaryColor),
                                       // ),
                                       // SizedBox(height: 3.5),
                                       Text(
                                         "Prescription",
                                         // textAlign:TextAlign.center,
                                         style: TextStyle(
                                             decoration: TextDecoration.none,
                                             fontSize: AppSize.s12,
                                             fontWeight: FontWeightManager.bold,
                                             color: ColorManager.textPrimaryColor),
                                       ),
                                       SizedBox(height: 1),
                                       Text(
                                         "Upload on: 2024/04/03",
                                         // textAlign:TextAlign.center,
                                         style: TextStyle(
                                             decoration: TextDecoration.none,
                                             fontSize: FontSize.s10,
                                             fontWeight: FontWeightManager.lightbold,
                                             color: ColorManager.textPrimaryColor),
                                       )
                                     ],
                                   ),
                                 ),
                               ],
                             ),
                             // SizedBox(width: MediaQuery.of(context).size.width/4.5), //3.5
                             Padding(
                               padding:
                               const EdgeInsets.only(
                                   right: 50.0),
                               child: Row(
                                 children: [
                                   IconButton(
                                     icon: Icon(
                                         size: 20,
                                         Icons.history,
                                         color: ColorManager
                                             .textPrimaryColor),
                                     onPressed: () {},
                                   ),
                                   SizedBox(
                                       width: MediaQuery.of(
                                                   context)
                                               .size
                                               .width /
                                           120),
                                   IconButton(
                                     icon: Icon(
                                         size: 20,
                                         Icons
                                             .print_outlined,
                                         color: ColorManager
                                             .textPrimaryColor),
                                     onPressed: () async {
                                       // final pdf =
                                       //     pw.Document();
                                       //
                                       // pdf.addPage(
                                       //   pw.Page(
                                       //     build: (pw.Context
                                       //             context) =>
                                       //         pw.Center(
                                       //       child: pw.Text(
                                       //           'Hello, this is a test print!'),
                                       //     ),
                                       //   ),
                                       // );
                                       //
                                       // await Printing
                                       //     .layoutPdf(
                                       //   onLayout: (PdfPageFormat
                                       //           format) async =>
                                       //       pdf.save(),
                                       // );
                                     },
                                   ),
                                   SizedBox(
                                       width: MediaQuery.of(
                                                   context)
                                               .size
                                               .width /
                                           120),
                                   IconButton(
                                     onPressed: () {
                                       // print("FileExtension:${fileExtension}");
                                       // DowloadFile().downloadPdfFromBase64(
                                       //     fileExtension,"Compliance.pdf");
                                       // downloadFile(fileUrl);
                                       // DowloadFile().downloadPdfFromBase64(fileExtension,"Compensation");
                                     },
                                     icon: Icon(
                                       Icons.save_alt_outlined,
                                       // color: Color(0xff1696C8,),
                                         color: ColorManager
                                             .textPrimaryColor
                                     ),),
                                   SizedBox(
                                       width: MediaQuery.of(
                                           context)
                                           .size
                                           .width /
                                           120),
                                   IconButton(
                                       onPressed: () {
                                         showDialog(
                                             context:
                                             context,
                                             builder:
                                                 (context) =>
                                                 StatefulBuilder(
                                                   builder:
                                                       (BuildContext context, void Function(void Function()) setState) {
                                                     return DeletePopup(
                                                         title: 'Delete license',
                                                        // loadingDuration: _isLoading,
                                                         onCancel: () {
                                                           Navigator.pop(context);
                                                         },
                                                         onDelete: () async {
                                                           // setState(() {
                                                           //   _isLoading = true;
                                                           // });
                                                           // try {
                                                           //   await deleteDocumentCompliance(context, snapshot.data![index].complianceId!);
                                                           //   setState(() async {
                                                           //     await getComplianceByPatientId(
                                                           //         context, 1
                                                           //     ).then((data) {
                                                           //       _compliancePatientDataController.add(data);
                                                           //     }).catchError((error) {
                                                           //       // Handle error
                                                           //     });
                                                           //     Navigator.pop(context);
                                                           //   });
                                                           // } finally {
                                                           //   setState(() {
                                                           //     _isLoading = false;
                                                           //   });
                                                           // }
                                                         }
                                                         );
                                                   },
                                                 ));
                                       },
                                       icon: Icon(
                                         Icons
                                             .delete_outline,
                                         size: 20,
                                         // color: ColorManager.red,
                                           color: ColorManager
                                               .textPrimaryColor
                                       )),
                                 ],
                               ),
                             ),
                           ],
                         ),
                       ),
                     ],
                   ),
                 );
               },
             ),
           ),
         ),
         // SizedBox(height: MediaQuery.of(context).size.height / 25),
       ],

      ),
    );
  }
}
