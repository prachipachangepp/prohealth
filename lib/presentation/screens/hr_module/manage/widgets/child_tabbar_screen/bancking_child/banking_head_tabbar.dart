import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/employee_banking_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/employee_banking_data.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/icon_button_constant.dart';
import '../../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../app/resources/hr_resources/string_manager.dart';

class BankingHeadTabbar extends StatefulWidget {
  BankingHeadTabbar({super.key,});
  @override
  _BankingHeadTabbarState createState() => _BankingHeadTabbarState();
}

class _BankingHeadTabbarState extends State<BankingHeadTabbar> {
  bool checkBox1 = false;
  bool checkBox2 = false;
  bool checkBox3 = false;
  bool checkBox4 = false;
  final StreamController<List<EmployeeBankingData>> bankingStreamController = StreamController<List<EmployeeBankingData>>();
  @override
  void initState() {
    // TODO: implement initState
    getEmployeeBanking(context, 2).then((data) {
      bankingStreamController.add(data);
    }).catchError((error) {
      // Handle error
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<EmployeeBankingData>>(
      stream: bankingStreamController.stream,
      builder: (context,snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(color: ColorManager.blueprime,),);
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
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: SingleChildScrollView(
              child: Wrap(
                  alignment: WrapAlignment.start,
                  children: List.generate(snapshot.data!.length
                      , (index){
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
                      child: Container(
                        width: MediaQuery.of(context).size.width/2.3,
                        child: Row(
                          children: [
                            Checkbox(
                              activeColor: ColorManager.blueprime,
                              hoverColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              value: checkBox1,
                              onChanged: (value) {
                                setState(() {
                                  checkBox1 = value!;
                                });
                              },
                            ),
                            const SizedBox(width: 8),
                             BankingContainerConst(typeName: snapshot.data![index].type, acNumber: snapshot.data![index].accountNumber,
                               effectiveDate: snapshot.data![index].effectiveDate, requestPercentage: '30%', bankName: snapshot.data![index].bankName, routinNo: snapshot.data![index].routinNumber,),
                          ],
                        ),
                      ),
                    );
                  })
              
                // const SizedBox(height: 16),
                // Row(
                //   children: [
                //     Checkbox(
                //       activeColor: const Color(0xff50B5E5),
                //       hoverColor: Colors.transparent,
                //       focusColor: Colors.transparent,
                //       value: checkBox3,
                //       onChanged: (value) {
                //         setState(() {
                //           checkBox3 = value!;
                //         });
                //       },
                //     ),
                //     const SizedBox(width: 8),
                //     const BankingContainerConst(),
                //     const SizedBox(width: 16),
                //     Checkbox(
                //       activeColor: const Color(0xff50B5E5),
                //       hoverColor: Colors.transparent,
                //       focusColor: Colors.transparent,
                //       value: checkBox4,
                //       onChanged: (value) {
                //         setState(() {
                //           checkBox4 = value!;
                //         });
                //       },
                //     ),
                //     const SizedBox(width: 8),
                //     const BankingContainerConst(),
                //   ],
                // ),
              
              ),
            ),
          );
        }
        return SizedBox();
      }
    );
  }
}

///Container Constant
class BankingContainerConst extends StatelessWidget {
   String typeName;
   String acNumber;
   String effectiveDate;
   String requestPercentage;
   String bankName;
   String routinNo;

   BankingContainerConst({Key? key, required this.typeName, required this.acNumber, required this.effectiveDate, required this.requestPercentage, required this.bankName, required this.routinNo,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 187,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            const BoxShadow(
              color: Color(0x40000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(AppStringHr.bankone,
                  style: GoogleFonts.firaSans(
                    fontSize: 13,
                    color: Color(0xFF333333),
                    fontWeight: FontWeight.w500,
                  ),),
                Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x40000040),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  height: MediaQuery.of(context).size.height / 35,
                  width: MediaQuery.of(context).size.width / 20,
                  child: ElevatedButton(
                    onPressed:
                        () {},
                    child:  Text(
                      AppStringHr.edit,
                      style: GoogleFonts.firaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,),
                      backgroundColor: const Color(0xFF50B5E5),
                      shadowColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppStringHr.type,
                                style: ThemeManager.customTextStyle(context)),
                            Text(
                              typeName.toString(),
                              style: ThemeManagerDark.customTextStyle(context),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppStringHr.effectiveDate,
                                style: ThemeManager.customTextStyle(context)),
                            Text(
                              effectiveDate.toString(),
                              style: ThemeManagerDark.customTextStyle(context),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppStringHr.bankName,
                                style: ThemeManager.customTextStyle(context)),
                            Text(
                              bankName.toString(),
                              style: ThemeManagerDark.customTextStyle(context),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppStringHr.routingNo,
                                style: ThemeManager.customTextStyle(context)),
                            Text(
                              routinNo,
                              style: ThemeManagerDark.customTextStyle(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: mediaQuery.width/8,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppStringHr.accNo,
                              style: ThemeManager.customTextStyle(context)),
                          Text(
                            acNumber,
                            style: ThemeManagerDark.customTextStyle(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppStringHr.requestPercent,
                              style: ThemeManager.customTextStyle(context)),
                          Text(
                            '30%',
                            style: ThemeManagerDark.customTextStyle(context),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),
             Row(
               mainAxisAlignment: MainAxisAlignment.end,
              children: [
                   IconButtonWidget(iconData: Icons.remove_red_eye_outlined, buttonText: AppStringHr.voidcheck, onPressed:(){},),
                const SizedBox(width: 10,),
                IconButtonWidget(iconData1: Icons.print_outlined, buttonText: AppStringHr.print, onPressed:(){},),
                const SizedBox(width: 10,),
                IconButtonWidget(iconData1: Icons.file_download_outlined, buttonText: AppStringHr.download, onPressed:(){},)
              ],
            )
          ],
        ),
      ),
    );
  }
}
