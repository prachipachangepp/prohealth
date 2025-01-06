import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/payrates_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/payrates_data.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';

import '../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';

class PayRatesHeadTabbar extends StatefulWidget {
  final int employeeId;
  const PayRatesHeadTabbar({super.key, required this.employeeId});

  @override
  State<PayRatesHeadTabbar> createState() => _PayRatesHeadTabbarState();
}

class _PayRatesHeadTabbarState extends State<PayRatesHeadTabbar> {
  TextEditingController vendorName = TextEditingController();
  final StreamController<List<PayratesData>> _payratesStreamController = StreamController<List<PayratesData>>();

  late int currentPage;

  late int itemsPerPage;

  late List<String> items;

  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 20;
    items = List.generate(20, (index) => 'Item ${index + 1}');
    // companyAllApi(context);
  }

  // String selectedValue = 'Per visit';
  String? selectedValue = 'Per Zone';
  @override
  Widget build(BuildContext context) {
    String? _expiryType;
    return SingleChildScrollView(
      child: StreamBuilder<List<PayratesData>>(
          stream: _payratesStreamController.stream,
          builder: (context,snapshot) {
            getEmployeePayrates(context, widget.employeeId,1,20).then((data) {
              _payratesStreamController.add(data);
            }).catchError((error) {
              // Handle error
            });
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 90),
                child: Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.blueprime,
                  ),
                ),
              );
            }
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 150),
                  child: Text(
                    AppStringHRNoData.payRatesNoData,
                    style: AllNoDataAvailable.customTextStyle(context),
                  ),
                ),
              );
            }
            if(snapshot.hasData){
              return Container(
                height: MediaQuery.of(context).size.height / 1,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child:

                          Container(
                            height: 25,
                            width: 200,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: const Color(0xff44435E)),
                            ),
                            child: DropdownButton<String>(
                              value: selectedValue,
                              icon: const Padding(
                                padding: EdgeInsets.only(left: 60.0),
                                child: Icon(Icons.arrow_drop_down),
                              ),
                              iconSize: 24,
                              elevation: 16,
                              style: EquipmentStyleRegular.customTextStyle(context),
                              underline: const SizedBox(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue = newValue!;
                                });
                              },
                              items: <String>['Per Zone', 'Per Mileage']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),

                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    Container(
                      height: 30,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Text(''),
                            Expanded(
                              child: Center(
                                child: Text(
                                    AppString.znNo,
                                    style: EquipmentStyleHeading.customTextStyle(context)
                                ),
                              ),
                            ),
                            //SizedBox(width: MediaQuery.of(context).size.width/7.5,),
                            Expanded(
                              child: Center(
                                child: Text('Type of Visit',
                                    style: EquipmentStyleHeading.customTextStyle(context)),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text('Rate',
                                    style: EquipmentStyleHeading.customTextStyle(context)),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text('Action',
                                    style: EquipmentStyleHeading.customTextStyle(context)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child:
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var payRates = snapshot.data![index];
                            int serialNumber =
                                index + 1 + (currentPage - 1) * itemsPerPage;
                            String formattedSerialNumber =
                            serialNumber.toString().padLeft(2, '0');
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xff000000).withOpacity(0.25),
                                            spreadRadius: 0,
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      margin: EdgeInsets.symmetric(horizontal: 9),
                                      height: 40,
                                      child: Stack(children: [
                                        Container(
                                          width: 10,
                                          decoration:  BoxDecoration(color: ColorManager.blueprime,
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(4),bottomLeft:Radius.circular(4))),

                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                      "${payRates.zoneId}",
                                                      style: EquipmentStyleRegular.customTextStyle(context)
                                                  ),
                                                ),
                                              ),
                                              // Text(''),
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                      payRates.visitType,
                                                      style: EquipmentStyleRegular.customTextStyle(context)
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                      "${payRates.payRates}",
                                                      style: EquipmentStyleRegular.customTextStyle(context)
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Container(
                                                      height: 25,
                                                      width: 150,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(5),
                                                          color: const Color(0xFFF6928A)),
                                                      child: ElevatedButton(
                                                          onPressed: () {
                                                            showDialog(context: context, builder: (BuildContext context)=>
                                                                DeletePopup(onCancel: (){
                                                                  Navigator.pop(context);
                                                                }, onDelete: () async{
                                                                  // await deleteEmployeePayrates(context: context,
                                                                  //     employeePayratesId: employeePayratesId);
                                                                  Navigator.pop(context);
                                                                }, title: "Delete"));
                                                          },
                                                          style:
                                                          ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                              const Color(
                                                                  0xFFF6928A)),
                                                          child: Text(
                                                            'Delete',
                                                            style: TextStyle(
                                                                color:
                                                                ColorManager.white),
                                                          ))),
                                                ),
                                              ) //  Text(''),
                                            ],
                                          ),
                                        ),
                                      ])),
                                ),
                              ],
                            );
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomRadioListTile(
                          title: "Per Zone",
                          value: 'Per zone',
                          groupValue: _expiryType,
                          onChanged: (value) {
                            setState(() {
                              _expiryType = value;
                            });
                          },
                        ),
                        CustomRadioListTile(
                          title: "Per milege",
                          value: 'type2',
                          groupValue: _expiryType,
                          onChanged: (value) {
                            setState(() {
                              _expiryType = value;
                            });
                          },
                        ),
                      ],
                    )
                  ],
                ),
              );
            }
            return SizedBox();
    }
    ),
    );
  }
}
