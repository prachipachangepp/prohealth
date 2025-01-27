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

  ScrollController _scrollController = ScrollController();

  TextEditingController branchstatecontroller = TextEditingController();
  TextEditingController idcontroller = TextEditingController();
  TextEditingController npicontroller = TextEditingController();
  TextEditingController prpidcontroller = TextEditingController();


  TextEditingController lastcontroller = TextEditingController();
  TextEditingController firstcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController citycontroller = TextEditingController();
  TextEditingController statecontroller = TextEditingController();
  TextEditingController zipcodecontroller = TextEditingController();

  ///other
  TextEditingController olastcontroller = TextEditingController();
  TextEditingController ofirstcontroller = TextEditingController();
  TextEditingController ophonecontroller = TextEditingController();
  TextEditingController oaddresscontroller = TextEditingController();
  TextEditingController ocitycontroller = TextEditingController();
  TextEditingController ostatecontroller = TextEditingController();
  TextEditingController ozipcodecontroller = TextEditingController();


  ///patient name

  TextEditingController plastcontroller = TextEditingController();
  TextEditingController pfirstcontroller = TextEditingController();
  TextEditingController pmicontroller = TextEditingController();
  TextEditingController psuffixcontroller = TextEditingController();
  TextEditingController pphonecontroller = TextEditingController();
  TextEditingController paddresscontroller = TextEditingController();
  TextEditingController pcitycontroller = TextEditingController();
  TextEditingController pstreetcontroller = TextEditingController();
  TextEditingController psuitecontroller = TextEditingController();
  // TextEditingController controller = TextEditingController();
  // TextEditingController controller = TextEditingController();
  // TextEditingController controller = TextEditingController();


  ///
  String? gender = "Male";
  ///


  @override
  Widget build(BuildContext context) {
    final AddminInfoChechBox admincheckboxController = Get.put(AddminInfoChechBox());
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
                      child: Column(
                        children: [
                          GreenContrainerConst(
                            height:MediaQuery.of(context).size.height /1,
                            child: ScrollConfiguration(
                              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                              child: SingleChildScrollView(
                                //controller: _scrollController,
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
                                              controller: branchstatecontroller,
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
                                              text: " National Provider Identifier (NPI) ", style: BoldfontStyle.customTextStyle(context)
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
                                      width: MediaQuery.of(context).size.width /5,
                                     // width: AppSize.s150,
                                      controller: npicontroller,
                                      keyboardType: TextInputType.text,
                                    ),
                                    SizedBox(height: 10,),
                                    CustomCheckBoxListTile(
                                      title: 'UK - Unknown or Not Available',
                                      isChecked: admincheckboxController.ukn,
                                      onChanged: (value) {
                                        admincheckboxController.toggleCheckukn(value);
                                      },
                                    ),
                                    SizedBox(height: 15,),
                                    Text("Primary Referring Physician I.D.: ", style: BoldfontStyle.customTextStyle(context)),
                                    SizedBox(height: 10,),
                                    EMRTextFConst(
                                      width: MediaQuery.of(context).size.width /5,
                                      // width: AppSize.s150,
                                      controller: prpidcontroller,
                                      keyboardType: TextInputType.text,
                                    ),
                                    SizedBox(height: 10,),
                                    CustomCheckBoxListTile(
                                      title: 'UK - Unknown or Not Available',
                                      isChecked: admincheckboxController.ukp,
                                      onChanged: (value) {
                                        admincheckboxController.toggleCheckukp(value);
                                      },
                                    ),

                                    SizedBox(height: 20,),
                                    Text("Physician Signing Plan of Care: ", style: BoldfontStyle.customTextStyle(context)),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 10,),
                                            Padding(
                                              padding: const  EdgeInsets.symmetric(vertical: 5),
                                              child: Text("Last :" ,style: BoldfontStyle.customTextStyle(context),),
                                            ),
                                            SizedBox(height:20 ,),
                                            Padding(
                                              padding: const  EdgeInsets.symmetric(vertical: 6),
                                              child: Text("First :" ,style: BoldfontStyle.customTextStyle(context),),
                                            ),
                                            SizedBox(height: 20,),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 6),
                                              child: Text("Phone :" ,style: BoldfontStyle.customTextStyle(context),),
                                            ),
                                            SizedBox(height: 20,),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 6),
                                              child: Text("Address :" ,style: BoldfontStyle.customTextStyle(context),),
                                            ),
                                            SizedBox(height: 20,),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 6),
                                              child: Text("City :" ,style: BoldfontStyle.customTextStyle(context),),
                                            ),
                                            SizedBox(height: 20,),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 6),
                                              child: Text("State :" ,style: BoldfontStyle.customTextStyle(context),),
                                            ),
                                            SizedBox(height: 20,),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8),
                                              child: Text("Zip Code :" ,style: BoldfontStyle.customTextStyle(context),),
                                            )
                                          ],
                                        ),

                                        SizedBox(width: 10,),
                                        Column(crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(height: 10,),
                                            EMRTextFConst(
                                            width: MediaQuery.of(context).size.width /5,
                                             // width:AppSize.s310,
                                              controller: lastcontroller, keyboardType: TextInputType.text, ),
                                           // SizedBox(height: 10,),
                                            // EMRTextFConst(controller: nameController, keyboardType: TextInputType.text,),

                                            SizedBox(height: 10,),
                                            EMRTextFConst(
                                              //width:AppSize.s310,
                                              width: MediaQuery.of(context).size.width /5,
                                              controller: firstcontroller, keyboardType: TextInputType.text,),
                                            SizedBox(height: 10,),
                                            EMRTextFConst(
                                              //width:AppSize.s310,
                                            width: MediaQuery.of(context).size.width /5,
                                              controller: phonecontroller, keyboardType: TextInputType.text,),
                                            SizedBox(height: 10,),
                                            EMRTextFConst(
                                              //width:AppSize.s310,
                                             width: MediaQuery.of(context).size.width /5,
                                              controller: addresscontroller, keyboardType: TextInputType.text,),
                                            SizedBox(height: 10,),
                                            EMRTextFConst(
                                              //width:AppSize.s310,
                                              width: MediaQuery.of(context).size.width /5,
                                              controller: citycontroller, keyboardType: TextInputType.text,),
                                            SizedBox(height: 10,),
                                            EMRTextFConst(
                                              //width:AppSize.s310,
                                              width: MediaQuery.of(context).size.width /5,
                                              controller: statecontroller, keyboardType: TextInputType.text,),
                                            SizedBox(height: 10,),
                                            EMRTextFConst(
                                             // width:AppSize.s310,
                                              width: MediaQuery.of(context).size.width /5,
                                              controller: zipcodecontroller, keyboardType: TextInputType.text,),
                                          ],
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 20,),
                                    Text("Other Physician: ", style: BoldfontStyle.customTextStyle(context)),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 10,),
                                            Padding(
                                              padding: const  EdgeInsets.symmetric(vertical: 5),
                                              child: Text("Last :" ,style: BoldfontStyle.customTextStyle(context),),
                                            ),
                                            SizedBox(height:20 ,),
                                            Padding(
                                              padding: const  EdgeInsets.symmetric(vertical: 6),
                                              child: Text("First :" ,style: BoldfontStyle.customTextStyle(context),),
                                            ),
                                            SizedBox(height: 20,),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 6),
                                              child: Text("Phone :" ,style: BoldfontStyle.customTextStyle(context),),
                                            ),
                                            SizedBox(height: 20,),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 6),
                                              child: Text("Address :" ,style: BoldfontStyle.customTextStyle(context),),
                                            ),
                                            SizedBox(height: 20,),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 6),
                                              child: Text("City :" ,style: BoldfontStyle.customTextStyle(context),),
                                            ),
                                            SizedBox(height: 20,),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 6),
                                              child: Text("State :" ,style: BoldfontStyle.customTextStyle(context),),
                                            ),
                                            SizedBox(height: 20,),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8),
                                              child: Text("Zip Code :" ,style: BoldfontStyle.customTextStyle(context),),
                                            )
                                          ],
                                        ),

                                        SizedBox(width: 10,),
                                        Column(crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(height: 10,),
                                            EMRTextFConst(
                                              width: MediaQuery.of(context).size.width /5,
                                              // width:AppSize.s310,
                                              controller: olastcontroller, keyboardType: TextInputType.text, ),
                                            // SizedBox(height: 10,),
                                            // EMRTextFConst(controller: nameController, keyboardType: TextInputType.text,),

                                            SizedBox(height: 10,),
                                            EMRTextFConst(
                                              //width:AppSize.s310,
                                              width: MediaQuery.of(context).size.width /5,
                                              controller: ofirstcontroller, keyboardType: TextInputType.text,),
                                            SizedBox(height: 10,),
                                            EMRTextFConst(
                                              //width:AppSize.s310,
                                              width: MediaQuery.of(context).size.width /5,
                                              controller: ophonecontroller, keyboardType: TextInputType.text,),
                                            SizedBox(height: 10,),
                                            EMRTextFConst(
                                              //width:AppSize.s310,
                                              width: MediaQuery.of(context).size.width /5,
                                              controller: oaddresscontroller, keyboardType: TextInputType.text,),
                                            SizedBox(height: 10,),
                                            EMRTextFConst(
                                              //width:AppSize.s310,
                                              width: MediaQuery.of(context).size.width /5,
                                              controller: ocitycontroller, keyboardType: TextInputType.text,),
                                            SizedBox(height: 10,),
                                            EMRTextFConst(
                                              //width:AppSize.s310,
                                              width: MediaQuery.of(context).size.width /5,
                                              controller: ostatecontroller, keyboardType: TextInputType.text,),
                                            SizedBox(height: 10,),
                                            EMRTextFConst(
                                              // width:AppSize.s310,
                                              width: MediaQuery.of(context).size.width /5,
                                              controller: ozipcodecontroller, keyboardType: TextInputType.text,),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Ontabtext(ontab: () async{  },
                                          child: Row(children: [
                                            Text("(M0020)", style: Redfontstyle.customTextStyle(context)),
                                            Text(" Patient ID Number: ", style: BoldfontStyle.customTextStyle(context))
                                          ],),),
                                        SizedBox(width:  MediaQuery.of(context).size.width /57,),
                                        EMRTextFConst(
                                          width: AppSize.s150,
                                          controller: branchstatecontroller,
                                          keyboardType: TextInputType.text,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Ontabtext(ontab: () async{  },
                                          child: Row(children: [
                                            Text("(M0300)", style: Redfontstyle.customTextStyle(context)),
                                            Text(" Start of Care Date: ", style: BoldfontStyle.customTextStyle(context))
                                          ],),),


                                        Container(
                                          constraints: BoxConstraints(maxWidth: 50),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Image.asset("images/oasis_emr/star.png",height: 15,),
                                                Image.asset("images/oasis_emr/P.png",height: 13),
                                                // Image.asset("images/oasis_emr/O.png",height: 15,alignment: Alignment.center),
                                                // Image.asset("images/oasis_emr/v.png",height: 18,),
                                                Image.asset("images/oasis_emr/excl_mark.png",height: 15),
                                                Image.asset("images/oasis_emr/cc.png",height: 13),
                                                //Image.asset("images/oasis_emr/.png",height: 10,),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Ontabtext(ontab: () async{  },
                                          child: Row(children: [
                                            Text("(M0032)", style: Redfontstyle.customTextStyle(context)),
                                            Text(" Resumption of Care Date: ", style: BoldfontStyle.customTextStyle(context))
                                          ],),),


                                        Container(
                                          constraints: BoxConstraints(maxWidth: 50),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Image.asset("images/oasis_emr/star.png",height: 15,),
                                                Image.asset("images/oasis_emr/P.png",height: 13),
                                                // Image.asset("images/oasis_emr/O.png",height: 15,alignment: Alignment.center),
                                                // Image.asset("images/oasis_emr/v.png",height: 18,),
                                                Image.asset("images/oasis_emr/excl_mark.png",height: 15),
                                                Image.asset("images/oasis_emr/cc.png",height: 13),
                                                //Image.asset("images/oasis_emr/.png",height: 10,),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomCheckBoxListTile(

                                          title: 'NA - Not Applicable',
                                          isChecked: admincheckboxController.na,
                                          onChanged: (value) {
                                            admincheckboxController.toggleCheckna(value);
                                          },
                                        ),

                                        SizedBox(width:  MediaQuery.of(context).size.width /40,),
                                        EMRTextFConst(
                                          width: AppSize.s150,
                                          controller: branchstatecontroller,
                                          keyboardType: TextInputType.text,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30,),

                                    Ontabtext(ontab: () async{  },
                                      child: Row(children: [
                                        Text("(M0040)", style: Redfontstyle.customTextStyle(context)),
                                        Text(" Patient Name: ", style: BoldfontStyle.customTextStyle(context))
                                      ],),),

                                    Row(
                                      children: [
                                        Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: const  EdgeInsets.symmetric(vertical: 4),
                                                    child: Text("First :" ,style: BoldfontStyle.customTextStyle(context),),
                                                  ),

                                                  SizedBox(height: 15,),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 4),
                                                    child: Text("Last :" ,style: Normalfontstyle.customTextStyle(context),),
                                                  )
                                                ],
                                              ),

                                              SizedBox(width: 10,),
                                              Column(crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  EMRTextFConst(
                                                    //width: MediaQuery.of(context).size.width /5,
                                                    width: AppSize.s150,
                                                    controller: pfirstcontroller, keyboardType: TextInputType.text, ),
                                                  SizedBox(height: 10,),
                                                  // EMRTextFConst(controller: nameController, keyboardType: TextInputType.text,),


                                                  EMRTextFConst(
                                                    width: AppSize.s150,
                                                    //width: MediaQuery.of(context).size.width /5,
                                                    controller: plastcontroller, keyboardType: TextInputType.text,)
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 15,),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: const  EdgeInsets.symmetric(vertical: 4),
                                                    child: Text("MI :" ,style: Normalfontstyle.customTextStyle(context),),
                                                  ),

                                                  SizedBox(height: 15,),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 4),
                                                    child: Text("Suffix :" ,style: Normalfontstyle.customTextStyle(context),),
                                                  )
                                                ],
                                              ),

                                              SizedBox(width: 10,),
                                              Column(crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  EMRTextFConst(
                                                    //width: MediaQuery.of(context).size.width /5,
                                                    width: AppSize.s150,
                                                    controller: pmicontroller, keyboardType: TextInputType.text, ),
                                                  SizedBox(height: 10,),
                                                  // EMRTextFConst(controller: nameController, keyboardType: TextInputType.text,),


                                                  EMRTextFConst(
                                                    width: AppSize.s150,
                                                    //width: MediaQuery.of(context).size.width /5,
                                                    controller: psuffixcontroller, keyboardType: TextInputType.text,)
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                           // SizedBox(height: 10,),

                                            SizedBox(height: 20,),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 6),
                                              child: Text("Patient Phone: :" ,style: Normalfontstyle.customTextStyle(context),),
                                            ),
                                            SizedBox(height: 20,),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 6),
                                              child: Text("Address :" ,style: Normalfontstyle.customTextStyle(context),),
                                            ),
                                            SizedBox(height: 20,),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 6),
                                              child: Text("Street :" ,style: Normalfontstyle.customTextStyle(context),),
                                            ),
                                            SizedBox(height: 20,),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8),
                                              child: Text("Suite/Apt # :" ,style: Normalfontstyle.customTextStyle(context),),
                                            ),
                                            SizedBox(height: 20,),

                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 6),
                                              child: Text("City :" ,style: Normalfontstyle.customTextStyle(context),),
                                            ),


                                          ],
                                        ),

                                        SizedBox(width: 10,),
                                        Column(crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                           // SizedBox(height: 10,),
                                        SizedBox(height: 10,),
                                            EMRTextFConst(
                                              //width:AppSize.s310,
                                              width: MediaQuery.of(context).size.width /5,
                                              controller: pphonecontroller, keyboardType: TextInputType.text,),
                                            SizedBox(height: 10,),
                                            EMRTextFConst(
                                              //width:AppSize.s310,
                                              width: MediaQuery.of(context).size.width /5,
                                              controller: paddresscontroller, keyboardType: TextInputType.text,),
                                            SizedBox(height: 10,),
                                            EMRTextFConst(
                                              //width:AppSize.s310,
                                              width: MediaQuery.of(context).size.width /5,
                                              controller: pstreetcontroller, keyboardType: TextInputType.text,),
                                            SizedBox(height: 10,),
                                            EMRTextFConst(
                                              //width:AppSize.s310,
                                              width: MediaQuery.of(context).size.width /5,
                                              controller: psuitecontroller, keyboardType: TextInputType.text,),
                                            SizedBox(height: 10,),
                                            EMRTextFConst(
                                              // width:AppSize.s310,
                                              width: MediaQuery.of(context).size.width /5,
                                              controller: pcitycontroller, keyboardType: TextInputType.text,),
                                          ],
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // SizedBox(height: 10,),
                                            Ontabtext(ontab: () async{  },
                                              child: Row(children: [
                                                Text("(M0050)", style: Redfontstyle.customTextStyle(context)),
                                                Text(" Patient State of \n Residence: ", style: BoldfontStyle.customTextStyle(context))
                                              ],),),
                                          ],
                                        ),

                                        SizedBox(width: 10,),
                                        Column(crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            // SizedBox(height: 10,),
                                            //    SizedBox(height: 10,),
                                            EMRTextFConst(
                                              //width:AppSize.s310,
                                              width: MediaQuery.of(context).size.width /5,
                                              controller: pphonecontroller, keyboardType: TextInputType.text,),
                                            // SizedBox(height: 10,),

                                          ],
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // SizedBox(height: 10,),
                                            Ontabtext(ontab: () async{  },
                                              child: Row(children: [
                                                Text("(M0060)", style: Redfontstyle.customTextStyle(context)),
                                                Text(" Patient ZIP Code: ", style: BoldfontStyle.customTextStyle(context))
                                              ],),),
                                          ],
                                        ),

                                        SizedBox(width: 10,),
                                        Column(crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            // SizedBox(height: 10,),
                                            //    SizedBox(height: 10,),
                                            EMRTextFConst(
                                              //width:AppSize.s310,
                                              width: MediaQuery.of(context).size.width /5,
                                              controller: pphonecontroller, keyboardType: TextInputType.text,),
                                            // SizedBox(height: 10,),

                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 10,),
                                            Ontabtext(ontab: () async{  },
                                              child: Row(children: [
                                                Text("(M0063)", style: Redfontstyle.customTextStyle(context)),
                                                Text(" Medicare Number: ", style: BoldfontStyle.customTextStyle(context))
                                              ],),),
                                          ],
                                        ),

                                        SizedBox(width: 10,),
                                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // SizedBox(height: 10,),
                                            //    SizedBox(height: 10,),
                                            EMRTextFConst(
                                              //width:AppSize.s310,
                                              width: MediaQuery.of(context).size.width /5,
                                              controller: pphonecontroller, keyboardType: TextInputType.text,),
                                            SizedBox(height: 10,),
                                            CustomCheckBoxListTile(

                                              title: ' NA - No Medicare (including suffix)',
                                              isChecked: admincheckboxController.na,
                                              onChanged: (value) {
                                                admincheckboxController.toggleCheckna(value);
                                              },
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 10,),
                                            Ontabtext(ontab: () async{  },
                                              child: Row(children: [
                                                Text("(M0064)", style: Redfontstyle.customTextStyle(context)),
                                                Text(" Social Security Number:", style: BoldfontStyle.customTextStyle(context))
                                              ],),),
                                          ],
                                        ),

                                        SizedBox(width: 10,),
                                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // SizedBox(height: 10,),
                                            //    SizedBox(height: 10,),
                                            EMRTextFConst(
                                              //width:AppSize.s310,
                                              width: MediaQuery.of(context).size.width /5,
                                              controller: pphonecontroller, keyboardType: TextInputType.text,),
                                            SizedBox(height: 10,),
                                            CustomCheckBoxListTile(

                                              title: ' UK - Unknown or Not Available',
                                              isChecked: admincheckboxController.na,
                                              onChanged: (value) {
                                                admincheckboxController.toggleCheckna(value);
                                              },
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 10,),
                                            Ontabtext(ontab: () async{  },
                                              child: Row(children: [
                                                Text("(M0065)", style: Redfontstyle.customTextStyle(context)),
                                                Text(" Medicaid Number:  ", style: BoldfontStyle.customTextStyle(context))
                                              ],),),
                                          ],
                                        ),

                                        SizedBox(width: 10,),
                                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // SizedBox(height: 10,),
                                            //    SizedBox(height: 10,),
                                            EMRTextFConst(
                                              //width:AppSize.s310,
                                              width: MediaQuery.of(context).size.width /5,
                                              controller: pphonecontroller, keyboardType: TextInputType.text,),
                                            SizedBox(height: 10,),
                                            CustomCheckBoxListTile(

                                              title: 'NA - No Medicaid',
                                              isChecked: admincheckboxController.na,
                                              onChanged: (value) {
                                                admincheckboxController.toggleCheckna(value);
                                              },
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 10,),
                                    Row(
                                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Ontabtext(ontab: () async{  },
                                          child: Row(children: [
                                            Text("(M0066)", style: Redfontstyle.customTextStyle(context)),
                                            Text(" Birth Date: ", style: BoldfontStyle.customTextStyle(context))
                                          ],),),
                                        SizedBox(width:  MediaQuery.of(context).size.width /17,),
                                        EMRTextFConst(
                                          width: AppSize.s150,
                                          controller: branchstatecontroller,
                                          keyboardType: TextInputType.text,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Ontabtext(ontab: () async{  },
                                          child: Row(children: [
                                            Text("(M0069)", style: Redfontstyle.customTextStyle(context)),
                                            Text(" Gender:  ", style: BoldfontStyle.customTextStyle(context))
                                          ],),),
                                        SizedBox(width:  MediaQuery.of(context).size.width /15,),
                                        Row(
                                          children: [
                                            EMRCustomRadioListTile(
                                              title: '1 - Male',
                                              value: 'Male',
                                              groupValue: gender,
                                              onChanged: (value) {
                                                setState(() {
                                                  gender = value;
                                                });
                                              },
                                            ),
                                            EMRCustomRadioListTile(
                                              title: '2 - Female',
                                              value: 'Female',
                                              groupValue: gender,
                                              onChanged: (value) {
                                                setState(() {
                                                  gender = value;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),








                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
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
                                  Text("(A1005)", style: Redfontstyle.customTextStyle(context)),
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
                              SemiBoldCheckBoxListTile(
                               // title: 'A. No, not of Hispanic, Latino/a, or Spanish origin',
                                isChecked: admincheckboxController.a,
                                onChanged: (value) {
                                  admincheckboxController.toggleChecka(value);
                                }, titlenormal: 'A.', titlebold: ' No, not of Hispanic, Latino/a, or Spanish origin',
                              ),
                              SemiBoldCheckBoxListTile(
                                //title: 'B. Yes, Mexican, Mexican American, Chicano/a',
                                isChecked: admincheckboxController.b,
                                onChanged: (value) {
                                  admincheckboxController.toggleCheckb(value);
                                }, titlenormal: 'B.', titlebold: 'Yes, Mexican, Mexican American, Chicano/a',
                              ),
                              SemiBoldCheckBoxListTile(
                                //title: 'C. Yes, Puerto Rican',
                                isChecked: admincheckboxController.c,
                                onChanged: (value) {
                                  admincheckboxController.toggleCheckc(value);
                                }, titlenormal: 'C.', titlebold: 'Yes, Puerto Rican',
                              ),
                              SemiBoldCheckBoxListTile(
                               // title: 'D. Yes, Cuban',
                                isChecked: admincheckboxController.d,
                                onChanged: (value) {
                                  admincheckboxController.toggleCheckd(value);
                                }, titlenormal: 'D.', titlebold: 'Yes, Cuban',
                              ),
                              SemiBoldCheckBoxListTile(
                               // title: 'E. Yes, another Hispanic, Latino, or Spanish origin',
                                isChecked: admincheckboxController.e,
                                onChanged: (value) {
                                  admincheckboxController.toggleChecke(value);
                                }, titlenormal: 'E.', titlebold: 'Yes, another Hispanic, Latino, or Spanish origin',
                              ),
                              SemiBoldCheckBoxListTile(
                               // title: 'X. Patient unable to respond',
                                isChecked: admincheckboxController.x,
                                onChanged: (value) {
                                  admincheckboxController.toggleCheckx(value);
                                }, titlenormal: 'X.', titlebold: 'Patient unable to respond',
                              ),
                              SemiBoldCheckBoxListTile(
                                //title: 'Y. Patient declines to respond',
                                isChecked: admincheckboxController.y,
                                onChanged: (value) {
                                  admincheckboxController.toggleChecky(value);
                                }, titlenormal: 'Y.', titlebold: 'Patient declines to respond',
                              ),


                            ],
                          ),

                          ),

                          SizedBox(height: 20,),
                          WhiteContrainerConst(
                             height: 640,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Ontabtext(ontab: () async{  },
                                  child: Row(children: [
                                    Text("(A1010)", style: Redfontstyle.customTextStyle(context)),
                                    Text(" Race", style: BoldfontStyle.customTextStyle(context))
                                  ],),),
                                SizedBox(height: 10,),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "What is your race? ", style: Normalfontstyle.customTextStyle(context)
                                      ),
                                      TextSpan(
                                          text: " ( Check all that apply )", style: BoldfontStyle.customTextStyle(context)
                                      ),

                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                SemiBoldCheckBoxListTile(
                                 // title: 'A.A. White',
                                  isChecked: admincheckboxController.aa,
                                  onChanged: (value) {
                                    admincheckboxController.toggleCheckaa(value);
                                  }, titlenormal: 'A.', titlebold: 'White',
                                ),
                                SemiBoldCheckBoxListTile(
                                  //title: 'B. Yes, Mexican, Mexican American, Chicano/a',
                                  isChecked: admincheckboxController.bb,
                                  onChanged: (value) {
                                    admincheckboxController.toggleCheckbb(value);
                                  }, titlenormal: 'B. ', titlebold: 'Black or African American',
                                ),
                                SemiBoldCheckBoxListTile(
                                //  title: 'C. Yes, Puerto Rican',
                                  isChecked: admincheckboxController.cc,
                                  onChanged: (value) {
                                    admincheckboxController.toggleCheckcc(value);
                                  }, titlenormal: 'C.', titlebold: ' American Indian or Alaska Native',
                                ),
                                SemiBoldCheckBoxListTile(
                                 // title: 'D. Yes, Cuban',
                                  isChecked: admincheckboxController.dd,
                                  onChanged: (value) {
                                    admincheckboxController.toggleCheckdd(value);
                                  }, titlenormal: 'D.', titlebold: ' Asian Indian',
                                ),
                                SemiBoldCheckBoxListTile(
                                 // title: 'E. Yes, another Hispanic, Latino, or Spanish origin',
                                  isChecked: admincheckboxController.ee,
                                  onChanged: (value) {
                                    admincheckboxController.toggleCheckee(value);
                                  }, titlenormal: 'E.', titlebold: ' Chinese',
                                ),
                                SemiBoldCheckBoxListTile(
                                 // title: 'X. Patient unable to respond',
                                  isChecked: admincheckboxController.ff,
                                  onChanged: (value) {
                                    admincheckboxController.toggleCheckff(value);
                                  }, titlenormal: 'F. ', titlebold: 'Filipino',
                                ),
                                SemiBoldCheckBoxListTile(
                                 // title: 'Y. Patient declines to respond',
                                  isChecked: admincheckboxController.gg,
                                  onChanged: (value) {
                                    admincheckboxController.toggleCheckgg(value);
                                  }, titlenormal: 'G.', titlebold: ' Japanese',
                                ),
                                SemiBoldCheckBoxListTile(
                                  // title: 'X. Patient unable to respond',
                                  isChecked: admincheckboxController.hh,
                                  onChanged: (value) {
                                    admincheckboxController.toggleCheckhh(value);
                                  }, titlenormal: 'H.', titlebold: ' Korean',
                                ),
                                SemiBoldCheckBoxListTile(
                                  // title: 'X. Patient unable to respond',
                                  isChecked: admincheckboxController.ii,
                                  onChanged: (value) {
                                    admincheckboxController.toggleCheckii(value);
                                  }, titlenormal: 'I.', titlebold: ' Vietnamese',
                                ),
                                SemiBoldCheckBoxListTile(
                                  // title: 'X. Patient unable to respond',
                                  isChecked: admincheckboxController.jj,
                                  onChanged: (value) {
                                    admincheckboxController.toggleCheckjj(value);
                                  }, titlenormal: 'J.', titlebold: ' Other Asian',
                                ),
                                SemiBoldCheckBoxListTile(
                                  // title: 'X. Patient unable to respond',
                                  isChecked: admincheckboxController.kk,
                                  onChanged: (value) {
                                    admincheckboxController.toggleCheckkk(value);
                                  }, titlenormal: 'K. ', titlebold: 'Native Hawaiian',
                                ),
                                SemiBoldCheckBoxListTile(
                                  // title: 'X. Patient unable to respond',
                                  isChecked: admincheckboxController.ll,
                                  onChanged: (value) {
                                    admincheckboxController.toggleCheckll(value);
                                  }, titlenormal: 'L.', titlebold: ' Guamanian or Chamorro',
                                ),
                                SemiBoldCheckBoxListTile(
                                  // title: 'X. Patient unable to respond',
                                  isChecked: admincheckboxController.mm,
                                  onChanged: (value) {
                                    admincheckboxController.toggleCheckmm(value);
                                  }, titlenormal: 'M.', titlebold: ' Samoan',
                                ),
                                SemiBoldCheckBoxListTile(
                                  // title: 'X. Patient unable to respond',
                                  isChecked: admincheckboxController.nn,
                                  onChanged: (value) {
                                    admincheckboxController.toggleChecknn(value);
                                  }, titlenormal: 'N.', titlebold: ' Other Pacific Islander',
                                ),
                                SemiBoldCheckBoxListTile(
                                  // title: 'X. Patient unable to respond',
                                  isChecked: admincheckboxController.xx,
                                  onChanged: (value) {
                                    admincheckboxController.toggleCheckxx(value);
                                  }, titlenormal: 'X.', titlebold: ' Patient unable to respond',
                                ),
                                SemiBoldCheckBoxListTile(
                                  // title: 'X. Patient unable to respond',
                                  isChecked: admincheckboxController.yy,
                                  onChanged: (value) {
                                    admincheckboxController.toggleCheckyy(value);
                                  }, titlenormal: 'Y.', titlebold: ' Patient declines to respond ',
                                ),
                                SemiBoldCheckBoxListTile(
                                  // title: 'X. Patient unable to respond',
                                  isChecked: admincheckboxController.zz,
                                  onChanged: (value) {
                                    admincheckboxController.toggleCheckzz(value);
                                  }, titlenormal: 'Z.', titlebold: ' None of the above',
                                ),



                              ],
                            ),

                          ),
                          SizedBox(height: 20,),
                          WhiteContrainerConst(
                            height: 100,
                              child: Column(
                            children: [
                              Ontabtext(ontab: () async{  },
                                child: Row(children: [
                                  Text(" (M0080)", style: Redfontstyle.customTextStyle(context)),
                                  Text(" Discipline of Person Completing Assessment:", style: BoldfontStyle.customTextStyle(context))
                                ],),),

                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: WhiteContrainerConstpadding(
                                      width:100,
                                    height: 30,
                                    child:Center(child: Text("1 - RN",style: Normalfontstyle.customTextStyle(context),)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: WhiteContrainerConstpadding(
                                      width:100,
                                      height: 30,
                                      child:Center(child: Text("2 - PT",style: Normalfontstyle.customTextStyle(context),)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: WhiteContrainerConstpadding(
                                      width:100,
                                      height: 30,
                                      child:Center(child: Text("3 - SLP/ST",style: Normalfontstyle.customTextStyle(context),)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: WhiteContrainerConstpadding(
                                      width:100,
                                      height: 30,
                                      child:Center(child: Text("1 - OT",style: Normalfontstyle.customTextStyle(context),)),
                                    ),
                                  ),
                                  
                                ],
                              )
                            ],
                          )),
                          SizedBox(height: 20,),

                          WhiteContrainerConst(
                              height: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Wrap(
                                        children: [
                                          Container(
                                            constraints: BoxConstraints(maxWidth: 330),
                                            child: Text.rich(
                                              textAlign: TextAlign.start,
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: "(M0100) ",
                                                    style: Redfontstyle.customTextStyle(context),
                                                  ),
                                                  TextSpan(
                                                    text: "This Assessment is Currently Being Completed for the Following Reason:",
                                                    style: BoldfontStyle.customTextStyle(context),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),


                                            Container(
                                            constraints: BoxConstraints(maxWidth: 90),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Image.asset("images/oasis_emr/star.png",height: 15,),
                                                  Image.asset("images/oasis_emr/P.png",height: 15),
                                                  Image.asset("images/oasis_emr/O.png",height: 15,alignment: Alignment.center),
                                                  Image.asset("images/oasis_emr/v.png",height: 18,),
                                                  Image.asset("images/oasis_emr/excl_mark.png",height: 15),
                                                  Image.asset("images/oasis_emr/cc.png",height: 13),
                                                  //Image.asset("images/oasis_emr/.png",height: 10,),
                                                ],
                                              ),
                                            ),
                                          )
                                    ],
                                  ),

                                  SizedBox(height: 20,),
                                  Text("Start/Resumption of Care:  ", style: BoldfontStyle.customTextStyle(context)),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: WhiteContrainerConstpadding(
                                    //  width:100,
                                      height: 30,
                                      child:Text("1 - Start of care-further visits planned",style: Normalfontstyle.customTextStyle(context),),
                                    ),
                                  ),
                                  WhiteContrainerConstpadding(
                                   // width:100,
                                    height: 30,
                                    child:Text("3 - Resumption of care (after inpatient stay)",style: Normalfontstyle.customTextStyle(context),),
                                  ),
                                ],
                              )),
                          SizedBox(height: 20,),
                          WhiteContrainerConst(
                           // height: ,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Ontabtext(ontab: () async{  },
                                  child: Row(children: [
                                    Text("(M0150)", style: Redfontstyle.customTextStyle(context)),
                                    Text(" Current Payment Sources for Home Care: ( Mark all that apply. )", style: BoldfontStyle.customTextStyle(context))
                                  ],),),
                                SizedBox(height: 10,),

                                CustomCheckBoxListTile(
                                  bold: false,
                                  title: '0 - None; no charge for current services',
                                  isChecked: admincheckboxController.zero,
                                  onChanged: (value) {
                                    admincheckboxController.toggleCheckzero(value);
                                  },
                                ),
                                CustomCheckBoxListTile(
                                  bold: false,
                                  title: '1 - Medicare (traditional fee-for-service)',
                                  isChecked: admincheckboxController.one,
                                  onChanged: (value) {
                                    admincheckboxController.toggleCheckone(value);
                                  },
                                ),
                                CustomCheckBoxListTile(
                                  bold: false,
                                  title: '2 - Medicare (HMO/managed care/Advantage plan)',
                                  isChecked: admincheckboxController.two,
                                  onChanged: (value) {
                                    admincheckboxController.toggleChecktwo(value);
                                  },
                                ),
                                CustomCheckBoxListTile(
                                  bold: false,
                                  title: '3 - Medicaid (traditional fee-for-service)',
                                  isChecked: admincheckboxController.three,
                                  onChanged: (value) {
                                    admincheckboxController.toggleCheckthree(value);
                                  },
                                ),
                                CustomCheckBoxListTile(
                                  bold: false,
                                  title: '4 - Medicaid (HMO/managed care)',
                                  isChecked: admincheckboxController.four,
                                  onChanged: (value) {
                                    admincheckboxController.toggleCheckfour(value);
                                  },
                                ),
                                CustomCheckBoxListTile(
                                  bold: false,
                                  title: "5 - Workers compensation",
                                  isChecked: admincheckboxController.five,
                                  onChanged: (value) {
                                    admincheckboxController.toggleCheckfive(value);
                                  },
                                ),
                                CustomCheckBoxListTile(
                                  bold: false,
                                  title: '6 - Title programs (for example, Title III, V, or XX)',
                                  isChecked: admincheckboxController.six,
                                  onChanged: (value) {
                                    admincheckboxController.toggleChecksix(value);
                                  },
                                ),
                                CustomCheckBoxListTile(
                                  bold: false,
                                  title: '7 - Other government (for example, TriCare, VA)',
                                  isChecked: admincheckboxController.seven,
                                  onChanged: (value) {
                                    admincheckboxController.toggleCheckseven(value);
                                  },
                                ),
                                CustomCheckBoxListTile(
                                  bold: false,
                                  title: '8 - Private insurance',
                                  isChecked: admincheckboxController.eight,
                                  onChanged: (value) {
                                    admincheckboxController.toggleCheckeight(value);
                                  },
                                ),
                                CustomCheckBoxListTile(
                                  bold: false,
                                  title: '9 - Private HMO/managed care',
                                  isChecked: admincheckboxController.nine,
                                  onChanged: (value) {
                                    admincheckboxController.toggleChecknine(value);
                                  },
                                ),
                                CustomCheckBoxListTile(
                                  bold: false,
                                  title: '10 - Self-pay',
                                  isChecked: admincheckboxController.ten,
                                  onChanged: (value) {
                                    admincheckboxController.toggleCheckten(value);
                                  },
                                ),
                                CustomCheckBoxListTile(
                                  bold: false,
                                  title: '11 - Other (specify)',
                                  isChecked: admincheckboxController.eleven,
                                  onChanged: (value) {
                                    admincheckboxController.toggleCheckeleven(value);
                                  },
                                ),
                                CustomCheckBoxListTile(
                                  bold: false,
                                  title: 'UK - Unknown',
                                  isChecked: admincheckboxController.tuk,
                                  onChanged: (value) {
                                    admincheckboxController.toggleChecktuk(value);
                                  },
                                ),


                              ],
                            ),

                          ),
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
