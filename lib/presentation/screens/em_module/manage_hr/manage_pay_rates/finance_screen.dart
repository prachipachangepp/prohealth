import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/all_from_hr_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/pay_rates_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/zone_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/all_from_hr/all_from_hr_data.dart';
import 'package:prohealth/data/api_data/establishment_data/zone/zone_model_data.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/services/api/managers/establishment_manager/company_identrity_manager.dart';
import '../../../../../data/api_data/establishment_data/pay_rates/pay_rates_finance_data.dart';
import '../../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../widgets/button_constant.dart';
import '../../widgets/table_constant.dart';
import '../../widgets/text_form_field_const.dart';



class FinanceScreen extends StatefulWidget {
  FinanceScreen({super.key});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController payRatesController = TextEditingController();
  final StreamController<List<PayRateFinanceData>> _payRatesController = StreamController<List<PayRateFinanceData>>();

  String _selectedOption = 'Option 1';
  late int currentPage;
  late int itemsPerPage;
  late List<String> items;

  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 6;
    items = List.generate(20, (index) => 'Item ${index + 1}');
    payRatesDataGet(context,1,10).then((data) {
      _payRatesController.add(data);
    }).catchError((error) {
      // Handle error
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> currentPageItems = items.sublist(
      (currentPage - 1) * itemsPerPage,
      min(currentPage * itemsPerPage, items.length),
    );

    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [buildDropdownButton(context)],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Clinicians Pay Rates',
                  style: GoogleFonts.firaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff686464),
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pick Employee',
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff686464),
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FutureBuilder<List<HRClinical>>(
                        future: companyAllHrClinicApi(context),
                        builder: (context,snapshot) {

                          if(snapshot.connectionState == ConnectionState.waiting){
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: 300,
                                height: 30,
                                decoration: BoxDecoration( color: ColorManager.faintGrey,borderRadius: BorderRadius.circular(10)),
                              )
                            );
                          }
                          if(snapshot.hasData){

                            List<String> dropDownList =[];
                            List<String> dropDownAbbreviation =[];
                            for(var i in snapshot.data!){
                              dropDownList.add(i.empType!,);
                              dropDownAbbreviation.add(i.abbrivation!);
                            }
                            // for(var i in snapshot.data!){
                            //
                            // }
                            print("::::::${dropDownList}");
                            print("::::::${dropDownAbbreviation}");
                            return Row(
                              children: [
                                ///home health dropdown
                                Container(
                                  height: 31,
                                  width: 185,
                                  // margin: EdgeInsets.symmetric(horizontal: 20),
                                  padding:
                                  EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Color(0xff686464).withOpacity(0.5),
                                        width: 1), // Black border
                                    borderRadius:
                                    BorderRadius.circular(12), // Rounded corners
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    focusColor: Colors.transparent,
                                    icon: Icon(
                                      Icons.arrow_drop_down_sharp,
                                      color: Color(0xff686464),
                                    ),
                                    decoration: InputDecoration.collapsed(hintText: ''),
                                    items: dropDownList.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value == null ? "1" : value,
                                        child: Text(value),
                                        // Container(
                                        //   height: 200,
                                        //   width: 400,
                                        //   child: ListView.builder(
                                        //     itemCount: dropDownList.length,
                                        //       itemBuilder: (BuildContext context, index){
                                        //     return Text(dropDownList[index]);
                                        //   }),
                                        // ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {},
                                    value: dropDownList[0],
                                    style: GoogleFonts.firaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff686464),
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  width: 20,
                                ),
                                /// Abbrevation dropdown
                                Container(
                                  height: 31,
                                  width: 185,
                                  // margin: EdgeInsets.symmetric(horizontal: 20),
                                  padding:
                                  EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Color(0xff686464).withOpacity(0.5),
                                        width: 1), // Black border
                                    borderRadius:
                                    BorderRadius.circular(12), // Rounded corners
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    focusColor: Colors.transparent,
                                    icon: Icon(
                                      Icons.arrow_drop_down_sharp,
                                      color: Color(0xff686464),
                                    ),
                                    decoration: InputDecoration.collapsed(hintText: ''),
                                    items: <String>[
                                      "NC",
                                      "PT",
                                     // "PT",
                                      "NA",
                                      //"NA",
                                      //"NC",
                                     // "NC"
                                    ].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {},
                                    value: "NC",
                                    style: GoogleFonts.firaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff686464),
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }else{
                            return Offstage();
                          }

                          }
                        ),

                    ///add payrate button
        FutureBuilder<List<AllZoneData>>(
        future:getAllZone(context),
        builder: (context,snapshot) {
          if(snapshot.hasData){
            List<String> dropDownList =[];
            for(var i in snapshot.data!){
              dropDownList.add(i.zoneName);
              return Container(
                width: 130,
                height: 32,
                child: CustomIconButtonConst(
                    text: 'Add Payrate',
                    icon: Icons.add,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            content:
                            Container(
                              height: 243,
                              width: 309,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(Icons.close))
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('Type of Visit',
                                        style: GoogleFonts.firaSans(
                                            fontSize: 12,
                                            fontWeight: FontWeightManager.bold,
                                            color: ColorManager.mediumgrey
                                        ),),
                                      SizedBox(height: 2,),
                                      Container(
                                        height: 30,
                                        width: 354,
                                        // margin: EdgeInsets.symmetric(horizontal: 20),
                                        padding:
                                        EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 15),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Color(0xff686464).withOpacity(
                                                  0.5),
                                              width: 1), // Black border
                                          borderRadius:
                                          BorderRadius.circular(8), // Rounded corners
                                        ),
                                        child: DropdownButtonFormField<String>(
                                          focusColor: Colors.transparent,
                                          icon: Icon(
                                            Icons.arrow_drop_down_sharp,
                                            color: Color(0xff686464),
                                          ),
                                          decoration: InputDecoration.collapsed(
                                              hintText: ''),
                                          items: <String>[
                                            'Random Visit',
                                            'Option 1',
                                            'Option 2',
                                            'Option 3',
                                            'Option 4'
                                          ].map<DropdownMenuItem<String>>((
                                              String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {},
                                          value: 'Random Visit',
                                          style: GoogleFonts.firaSans(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff686464),
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 17,
                                      ),
                                      Text('Zone',
                                        style: GoogleFonts.firaSans(
                                            fontSize: 12,
                                            fontWeight: FontWeightManager.bold,
                                            color: ColorManager.mediumgrey
                                        ),),
                                      SizedBox(height: 2,),
                                      Container(
                                        height: 30,
                                        width: 354,
                                        // margin: EdgeInsets.symmetric(horizontal: 20),
                                        padding:
                                        EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 15),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Color(0xff686464).withOpacity(
                                                  0.5),
                                              width: 1), // Black border
                                          borderRadius:
                                          BorderRadius.circular(8), // Rounded corners
                                        ),
                                        child: DropdownButtonFormField<String>(
                                          focusColor: Colors.transparent,
                                          icon: Icon(
                                            Icons.arrow_drop_down_sharp,
                                            color: Color(0xff686464),
                                          ),
                                          decoration: InputDecoration.collapsed(
                                              hintText: ''),
                                          items: dropDownList.map<DropdownMenuItem<String>>((
                                              String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {

                                          },
                                          value: dropDownList[0],
                                          style: GoogleFonts.firaSans(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff686464),
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 17,
                                      ),
                                      SMTextFConst(
                                        controller: payRatesController,
                                        keyboardType:
                                        TextInputType.emailAddress,
                                        text: 'Rate',
                                      ),
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
                                    text: 'Submit',
                                    onPressed: () async {
                                      await addPayRatesSetupPost(context, 1, 2, 2, 1, int.parse(payRatesController.text));
                                      payRatesDataGet(context,1,10).then((data) {
                                        _payRatesController.add(data);
                                      }).catchError((error) {
                                        // Handle error
                                      });
                                      Navigator.pop(context);

                                    }),)
                            ]
                            ,
                          );
                        },
                      );
                    }),
              );
            }
          }else{
            return Offstage();
          }
          return Offstage();
    }

    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),

            TableHeadConstant(
              items: [
                TableHeadItem(text: 'Sr No.', textAlign: TextAlign.start),
                TableHeadItem(
                    text: 'Type of Visit', textAlign: TextAlign.start),
                TableHeadItem(text: 'Rate', textAlign: TextAlign.start),
                TableHeadItem(text: 'Zone', textAlign: TextAlign.start),
                TableHeadItem(text: 'Actions', textAlign: TextAlign.end),
              ],
            ),
            SizedBox(
              height: 5,
            ),

            ///list
            Expanded(
              child:
              StreamBuilder<List<PayRateFinanceData>>(
                stream:_payRatesController.stream,
                builder: (context, snapshot) {
                  print('1111111');
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: ColorManager.blueprime,
                      ),
                    );
                  }
                  if (snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        AppString.dataNotFound,
                        style: CustomTextStylesCommon.commonStyle(
                          fontWeight: FontWeightManager.medium,
                          fontSize: FontSize.s12,
                          color: ColorManager.mediumgrey,
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    int serialNumber =
                        index + 1 + (currentPage - 1) * itemsPerPage;
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
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    snapshot.data![index].typeVisit,
                                    textAlign: TextAlign.end,
                                    style: GoogleFonts.firaSans(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff686464),
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                                Text(
                                  '\$${snapshot.data![index].payRates}',
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.firaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff686464),
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                                Text(
                                  '${snapshot.data![index].zone!}' ,
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.firaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff686464),
                                    decoration: TextDecoration.none,
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
                                                height: 243,
                                                width: 309,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(8)),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.end,
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            icon: Icon(Icons.close))
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text('Type of Visit',
                                                          style: GoogleFonts.firaSans(
                                                              fontSize: 12,
                                                              fontWeight: FontWeightManager.bold,
                                                              color: ColorManager.fmediumgrey
                                                          ),),
                                                        SizedBox(height: 2,),
                                                        Container(
                                                          height: 30,
                                                          width: 354,
                                                          // margin: EdgeInsets.symmetric(horizontal: 20),
                                                          padding:
                                                          EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color: Color(0xff686464).withOpacity(0.5),
                                                                width: 1), // Black border
                                                            borderRadius:
                                                            BorderRadius.circular(8), // Rounded corners
                                                          ),
                                                          child: DropdownButtonFormField<String>(
                                                            focusColor: Colors.transparent,
                                                            icon: Icon(
                                                              Icons.arrow_drop_down_sharp,
                                                              color: ColorManager.fmediumgrey,
                                                            ),
                                                            decoration: InputDecoration.collapsed(hintText: ''),
                                                            items: <String>[
                                                              'Random Visit',
                                                              'Option 1',
                                                              'Option 2',
                                                              'Option 3',
                                                              'Option 4'
                                                            ].map<DropdownMenuItem<String>>((String value) {
                                                              return DropdownMenuItem<String>(
                                                                value: value,
                                                                child: Text(value),
                                                              );
                                                            }).toList(),
                                                            onChanged: (String? newValue) {},
                                                            value: 'Random Visit',
                                                            style: GoogleFonts.firaSans(
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w600,
                                                              color: ColorManager.fmediumgrey,
                                                              decoration: TextDecoration.none,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 17,
                                                        ),
                                                        Text('Zone',
                                                          style: GoogleFonts.firaSans(
                                                              fontSize: 12,
                                                              fontWeight: FontWeightManager.bold,
                                                              color: ColorManager.mediumgrey
                                                          ),),
                                                        SizedBox(height: 2,),
                                                        Container(
                                                          height: 30,
                                                          width: 354,
                                                          // margin: EdgeInsets.symmetric(horizontal: 20),
                                                          padding:
                                                          EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color: Color(0xff686464).withOpacity(0.5),
                                                                width: 1), // Black border
                                                            borderRadius:
                                                            BorderRadius.circular(8), // Rounded corners
                                                          ),
                                                          child: DropdownButtonFormField<String>(
                                                            focusColor: Colors.transparent,
                                                            icon: Icon(
                                                              Icons.arrow_drop_down_sharp,
                                                              color: Color(0xff686464),
                                                            ),
                                                            decoration: InputDecoration.collapsed(hintText: ''),
                                                            items: <String>[
                                                              'Sans Josh z4',
                                                              'Option 1',
                                                              'Option 2',
                                                              'Option 3',
                                                              'Option 4'
                                                            ].map<DropdownMenuItem<String>>((String value) {
                                                              return DropdownMenuItem<String>(
                                                                value: value,
                                                                child: Text(value),
                                                              );
                                                            }).toList(),
                                                            onChanged: (String? newValue) {},
                                                            value: 'Sans Josh z4',
                                                            style: GoogleFonts.firaSans(
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w600,
                                                              color: Color(0xff686464),
                                                              decoration: TextDecoration.none,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        SMTextFConst(
                                                          controller:
                                                          payRatesController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .emailAddress,
                                                          text: 'Rate',
                                                        ),
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
                                                      text: 'Submit',
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
                                        Icons.edit_outlined,size: 18,
                                        color: ColorManager.blueprime,
                                      ),
                                    ),
                                    IconButton(onPressed: (){

                                    }, icon: Icon(
                                      Icons.delete_outline_outlined,
                                      size: 18,color: ColorManager.red,))
                                  ],
                                ),
                              ],
                            )),
                      ],
                    );
                  });
  }
  return Offstage();
},
),
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
    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Color(0xff50B5E5), width: 1.2),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xff000000).withOpacity(0.25),
          blurRadius: 2,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: DropdownButton<String>(
      value: 'Sort By',
      style: GoogleFonts.firaSans(
        fontSize: 12,
        fontWeight: FontWeightManager.bold,
        color: Color(0xff50B5E5),
        decoration: TextDecoration.none,
      ),
      icon: Icon(
        Icons.arrow_drop_down,
        color: Color(0xff50B5E5),
      ),
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
                  content: Container(
                    height: 343,
                    width: 409,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.close))
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SMTextFConst(
                              controller: nameController,
                              keyboardType: TextInputType.text,
                              text: 'Type of Visit',
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            SMTextFConst(
                              controller: addressController,
                              keyboardType: TextInputType.streetAddress,
                              text: 'Zone',
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            SMTextFConst(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              text: 'Rate',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 60,
                        ),
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
        }
      },
      items: <String>[
        'Sort By',
        'For all zones',
        'San Jose z4',
        'San Jose z4',
        'San Jose z4',
        'San Jose z4',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(color: ColorManager.blueprime),
          ),
        );
      }).toList(),
    ),
  );
}

