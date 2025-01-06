import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../../../widgets/widgets/constant_textfield/const_textfield.dart';
import 'completed_popup.dart';

class CompletedPageView extends StatefulWidget {
  const CompletedPageView({super.key});

  @override
  State<CompletedPageView> createState() => _CompletedPageViewState();
}

class _CompletedPageViewState extends State<CompletedPageView> {

  String _selectedValue = 'Sort';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100,vertical: 10),
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
                      child:TextField(
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
                            hintStyle: DocumentTypeDataStyle.customTextStyle(context),
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

                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Container(
                       // height: 32,

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
              ],
            ),

            SizedBox(height: 30,),
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) { return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1,
                      vertical: 5,),
                    child: InkWell(
                      onTap: ()async{
                    await showDialog(
                    context: context,
                    builder: (BuildContext context) { return Completed_popup();});
                      },
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
                                    padding: const EdgeInsets.only(top: 15),
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

                            Row(
                              children: [
                                // Text("POC :",style: DocumentTypeDataStyle.customTextStyle(context),),
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
                                Text("Completed",style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: FontSize.s13,
                                  color:  ColorManager.greenDark,
                                  decoration: TextDecoration.none,
                                ),)
                              ],
                            ),

                            Row(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(right: 0),
                                    child:SvgPicture.asset("images/sm/contact_sv.svg",  height: 30,width: 20,)
                                ),
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
                    ),
                  ); },

                ),
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
