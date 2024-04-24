import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/sm_module/widgets/text_form_field_const.dart';

import '../../../widgets/custom_icon_button_constant.dart';
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
  late int currentPage;
  late int itemsPerPage;
  late List<String> items;


  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 5;
    items = List.generate(20, (index) => 'Item ${index + 1}');
  }

  @override
  Widget build(BuildContext context) {
    List<String> currentPageItems = items.sublist(
      (currentPage - 1) * itemsPerPage,
      min(currentPage * itemsPerPage, items.length),
    );

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
                      fontWeight: FontWeight.w600,
                      color: Color(0xff686464),
                      decoration: TextDecoration.none,
                    ),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 31,
                          width: 185,
                         // margin: EdgeInsets.symmetric(horizontal: 20),
                          padding: EdgeInsets.symmetric(vertical: 6,horizontal: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color(0xff686464).withOpacity(0.5),width: 1), // Black border
                            borderRadius: BorderRadius.circular(12), // Rounded corners
                          ),
                          child: DropdownButtonFormField<String>(
                            focusColor: Colors.transparent,
                            icon: Icon(Icons.arrow_drop_down_sharp,color: Color(0xff686464),),
                            decoration: InputDecoration.collapsed(hintText: ''),
                            items: <String>['Home Health', 'Option 1', 'Option 2', 'Option 3', 'Option 4']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                            },
                            value: 'Home Health',
                            style: GoogleFonts.firaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff686464),
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                        Container(
                          height: 31,
                          width: 185,
                          // margin: EdgeInsets.symmetric(horizontal: 20),
                          padding: EdgeInsets.symmetric(vertical: 6,horizontal: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color(0xff686464).withOpacity(0.5),width: 1), // Black border
                            borderRadius: BorderRadius.circular(12), // Rounded corners
                          ),
                          child: DropdownButtonFormField<String>(
                            focusColor: Colors.transparent,
                            icon: Icon(Icons.arrow_drop_down_sharp,color: Color(0xff686464),),
                            decoration: InputDecoration.collapsed(hintText: ''),
                            items: <String>['NC', 'Option 1', 'Option 2', 'Option 3', 'Option 4']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                            },
                            value: 'NC',
                            style: GoogleFonts.firaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff686464),
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 130,
                      height: 32,
                      child: CustomIconButtonConst(
                          text: 'Add Payrate', icon: Icons.add, onPressed: () {}),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20,),
            Container(
              height: 30,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Sr No',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.firaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Text('Type of Visit',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      )),
                  // SizedBox(width: MediaQuery.of(context).size.width/7.5,),
                  Text('Rate',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      )),

                  //SizedBox(width: MediaQuery.of(context).size.width/5.5,),
                  Text('Zone',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      )),
                  // SizedBox(height: 1,),
                  //SizedBox(width: MediaQuery.of(context).size.width/150,),
                  Text('Actions',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ///list
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: currentPageItems.length,
                  itemBuilder: (context, index) {
                    int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                    String formattedSerialNumber =
                    serialNumber.toString().padLeft(2, '0');
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff000000).withOpacity(0.25),
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  formattedSerialNumber,
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.firaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff686464),
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                                Text(
                                  'Additional Rates',
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.firaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff686464),
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                                Text(
                                  '\$4.58',
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.firaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff686464),
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                                Text(
                                  'San Jose Zone 1',
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.firaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff686464),
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.edit_outlined,
                                      color: Color(0xffF6928A),
                                    )),
                              ],
                            )),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildDropdownButton(BuildContext context) {
  return Container(
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
  );
}