import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/widgets/widgets/constant_textfield/const_textfield.dart';

class PatientDetailsCalender extends StatefulWidget {
  final VoidCallback onBack;
  const PatientDetailsCalender({super.key, required this.onBack});

  @override
  State<PatientDetailsCalender> createState() => _PatientDetailsCalenderState();
}

class _PatientDetailsCalenderState extends State<PatientDetailsCalender> {
  bool isSwitched = false;
  final PageController _pageController = PageController();

  int selectedIndex = 0;
  void selectButton(int index) {
    setState(() {
      selectedIndex = index;
    });

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void pageTransition() {
    if (isSwitched) {
      selectButton(1);
    }else{
      selectButton(0);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    pageTransition();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:ColorManager.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 100),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: widget.onBack,
                  label: Text(
                    'Back',
                    style: GoogleFonts.firaSans(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.medium,
                        color: ColorManager.textBlack),
                  ),
                  icon: Icon(Icons.keyboard_arrow_left_rounded, color: ColorManager.textBlack),
                ),
                Row(
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
                    SizedBox(width: 10,),
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
                    SizedBox(width: 20,),
                    Text('SOC',style: DocumentTypeDataStyle.customTextStyle(context),),
                    SizedBox(width: 10,),
                    /// Toggle button
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                      activeColor: ColorManager.blueprime,
                      inactiveThumbColor: ColorManager.white,
                      inactiveTrackColor: Colors.grey,
                    ),
                    SizedBox(width: 10,),
                    //ToggleButtons(children: [], isSelected: [true]),
                    Text('POC',style: DocumentTypeDataStyle.customTextStyle(context),)
                  ],
                ),

              ],
            ),
            SizedBox(height: 30,),
            PageView(
              children: [
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
                                  padding: const EdgeInsets.only(right: 50),
                                  child: Icon(Icons.call,color: ColorManager.greenDark,),
                                ),
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
                                  child:Text("John Smith, 999 Anywhere St.,Apt 555, Medford MA 02155 ",
                                    textAlign: TextAlign.start,
                                    style:DocumentTypeDataStyle.customTextStyle(context),
                                  ) ,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.access_time_rounded,color: ColorManager.faintGrey,),
                                Text("08:05 AM TO 09:00 AM",style:DocumentTypeDataStyle.customTextStyle(context),)
                              ],
                            ),

                            Row(
                              children: [
                                // Text("POC :",style: DocumentTypeDataStyle.customTextStyle(context),),
                                //  Padding(
                                //    padding: const EdgeInsets.all(8.0),
                                //    child: Container(
                                //      color: Color(0xFF527FB9),
                                //      width: 19,
                                //      height: 19,
                                //      child: Center(
                                //        child: Text("ST",style: TextStyle(
                                //          // fontWeight: FontWeight.w600,
                                //          // fontSize: FontSize.s13,
                                //          color: ColorManager.white,
                                //          decoration: TextDecoration.none,
                                //        ),),
                                //      ),
                                //    ),
                                //  ),
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
                Expanded(
                  child: ListView.builder(
                    itemCount: 2,
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
                                  padding: const EdgeInsets.only(right: 50),
                                  child: Icon(Icons.call,color: ColorManager.greenDark,),
                                ),
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
                                  child:Text("John Smith, 999 Anywhere St.,Apt 555, Medford MA 02155 ",
                                    textAlign: TextAlign.start,
                                    style:DocumentTypeDataStyle.customTextStyle(context),
                                  ) ,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.access_time_rounded,color: ColorManager.faintGrey,),
                                Text("08:05 AM TO 09:00 AM",style:DocumentTypeDataStyle.customTextStyle(context),)
                              ],
                            ),

                            Row(
                              children: [
                                // Text("POC :",style: DocumentTypeDataStyle.customTextStyle(context),),
                                //  Padding(
                                //    padding: const EdgeInsets.all(8.0),
                                //    child: Container(
                                //      color: Color(0xFF527FB9),
                                //      width: 19,
                                //      height: 19,
                                //      child: Center(
                                //        child: Text("ST",style: TextStyle(
                                //          // fontWeight: FontWeight.w600,
                                //          // fontSize: FontSize.s13,
                                //          color: ColorManager.white,
                                //          decoration: TextDecoration.none,
                                //        ),),
                                //      ),
                                //    ),
                                //  ),
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
            )

          ],
        ),
      ),
    );
  }
}
