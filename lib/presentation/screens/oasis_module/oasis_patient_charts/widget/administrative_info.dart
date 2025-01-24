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
                                      isChecked: checkboxController.ukn,
                                      onChanged: (value) {
                                        checkboxController.toggleCheckukn(value);
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
                                      isChecked: checkboxController.ukp,
                                      onChanged: (value) {
                                        checkboxController.toggleCheckukp(value);
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
                                isChecked: checkboxController.a,
                                onChanged: (value) {
                                  checkboxController.toggleChecka(value);
                                }, titlenormal: 'A.', titlebold: ' No, not of Hispanic, Latino/a, or Spanish origin',
                              ),
                              SemiBoldCheckBoxListTile(
                                //title: 'B. Yes, Mexican, Mexican American, Chicano/a',
                                isChecked: checkboxController.b,
                                onChanged: (value) {
                                  checkboxController.toggleCheckb(value);
                                }, titlenormal: 'B.', titlebold: 'Yes, Mexican, Mexican American, Chicano/a',
                              ),
                              SemiBoldCheckBoxListTile(
                                //title: 'C. Yes, Puerto Rican',
                                isChecked: checkboxController.c,
                                onChanged: (value) {
                                  checkboxController.toggleCheckc(value);
                                }, titlenormal: 'C.', titlebold: 'Yes, Puerto Rican',
                              ),
                              SemiBoldCheckBoxListTile(
                               // title: 'D. Yes, Cuban',
                                isChecked: checkboxController.d,
                                onChanged: (value) {
                                  checkboxController.toggleCheckd(value);
                                }, titlenormal: 'D.', titlebold: 'Yes, Cuban',
                              ),
                              SemiBoldCheckBoxListTile(
                               // title: 'E. Yes, another Hispanic, Latino, or Spanish origin',
                                isChecked: checkboxController.e,
                                onChanged: (value) {
                                  checkboxController.toggleChecke(value);
                                }, titlenormal: 'E.', titlebold: 'Yes, another Hispanic, Latino, or Spanish origin',
                              ),
                              SemiBoldCheckBoxListTile(
                               // title: 'X. Patient unable to respond',
                                isChecked: checkboxController.x,
                                onChanged: (value) {
                                  checkboxController.toggleCheckx(value);
                                }, titlenormal: 'X.', titlebold: 'Patient unable to respond',
                              ),
                              SemiBoldCheckBoxListTile(
                                //title: 'Y. Patient declines to respond',
                                isChecked: checkboxController.y,
                                onChanged: (value) {
                                  checkboxController.toggleChecky(value);
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
                                  isChecked: checkboxController.aa,
                                  onChanged: (value) {
                                    checkboxController.toggleCheckaa(value);
                                  }, titlenormal: 'A.', titlebold: 'White',
                                ),
                                SemiBoldCheckBoxListTile(
                                  //title: 'B. Yes, Mexican, Mexican American, Chicano/a',
                                  isChecked: checkboxController.bb,
                                  onChanged: (value) {
                                    checkboxController.toggleCheckbb(value);
                                  }, titlenormal: 'B. ', titlebold: 'Black or African American',
                                ),
                                SemiBoldCheckBoxListTile(
                                //  title: 'C. Yes, Puerto Rican',
                                  isChecked: checkboxController.cc,
                                  onChanged: (value) {
                                    checkboxController.toggleCheckcc(value);
                                  }, titlenormal: 'C.', titlebold: ' American Indian or Alaska Native',
                                ),
                                SemiBoldCheckBoxListTile(
                                 // title: 'D. Yes, Cuban',
                                  isChecked: checkboxController.dd,
                                  onChanged: (value) {
                                    checkboxController.toggleCheckdd(value);
                                  }, titlenormal: 'D.', titlebold: ' Asian Indian',
                                ),
                                SemiBoldCheckBoxListTile(
                                 // title: 'E. Yes, another Hispanic, Latino, or Spanish origin',
                                  isChecked: checkboxController.ee,
                                  onChanged: (value) {
                                    checkboxController.toggleCheckee(value);
                                  }, titlenormal: 'E.', titlebold: ' Chinese',
                                ),
                                SemiBoldCheckBoxListTile(
                                 // title: 'X. Patient unable to respond',
                                  isChecked: checkboxController.ff,
                                  onChanged: (value) {
                                    checkboxController.toggleCheckff(value);
                                  }, titlenormal: 'F. ', titlebold: 'Filipino',
                                ),
                                SemiBoldCheckBoxListTile(
                                 // title: 'Y. Patient declines to respond',
                                  isChecked: checkboxController.gg,
                                  onChanged: (value) {
                                    checkboxController.toggleCheckgg(value);
                                  }, titlenormal: 'G.', titlebold: ' Japanese',
                                ),
                                SemiBoldCheckBoxListTile(
                                  // title: 'X. Patient unable to respond',
                                  isChecked: checkboxController.hh,
                                  onChanged: (value) {
                                    checkboxController.toggleCheckhh(value);
                                  }, titlenormal: 'H.', titlebold: ' Korean',
                                ),
                                SemiBoldCheckBoxListTile(
                                  // title: 'X. Patient unable to respond',
                                  isChecked: checkboxController.ii,
                                  onChanged: (value) {
                                    checkboxController.toggleCheckii(value);
                                  }, titlenormal: 'I.', titlebold: ' Vietnamese',
                                ),
                                SemiBoldCheckBoxListTile(
                                  // title: 'X. Patient unable to respond',
                                  isChecked: checkboxController.jj,
                                  onChanged: (value) {
                                    checkboxController.toggleCheckjj(value);
                                  }, titlenormal: 'J.', titlebold: ' Other Asian',
                                ),
                                SemiBoldCheckBoxListTile(
                                  // title: 'X. Patient unable to respond',
                                  isChecked: checkboxController.kk,
                                  onChanged: (value) {
                                    checkboxController.toggleCheckkk(value);
                                  }, titlenormal: 'K. ', titlebold: 'Native Hawaiian',
                                ),
                                SemiBoldCheckBoxListTile(
                                  // title: 'X. Patient unable to respond',
                                  isChecked: checkboxController.ll,
                                  onChanged: (value) {
                                    checkboxController.toggleCheckll(value);
                                  }, titlenormal: 'L.', titlebold: ' Guamanian or Chamorro',
                                ),
                                SemiBoldCheckBoxListTile(
                                  // title: 'X. Patient unable to respond',
                                  isChecked: checkboxController.mm,
                                  onChanged: (value) {
                                    checkboxController.toggleCheckmm(value);
                                  }, titlenormal: 'M.', titlebold: ' Samoan',
                                ),
                                SemiBoldCheckBoxListTile(
                                  // title: 'X. Patient unable to respond',
                                  isChecked: checkboxController.nn,
                                  onChanged: (value) {
                                    checkboxController.toggleChecknn(value);
                                  }, titlenormal: 'N.', titlebold: ' Other Pacific Islander',
                                ),
                                SemiBoldCheckBoxListTile(
                                  // title: 'X. Patient unable to respond',
                                  isChecked: checkboxController.xx,
                                  onChanged: (value) {
                                    checkboxController.toggleCheckxx(value);
                                  }, titlenormal: 'X.', titlebold: ' Patient unable to respond',
                                ),
                                SemiBoldCheckBoxListTile(
                                  // title: 'X. Patient unable to respond',
                                  isChecked: checkboxController.yy,
                                  onChanged: (value) {
                                    checkboxController.toggleCheckyy(value);
                                  }, titlenormal: 'Y.', titlebold: ' Patient declines to respond ',
                                ),
                                SemiBoldCheckBoxListTile(
                                  // title: 'X. Patient unable to respond',
                                  isChecked: checkboxController.zz,
                                  onChanged: (value) {
                                    checkboxController.toggleCheckzz(value);
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
                          // WhiteContrainerConst(
                          //  // height: ,
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Ontabtext(ontab: () async{  },
                          //         child: Row(children: [
                          //           Text("(A1005)", style: Redfontstyle.customTextStyle(context)),
                          //           Text(" Ethnicity", style: BoldfontStyle.customTextStyle(context))
                          //         ],),),
                          //       SizedBox(height: 10,),
                          //       Text.rich(
                          //         TextSpan(
                          //           children: [
                          //             TextSpan(
                          //                 text: "Are you of Hispanic, Latino/a, or Spanish origin?", style: Normalfontstyle.customTextStyle(context)
                          //             ),
                          //             TextSpan(
                          //                 text: "            ( Check all that apply )", style: BoldfontStyle.customTextStyle(context)
                          //             ),
                          //
                          //           ],
                          //         ),
                          //       ),
                          //       SizedBox(height: 10,),
                          //       CustomCheckBoxListTile(
                          //         title: 'A. No, not of Hispanic, Latino/a, or Spanish origin',
                          //         isChecked: checkboxController.a,
                          //         onChanged: (value) {
                          //           checkboxController.toggleChecka(value);
                          //         },
                          //       ),
                          //       CustomCheckBoxListTile(
                          //         title: 'B. Yes, Mexican, Mexican American, Chicano/a',
                          //         isChecked: checkboxController.b,
                          //         onChanged: (value) {
                          //           checkboxController.toggleCheckb(value);
                          //         },
                          //       ),
                          //       CustomCheckBoxListTile(
                          //         title: 'C. Yes, Puerto Rican',
                          //         isChecked: checkboxController.c,
                          //         onChanged: (value) {
                          //           checkboxController.toggleCheckc(value);
                          //         },
                          //       ),
                          //       CustomCheckBoxListTile(
                          //         title: 'D. Yes, Cuban',
                          //         isChecked: checkboxController.d,
                          //         onChanged: (value) {
                          //           checkboxController.toggleCheckd(value);
                          //         },
                          //       ),
                          //       CustomCheckBoxListTile(
                          //         title: 'E. Yes, another Hispanic, Latino, or Spanish origin',
                          //         isChecked: checkboxController.e,
                          //         onChanged: (value) {
                          //           checkboxController.toggleChecke(value);
                          //         },
                          //       ),
                          //       CustomCheckBoxListTile(
                          //         title: 'X. Patient unable to respond',
                          //         isChecked: checkboxController.x,
                          //         onChanged: (value) {
                          //           checkboxController.toggleCheckx(value);
                          //         },
                          //       ),
                          //       CustomCheckBoxListTile(
                          //         title: 'Y. Patient declines to respond',
                          //         isChecked: checkboxController.y,
                          //         onChanged: (value) {
                          //           checkboxController.toggleChecky(value);
                          //         },
                          //       ),
                          //
                          //
                          //     ],
                          //   ),
                          //
                          // ),
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
