import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../../em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import '../../../../widgets/constant_widgets/button_constant.dart';


class OverdeuPageView extends StatefulWidget {
  const OverdeuPageView({super.key});

  @override
  State<OverdeuPageView> createState() => _OverdeuPageViewState();
}

class _OverdeuPageViewState extends State<OverdeuPageView> {

  String _selectedValue = 'Sort';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100,vertical: 10
        ),
        child: Column(
          children: [
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 300,
                      height: 32,
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
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(child: Row(  mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [ Text("Employee Type"), IconButton(onPressed: (){}, icon: Icon(Icons.arrow_drop_down_sharp))],),),
                    Container(child: Row(  mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [ Text("Clinician Type"), IconButton(onPressed: (){}, icon: Icon(Icons.arrow_drop_down_sharp))],),),



                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Container(

                        decoration: BoxDecoration(
                            border:  Border.all(color: Color(0xFFC9C9C9), width: 0.86),
                            borderRadius: BorderRadius.all(
                                Radius.circular(8))
                        ),
                        child:buildDropdownButton(context),
                      ),
                    ),

                  ],
                ),
              ],
            ),

            SizedBox(height: 30,),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) { return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1,
                    vertical: 5,),
                  child: Container(
                    // color: Colors.red,
                    height: 80,
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
                              Padding(
                                padding: const EdgeInsets.only(top: 18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Jeh Tiwari',
                                      style:DocumentTypeDataStyle.customTextStyle(context),
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(8),
                                    color:Color(0xFFDCEFF7) ,
                                  ),
                                  height:40,
                                  width: 40,

                                  child: Icon(Icons.location_on_outlined,color: ColorManager.bluebottom,)),
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

                        Row(
                          children: [
                            Text("Intake Date : ",style: DocumentTypeDataStyle.customTextStyle(context),),
                            Text("2023/25/05",style: AllHRTableData.customTextStyle(context),),

                          ],
                        ),

                        Row(
                          children: [
                            Text("SOC",style: DocumentTypeDataStyle.customTextStyle(context),),

                          ],
                        ),
                        Row(
                          children: [
                            Text("Overdue",style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.s13,
                              color: ColorManager.tangerine,
                              decoration: TextDecoration.none,
                            ),)
                          ],
                        ),

                        // Row(
                        //   children: [
                        //     Padding(
                        //         padding: const EdgeInsets.only(right: 0),
                        //         child: Image.asset("images/sm/contact.png",height: 50,width: 60,)
                        //     ),
                        //   ],
                        // ),
                        //
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Container(
                        //         width: 200,
                        //         height: 55,
                        //         child:Row(
                        //           children: [
                        //             Container(
                        //               width: 100,
                        //               child:  ElevatedButton.icon(onPressed: ()async{
                        //                 await  showDialog(
                        //                   context: context,
                        //                   builder: (BuildContext context) {
                        //                     return VendorSelectNoti(
                        //                       message: 'Please Select A File',
                        //                     );
                        //                   },
                        //                 );
                        //               },label: Text("Auto", style: TextStyle(
                        //                 fontSize: FontSize.s13,
                        //                 fontWeight: FontWeight.w600,
                        //                 color: ColorManager.white,
                        //                 decoration: TextDecoration.none,
                        //               )),
                        //                 icon: Icon(Icons.flash_auto,color:ColorManager.white ,size: 16,),
                        //                 style: ElevatedButton.styleFrom(
                        //                   backgroundColor:  ColorManager.bluebottom,
                        //                   shape: RoundedRectangleBorder(
                        //                     borderRadius: BorderRadius.only(
                        //                       topLeft: Radius.circular(12), // Round only the top-left corner
                        //                       bottomLeft: Radius.circular(12), // Round only the bottom-left corner
                        //                     ),
                        //                     side: BorderSide(
                        //                       color: Color(0xFF0A74DA), // Border color
                        //                       width: 1,
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //             Container(
                        //               width: 100,
                        //               child:  ElevatedButton.icon(onPressed: (){
                        //                 showDialog(
                        //                   context: context,
                        //                   builder: (BuildContext context) {
                        //                     return AddErrorPopup(
                        //                       message: 'File is too large!',
                        //                     );
                        //                   },
                        //                 );
                        //               },label: Text("Manual", style: TextStyle(
                        //                 fontSize: FontSize.s13,
                        //                 fontWeight: FontWeight.w600,
                        //                 color: ColorManager.bluebottom,
                        //                 decoration: TextDecoration.none,
                        //               )),
                        //                 icon: Icon(Icons.swipe_rounded,color:ColorManager.bluebottom ,size: 16,),
                        //                 style: ElevatedButton.styleFrom(
                        //                   backgroundColor: Colors.white,
                        //                   shape: RoundedRectangleBorder(
                        //                     borderRadius: BorderRadius.only(
                        //                       topRight: Radius.circular(12), // Round only the top-left corner
                        //                       bottomRight: Radius.circular(12), // Round only the bottom-left corner
                        //                     ),
                        //                     side: BorderSide(
                        //                       color: Color(0xFF0A74DA), // Border color
                        //                       width: 1,
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //
                        //
                        //           ],
                        //         )
                        //     )
                        //   ],
                        // ),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(right: 3),
                                child: Image.asset("images/sm/contact.png",height: 50,width: 60,)
                            ),

                            // Container(
                            //   width: 120,
                            //  // height: 32,
                            //   child: ElevatedButton.icon(onPressed: (){}, label: Text("Manual", style: BlueButtonTextConst.customTextStyle(context),),
                            //     icon: Icon( FontAwesomeIcons.userCheck,color:ColorManager.white ,size: 16,),
                            //     style: ElevatedButton.styleFrom(backgroundColor:  ColorManager.bluebottom,
                            //       elevation: 5,
                            //       shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(12),
                            //
                            //       ),),
                            //   ),
                            // ),
                            Container(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(8),
                                          color:Color(0xFFDCEFF7) ,
                                        ),
                                        height:40,
                                        width: 40,

                                        child: Icon(Icons.edit,color: ColorManager.bluebottom,)),
                                  ),
                                  CircleAvatar(
                                    child:
                                    Image.asset('images/1.png'),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),

                        Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: SizedBox()
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ); },

              ),
            ),



          ],
        ),
      ),
    );
  }

  Widget buildDropdownButton(BuildContext context) {
    final Map<String, String> displayTextMap = {
      'Sort': 'Filter by',
      'Opened': 'Opened',
      'Notopen': 'Not Opened',
      'Partial': 'Partial',
      'Completed': 'Completed',
    };

    return Column(
      children: [
        DropdownButton2<String>(
          value: _selectedValue,
          onChanged: (String? newValue) {
            setState(() {
              _selectedValue = newValue!;
              //filterData();
            });
          },
          style: AllPopupHeadings.customTextStyle(context),
          iconStyleData:  IconStyleData(
            icon: Icon(
              Icons.arrow_drop_down,
              color: ColorManager.mediumgrey,
            ),
          ),
          // iconSize: 20,
          underline: const SizedBox(),
          buttonStyleData: ButtonStyleData(
            height: 32,
            width: 130,
            padding:
            const EdgeInsets.symmetric(horizontal: 8), // Internal padding.
            elevation: 2, // Shadow depth.
            // decoration: BoxDecoration(
            //   color: Colors.white,
            //   border: Border.all(color: const Color(0xff50B5E5), width: 1.2),
            //   borderRadius: BorderRadius.circular(12.0),
            //   // boxShadow: [
            //   //   BoxShadow(
            //   //     color: const Color(0xff000000).withOpacity(0.25),
            //   //     blurRadius: 2,
            //   //     offset: const Offset(0, 2),
            //   //   ),
            //   // ],
            // ),
            overlayColor: WidgetStateProperty.all(
                Colors.grey.withOpacity(0.1)), // Background color when pressed.
          ),

          /// buttonPadding: const EdgeInsets.symmetric(horizontal: 8),
          // dropdownMaxHeight: 200,
          // dropdownDecoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(12),
          //   color: Colors.white,
          // ),
          // itemPadding: const EdgeInsets.symmetric(horizontal: 8), // Updated padding
          selectedItemBuilder: (context) =>
              displayTextMap.keys.map((String value) {
                return Align(
                  alignment: Alignment.center,
                  child: Text(displayTextMap[value]!),
                );
              }).toList(),
          items: displayTextMap.keys.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(displayTextMap[value]!),
            );
          }).toList(),
        ),
      ],
    );
  }
}
