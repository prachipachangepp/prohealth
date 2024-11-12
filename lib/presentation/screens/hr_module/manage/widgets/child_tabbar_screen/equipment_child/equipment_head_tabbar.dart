import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/equipment_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/equipment_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/equipment_child/widgets/add_new_popup.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';
import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../app/resources/hr_resources/string_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../../em_module/widgets/button_constant.dart';
import '../../../../../em_module/widgets/text_form_field_const.dart';

class InventoryHeadTabbar extends StatefulWidget {
  final int employeeId;
  const InventoryHeadTabbar({super.key, required this.employeeId});

  @override
  State<InventoryHeadTabbar> createState() => _InventoryHeadTabbarState();
}

class _InventoryHeadTabbarState extends State<InventoryHeadTabbar> {
  TextEditingController vendorName = TextEditingController();
  final StreamController<List<EquipmentData>> equipementDataStreamController = StreamController<List<EquipmentData>>();
  late int currentPage;

  late int itemsPerPage;

  late List<String> items;

  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 20;
    items = List.generate(60, (index) => 'Item ${index + 1}');
    // companyAllApi(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 60),
              child: CustomIconButtonConst(
                  width: 100,
                  text: AppStringHr.addNew,
                  icon: Icons.add,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => EquipmentAddPopup(employeeId: widget.employeeId));
                  }),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        StreamBuilder(
            stream: equipementDataStreamController.stream,
            builder: (context,snapshot) {
              getEquipement(context,widget.employeeId).then((data) {
                equipementDataStreamController.add(data);
              }).catchError((error) {
                // Handle error
              });
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100),
                    child: CircularProgressIndicator(color: ColorManager.blueprime,),
                  ),
                );
              }
              if (snapshot.data!.isEmpty) {
                return Center(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 100),
                        child: Text(
                          AppStringHRNoData.equpmentNoData,
                          style: AllNoDataAvailable.customTextStyle(context),
                        )));
              }
              if(snapshot.hasData){
                return Container(
                  height: MediaQuery.of(context).size.height/1,

                  child: Column(
                    children: [
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
                                      AppString.srNo,
                                      style: EquipmentStyleHeading.customTextStyle(context)
                                  ),
                                ),
                              ),
                              //SizedBox(width: MediaQuery.of(context).size.width/7.5,),
                              Expanded(
                                child: Center(
                                  child: Text(
                                      AppStringHr.inventoryid,
                                      style: EquipmentStyleHeading.customTextStyle(context)),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(AppStringHr.docName,
                                      style: EquipmentStyleHeading.customTextStyle(context)),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text('Device Description',
                                      style: EquipmentStyleHeading.customTextStyle(context)),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text('Assign Date   ',
                                      style: EquipmentStyleHeading.customTextStyle(context)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              var equipmentData = snapshot.data![index];
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
                                              color: Color(0xff000000)
                                                  .withOpacity(0.25),
                                              spreadRadius: 0,
                                              blurRadius: 4,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        height: 50,
                                        margin: EdgeInsets.symmetric(horizontal: 9),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                      formattedSerialNumber,
                                                      style: EquipmentStyleRegular.customTextStyle(context)
                                                  ),
                                                ),
                                              ),
                                              // Text(''),
                                              Expanded(
                                                child: Center(
                                                  child: Text(

                                                      "${equipmentData.inventoryTypeId}",
                                                      style: EquipmentStyleRegular.customTextStyle(context)
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                      equipmentData.name,
                                                      // "${equipmentData.inventoryId}",
                                                      style: EquipmentStyleRegular.customTextStyle(context)
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                      equipmentData.givenId,
                                                      style: EquipmentStyleRegular.customTextStyle(context)
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                      equipmentData.assignedDate.toString(),
                                                      style: EquipmentStyleRegular.customTextStyle(context)
                                                  ),
                                                ),
                                              ),
                                              //  Text(''),
                                            ],
                                          ),
                                        )),
                                  ),
                                ],
                              );
                            }),

                      ),
                    ],
                  ),
                );
              }
              return SizedBox();
            }
        ),
      ],
    );
  }
}
