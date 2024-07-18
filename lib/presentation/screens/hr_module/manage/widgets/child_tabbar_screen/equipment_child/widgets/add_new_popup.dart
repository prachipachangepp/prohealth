import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';

class AddNewEquipmentPopup extends StatefulWidget {
  final TextEditingController idController;
  final TextEditingController nameController;

  const AddNewEquipmentPopup({super.key, required this.idController, required this.nameController,});

  @override
  State<AddNewEquipmentPopup> createState() => _AddNewEquipmentPopupState();
}

class _AddNewEquipmentPopupState extends State<AddNewEquipmentPopup> {
  String? _expiryType;
  TextEditingController calenderController = TextEditingController();
  final DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s400,
        height: AppSize.s350,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              height: 34,
              decoration: BoxDecoration(
                color: Color(0xff50B5E5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Padding(
                padding:  EdgeInsets.only(left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Add Equipment",style:GoogleFonts.firaSans(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      //decoration: TextDecoration.none,
                    ),),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close,color: Colors.white,),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SMTextFConst(
                    controller: widget.idController,
                    keyboardType: TextInputType.text,
                    text: 'ID',
                  ),
                  SizedBox(height: AppSize.s8),
                  SMTextFConst(
                    controller: widget.nameController,
                    keyboardType: TextInputType.text,
                    text: 'Name',
                  ),
                  SizedBox(height: AppSize.s8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Type',
                        style: GoogleFonts.firaSans(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.mediumgrey,
                          //decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(height: 5),
              CICCDropdown(
                initialValue: 'Cellular',
                items: [
                  DropdownMenuItem(
                      value: 'Type 1',
                      child: Text('Type 1')),
                  DropdownMenuItem(
                      value: 'Type 2',
                      child: Text('Type 2')),
                  DropdownMenuItem(
                      value: 'Type 3',
                      child: Text('Type 3')),
                  DropdownMenuItem(
                      value: 'Type 4',
                      child: Text('Type 4')),
                ],
              ),
                    ],
                  ),
                  SizedBox(height: AppSize.s12),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Assign Date',
                    style: GoogleFonts.firaSans(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.mediumgrey,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  FormField<String>(
                    builder: (FormFieldState<String> field) {
                      return SizedBox(
                        width: 354,
                        height: 30,
                        child: TextFormField(
                          controller: calenderController,
                          style: GoogleFonts.firaSans(
                            fontSize: FontSize.s12,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.mediumgrey,
                            //decoration: TextDecoration.none,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Select',
                            hintStyle: GoogleFonts.firaSans(
                              fontSize: FontSize.s12,
                              fontWeight: FontWeight.w700,
                              color: ColorManager.mediumgrey,
                              //decoration: TextDecoration.none,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(width: 1),
                            ),
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 16),
                            suffixIcon: Icon(
                              Icons.calendar_month_outlined,
                              color: ColorManager.blueprime,
                            ),
                            errorText: field.errorText,
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: _selectedDate,
                              firstDate: DateTime(1100),
                              lastDate: DateTime.now(),
                            );
                            if (date != null) {
                              calenderController.text =DateFormat('dd/mm/yyyy').format(_selectedDate);
                              field.didChange(
                                  date.toLocal().toString().split(' ')[0]);
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
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p24),
              child: Center(
                child: CustomElevatedButton(
                  width: AppSize.s105,
                  height: AppSize.s30,
                  text: AppStringEM.submit,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
