import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/ci_role_manager_tab/widgets/ci_role_container_constant.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../../app/services/api/managers/establishment_manager/all_from_hr_manager.dart';
import '../../../../../../../../app/services/api/managers/establishment_manager/pay_rates_manager.dart';
import '../../../../../../../../data/api_data/establishment_data/all_from_hr/all_from_hr_data.dart';
import '../../../../../../../../data/api_data/establishment_data/pay_rates/pay_rates_finance_data.dart';
import '../../../../../widgets/button_constant.dart';

class RoleManagerSales extends StatefulWidget {
  const RoleManagerSales({super.key});

  @override
  State<RoleManagerSales> createState() => _RoleManagerSalesState();
}

class _RoleManagerSalesState extends State<RoleManagerSales> {
  List<bool> selectedContainers = List.generate(15, (_) => false);
  final StreamController<List<PayRateFinanceData>> _roleMDropDownController = StreamController<List<PayRateFinanceData>>();

  void toggleSelection(int index) {
    setState(() {
      selectedContainers[index] = !selectedContainers[index];
    });
  }

  @override
  void initState() {
    super.initState();
    payRatesDataGet(context,1,10).then((data) {
      _roleMDropDownController.add(data);
    }).catchError((error) {
      // Handle error
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
    child: SingleChildScrollView(
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: AppPadding.p220),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pick Employee',
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s10,
                        fontWeight: FontWeightManager.bold,
                        color: ColorManager.fmediumgrey,
                        decoration: TextDecoration.none,
                      ),),
                    SizedBox(height: AppSize.s4,),
                    FutureBuilder<List<HRClinical>>(
                        future: companyAllHrClinicApi(context),
                        builder: (context, snapshot) {
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
                          if(snapshot.hasData) {
                            List<String> dropDownList = [];
                            List<String> dropDownAbbreviation = [];
                            for (var i in snapshot.data!) {
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
                                    // items: <String>[
                                    //   'Pick Office',
                                    //   'RN',
                                    //   'LVN',
                                    //   'PT',
                                    //   'PTA',
                                    //   'OT',
                                    //   'COTA',
                                    //   'ST',
                                    //   'MSW',
                                    //   'HHA',
                                    // ].map<DropdownMenuItem<String>>((String value) {
                                    //   return DropdownMenuItem<String>(
                                    //     value: value,
                                    //     child: Text(value),
                                    //   );
                                    // }).toList(),
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
                                    value:  dropDownList[0],
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
                          }else{return Offstage();

                          }
                        }
                    ),
                  ],
                ),
            ],),
          ),
          SizedBox(height: 20,),
          ///row 1
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
          SizedBox(height: 40,),
          ///button
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
