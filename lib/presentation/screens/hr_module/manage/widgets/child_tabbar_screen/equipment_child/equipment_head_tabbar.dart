import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/equipment_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/equipment_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
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
            Container(
              // width: 100,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.25),
                    //spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              margin: EdgeInsets.only(right: 10),
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
                  child: Text(
                    AppString.dataNotFound,
                    style: CustomTextStylesCommon.commonStyle(
                        fontWeight: FontWeightManager.medium,
                        fontSize: FontSize.s12,
                        color: ColorManager.mediumgrey),
                  ));
            }
            if(snapshot.hasData){
              return Container(
                height: MediaQuery.of(context).size.height/1,
                child: Column(
                  children: [
                    Container(
                      height: 30,
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
                                  style: GoogleFonts.firaSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),
                            //SizedBox(width: MediaQuery.of(context).size.width/7.5,),
                            Expanded(
                              child: Center(
                                child: Text(AppStringHr.inventoryid,
                                    style: GoogleFonts.firaSans(
                                      fontSize: FontSize.s12,
                                      fontWeight: FontWeightManager.bold,
                                      color: Colors.white,
                                      decoration: TextDecoration.none,
                                    )),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(AppStringHr.docName,
                                    style: GoogleFonts.firaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      decoration: TextDecoration.none,
                                    )),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text('Device Description',
                                    style: GoogleFonts.firaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      decoration: TextDecoration.none,
                                    )),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text('Assign Date   ',
                                    style: GoogleFonts.firaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      decoration: TextDecoration.none,
                                    )),
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
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff686464),
                                                    decoration: TextDecoration.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // Text(''),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  "${equipmentData.inventoryId}",
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff686464),
                                                    decoration: TextDecoration.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  equipmentData.name,
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff686464),
                                                    decoration: TextDecoration.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  equipmentData.givenId,
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff686464),
                                                    decoration: TextDecoration.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  equipmentData.assignedDate.toString(),
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff686464),
                                                    decoration: TextDecoration.none,
                                                  ),
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


class EquipmentAddPopup extends StatefulWidget {
  final int employeeId;
  const EquipmentAddPopup({super.key, required this.employeeId});

  @override
  State<EquipmentAddPopup> createState() => _EquipmentAddPopupState();
}

