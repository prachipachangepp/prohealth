import 'package:flutter/material.dart';

import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../widgets/widgets/constant_textfield/const_textfield.dart';
import '../../../../../../em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';

class Auto_Assign extends StatefulWidget {
  final VoidCallback? onGoBackAuto;
  const Auto_Assign({super.key, this.onGoBackAuto});

  @override
  State<Auto_Assign> createState() => _Auto_AssignState();
}

class _Auto_AssignState extends State<Auto_Assign> {

  TextEditingController DSummarycont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     body: SingleChildScrollView(
       child: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 20),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                // SizedBox(width: AppSize.s25,),
                 InkWell(
                   hoverColor: Colors.transparent,
                   splashColor: Colors.transparent,
                   focusColor: Colors.transparent,
                   onTap: () {
                     if (widget.onGoBackAuto != null) {
                       widget.onGoBackAuto!(); // Trigger the callback to notify parent
                     }},
                   child: Row(
                     children: [
                       Icon(
                         Icons.arrow_back,
                         size: IconSize.I16,
                         color: ColorManager.mediumgrey,
       
                       ),
                       SizedBox(width: 5,),
                       Text(
                         'Clinician Assignment',
                         style:TextStyle(
                           fontSize: FontSize.s14,
                           fontWeight: FontWeight.w700,
                           color: ColorManager.mediumgrey,
                         ),
                       ),
                     ],
                   ),
                 ),
                 
