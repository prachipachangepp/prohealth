import 'package:flutter/material.dart';

import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../../app/resources/value_manager.dart';
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
         SizedBox(height: 100,),
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
                 SchedularIconButtonConst(
                   width: 117,
                   text: 'Add Physician',
                   icon: Icons.add,
                   onPressed: () {}
                   // onPressed: () {}
                 ),
               ],
             ),
           ],
         ),

//          Container(
//            color: Colors.red,
// height: 70,
//
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: [
//                Row(
//                  children: [
//                    CircleAvatar(
//                      child:
//                      Image.asset('images/1.png'),
//                    ),
//                    SizedBox(width: AppSize.s7),
//                    Text(
//                      'James Smith',
//                      style:DocumentTypeDataStyle.customTextStyle(context),
//                    ),
//                  ],
//                ),
//                Row(
//                  children: [
//                    Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Icon(Icons.call),
//                    ),
//                    Container(
//                      width: 120,
//                      child:Text("+49 4464646548",
//                        style:DocumentTypeDataStyle.customTextStyle(context),) ,
//                    )
//                  ],
//                ),
//                Row(
//                  children: [
//                    Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Icon(Icons.location_on_outlined),
//                    ),
//                    Container(
//                      width: 200,
//
//                      child:Text("Tufts International Center, 20 Sawyer Ave, Medford MA 02155 ",
//                        textAlign: TextAlign.start,
//                        style:DocumentTypeDataStyle.customTextStyle(context),
//                      ) ,
//                    )
//                  ],
//                ),
//                Row(
//                  children: [
//                    Container(
//                      width: 200,
//                      child: ElevatedButton.icon(onPressed: (){}, label: Text("Upload prescription"),
//                      icon: Icon(Icons.file_upload_outlined),),
//                    )
//                  ],
//                ),
//
//
//              ],
//            ),
//          )
       ],

      ),
    );
  }
}
