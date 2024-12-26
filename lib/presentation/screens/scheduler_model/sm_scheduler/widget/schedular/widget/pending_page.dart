import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_scheduler/widget/schedular/widget/tab_widget/auto_tab.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../../../widgets/widgets/constant_textfield/const_textfield.dart';
import '../../../../../em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import '../../../../textfield_dropdown_constant/chatbotContainer.dart';
import '../../../../widgets/constant_widgets/button_constant.dart';

class PendingPageView extends StatefulWidget {
  const PendingPageView({super.key});

  @override
  State<PendingPageView> createState() => _PendingPageViewState();
}

class _PendingPageViewState extends State<PendingPageView> {


  bool isSwitched = false;

  String _selectedValue = 'Sort';
  bool _isChatbotVisible = false;

  void _toggleChatbotVisibility() {
    setState(() {
      _isChatbotVisible = !_isChatbotVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Stack(
        children:[ Padding(
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

                      ),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomDropdownTextField(
                        width: 150,
                        isAstric:false,
                        // Adjust headText based on depId
                        initialValue: 'Employee Type',
                        headText: "", // Default fallback if depId doesn't match any of the expected values
                        items: ['Employee 1','Employee 2','Employee 3'],
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
                      CustomDropdownTextField(
                        width:150,
                        isAstric:false,
                        // Adjust headText based on depId
                        initialValue: 'Clinician Type',
                        headText: "", // Default fallback if depId doesn't match any of the expected values
                        items: ['Clinical 1','Clinical 2','Clinical 3'],
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

                      Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: Text("SOC",style: DocumentTypeDataStyle.customTextStyle(context),),
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
                        padding: const EdgeInsets.only(right: 8,left: 5),
                        child: Text("POC",style: DocumentTypeDataStyle.customTextStyle(context),),
                      ),

                      Container(
                        width: 130,
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
                                  color: Color(0xFF527FB9).withOpacity(0.5),
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
                                  color: Color(0xFFFEBD4D).withOpacity(0.5),
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
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(right: 0),
                                  child:
                                  InkWell(
                                    child: SvgPicture.asset("images/sm/contact_s.svg",  height: 30,width: 20,)
                                 ,onTap: _toggleChatbotVisibility,)
                              ),
                            ],
                          ),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: 200,
                                  height: 55,
                                  child:Row(
                                    children: [
                                      Container(
                                        width: 100,
                                        child:  ElevatedButton.icon(onPressed: ()async{
                                          await  Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => Auto_Assign()),
                                          );
                                        },label: Text("Auto", style: TextStyle(
                                          fontSize: FontSize.s13,
                                          fontWeight: FontWeight.w600,
                                          color: ColorManager.white,
                                          decoration: TextDecoration.none,
                                        )),
                                          //icon: Icon(Icons.flash_auto,color:ColorManager.white ,size: 16,),
                                          icon: Image.asset("images/sm/auto.png",height: 30,width: 18,),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:  ColorManager.bluebottom,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12), // Round only the top-left corner
                                                bottomLeft: Radius.circular(12), // Round only the bottom-left corner
                                              ),
                                              side: BorderSide(
                                                color: Color(0xFF0A74DA), // Border color
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        child:  ElevatedButton.icon(onPressed: (){
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AddErrorPopup(
                                                message: 'File is too large!',
                                              );
                                            },
                                          );
                                        },label: Text("Manual", style: TextStyle(
                                          fontSize: FontSize.s13,
                                          fontWeight: FontWeight.w600,
                                          color: ColorManager.bluebottom,
                                          decoration: TextDecoration.none,
                                        )),
                                          //icon: Icon(Icons.swipe_rounded,color:ColorManager.bluebottom ,size: 16,),
                                          icon: Image.asset("images/sm/manual.png",height: 30,width: 18,),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(12), // Round only the top-left corner
                                                bottomRight: Radius.circular(12), // Round only the bottom-left corner
                                              ),
                                              side: BorderSide(
                                                color: Color(0xFF0A74DA), // Border color
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),


                                    ],
                                  )
                              )
                            ],
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Container(
                          //       width: 150,
                          //       height: 31,
                          //       child: ElevatedButton.icon(onPressed: (){}, label: Text("Auto Assign", style: BlueButtonTextConst.customTextStyle(context),),
                          //         icon: Icon( FontAwesomeIcons.userCheck,color:ColorManager.white ,size: 16,),
                          //         style: ElevatedButton.styleFrom(backgroundColor:  ColorManager.bluebottom,
                          //           elevation: 5,
                          //           shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(12),
                          //
                          //           ),),
                          //       ),
                          //     )
                          //   ],
                          // ),

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
         // if (_isChatbotVisible)
          // Background overlay when the popup is visible
            if (_isChatbotVisible)
              Positioned.fill(
                child: GestureDetector(
                  onTap: _toggleChatbotVisibility, // Close popup on tapping outside
                  child: Container(
                    color: Colors.transparent
                  ),
                ),
              ),
            AnimatedPositioned(duration:Duration(milliseconds: 300),
                bottom: _isChatbotVisible ? 0 : -500, // Slide in from bottom-right
                right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFF7F8FA),
                borderRadius: BorderRadius.circular(10),
              ),
          height: 450,
          width: 500,


              child: ChatBotContainer(
                onClose: _toggleChatbotVisibility,
              ),

        ) )

        ] ,

      ),

    );
  }





}