///change color dropdown
// Widget buildDropdownButton(BuildContext context) {
//   ValueNotifier<String> selectedValueNotifier = ValueNotifier<String>('Sort By');
//
//   return ValueListenableBuilder<String>(
//     valueListenable: selectedValueNotifier,
//     builder: (context, selectedValue, child) {
//       return Container(
//         height: 31,
//         padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(
//             color: selectedValue == 'For all zones' ? Colors.red : Color(0xff50B5E5),
//             width: 1.2,
//           ),
//           borderRadius: BorderRadius.circular(12.0),
//           boxShadow: [
//             BoxShadow(
//               color: Color(0xff000000).withOpacity(0.25),
//               blurRadius: 2,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: DropdownButton<String>(
//           value: selectedValue,
//           style: GoogleFonts.firaSans(
//             fontSize: 10,
//             fontWeight: FontWeight.w500,
//             color: selectedValue == 'For all zones' ? Colors.red : Color(0xff50B5E5),
//             decoration: TextDecoration.none,
//           ),
//           icon: Icon(
//             Icons.arrow_drop_down,
//             color: selectedValue == 'For all zones' ? Colors.red : Color(0xff50B5E5),
//           ),
//           iconSize: 20,
//           underline: SizedBox(),
//           onChanged: (newValue) {
//             selectedValueNotifier.value = newValue!;
//           },
//           items: <String>['Sort By', 'For all zones', 'San Jose z4']
//               .map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(
//                 value,
//                 style: TextStyle(
//                   color: selectedValue == 'For all zones' ? Colors.red : Color(0xff50B5E5),
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       );
//     },
//   );
// }
