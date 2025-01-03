import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../../../widgets/widgets/constant_textfield/const_textfield.dart';

class HistoryPageView extends StatefulWidget {
  const HistoryPageView({super.key});

  @override
  State<HistoryPageView> createState() => _HistoryPageViewState();
}

class _HistoryPageViewState extends State<HistoryPageView> {
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
              mainAxisAlignment: MainAxisAlignment.start,
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
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //
                //     Padding(
                //       padding: const EdgeInsets.only(right: 20),
                //       child: Container(
                //         // height: 32,
                //
                //         decoration: BoxDecoration(
                //             border:  Border.all(color: Color(0xFFC9C9C9), width: 0.86),
                //             borderRadius: BorderRadius.all(
                //                 Radius.circular(8))
                //         ),
                //         // child:buildDropdownButton(context),
                //         child: CustomDropdownTextField(
                //           width:100,
                //
                //           isAstric:false,
                //           // Adjust headText based on depId
                //           initialValue: 'Filter by',
                //           headText: "", // Default fallback if depId doesn't match any of the expected values
                //           items: ['Weekly','Monthly',],
                //           onChanged: (newValue) {
                //             // for (var a in snapshot.data!) {
                //             //   if (a.empType == newValue) {
                //             //     clinicialName = a.empType!;
                //             //     clinicalId = a.employeeTypesId!;
                //             //     print("Dept ID'''''' ${clinicalId}");
                //             //     print("';';';''''''''Dept ID ${clinicialName}");
                //             //     // Do something with docType
                //             //   }
                //             // }
                //           },
                //         ),
                //       ),
                //     ),
                //
                //
                //
                //
                //
                //   ],
                // ),
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
                                Stack(

                                  children: [SizedBox(
                                    height:50,
                                    child: CircleAvatar(
                                      child:
                                      Image.asset('images/1.png'),
                                    ),
                                  ),
                                    Positioned(
                                      left:22,
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
                                SizedBox(width: AppSize.s7),
                                Text(
                                  'John Smith',
                                  style:DocumentTypeDataStyle.customTextStyle(context),
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
                              Padding(
                                  padding: const EdgeInsets.only(right: 0),
                                  child:SvgPicture.asset("images/sm/contact_s.svg",  height: 30,width: 20,)
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.start, // Aligns items in the row to the start (left)
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Auto assigned on 2024/12/08 |",style: DocumentTypeDataStyle.customTextStyle(context),),
                                 // Text("2023/25/05",style: DocumentTypeDataStyle.customTextStyle(context),),
                                ],
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.start, // Aligns items in the row to the start (left)
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("10:00 AM ",style: DocumentTypeDataStyle.customTextStyle(context),),

                                ],
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
                  ); },

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