                 Row(
                   children: [
                     ElevatedButton(onPressed: () {  }, child: Text("Submit", style: TextStyle(
                       fontSize: FontSize.s13,
                       fontWeight: FontWeight.w600,
                       color: ColorManager.white,
                       decoration: TextDecoration.none,
                     )),style: ElevatedButton.styleFrom(
                       backgroundColor:  ColorManager.bluebottom,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.all(
                           Radius.circular(12), // Round only the top-left corner
                           // Round only the bottom-left corner
                         ),
                         side: BorderSide(
                           color: Color(0xFF0A74DA), // Border color
                           width: 1,
                         ),
                       ),
                     ),)
                   ],
                 )
       
               ],
             ),
             SizedBox(height: AppSize.s25,),
       
             Text("Patient Details", style:TextStyle(
               fontSize: FontSize.s14,
               fontWeight: FontWeight.w700,
               color: ColorManager.mediumgrey,
             ),),
       
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 1,
                 vertical: 5,),
               child: Container(
                 // color: Colors.red,
                 height: 80,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius:
                   BorderRadius.circular(8),
                   // boxShadow: [
                   //   BoxShadow(
                   //     color: Colors.grey
                   //         .withOpacity(0.5),
                   //     spreadRadius: 1,
                   //     blurRadius: 4,
                   //     offset: const Offset(0, 2),
                   //   ),
                   // ],
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
                           Padding(
                             padding: const EdgeInsets.only(top: 18),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(
                                     'Jeh Tiwari',
                                     style:AllHRTableData.customTextStyle(context)
                                 ),
                                 SizedBox(height: AppSize.s3),
                                 Text(
                                   'Anxiety',
                                   style:DocumentTypeDataStyle.customTextStyle(context),
                                 ),
                               ],
                             ),
                           ),
                         ],
                       ),
                     ),
       
       
       
                     Row(
                       children: [
                       Text("POC :",style: DocumentTypeDataStyle.customTextStyle(context),),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Container(
                             decoration: BoxDecoration(
                               color: Color(0xFF527FB9).withOpacity(0.5),
                               borderRadius: BorderRadius.circular(5), // Makes the borders curved with radius 5
                             ),
                             // color: Color(0xFF527FB9).withOpacity(0.5),
                             width: 22,
                             height: 20,
                             child: Center(
                               child: Text("ST",style: TextStyle(
                                 // fontWeight: FontWeight.w600,
                                 // fontSize: FontSize.s13,
                                 color: ColorManager.white,
                                 decoration: TextDecoration.none,
                               ),),
                             ),
                           ),
                         ),
       
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Container(
                             decoration: BoxDecoration(
                               color: Color(0xFFFEBD4D).withOpacity(0.5),
                               borderRadius: BorderRadius.circular(5), // Makes the borders curved with radius 5
                             ),
                             width: 22,
                             height: 20,
                             child: Center(
                               child: Text(
                                 "OT",
                                 style: TextStyle(
                                   color: ColorManager.white,
                                   decoration: TextDecoration.none,
                                 ),
                               ),
                             ),
                           ),
                         )
                       ],
                     ),
       
       
                     Row(
                       children: [
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Icon(Icons.location_on_outlined,color: ColorManager.bluebottom,),
                         ),
                         Container(
                           width: 200,
       
                           child:Text("132 My Street, Kingston, New York 12401",
                             textAlign: TextAlign.start,
                             style:DocumentTypeDataStyle.customTextStyle(context),
                           ) ,
                         )
                       ],
                     ),
                     SizedBox(
                       width: 100,
                     )
       
                   ],
                 ),
               ),
             ),
             Divider(),
             SizedBox(height: AppSize.s25,),
       
             Text("Clinician Preference", style:TextStyle(
               fontSize: FontSize.s14,
               fontWeight: FontWeight.w700,
               color: ColorManager.mediumgrey,
             ),),
             SizedBox(height: AppSize.s25,),
             Text("Clinician Type", style:TextStyle(
               fontSize: FontSize.s14,
               fontWeight: FontWeight.w700,
               color: ColorManager.mediumgrey,
             ),),
             SizedBox(height: 5),
             CICCDropdown(
               width:500,
       
             //  isAstric:false,
               // Adjust headText based on depId
               //initialValue: 'Filter by',
              // headText: "", // Default fallback if depId doesn't match any of the expected values
               items: [],
               onChange: (newValue) {
                 // for (var a in snapshot.data!) {
                 //   if (a.empType == newValue) {
                 //     clinicialName = a.empType!;
                 //     clinicalId = a.employeeTypesId!;
                 //     print("Dept ID'''''' ${clinicalId}");
                 //     print("';';';''''''''Dept ID ${clinicialName}");
                 //     // Do something with docType
                 //   }
                 // }
               },
             ),
       
             SizedBox(height: AppSize.s25,),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
               Container(
               // height: 100,          // Height of the container
            width: 300,           // Width of the container (adjust as needed)
               decoration: BoxDecoration(
                 color: Colors.white,  // Background color (adjust as needed)
                 border: Border.all(
                   color: ColorManager.bluebottom,  // Border color
                   width: 2,             // Border width
                 ),
                 borderRadius: BorderRadius.circular(12),  // Circular border radius
               ),
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Column(
                     children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                           Text("In Zone", style:TextStyle(
                             fontSize: FontSize.s14,
                             fontWeight: FontWeight.w700,
                             color: ColorManager.greenDark,
                           ),),
                         ],
                       ),
                       SizedBox(height: 5),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Column(
                             children: [
                               Row(
                                 children: [
                                   Stack(
       
                                     children: [SizedBox(
                                       height: 60,  // Adjust height for circle size
                                       width: 60,
                                       child: CircleAvatar(
                                         child:
                                         Image.asset('images/1.png',fit: BoxFit.contain,),
                                       ),
                                     ),
                                       Positioned(
                                      right:0,
                                         bottom :0,
                                         child: Container(
                                           color: Color(0xFF527FB9),
                                           width: 19,
                                           height: 19,
                                           child: Center(
                                             child: Text("ST",style: TextStyle(
                                               // fontWeight: FontWeight.w600,
                                               // fontSize: FontSize.s13,
                                               color: ColorManager.white,
                                               decoration: TextDecoration.none,
                                             ),),
                                           ),
                                         ),)
                                     ],
                                   ),
                                 ],
                               ),
                               SizedBox(height: 5),
                               Text("\$24", style:TextStyle(
                                 fontSize: FontSize.s14,
                                 fontWeight: FontWeight.w700,
                                 color: ColorManager.greenDark,
                               ),),
                             ],
                           ),
                           SizedBox(width: 10),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text("Adam Johnson", style:TextStyle(
                                 fontSize: FontSize.s14,
                                 fontWeight: FontWeight.w700,
                                 color: ColorManager.mediumgrey,
                               ),),
                               SizedBox(height: 5),
                               Text("Available", style:TextStyle(
                                 fontSize: FontSize.s14,
                                 fontWeight: FontWeight.w400,
                                 color: ColorManager.greenDark,
                               ),),
                               SizedBox(height: 5),
                               Text("Sacramento Z1 (2.4 Miles Away)", style:TextStyle(
                                 fontSize: FontSize.s14,
                                 fontWeight: FontWeight.w400,
                                 color: ColorManager.mediumgrey,
                               ),),
                               SizedBox(height: 5),
                               Text("Salaried", style:TextStyle(
                                 fontSize: FontSize.s14,
                                 fontWeight: FontWeight.w700,
                                 color: ColorManager.mediumgrey,
                               ),),
       
                             ],
                           ),
       
                         ],
                       ),
                       SizedBox(height: 5),
                     ],
                   ),
                 ),
             ),
       
                 Container(
                   width: 300,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text("Week 1 ", style:TextStyle(
                         fontSize: FontSize.s14,
                         fontWeight: FontWeight.w700,
                         color: ColorManager.mediumgrey,
                       ),),
                       SizedBox(height: AppSize.s25,),
                       Text("1.2024-12-1  (Tuesday) , 01:00 PM", style:TextStyle(
                         fontSize: FontSize.s14,
                         fontWeight: FontWeight.w400,
                         color: ColorManager.mediumgrey,
                       ),),
                       SizedBox(height: 5),
                       Text("2.2024-12-1  (Tuesday) , 01:00 PM", style:TextStyle(
                         fontSize: FontSize.s14,
                         fontWeight: FontWeight.w400,
                         color: ColorManager.mediumgrey,
                       ),),
       
       
                     ],
                   ),
                 ),
       
                 SizedBox(
                   height: 120, // Set this to match the height of your container
                   child: VerticalDivider(
                     width: 2,  // Divider width
                     color: ColorManager.containerBorderGrey, // Divider color
                     thickness: 2, // Thickness of the divider
                   ),
                 ),
                 Container(
                   width: 300,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text("Week 2 ", style:TextStyle(
                         fontSize: FontSize.s14,
                         fontWeight: FontWeight.w700,
                         color: ColorManager.mediumgrey,
                       ),),
                       SizedBox(height: AppSize.s25,),
                       Text("1.2024-12-1  (Tuesday) , 01:00 PM", style:TextStyle(
                         fontSize: FontSize.s14,
                         fontWeight: FontWeight.w400,
                         color: ColorManager.mediumgrey,
                       ),),
                       SizedBox(height: 5),
                       Text("2.2024-12-1  (Tuesday) , 01:00 PM", style:TextStyle(
                         fontSize: FontSize.s14,
                         fontWeight: FontWeight.w400,
                         color: ColorManager.mediumgrey,
                       ),),
       
       
                     ],
                   ),
                 ),
                 SizedBox(
                   height: 120, // Set this to match the height of your container
                   child: VerticalDivider(
                     width: 2,  // Divider width
                     color: ColorManager.containerBorderGrey, // Divider color
                     thickness: 2, // Thickness of the divider
                   ),
                 ),
                 Container(
                   width: 300,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text("Week 3 ", style:TextStyle(
                             fontSize: FontSize.s14,
                             fontWeight: FontWeight.w700,
                             color: ColorManager.mediumgrey,
                           ),),
                           IconButton(onPressed: (){}, icon: Icon(Icons.close,color: ColorManager.faintOrange,))
                         ],
                       ),
                       SizedBox(height: AppSize.s25,),
                       Text("1.2024-12-1  (Tuesday) , 01:00 PM", style:TextStyle(
                         fontSize: FontSize.s14,
                         fontWeight: FontWeight.w400,
                         color: ColorManager.mediumgrey,
                       ),),
                       SizedBox(height: 5),
                       Text("2.2024-12-1  (Tuesday) , 01:00 PM", style:TextStyle(
                         fontSize: FontSize.s14,
                         fontWeight: FontWeight.w400,
                         color: ColorManager.mediumgrey,
                       ),),
       
       
                     ],
                   ),
                 ),
                 SizedBox(width: 10,),
       
       
               ],
             ),
       
             SizedBox(height: AppSize.s30,),
       
             Padding(
               padding: const EdgeInsets.only(bottom: 5,left: 5),
               child: Text(
                 'Notes to Clinician',
                 style: AllPopupHeadings.customTextStyle(context),
               ),
             ),
             Container(
               height: AppSize.s60,
               width: 650,
               child: TextFormField(
                 controller: DSummarycont,
                 maxLines: 3,
                 cursorColor: Colors.black,
                 decoration: InputDecoration(
                   //labelText: 'Diagnosis Summary',
                   labelStyle: DocumentTypeDataStyle.customTextStyle(context),
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(8.0),
                     borderSide: BorderSide(
                       color: ColorManager.containerBorderGrey,
                       width: 1.0,
                     ),
                   ),
                   enabledBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(8.0),
                     borderSide: BorderSide(
                       color: ColorManager.containerBorderGrey,
                       width: 1.0,
                     ),
                   ),
                   focusedBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(8.0),
                     borderSide: BorderSide(
                       color: ColorManager.containerBorderGrey,
                       width: 1.0,
                     ),
                   ),
                 ),
               ),
             ),
             SizedBox(height: AppSize.s30,),
             Container(
               height:35,
               width: 200,
               child: ElevatedButton.icon(
                 icon: Icon(Icons.add,color: ColorManager.bluebottom,),
                 onPressed: (){
                  // showDialog(context: context, builder: (context) => ViewDetailsPopup());
                 },
                 style: ElevatedButton.styleFrom(
                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                   backgroundColor: ColorManager.white,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(12),
                     side: BorderSide(color: ColorManager.bluebottom),
                   ),
                 ), label: Text(
                   "Add Assistant Clinician",
                   style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s14,
                     fontWeight: FontWeight.w600,
                     color: ColorManager.bluebottom,)
               ),
               ),
             ),

             SizedBox(height: AppSize.s30,),
             Divider(),
             SizedBox(height: AppSize.s30,),
             Text("Clinician Type", style:TextStyle(
               fontSize: FontSize.s14,
               fontWeight: FontWeight.w700,
               color: ColorManager.mediumgrey,
             ),),
             SizedBox(height: 5),
             CICCDropdown(
               width:500,

               //  isAstric:false,
               // Adjust headText based on depId
               //initialValue: 'Filter by',
               // headText: "", // Default fallback if depId doesn't match any of the expected values
               items: [],
               onChange: (newValue) {
                 // for (var a in snapshot.data!) {
                 //   if (a.empType == newValue) {
                 //     clinicialName = a.empType!;
                 //     clinicalId = a.employeeTypesId!;
                 //     print("Dept ID'''''' ${clinicalId}");
                 //     print("';';';''''''''Dept ID ${clinicialName}");
                 //     // Do something with docType
                 //   }
                 // }
               },
             ),

             SizedBox(height: AppSize.s25,),

             Row(
               children: [
                 Container(
                   width: 300,
                   height: 35,
                   child: TextField(
                     // controller: _controller,
                     textCapitalization:
                     TextCapitalization.words,
                     style: DocumentTypeDataStyle.customTextStyle(context),
                     // onChanged: _search,
                     decoration: InputDecoration(
                         filled: true,
                         fillColor: Color(0xFFF8F8F8),
                         hintText: 'Search',
                         alignLabelWithHint: true,
                         // hintStyle: DocumentTypeDataStyle.customTextStyle(context),
                         enabledBorder: OutlineInputBorder(
                           borderSide: BorderSide(color:Color(0xFFC9C9C9)),
                           borderRadius: BorderRadius.circular(20),
                         ),
                         focusedBorder: OutlineInputBorder(
                           borderSide: BorderSide(color:ColorManager.greylight ),
                           borderRadius: BorderRadius.circular(20),
                         ),
                         // border: OutlineInputBorder(
                         //
                         //     borderRadius: BorderRadius.all(
                         //
                         //         Radius.circular(20))),
                         prefixIcon: IconButton(
                           splashColor: Colors.transparent,
                           highlightColor: Colors.transparent,
                           hoverColor: Colors.transparent,
                           icon: Center(
                             child: Icon(
                               Icons.search,
                               size: 18,
                               color:  ColorManager.greylight,
                             ),
                           ),
                           onPressed: () {},
                         ),
                         contentPadding: EdgeInsets.symmetric(
                             horizontal: 20, vertical: 5)),
                   ),

                 ),SizedBox(width: 20,),
                 Padding(
                   padding: const EdgeInsets.all(10),
                   child: Container(

                     decoration: BoxDecoration(
                         border:  Border.all(color: Color(0xFFC9C9C9), width: 0.86),
                         borderRadius: BorderRadius.all(
                             Radius.circular(8))
                     ),
                     // child:buildDropdownButton(context),
                     child: CustomDropdownTextField(
                       width:100,

                       isAstric:false,
                       // Adjust headText based on depId
                       initialValue: 'Filter by',
                       headText: "", // Default fallback if depId doesn't match any of the expected values
                       items: ['Weekly','Monthly',],
                       onChanged: (newValue) {
                         // for (var a in snapshot.data!) {
                         //   if (a.empType == newValue) {
                         //     clinicialName = a.empType!;
                         //     clinicalId = a.employeeTypesId!;
                         //     print("Dept ID'''''' ${clinicalId}");
                         //     print("';';';''''''''Dept ID ${clinicialName}");
                         //     // Do something with docType
                         //   }
                         // }
                       },
                     ),
                   ),
                 ),
               ],
             ),
             SizedBox(height: AppSize.s25,),
             Text("Suggestions", style:TextStyle(
               fontSize: FontSize.s14,
               fontWeight: FontWeight.w700,
               color: ColorManager.mediumgrey,
             ),),
             SizedBox(height: AppSize.s25,),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Container(
                   // height: 100,          // Height of the container
                   width: 300,           // Width of the container (adjust as needed)
                   decoration: BoxDecoration(
                     color: Colors.white,  // Background color (adjust as needed)
                     border: Border.all(
                       color: ColorManager.bluebottom,  // Border color
                       width: 2,             // Border width
                     ),
                     borderRadius: BorderRadius.circular(12),  // Circular border radius
                   ),
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Column(
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                           children: [
                             Text("In Zone", style:TextStyle(
                               fontSize: FontSize.s14,
                               fontWeight: FontWeight.w700,
                               color: ColorManager.greenDark,
                             ),),
                           ],
                         ),
                         SizedBox(height: 5),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Column(
                               children: [
                                 Row(
                                   children: [
                                     Stack(

                                       children: [SizedBox(
                                         height: 60,  // Adjust height for circle size
                                         width: 60,
                                         child: CircleAvatar(
                                           child:
                                           Image.asset('images/1.png',fit: BoxFit.contain,),
                                         ),
                                       ),
                                         Positioned(
                                           right:0,
                                           bottom :0,
                                           child: Container(
                                             color: Color(0xFF527FB9),
                                             width: 19,
                                             height: 19,
                                             child: Center(
                                               child: Text("ST",style: TextStyle(
                                                 // fontWeight: FontWeight.w600,
                                                 // fontSize: FontSize.s13,
                                                 color: ColorManager.white,
                                                 decoration: TextDecoration.none,
                                               ),),
                                             ),
                                           ),)
                                       ],
                                     ),
                                   ],
                                 ),
                                 SizedBox(height: 5),
                                 Text("\$24", style:TextStyle(
                                   fontSize: FontSize.s14,
                                   fontWeight: FontWeight.w700,
                                   color: ColorManager.greenDark,
                                 ),),
                               ],
                             ),
                             SizedBox(width: 10),
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text("Adam Johnson", style:TextStyle(
                                   fontSize: FontSize.s14,
                                   fontWeight: FontWeight.w700,
                                   color: ColorManager.mediumgrey,
                                 ),),
                                 SizedBox(height: 5),
                                 Text("Available", style:TextStyle(
                                   fontSize: FontSize.s14,
                                   fontWeight: FontWeight.w400,
                                   color: ColorManager.greenDark,
                                 ),),
                                 SizedBox(height: 5),
                                 Text("Sacramento Z1 (2.4 Miles Away)", style:TextStyle(
                                   fontSize: FontSize.s14,
                                   fontWeight: FontWeight.w400,
                                   color: ColorManager.mediumgrey,
                                 ),),
                                 SizedBox(height: 5),
                                 Text("Salaried", style:TextStyle(
                                   fontSize: FontSize.s14,
                                   fontWeight: FontWeight.w700,
                                   color: ColorManager.mediumgrey,
                                 ),),

                               ],
                             ),

                           ],
                         ),
                         SizedBox(height: 5),
                       ],
                     ),
                   ),
                 ),

                 Container(
                   width: 300,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text("Week 1 ", style:TextStyle(
                         fontSize: FontSize.s14,
                         fontWeight: FontWeight.w700,
                         color: ColorManager.mediumgrey,
                       ),),
                       SizedBox(height: AppSize.s25,),
                       Text("1.2024-12-1  (Tuesday) , 01:00 PM", style:TextStyle(
                         fontSize: FontSize.s14,
                         fontWeight: FontWeight.w400,
                         color: ColorManager.mediumgrey,
                       ),),
                       SizedBox(height: 5),
                       Text("2.2024-12-1  (Tuesday) , 01:00 PM", style:TextStyle(
                         fontSize: FontSize.s14,
                         fontWeight: FontWeight.w400,
                         color: ColorManager.mediumgrey,
                       ),),


                     ],
                   ),
                 ),

                 SizedBox(
                   height: 120, // Set this to match the height of your container
                   child: VerticalDivider(
                     width: 2,  // Divider width
                     color: ColorManager.containerBorderGrey, // Divider color
                     thickness: 2, // Thickness of the divider
                   ),
                 ),
                 Container(
                   width: 300,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text("Week 2 ", style:TextStyle(
                         fontSize: FontSize.s14,
                         fontWeight: FontWeight.w700,
                         color: ColorManager.mediumgrey,
                       ),),
                       SizedBox(height: AppSize.s25,),
                       Text("1.2024-12-1  (Tuesday) , 01:00 PM", style:TextStyle(
                         fontSize: FontSize.s14,
                         fontWeight: FontWeight.w400,
                         color: ColorManager.mediumgrey,
                       ),),
                       SizedBox(height: 5),
                       Text("2.2024-12-1  (Tuesday) , 01:00 PM", style:TextStyle(
                         fontSize: FontSize.s14,
                         fontWeight: FontWeight.w400,
                         color: ColorManager.mediumgrey,
                       ),),


                     ],
                   ),
                 ),
                 SizedBox(
                   height: 120, // Set this to match the height of your container
                   child: VerticalDivider(
                     width: 2,  // Divider width
                     color: ColorManager.containerBorderGrey, // Divider color
                     thickness: 2, // Thickness of the divider
                   ),
                 ),
                 Container(
                   width: 300,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text("Week 3 ", style:TextStyle(
                             fontSize: FontSize.s14,
                             fontWeight: FontWeight.w700,
                             color: ColorManager.mediumgrey,
                           ),),
                           IconButton(onPressed: (){}, icon: Icon(Icons.close,color: ColorManager.faintOrange,))
                         ],
                       ),
                       SizedBox(height: AppSize.s25,),
                       Text("1.2024-12-1  (Tuesday) , 01:00 PM", style:TextStyle(
                         fontSize: FontSize.s14,
                         fontWeight: FontWeight.w400,
                         color: ColorManager.mediumgrey,
                       ),),
                       SizedBox(height: 5),
                       Text("2.2024-12-1  (Tuesday) , 01:00 PM", style:TextStyle(
                         fontSize: FontSize.s14,
                         fontWeight: FontWeight.w400,
                         color: ColorManager.mediumgrey,
                       ),),


                     ],
                   ),
                 ),
                 SizedBox(width: 10,),


               ],
             ),

             SizedBox(height: AppSize.s30,),

             Padding(
               padding: const EdgeInsets.only(bottom: 5,left: 5),
               child: Text(
                 'Notes to Clinician',
                 style: AllPopupHeadings.customTextStyle(context),
               ),
             ),
             Container(
               height: AppSize.s60,
               width: 650,
               child: TextFormField(
                 controller: DSummarycont,
                 maxLines: 3,
                 cursorColor: Colors.black,
                 decoration: InputDecoration(
                   //labelText: 'Diagnosis Summary',
                   labelStyle: DocumentTypeDataStyle.customTextStyle(context),
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(8.0),
                     borderSide: BorderSide(
                       color: ColorManager.containerBorderGrey,
                       width: 1.0,
                     ),
                   ),
                   enabledBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(8.0),
                     borderSide: BorderSide(
                       color: ColorManager.containerBorderGrey,
                       width: 1.0,
                     ),
                   ),
                   focusedBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(8.0),
                     borderSide: BorderSide(
                       color: ColorManager.containerBorderGrey,
                       width: 1.0,
                     ),
                   ),
                 ),
               ),
             ),
             SizedBox(height: AppSize.s30,),
             Container(
               height:35,
               width: 200,
               child: ElevatedButton.icon(
                 icon: Icon(Icons.add,color: ColorManager.bluebottom,),
                 onPressed: (){
                   // showDialog(context: context, builder: (context) => ViewDetailsPopup());
                 },
                 style: ElevatedButton.styleFrom(
                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                   backgroundColor: ColorManager.white,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(12),
                     side: BorderSide(color: ColorManager.bluebottom),
                   ),
                 ), label: Text(
                   "Add Assistant Clinician",
                   style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s14,
                     fontWeight: FontWeight.w600,
                     color: ColorManager.bluebottom,)
               ),
               ),
             ),

             SizedBox(height: AppSize.s30,),
             Divider(),
             SizedBox(height: AppSize.s30,),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 ElevatedButton(onPressed: () {  }, child: Text("Submit", style: TextStyle(
                   fontSize: FontSize.s13,
                   fontWeight: FontWeight.w600,
                   color: ColorManager.white,
                   decoration: TextDecoration.none,
                 )),style: ElevatedButton.styleFrom(
                   backgroundColor:  ColorManager.bluebottom,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.all(
                       Radius.circular(12), // Round only the top-left corner
                       // Round only the bottom-left corner
                     ),
                     side: BorderSide(
                       color: Color(0xFF0A74DA), // Border color
                       width: 1,
                     ),
                   ),
                 ),)
               ],
             ),
             SizedBox(height: AppSize.s30,),
           ],
         ),
       ),
     ),
    );
  }
}
