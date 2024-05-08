import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/sm_module/hr_screens/widgets/add_emp_popup_const.dart';
import 'package:prohealth/presentation/screens/sm_module/hr_screens/widgets/edit_emp_popup_const.dart';
import 'package:prohealth/presentation/screens/sm_module/widgets/table_constant.dart';
import '../../../widgets/custom_icon_button_constant.dart';
import '../widgets/button_constant.dart';
import '../widgets/text_form_field_const.dart';

class HrClinicalScreen extends StatefulWidget {
   HrClinicalScreen({super.key});

  @override
  State<HrClinicalScreen> createState() => _HrClinicalScreenState();
}

class _HrClinicalScreenState extends State<HrClinicalScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController shorthandController = TextEditingController();
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
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ///dropdown
            Container(
              height: 32,
              width: 103,
              padding: EdgeInsets.symmetric(vertical: 6,horizontal: 6),
              decoration: BoxDecoration(
                color: Color(0xff50B5E5),
                borderRadius: BorderRadius.circular(12), // Rounded corners
              ),
              child: DropdownButtonFormField<String>(
                focusColor: Colors.transparent,
                icon: Icon(Icons.arrow_drop_down_sharp,color: Colors.white,),
                decoration: InputDecoration.collapsed(hintText: '',),
                items: <String>['Sort By','Available', 'Unavailable',]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                },
                value: 'Sort By',
                style: GoogleFonts.firaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff686464),
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            Container(
              width: 170,
              height: 32,
              child: CustomIconButtonConst(
                  text: 'Add Employee Type', icon: Icons.add,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomPopupWidget(
                          nameController: nameController,
                          addressController: addressController,
                          emailController: emailController,
                          onAddPressed: () {  },
                          containerColor: Color(0xffE8A87D),);
                      },
                    );
                  }),
            ),
          ],
        ),
        SizedBox(height: 5,),
        TableHeadConstant(
            items: [
              TableHeadItem(text: 'Sr No', textAlign: TextAlign.start),
              TableHeadItem(text: 'EmployeeType', textAlign: TextAlign.start),
              TableHeadItem(text: 'Abbreviation', textAlign: TextAlign.start),
              TableHeadItem(text: 'Color', textAlign: TextAlign.start),
              TableHeadItem(text: 'Actions', textAlign: TextAlign.center),
            ]),
        SizedBox(height: 5,),
        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: currentPageItems.length,
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                          Container(
                            margin: EdgeInsets.only(top: 5, right: 10),
                            height: 7,
                            width:7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Color(0xff008000)
                            ),
                          )
                        ],),
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
                              'License Vocational Nurse',
                              textAlign: TextAlign.end,
                              style: GoogleFonts.firaSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff686464),
                                decoration: TextDecoration.none,
                              ),
                            ),
                            Text(
                              'NC',
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
                                        return EditPopupWidget(
                                            typeController: typeController,
                                            shorthandController: shorthandController,
                                            emailController: emailController,
                                            containerColor: Color(0xffE4CCF3),
                                            onSavePressed: (){});
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit_outlined,
                                    color: Color(0xff898989),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                  },
                                  icon: Icon(
                                    Icons.delete_outline,
                                    color: Color(0xffF6928A),
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
