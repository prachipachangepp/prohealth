import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../widgets/constant_widgets/button_constant.dart';

class PendingPageView extends StatefulWidget {
  const PendingPageView({super.key});

  @override
  State<PendingPageView> createState() => _PendingPageViewState();
}

class _PendingPageViewState extends State<PendingPageView> {


  bool isSwitched = false;

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
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text("SOC"),
                    ),
                    Container(
                      child:  Switch(
                        focusColor: Colors.transparent,

                        hoverColor: Colors.transparent,
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            print(isSwitched);
                          });
                        },
                        activeTrackColor: ColorManager.bluebottom,
                        inactiveTrackColor:ColorManager.bluebottom ,
                        activeColor: ColorManager.white,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Text("POC"),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Container(
                        width: 40, // Set the desired width
                        height: 32, // Set the desired height to make it square
                        decoration: BoxDecoration(
                            border: Border.all(width: 1,color: ColorManager.greylight),
                            borderRadius: BorderRadius.all(
                                Radius.circular(8))
                        ),
                        child: IconButton(onPressed: () {  }, icon: Icon(CupertinoIcons.bell,size: 18,color:ColorManager.mediumgrey,), splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Container(

                        decoration: BoxDecoration(
                          border: Border.all(width: 1,color: ColorManager.greylight),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(8))
                        ),
                        child:buildDropdownButton(context),
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 32,
                      child: ElevatedButton.icon(onPressed: (){}, label: Text("Bulk Assign", style: BlueButtonTextConst.customTextStyle(context),),
                        icon: Icon( Icons.supervisor_account,color:ColorManager.white ,size: 18,),
                        style: ElevatedButton.styleFrom(backgroundColor:  ColorManager.bluebottom,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),

                          ),),
                      ),
                    )
                    // Container(
                    //   width: 130,
                    //   height: 32,
                    //   child: SchedularIconButtonConst(
                    //       text: 'Bulk Assign',
                    //       icon: Icons.supervisor_account,
                    //       onPressed: () {}
                    //     // onPressed: () {}
                    //   ),
                    // ),
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
                              child: Icon(Icons.location_on_outlined),
                            ),
                            Container(
                              width: 200,

                              child:Text("John Smith, 999 Anywhere St.,Apt 555, Medford MA 02155 ",
                                textAlign: TextAlign.start,
                                style:DocumentTypeDataStyle.customTextStyle(context),
                              ) ,
                            )
                          ],
                        ),

                        Row(
                          children: [
                            Text("POC :",style: DocumentTypeDataStyle.customTextStyle(context),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
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
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Color(0xFFFEBD4D),
                                width: 19,
                                height: 19,
                                child: Center(
                                  child: Text("OT",style: TextStyle(
                                    // fontWeight: FontWeight.w600,
                                    //     fontSize: FontSize.s13,
                                    color: ColorManager.white,
                                    decoration: TextDecoration.none,
                                  ),),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text("Pending",style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize.s13,
                              color: Color(0xFFD00101),
                              decoration: TextDecoration.none,
                            ),)
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 165,
                              height: 31,
                              child: ElevatedButton.icon(onPressed: (){},label: Text("Manually Assign", style: TextStyle(
                                fontSize: FontSize.s14,
                                fontWeight: FontWeight.w600,
                                color: ColorManager.bluebottom,
                                decoration: TextDecoration.none,
                              )),
                                icon: Icon(Icons.check_circle_outline_rounded,color:ColorManager.bluebottom ,size: 18,),
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.white,

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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 150,
                              height: 31,
                              child: ElevatedButton.icon(onPressed: (){}, label: Text("Auto Assign", style: BlueButtonTextConst.customTextStyle(context),),
                                icon: Icon( FontAwesomeIcons.userCheck,color:ColorManager.white ,size: 16,),
                                style: ElevatedButton.styleFrom(backgroundColor:  ColorManager.bluebottom,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),

                                  ),),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 50),
                              child: Icon(Icons.call,color: ColorManager.greenDark,),
                            ),
                          ],
                        )

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
