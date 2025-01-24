import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prohealth/app/resources/color.dart';

import '../../../../../app/resources/value_manager.dart';
import '../../them_manager/oasis_them_mnager.dart';
import '../../widgets/constant/getx_oasis.dart';
import '../../widgets/constant/green_container_constant.dart';

class AdministrativeInfo extends StatefulWidget {
  const AdministrativeInfo({super.key});

  @override
  State<AdministrativeInfo> createState() => _AdministrativeInfoState();
}

class _AdministrativeInfoState extends State<AdministrativeInfo> {

  TextEditingController statecontroller = TextEditingController();
  TextEditingController idcontroller = TextEditingController();
  TextEditingController npicontroller = TextEditingController();
  TextEditingController prpidcontroller = TextEditingController();



  @override
  Widget build(BuildContext context) {
    final CheckboxController checkboxController = Get.put(CheckboxController());
    return  Scaffold(
      backgroundColor: ColorManager.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 50,left: 20),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                       // color: Colors.red,
                        child: Column(
                          children: [
                            GreenContrainerConst(
                              height:MediaQuery.of(context).size.height /1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20,),


                                  Row(
                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Ontabtext(ontab: () async{  },
                                        child: Row(children: [
                                          Text("(M0010)", style: Redfontstyle.customTextStyle(context)),
                                          Text(" CMS Certification Number: ", style: BoldfontStyle.customTextStyle(context))
                                        ],),),
                                      SizedBox(width:  MediaQuery.of(context).size.width /30,),
                                      Text("5678945"),
                                    ],
                                  ),
                                  SizedBox(height: 30,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Column for labels and text widgets
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Padding(
                                          //   padding: const EdgeInsets.symmetric(vertical: 5),
                                          //   child: Ontabtext(
                                          //     ontab: () async {},
                                          //     child: Row(
                                          //       children: [
                                          //         Text("(M0010)", style: Redfontstyle.customTextStyle(context)),
                                          //         Text(" CMS Certification Number : ", style: BoldfontStyle.customTextStyle(context)),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // ),
                                      // SizedBox(height: 0,),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5),
                                            child: Ontabtext(
                                              ontab: () async {},
                                              child: Row(
                                                children: [
                                                  Text("(M0014)", style: Redfontstyle.customTextStyle(context)),
                                                  Text(" Branch State : ", style: BoldfontStyle.customTextStyle(context)),
                                                ],
                                              ),
                                            ),
                                          ),
                                      SizedBox(height: 30,),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5),
                                            child: Ontabtext(
                                              ontab: () async {},
                                              child: Row(
                                                children: [
                                                  Text("(M0016)", style: Redfontstyle.customTextStyle(context)),
                                                  Text(" Branch ID Number : ", style: BoldfontStyle.customTextStyle(context)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(width: 40),

                                      // Column for the values and textfields
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // CMS Certification Number value
                                          // Row(
                                          //   children: [
                                          //     Text("564789"), // Your CMS Certification Number
                                          //   ],
                                          // ),
                                         // SizedBox(height: 20,),
                                          // Branch State TextField
                                          EMRTextFConst(
                                            width: AppSize.s150,
                                            controller: statecontroller,
                                            keyboardType: TextInputType.text,
                                          ),
                                          // Branch ID Number TextField
                                          SizedBox(height: 20,),
                                          EMRTextFConst(
                                            width: AppSize.s150,
                                            controller: idcontroller,
                                            keyboardType: TextInputType.text,
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 20),
                                      Column(children: [],)

                                    ],
                                  ),
                                  SizedBox(height: 20,),

                                  InkWell( onTap: (){},
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text:"(M0018)", style: Redfontstyle.customTextStyle(context)
                                          ),
                                          TextSpan(
                                            text: " National Provider Identifier (NPI)", style: BoldfontStyle.customTextStyle(context)
                                          ),
                                          TextSpan(
                                            text: "for the attending physician who has signed the plan of care: ", style: Normalfontstyle.customTextStyle(context)
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  EMRTextFConst(
                                   // width: AppSize.s150,
                                    controller: npicontroller,
                                    keyboardType: TextInputType.text,
                                  ),
                                  SizedBox(height: 10,),
                                  CustomCheckBoxListTile(
                                    title: 'UK - Unknown or Not Available',
                                    isChecked: checkboxController.ukn,
                                    onChanged: (value) {
                                      checkboxController.toggleCheckukn(value);
                                    },
                                  ),
                                  SizedBox(height: 15,),
                                  Text("Primary Referring Physician I.D.: ", style: BoldfontStyle.customTextStyle(context)),
                                  SizedBox(height: 10,),
                                  EMRTextFConst(
                                    // width: AppSize.s150,
                                    controller: prpidcontroller,
                                    keyboardType: TextInputType.text,
                                  ),
                                  SizedBox(height: 10,),
                                  CustomCheckBoxListTile(
                                    title: 'UK - Unknown or Not Available',
                                    isChecked: checkboxController.ukp,
                                    onChanged: (value) {
                                      checkboxController.toggleCheckukp(value);
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                     // color: Colors.purple,
                      child: Column(
                        children: [
                          WhiteContrainerConst(
                            height: 350,
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Ontabtext(ontab: () async{  },
                                child: Row(children: [
                                  Text(" (A1005)", style: Redfontstyle.customTextStyle(context)),
                                  Text(" Ethnicity", style: BoldfontStyle.customTextStyle(context))
                                ],),),
                              SizedBox(height: 10,),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "Are you of Hispanic, Latino/a, or Spanish origin?", style: Normalfontstyle.customTextStyle(context)
                                    ),
                                    TextSpan(
                                        text: "            ( Check all that apply )", style: BoldfontStyle.customTextStyle(context)
                                    ),

                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              CustomCheckBoxListTile(
                                title: 'A. No, not of Hispanic, Latino/a, or Spanish origin',
                                isChecked: checkboxController.a,
                                onChanged: (value) {
                                  checkboxController.toggleChecka(value);
                                },
                              ),
                              CustomCheckBoxListTile(
                                title: 'B. Yes, Mexican, Mexican American, Chicano/a',
                                isChecked: checkboxController.b,
                                onChanged: (value) {
                                  checkboxController.toggleCheckb(value);
                                },
                              ),
                              CustomCheckBoxListTile(
                                title: 'C. Yes, Puerto Rican',
                                isChecked: checkboxController.c,
                                onChanged: (value) {
                                  checkboxController.toggleCheckc(value);
                                },
                              ),
                              CustomCheckBoxListTile(
                                title: 'D. Yes, Cuban',
                                isChecked: checkboxController.d,
                                onChanged: (value) {
                                  checkboxController.toggleCheckd(value);
                                },
                              ),
                              CustomCheckBoxListTile(
                                title: 'E. Yes, another Hispanic, Latino, or Spanish origin',
                                isChecked: checkboxController.e,
                                onChanged: (value) {
                                  checkboxController.toggleChecke(value);
                                },
                              ),
                              CustomCheckBoxListTile(
                                title: 'X. Patient unable to respond',
                                isChecked: checkboxController.x,
                                onChanged: (value) {
                                  checkboxController.toggleCheckx(value);
                                },
                              ),
                              CustomCheckBoxListTile(
                                title: 'Y. Patient declines to respond',
                                isChecked: checkboxController.y,
                                onChanged: (value) {
                                  checkboxController.toggleChecky(value);
                                },
                              ),


                            ],
                          ),

                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          
            ],
          ),
        ),
      ),

    );
  }
}
