import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/sm_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/sm_module/widgets/text_form_field_const.dart';
import 'package:prohealth/presentation/widgets/custom_icon_button_constant.dart';

import '../hr_module/manage/widgets/custom_icon_button_constant.dart';

class CompanyIdentityScreen extends StatefulWidget {
  const CompanyIdentityScreen({super.key});

  @override
  State<CompanyIdentityScreen> createState() => _CompanyIdentityScreenState();
}

class _CompanyIdentityScreenState extends State<CompanyIdentityScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobNumController = TextEditingController();
  TextEditingController secNumController = TextEditingController();
  TextEditingController OptionalController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.pink,
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 6),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                  borderRadius: 12,
                  text: 'Whitelabelling',
                  width: 120,
                  height: 30,
                  onPressed: () {}),
              SizedBox(
                width: 30,
              ),
      CustomIconButtonConst(
        text: 'Add New Office',
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  backgroundColor: Colors.white,
                  content: Container(
                   height: 425,
                    width: 300,
                    child: Column(
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
                           SMTextFConst(controller: nameController, keyboardType: TextInputType.text, text: 'Name',),
                           SizedBox(height: 5,),
                           SMTextFConst(controller: addressController, keyboardType: TextInputType.streetAddress, text: 'Address',),
                           SizedBox(height: 5,),
                           SMTextFConst(controller: emailController, keyboardType: TextInputType.emailAddress, text: 'Email',),
                           SizedBox(height: 5,),
                           SMTextFConst(controller: mobNumController, keyboardType: TextInputType.number, text: 'Primary Phone',),
                           SizedBox(height: 5,),
                           SMTextFConst(controller: secNumController, keyboardType: TextInputType.number, text: 'Secondary Phone',),
                           SizedBox(height: 5,),
                           SMTextFConst(controller: OptionalController, keyboardType: TextInputType.number, text: 'Alternative Phone',),
                         ],
                       ),
                        SizedBox(height: 40,),
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
                  ));
            },
          );
        },
        icon: Icons.add,
      )
      ],
          ),
          SizedBox(height: 20),
          Container(
            height: 30,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(''),
                Text(
                  'Sr No',
                  style: GoogleFonts.firaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                // SizedBox(width: MediaQuery.of(context).size.width/7.5,),
                Text('Office Name',
                    style: GoogleFonts.firaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    )),

               //SizedBox(width: MediaQuery.of(context).size.width/5.5,),
                Text('Address  ',
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
                    textAlign: TextAlign.start,
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
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 10,
                itemBuilder: (context, index) {
                  int serialNumber = index + 1;
                  String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
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
                          height: 56,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(onPressed: (){},
                                  icon: Icon(Icons.menu_sharp,color: Color(0xff686464),)),
                              Text('  '),
                              Text(formattedSerialNumber,
                              style: GoogleFonts.firaSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff686464),
                                decoration: TextDecoration.none,
                                ),),
                              Text(''),
                              Text('ProHealth San Jose',
                                style: GoogleFonts.firaSans(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff686464),
                                  decoration: TextDecoration.none,
                                ),),
                              Text(''),
                              Text('2700 Zankar Road Suite 180, San Jose, CA, USA',
                                textAlign: TextAlign.end,
                                style: GoogleFonts.firaSans(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff686464),
                                  decoration: TextDecoration.none,
                                ),),
                              Text(''),
                              CustomButtonTransparentSM(text: 'Manage', onPressed: (){})
                            ],
                          )),
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}