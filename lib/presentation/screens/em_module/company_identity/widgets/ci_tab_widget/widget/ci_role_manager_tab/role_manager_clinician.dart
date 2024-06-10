import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_role_manager_tab/widgets/ci_role_container_constant.dart';
import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../../app/resources/font_manager.dart';
import '../../../../../widgets/button_constant.dart';


class RoleManagerClinician extends StatefulWidget {
  const RoleManagerClinician({super.key});

  @override
  State<RoleManagerClinician> createState() => _RoleManagerClinicianState();
}

class _RoleManagerClinicianState extends State<RoleManagerClinician> {
  List<bool> selectedContainers = List.generate(15, (_) => false);

  void toggleSelection(int index) {
    setState(() {
      selectedContainers[index] = !selectedContainers[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pick Office',
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s10,
                        fontWeight: FontWeightManager.bold,
                        color: ColorManager.mediumgrey,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(height: AppSize.s4),
                    Container(
                      height: 30,
                      width: 354,
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color(0xff686464).withOpacity(0.5),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonFormField<String>(
                        focusColor: Colors.transparent,
                        icon: Icon(
                          Icons.arrow_drop_down_sharp,
                          color: Color(0xff686464),
                        ),
                        decoration: InputDecoration.collapsed(hintText: ''),
                        items: <String>[
                          'Pick Office',
                          'RN',
                          'LVN',
                          'PT',
                          'PTA',
                          'OT',
                          'COTA',
                          'ST',
                          'MSW',
                          'HHA',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {},
                        value: 'Pick Office',
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff686464),
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pick Employee',
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s10,
                        fontWeight: FontWeightManager.bold,
                        color: ColorManager.fmediumgrey,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(height: AppSize.s4),
                    Container(
                      height: 30,
                      width: 354,
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color(0xff686464).withOpacity(0.5),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonFormField<String>(
                        focusColor: Colors.transparent,
                        icon: Icon(
                          Icons.arrow_drop_down_sharp,
                          color: Color(0xff686464),
                        ),
                        decoration: InputDecoration.collapsed(hintText: ''),
                        items: <String>[
                          'ST',
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
                        value: 'ST',
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: ColorManager.fmediumgrey,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            /// row 1
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    toggleSelection(0);
                  },
                  child: CIRoleContainerConstant(
                    'Referral Resource Manager',
                    AssetImage("images/r_r_m.png"),
                    borderColor: selectedContainers[0] ? ColorManager.blueprime : Colors.white,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 20),
                InkWell(
                  onTap: () {
                    toggleSelection(1);
                  },
                  child: CIRoleContainerConstant(
                    'Business Intelligence & Reports',
                    AssetImage("images/b_i_r.png"),
                    borderColor: selectedContainers[1] ? ColorManager.blueprime : Colors.transparent,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 20),
                InkWell(
                  onTap: () {
                    toggleSelection(2);
                  },
                  child: CIRoleContainerConstant(
                    'Intake & Scheduler',
                    AssetImage("images/i_s.png"),
                    borderColor: selectedContainers[2] ? ColorManager.blueprime : Colors.transparent,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 20),
                InkWell(
                  onTap: () {
                    toggleSelection(3);
                  },
                  child: CIRoleContainerConstant(
                    'Rehab',
                    AssetImage("images/rehab.png"),
                    borderColor: selectedContainers[3] ? ColorManager.blueprime : Colors.transparent,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            /// row 2
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    toggleSelection(4);
                  },
                  child: CIRoleContainerConstant(
                    'Home Care',
                    AssetImage("images/h_c.png"),
                    borderColor: selectedContainers[4] ? ColorManager.blueprime : Colors.transparent,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 20),
                InkWell(
                  onTap: () {
                    toggleSelection(5);
                  },
                  child: CIRoleContainerConstant(
                    'Establishment Manager',
                    AssetImage("images/e_m.png"),
                    borderColor: selectedContainers[5] ? ColorManager.blueprime : Colors.transparent,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 20),
                InkWell(
                  onTap: () {
                    toggleSelection(6);
                  },
                  child: CIRoleContainerConstant(
                    'Human Resource Manager',
                    AssetImage("images/h_r_m.png"),
                    borderColor: selectedContainers[6] ? ColorManager.blueprime : Colors.transparent,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 20),
                InkWell(
                  onTap: () {
                    toggleSelection(7);
                  },
                  child: CIRoleContainerConstant(
                    'Home Health EMR',
                    AssetImage("images/h_h_emr.png"),
                    borderColor: selectedContainers[7] ? ColorManager.blueprime : Colors.transparent,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            /// row 3
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    toggleSelection(8);
                  },
                  child: CIRoleContainerConstant(
                    'Hospice EMR',
                    AssetImage("images/h_emr.png"),
                    borderColor: selectedContainers[8] ? ColorManager.blueprime : Colors.transparent,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 20),
                InkWell(
                  onTap: () {
                    toggleSelection(9);
                  },
                  child: CIRoleContainerConstant(
                    'Finance',
                    AssetImage("images/finance.png"),
                    borderColor: selectedContainers[9] ? ColorManager.blueprime : Colors.transparent,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 20),
                InkWell(
                  onTap: () {
                    toggleSelection(10);
                  },
                  child: CIRoleContainerConstant(
                    'Other',
                    AssetImage("images/other.png"),
                    borderColor: selectedContainers[10] ? ColorManager.blueprime : Colors.transparent,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 5),
              ],
            ),
            SizedBox(height: 40),
            /// button
            Center(
              child: CustomElevatedButton(
                width: AppSize.s105,
                height: AppSize.s30,
                text: AppStringEM.save,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
