import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/company_identity_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../widgets/button_constant.dart';
import '../../../widgets/text_form_field_const.dart';

class WhitelabellingScreen extends StatefulWidget {
  WhitelabellingScreen({super.key});

  @override
  State<WhitelabellingScreen> createState() => _WhitelabellingScreenState();
}

class _WhitelabellingScreenState extends State<WhitelabellingScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController secNumberController = TextEditingController();

  TextEditingController primNumController = TextEditingController();

  TextEditingController altNumController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController hcoNumController = TextEditingController();

  TextEditingController medicareController = TextEditingController();

  TextEditingController npiNumController = TextEditingController();

  TextEditingController faxontroller = TextEditingController();
  String fileName = "No Chosen";

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        fileName = result.files.single.name;
      });
    } else {
      // User canceled the picker
      setState(() {
        fileName = "No Chosen";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_outlined, size: 15),
                  color: ColorManager.mediumgrey,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CompanyIdentityScreen()));
                  },
                ),
                Text(
                  'Go Back',
                  style: GoogleFonts.firaSans(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManager.mediumgrey,
                    decoration: TextDecoration
                        .underline,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: CustomIconButton(
                    icon: Icons.edit_outlined,
                    text: "Edit Details",
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            content: Container(
                              height: 300,
                              width: 950,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                         Column(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Text("Company App Logo",
                                                 style: GoogleFonts.firaSans(
                                                   fontSize: FontSize.s12,
                                                   fontWeight:
                                                   FontWeightManager.bold,
                                                   color: Color(0xff686464),
                                                 )),
                                             Container(
                                               width: 354,
                                               height: 50,
                                               decoration: BoxDecoration(
                                                 border: Border.all(
                                                     color: Colors.grey),
                                                 borderRadius: BorderRadius.all(
                                                     Radius.circular(10)),
                                               ),
                                               child: Row(
                                                 mainAxisAlignment:
                                                 MainAxisAlignment.spaceAround,
                                                 children: [
                                                   Text(
                                                       "Upload Immunization Records from PDF",
                                                       style: GoogleFonts.firaSans(
                                                           fontSize: 10,
                                                           fontWeight: FontWeight
                                                               .w500,
                                                           color: Color(0xff686464))
                                                   ),
                                                   Container(
                                                     width: 130,
                                                     height: 30,
                                                     decoration: BoxDecoration(
                                                       border: Border.all(
                                                           color: Colors.grey),
                                                       borderRadius:
                                                       BorderRadius.all(
                                                           Radius.circular(
                                                               10)),
                                                     ),
                                                     child: Row(
                                                       mainAxisAlignment:
                                                       MainAxisAlignment
                                                           .spaceAround,
                                                       children: [
                                                         InkWell(
                                                           onTap: pickFile,
                                                           child: Container(
                                                             color:
                                                             Color(0xffD9D9D9),
                                                             child: Text(
                                                               "Choose File",
                                                               style: GoogleFonts
                                                                   .firaSans(
                                                                 fontSize: 10,
                                                                 fontWeight:
                                                                 FontWeight
                                                                     .w500,
                                                                 color:
                                                                 Colors.grey,
                                                               ),
                                                             ),
                                                           ),
                                                         ),
                                                         Container(
                                                           child: Text(
                                                             fileName,
                                                             style: GoogleFonts
                                                                 .firaSans(
                                                               fontSize: 10,
                                                               fontWeight:
                                                               FontWeight.w500,
                                                               color: Colors.grey,
                                                             ),
                                                           ),
                                                         ),
                                                       ],
                                                     ),
                                                   ),
                                                 ],
                                               ),
                                             ),
                                           ],
                                         ),
                                          SMTextFConst(
                                            controller: nameController,
                                            keyboardType: TextInputType.text,
                                            text: AppStringEM.companyName,
                                          ),
                                          SizedBox(height: AppSize.s4),
                                          SMTextFConst(
                                            controller: secNumberController,
                                            keyboardType: TextInputType.number,
                                            text: AppStringEM.secNum,
                                          ),
                                          SizedBox(height: AppSize.s4),
                                          SMTextFConst(
                                            controller: faxontroller,
                                            keyboardType: TextInputType.text,
                                            text: AppStringEM.fax,
                                          ),
                                          SizedBox(height: AppSize.s4),
                                          SMTextFConst(
                                            controller: addressController,
                                            keyboardType: TextInputType.text,
                                            text: AppStringEM.address,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Company App Logo",
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: FontSize.s12,
                                                    fontWeight:
                                                    FontWeightManager.bold,
                                                    color: Color(0xff686464),
                                                  )),
                                              Container(
                                                width: 354,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(10)),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Text(
                                                        "Upload Immunization Records from PDF",
                                                        style: GoogleFonts.firaSans(
                                                            fontSize: 10,
                                                            fontWeight: FontWeight
                                                                .w500,
                                                            color: Color(0xff686464))
                                                    ),
                                                    Container(
                                                      width: 130,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                        borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                        children: [
                                                          InkWell(
                                                            onTap: pickFile,
                                                            child: Container(
                                                              color:
                                                              Color(0xffD9D9D9),
                                                              child: Text(
                                                                "Choose File",
                                                                style: GoogleFonts
                                                                    .firaSans(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  color:
                                                                  Colors.grey,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              fileName,
                                                              style: GoogleFonts
                                                                  .firaSans(
                                                                fontSize: 10,
                                                                fontWeight:
                                                                FontWeight.w500,
                                                                color: Colors.grey,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SMTextFConst(
                                            controller: primNumController,
                                            keyboardType: TextInputType.number,
                                            text: AppStringEM.primNum,
                                          ),
                                          SizedBox(height: AppSize.s4),
                                          SMTextFConst(
                                            controller: altNumController,
                                            keyboardType: TextInputType.number,
                                            text: AppStringEM.alternatephone,
                                          ),
                                          SizedBox(height: AppSize.s4),
                                          SMTextFConst(
                                            controller: emailController,
                                            keyboardType: TextInputType.text,
                                            text: AppStringEM.primarymail,
                                          ),
                                          SizedBox(
                                            width: 354,
                                            height: 30,
                                          ),
                                          SizedBox(
                                            width: 354,
                                            height: 30,
                                          )


                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              Align(
                                alignment: Alignment.bottomRight,
                                child: CustomElevatedButton(
                                    width: 105,
                                    height: 31,
                                    text: 'Submit',
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }),
                              )
                            ],
                          );
                        },
                      );
                    }),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40),
              child: Row(
                children: [
                  Text("Logos",
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.medium,
                        color: ColorManager.mediumgrey,
                      )),
                  SizedBox(width: MediaQuery.of(context).size.width / 5),
                  Text("Details",
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeightManager.medium,
                        color: ColorManager.mediumgrey,
                      ))
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Container(
                        width: 290,
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: ColorManager.blueprime),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        height: 260,
                        // color: ColorManager.green,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.asset(
                                "images/formainlogoprohealth.png",
                                // height: 60,
                                //   width: 120,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Image.asset(
                                "images/forwebprohealth.png",
                                // height: 60,
                                // width: 120,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Image.asset(
                                "images/forappprohealth.png",
                                // height: 60,
                                // width: 120,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: ColorManager.blueprime,),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        height: 260,
                        // color: ColorManager.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SMTextFConst(
                                  controller: nameController,
                                  keyboardType: TextInputType.text,
                                  text: AppStringEM.companyName,
                                ),
                                SizedBox(height: AppSize.s4),
                                SMTextFConst(
                                  controller: secNumberController,
                                  keyboardType: TextInputType.number,
                                  text: AppStringEM.secNum,
                                ),
                                SizedBox(height: AppSize.s4),
                                SMTextFConst(
                                  controller: faxontroller,
                                  keyboardType: TextInputType.text,
                                  text: AppStringEM.fax,
                                ),
                                SizedBox(height: AppSize.s4),
                                SMTextFConst(
                                  controller: addressController,
                                  keyboardType: TextInputType.text,
                                  text: AppStringEM.address,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SMTextFConst(
                                  controller: primNumController,
                                  keyboardType: TextInputType.number,
                                  text: AppStringEM.primNum,
                                ),
                                SizedBox(height: AppSize.s4),
                                SMTextFConst(
                                  controller: altNumController,
                                  keyboardType: TextInputType.number,
                                  text: AppStringEM.alternatephone,
                                ),
                                SizedBox(height: AppSize.s4),
                                SMTextFConst(
                                  controller: emailController,
                                  keyboardType: TextInputType.text,
                                  text: AppStringEM.primarymail,
                                ),
                                SizedBox(
                                  width: 354,
                                  height: 30,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