TextEditingController idController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController calenderController = TextEditingController();
class _EquipmentAddPopupState extends State<EquipmentAddPopup> {
  bool isLoading = false;
  String typeName = '';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft:Radius.circular(8),topRight:Radius.circular(8)),
      ),
      titlePadding: EdgeInsets.zero,
      title: Column(
        children: [
          Container(
            height: 45,
            decoration: BoxDecoration(
                color: Color(0xFF27A3E0),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8.0),
                    topLeft: Radius.circular(8.0))),
            padding: EdgeInsets.only(left: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add New Equipment',
                  style: GoogleFonts.firaSans(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManager.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                IconButton(

                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
      SizedBox(height: MediaQuery.of(context ).size.height/30),
      Container(
        height: AppSize.s400,
        width: AppSize.s350,
        decoration: BoxDecoration(
          color: ColorManager.white,                                              //background colour
          borderRadius: BorderRadius.circular(0),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p3,horizontal: AppPadding.p25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SMTextFConst(controller: idController, keyboardType: TextInputType.text, text: 'Id',),
                  SizedBox(height: AppSize.s16,),
                  SMTextFConst(controller:nameController, keyboardType: TextInputType.streetAddress, text: 'Name',),
                  SizedBox(height: AppSize.s16,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Device Description',
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color:  ColorManager.granitegray,
                          decoration: TextDecoration.none,
                        ),),
                      SizedBox(height: 5),
                      CICCDropdown(
                        onChange: (newValue){
                          setState(() {
                            typeName = newValue;
                            print("Type::${typeName}");
                          });
                        },
                        initialValue: 'Cellular',
                        items: [
                          DropdownMenuItem(value: 'Cellular', child: Text('Cellular')),
                          DropdownMenuItem(value: 'A', child: Text('A')),
                          DropdownMenuItem(value: 'B', child: Text('B')),
                          DropdownMenuItem(value: 'C', child: Text('C')),
                        ],
                      )
                      // Container(
                      //   height: 30,
                      //   padding: EdgeInsets.only(top: 2,bottom: 1,left: 4),
                      //   decoration: BoxDecoration(
                      //     color: Colors.transparent,
                      //     border: Border.all(color: Color(0xffB1B1B1)), // Black border
                      //     borderRadius: BorderRadius.circular(8), // Rounded corners
                      //   ),
                      //   child: DropdownButtonFormField<String>(
                      //     focusColor: Colors.transparent,
                      //     icon: Icon(Icons.arrow_drop_down_sharp,color: ColorManager.black,),
                      //     decoration: InputDecoration.collapsed(hintText: ''),
                      //     items: <String>['Cellular', 'A', 'B', 'C']
                      //         .map<DropdownMenuItem<String>>((String value) {
                      //       return DropdownMenuItem<String>(
                      //         value: value,
                      //         child: Text(value,style: GoogleFonts.roboto(color: Color(0xff686464),fontSize: 12,fontWeight: FontWeightManager.bold),),
                      //       );
                      //     }).toList(),
                      //     onChanged: (String? newValue) {
                      //       setState(() {
                      //         typeName = newValue!;
                      //         print("Type::${typeName}");
                      //       });
                      //     },
                      //     value: 'Cellular',
                      //     style: GoogleFonts.roboto(
                      //         color: ColorManager.granitegray,
                      //       fontSize: AppSize.s12,
                      //       fontWeight: FontWeightManager.bold),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: AppSize.s16,),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Assign Date',
                            style: GoogleFonts.firaSans(
                              fontSize: AppSize.s12,
                              fontWeight: FontWeightManager.bold,
                              color: ColorManager.granitegray,
                              decoration: TextDecoration.none,
                            ),),
                        ],
                      ),
                      SizedBox(height:5,),
                      FormField<String>(
                        builder: (FormFieldState<String> field) {
                          return SizedBox(
                            width: 354,
                            height: AppSize.s30,
                            child: TextFormField(
                              style: GoogleFonts.firaSans(
                                fontSize: FontSize.s12,
                                fontWeight: FontWeightManager.bold,
                                color: ColorManager.mediumgrey,
                                //decoration: TextDecoration.none,
                              ),
                              controller: calenderController,
                              decoration: InputDecoration(
                                focusColor: ColorManager.mediumgrey,
                                hoverColor: ColorManager.mediumgrey,
                                hintText: 'dd-mm-yyyy',
                                hintStyle: GoogleFonts.firaSans(
                                  fontSize: FontSize.s12,
                                  fontWeight: FontWeightManager.bold,
                                  color: ColorManager.mediumgrey,
                                  //decoration: TextDecoration.none,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      width: 1, color: ColorManager.mediumgrey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: ColorManager.mediumgrey), // Set focused border color to red
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: ColorManager
                                          .mediumgrey), // Set enabled border color to red
                                ),
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                                suffixIcon: Icon(Icons.calendar_month_outlined,
                                    color: ColorManager.blueprime),
                                errorText: field.errorText,
                              ),
                              readOnly: true,
                              onTap: () async {
                                DateTime? date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1100),
                                  lastDate: DateTime(2026),
                                );
                                if (date != null) {
                                  String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(date);
                                  calenderController.text = formattedDate;
                                  field.didChange(formattedDate);
                                  // birthdayController.text =
                                  // date.toLocal().toString().split(' ')[0];
                                  // field.didChange(date.toLocal().toString().split(' ')[0]);
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please select date';
                                }
                                return null;
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width/22,),
                  Center(
                    child: isLoading ? SizedBox(
                      height: AppSize.s25,
                        width: AppSize.s25,
                        child: CircularProgressIndicator(color: ColorManager.blueprime,)):
                     CustomElevatedButton(
                        width: AppSize.s150,
                        height: AppSize.s30,
                        text: 'Add Equipment',
                        onPressed: () async{
                          setState(() {
                            isLoading = true;
                          });
                            await addEquipment(context, int.parse(idController.text), calenderController.text,
                                widget.employeeId, typeName, 11, nameController.text);
                            print("::${idController.text}");
                          print("::${typeName}");
                          print("::${calenderController.text}");
                          print("::${nameController.text}");
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.pop(context);
                            nameController.clear();
                            idController.clear();
                            calenderController.clear();

                        }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
  ]
      ),
    );
  }
}
