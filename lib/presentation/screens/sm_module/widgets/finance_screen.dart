import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/sm_module/widgets/text_form_field_const.dart';

import 'button_constant.dart';

class FinanceScreen extends StatefulWidget {

  FinanceScreen({super.key});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String _selectedOption = 'Option 1';

  @override
  Widget build(BuildContext context) {

    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:  35.0,vertical: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                buildDropdownButton(context)

            ],),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Clinicians Pay Rates',
                  style: GoogleFonts.firaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff686464),
                    decoration: TextDecoration.none,
                  ),),
              ],
            ),
            SizedBox(height: 20,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pick Employee',
                      style: GoogleFonts.firaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff686464),
                      decoration: TextDecoration.none,
                    ),),
                  ],
                ),
              ],
            ),
              Row(
                children: [
                Container(
                  width: 185,
                  height: 31,
                  padding: EdgeInsets.symmetric(vertical: 6,horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0xff686464).withOpacity(0.5),width: 1),
                    borderRadius: BorderRadius.circular(12.0),
                  ),

                  child: DropdownButton<String>(
                    icon: Icon(Icons.arrow_drop_down,color: Color(0xff50B5E5),),
                    iconSize: 20,
                    underline: SizedBox(),
                  value: _selectedOption,
                    style: GoogleFonts.firaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff50B5E5),
                      decoration: TextDecoration.none,
                    ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedOption = newValue ?? '';
                    });
                    print('Selected: $_selectedOption');
                  },
                  items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                                ),
                ),
              SizedBox(width: 20,),
                  Container(
                    height: 31,
                    padding: EdgeInsets.symmetric(vertical: 6,horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xff50B5E5),width: 1.2),
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff000000).withOpacity(0.25),
                          blurRadius: 2,
                          offset: Offset(0,2),
                        ),
                      ],
                    ),
                    child: DropdownButton<String>(
                      value: 'Sort By',
                      style: GoogleFonts.firaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff50B5E5),
                        decoration: TextDecoration.none,
                      ),
                      icon: Icon(Icons.arrow_drop_down,color: Color(0xff50B5E5),),
                      iconSize: 20,
                      underline: SizedBox(),
                      onChanged: (String? newValue) {
                        // Show popup or AlertDialog
                        if (newValue != null) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              TextEditingController nameController = TextEditingController();
                              TextEditingController addressController = TextEditingController();
                              TextEditingController emailController = TextEditingController();
                              return AlertDialog(
                                  backgroundColor: Colors.white,
                                  content:  Container(
                                    height: 343,
                                    width: 409,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [IconButton(onPressed: (){
                                            Navigator.pop(context);
                                          }, icon: Icon(Icons.close))],),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SMTextFConst(controller: nameController, keyboardType: TextInputType.text, text: 'Type of Visit',),
                                            SizedBox(height: 25,),
                                            SMTextFConst(controller: addressController, keyboardType: TextInputType.streetAddress, text: 'Zone',),
                                            SizedBox(height: 25,),
                                            SMTextFConst(controller: emailController, keyboardType: TextInputType.emailAddress, text: 'Rate',),
                                          ],
                                        ),
                                        SizedBox(height: 60,),
                                        CustomElevatedButton(
                                            width: 105,
                                            height: 31,
                                            text: 'Submit',
                                            onPressed: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             LoginScreen()));
                                            })
                                      ],
                                    ),
                                  )
                              );
                            },
                          );
                        }
                      },
                      items: <String>['Sort By','For all zones', 'San Jose z4','San Jose z4','San Jose z4','San Jose z4',]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                            style: TextStyle(color: Color(0xff50B5E5)),),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
            Row(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ///text
                  Row(children: [
                    ///dropdown 1,2
                  ],
                  )
                ],
              )
            ],),
          ],
        ),
      ),
    );
  }
}

Widget buildDropdownButton(BuildContext context) {
  return Container(
    height: 40,
    padding: EdgeInsets.symmetric(vertical: 6,horizontal: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Color(0xff50B5E5),width: 1.2),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xff000000).withOpacity(0.25),
          blurRadius: 2,
          offset: Offset(0,2),
        ),
      ],
    ),
    child: DropdownButton<String>(
      value: 'Sort By',
      style: GoogleFonts.firaSans(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: Color(0xff50B5E5),
        decoration: TextDecoration.none,
      ),
      icon: Icon(Icons.arrow_drop_down,color: Color(0xff50B5E5),),
      iconSize: 20,
      underline: SizedBox(),
      onChanged: (String? newValue) {
        // Show popup or AlertDialog
        if (newValue != null) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              TextEditingController nameController = TextEditingController();
              TextEditingController addressController = TextEditingController();
              TextEditingController emailController = TextEditingController();
              return AlertDialog(
                backgroundColor: Colors.white,
                content:  Container(
                  height: 343,
                  width: 409,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: Icon(Icons.close))],),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SMTextFConst(controller: nameController, keyboardType: TextInputType.text, text: 'Type of Visit',),
                          SizedBox(height: 25,),
                          SMTextFConst(controller: addressController, keyboardType: TextInputType.streetAddress, text: 'Zone',),
                          SizedBox(height: 25,),
                          SMTextFConst(controller: emailController, keyboardType: TextInputType.emailAddress, text: 'Rate',),
                        ],
                      ),
                      SizedBox(height: 60,),
                      CustomElevatedButton(
                          width: 105,
                          height: 31,
                          text: 'Submit',
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             LoginScreen()));
                          })
                    ],
                  ),
                )
              );
            },
          );
        }
      },
      items: <String>['Sort By','For all zones', 'San Jose z4','San Jose z4','San Jose z4','San Jose z4',]
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value,
          style: TextStyle(color: Color(0xff50B5E5)),),
        );
      }).toList(),
    ),
  );
}