import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/presentation/screens/sm_module/widgets/table_constant.dart';
import 'package:prohealth/presentation/widgets/custom_icon_button_constant.dart';

import '../widgets/button_constant.dart';
import '../widgets/text_form_field_const.dart';

class HrSalesScreen extends StatefulWidget {
   HrSalesScreen({super.key});

  @override
  State<HrSalesScreen> createState() => _HrSalesScreenState();
}

class _HrSalesScreenState extends State<HrSalesScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();

   late int currentPage;
   late int itemsPerPage;
   late List<String> items;

   @override
   void initState() {
     super.initState();
     currentPage = 1;
     itemsPerPage = 6;
     items = List.generate(20, (index) => 'Item ${index + 1}');
   }

  @override
  Widget build(BuildContext context) {
    List<String> currentPageItems = items.sublist(
      (currentPage - 1) * itemsPerPage,
      min(currentPage * itemsPerPage, items.length),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomIconButtonConst(text: 'Add Employee Type', icon: Icons.add,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    content: Container(
                      height: 273,
                      width: 309,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8)
                      ),
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
                              SMTextFConst(controller: nameController, keyboardType: TextInputType.text, text: 'Employee Type',),
                              SizedBox(height: 15,),
                              SMTextFConst(controller: addressController, keyboardType: TextInputType.streetAddress, text: 'Shorthand',),
                              SizedBox(height: 15,),
                              SMTextFConst(controller: emailController, keyboardType: TextInputType.emailAddress, text: 'Type of Employee',),
                              SizedBox(height: 15,),
                              Row(
                                children: [
                                  Text('Color',
                                    style: GoogleFonts.firaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff686464),
                                      decoration: TextDecoration.none,
                                    ),),
                                  SizedBox(width: 25,),
                                  Container(
                                    padding: EdgeInsets.all(3),
                                    width: 61,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      border: Border.all(width: 1, color: Colors.black26,
                                      ),
                                    ),
                                    child: Container(
                                      width: 57,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: Color(0xffE8A87D),
                                      ),
                                    ),
                                  )

                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 20,)
                        ],
                      ),
                    ),
                    actions: [
                      Center(
                        child: CustomElevatedButton(
                            width: 105,
                            height: 31,
                            text: 'Add',
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             LoginScreen()));
                            }),
                      )
                    ],
                  );
                },
              );
            }),
        SizedBox(height: 5,),
        TableHeadConstant(items: [
          TableHeadItem(text: 'Sr No', textAlign: TextAlign.start),
          TableHeadItem(text: 'EmployeeType', textAlign: TextAlign.start),
          TableHeadItem(text: 'Abbreviation            ', textAlign: TextAlign.start),
          TableHeadItem(text: 'Color', textAlign: TextAlign.start),
          TableHeadItem(text: 'Actions ', textAlign: TextAlign.center),
        ]),
        SizedBox(height: 5,),
        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 2,
              itemBuilder: (context, index) {
                int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                String formattedSerialNumber =
                serialNumber.toString().padLeft(2, '0');
                return Container(
                    margin: EdgeInsets.all(5,),
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
                    height: 56,
                    child: Column(
                      children: [
                        Row(
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
                              'Sales Manager',
                              textAlign: TextAlign.end,
                              style: GoogleFonts.firaSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff686464),
                                decoration: TextDecoration.none,
                              ),
                            ),
                            Text(
                              'SM',
                              textAlign: TextAlign.end,
                              style: GoogleFonts.firaSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff686464),
                                decoration: TextDecoration.none,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width/20,
                              height: 22,
                             // margin: EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color(0xffE8A87D),
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          content: Container(
                                            height: 283,
                                            width: 309,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8)
                                            ),
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
                                                    Row(
                                                      children: [
                                                        Text('Color',
                                                          style: GoogleFonts.firaSans(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w700,
                                                            color: Color(0xff686464),
                                                            decoration: TextDecoration.none,
                                                          ),),
                                                        SizedBox(width: 25,),
                                                        Container(
                                                          padding: EdgeInsets.all(3),
                                                          width: 61,
                                                          height: 22,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(2),
                                                            border: Border.all(width: 1, color: Colors.black26,
                                                            ),
                                                          ),
                                                          child: Container(
                                                            width: 57,
                                                            height: 16,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(2),
                                                              color: Color(0xffE4CCF3),
                                                            ),
                                                          ),
                                                        )

                                                      ],
                                                    ),
                                                    SizedBox(height: 15,),
                                                    SMTextFConst(controller: nameController, keyboardType: TextInputType.text, text: 'Type',),
                                                    SizedBox(height: 15,),
                                                    SMTextFConst(controller: addressController, keyboardType: TextInputType.streetAddress, text: 'Shorthand',),
                                                    SizedBox(height: 15,),
                                                    SMTextFConst(controller: emailController, keyboardType: TextInputType.emailAddress, text: 'Type of Employee',),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            Center(
                                              child: CustomElevatedButton(
                                                  width: 105,
                                                  height: 31,
                                                  text: 'Save',
                                                  onPressed: () {
                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //         builder: (context) =>
                                                    //             LoginScreen()));
                                                  }),
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit_outlined,
                                    color: ColorManager.darktgrey,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                  },
                                  icon: Icon(
                                    Icons.delete_outline,
                                    color: ColorManager.faintOrange,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ));
              }),
        ),
      ],
    );
  }
}
