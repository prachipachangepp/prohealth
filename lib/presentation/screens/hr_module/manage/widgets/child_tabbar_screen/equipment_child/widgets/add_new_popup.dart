import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/dialogue_template.dart';

import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../../app/resources/const_string.dart';
import '../../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../../app/services/api/managers/hr_module_manager/manage_emp/equipment_manager.dart';
import '../../../../../../../../data/api_data/hr_module_data/manage/equipment_data.dart';
import '../../../../../../em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import '../../../../../../em_module/widgets/button_constant.dart';
import '../../../../../../em_module/widgets/text_form_field_const.dart';

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
  String inventoryName = '';
  int inventoryId = 0;
  bool _isFormValid = true;
  String? _idDocError;
  String? _nameDocError;
  String? _dateDocError;

  String? _validateTextField(String value, String fieldName) {
    if (value.isEmpty) {
      _isFormValid = false;
      return "Please Enter $fieldName";
    }
    return null;
  }

  void _validateForm() {
    setState(() {
      _isFormValid = true;
      _idDocError =
          _validateTextField(idController.text, 'ID of the Equipment');
      _nameDocError =
          _validateTextField(idController.text, 'Name of the Equipment');
      _dateDocError = _validateTextField(calenderController.text, 'Date');
    });
  }

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
      width: AppSize.s400,
      height: AppSize.s480,
      title: "Add New Equipment",
      onClear: (){
        Navigator.pop(context);
        inventoryId = 0;
        inventoryName = '';
        nameController.clear();
        idController.clear();
        calenderController.clear();
      },
      body: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SMTextFConst(
                controller: idController,
                keyboardType: TextInputType.number,
                text: 'Id',
              ),
              if (_idDocError != null)
                Text(
                  _idDocError!,
                  style: CommonErrorMsg.customTextStyle(context),
                ),
              SizedBox(
                height: AppSize.s16,
              ),
              SMTextFConst(
                controller: nameController,
                keyboardType: TextInputType.streetAddress,
                text: 'Name',
              ),
              if (_nameDocError != null) // Display error if any
                Text(
                  _nameDocError!,
                  style: CommonErrorMsg.customTextStyle(context),
                ),
              SizedBox(
                height: AppSize.s16,
              ),
              Text('Device Description',
                  style: AllPopupHeadings.customTextStyle(context)),
              SizedBox(height: 5),
              FutureBuilder<List<InventoryDropdownData>>(
                  future: getDropdownInventory(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        width: 350,
                        height: 30,
                        decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(10)),
                      );
                    }
                    if (snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          AppStringHRNoData.nodevicedesc,
                          style: AllNoDataAvailable.customTextStyle(context),
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      List dropDown = [];
                      int docType = 0;
                      List<DropdownMenuItem<String>> dropDownMenuItems = [];
                      for (var i in snapshot.data!) {
                        dropDownMenuItems.add(
                          DropdownMenuItem<String>(
                            child: Text(i.name),
                            value: i.name,
                          ),
                        );
                      }
                      inventoryName = snapshot.data![0].name;
                      inventoryId = snapshot.data![0].inventoryId;
                      print('Inventory name ${inventoryName}');
                      print('Inventory Id ${inventoryId}');
                      return CICCDropdown(
                          initialValue: dropDownMenuItems[0].value,
                          onChange: (val) {
                            for (var a in snapshot.data!) {
                              if (a.name == val) {
                                inventoryName = a.name;
                                inventoryId = a.inventoryId;
                                //docMetaId = docType;
                              }
                            }
                            print(":::${docType}");
                            //print(":::<>${docMetaId}");
                          },
                          items: dropDownMenuItems);
                    } else {
                      return SizedBox();
                    }
                  }),
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
              SizedBox(
                height: AppSize.s16,
              ),
              Text('Assign Date',
                  style: AllPopupHeadings.customTextStyle(context)),
              SizedBox(
                height: 5,
              ),
              FormField<String>(
                builder: (FormFieldState<String> field) {
                  return SizedBox(
                    width: 350,
                    height: AppSize.s30,
                    child: TextFormField(
                      style: DocumentTypeDataStyle.customTextStyle(context),
                      controller: calenderController,
                      decoration: InputDecoration(
                        focusColor: ColorManager.mediumgrey,
                        hoverColor: ColorManager.mediumgrey,
                        hintText: 'dd-mm-yyyy',
                        hintStyle:
                            DocumentTypeDataStyle.customTextStyle(context),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              width: 1, color: ColorManager.mediumgrey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              width: 1,
                              color: ColorManager
                                  .mediumgrey), // Set focused border color to red
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              width: 1,
                              color: ColorManager
                                  .mediumgrey), // Set enabled border color to red
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
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
              if (_dateDocError != null) // Display error if any
                Text(
                  _dateDocError!,
                  style: CommonErrorMsg.customTextStyle(context),
                ),
            ],
          ),
        ),
      ],
      bottomButtons: Center(
        child: isLoading
            ? SizedBox(
                height: AppSize.s25,
                width: AppSize.s25,
                child: CircularProgressIndicator(
                  color: ColorManager.blueprime,
                ))
            : CustomElevatedButton(
                width: AppSize.s150,
                height: AppSize.s30,
                text: 'Add',
                onPressed: () async {
                  _validateForm();
                  if (_isFormValid) {
                    setState(() {
                      isLoading = true;
                    });
                    await addEquipment(
                      context,
                      int.parse(idController.text),
                      calenderController.text,
                      widget.employeeId,
                      inventoryName,
                      inventoryId,
                      // typeName,
                      nameController.text,
                    );
                    print("::${idController.text}");
                    print("::${typeName}");
                    print("::${calenderController.text}");
                    print("::${nameController.text}");
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.pop(context);
                    inventoryId = 0;
                    inventoryName = '';
                    nameController.clear();
                    idController.clear();
                    calenderController.clear();
                  }
                }),
      ),
    );
  }
}
