import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/employee_banking_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/employee_banking_data.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/bancking_child/widget/edit_banking_popup.dart';
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
  String? selectedType;
  TextEditingController effectiveDateController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController  accountNumberController = TextEditingController();
  TextEditingController verifyAccountController = TextEditingController();
  TextEditingController routingNumberController = TextEditingController();
  TextEditingController specificAmountController = TextEditingController();
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
                             BankingContainerConst(
                               bankId: snapshot.data![index].empBankingId,
                               typeName: snapshot.data![index].type, acNumber: snapshot.data![index].accountNumber,
                               effectiveDate: snapshot.data![index].effectiveDate,
                               requestPercentage: '30%', bankName: snapshot.data![index].bankName,
                               routinNo: snapshot.data![index].routinNumber,
                               selectedType: selectedType,
                               effectiveDateController: effectiveDateController,
                               bankNameController: bankNameController, accountNumberController: accountNumberController, verifyAccountController: verifyAccountController,
                               routingNumberController: routingNumberController, specificAmountController: specificAmountController, onPressed: () {
                               showDialog(context: context, builder: (_) => FutureBuilder<EmployeeBankingPrefillData>(
                                 future: getPrefillEmployeeBancking(context,snapshot.data![index].empBankingId),
                                 builder: (context,snapshotPrefill) {
                                   if(snapshotPrefill.connectionState == ConnectionState.waiting){
                                     return Center(child:CircularProgressIndicator(color: ColorManager.blueprime,));
                                   }
                                   if(snapshot.connectionState == ConnectionState.waiting){
                                     return Center(child: CircularProgressIndicator(color: ColorManager.blueprime,),);
                                   }
                                   var bankName = snapshotPrefill.data!.bankName;
                                   bankNameController = TextEditingController(text:snapshotPrefill.data!.bankName);

                                   var effectiveDate = snapshotPrefill.data!.effectiveDate;
                                   effectiveDateController = TextEditingController(text:snapshotPrefill.data!.effectiveDate);

                                   var accountNumber = snapshotPrefill.data!.accountNumber;
                                   accountNumberController = TextEditingController(text:snapshotPrefill.data!.accountNumber);

                                   //var verifyAcNumber = snapshotPrefill.data.
                                   var routingNumber = snapshotPrefill.data!.routinNumber;
                                   routingNumberController = TextEditingController(text:snapshotPrefill.data!.routinNumber);

                                   var amount = snapshotPrefill.data!.amountRequested;
                                   specificAmountController = TextEditingController(text: snapshotPrefill.data!.amountRequested.toString());
                                   return EditBankingPopUp(effectiveDateController: effectiveDateController,
                                     bankNameController: bankNameController, accountNumberController: accountNumberController, verifyAccountController: verifyAccountController,
                                     routingNumberController: routingNumberController, specificAmountController: specificAmountController, onPressed: () async{
                                     await PatchEmployeeBanking(context, snapshot.data![index].empBankingId, snapshotPrefill.data!.employeeId,
                                         accountNumber == accountNumberController.text ? accountNumber.toString() : accountNumberController.text,
                                         bankName == bankNameController.text ? bankName.toString() : bankNameController.text,
                                         amount == int.parse(specificAmountController.text) ? amount : int.parse(specificAmountController.text),
                                         snapshotPrefill.data!.checkUrl,
                                         effectiveDate == effectiveDateController.text ? effectiveDate.toString() : effectiveDateController.text,
                                         routingNumber == routingNumberController.text ? routingNumber.toString() : routingNumberController.text,
                                         snapshotPrefill.data!.type);
                                     },);
                                 }
                               ));
                               },),
                          ],
                        ),
                      ),
                    );
                  })
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
  int bankId;
   String typeName;
   String acNumber;
   String effectiveDate;
   String requestPercentage;
   String bankName;
   String routinNo;
   String? selectedType;
   final VoidCallback onPressed;
   final TextEditingController effectiveDateController;
   final TextEditingController bankNameController;
   final TextEditingController accountNumberController;
   final TextEditingController verifyAccountController;
   final TextEditingController routingNumberController;
   final TextEditingController specificAmountController;

   BankingContainerConst({Key? key,required this.bankId, this.selectedType,required this.typeName, required this.acNumber, required this.effectiveDate, required this.requestPercentage, required this.bankName, required this.routinNo,
     required this.effectiveDateController, required this.bankNameController, required this.accountNumberController, required this.verifyAccountController, required this.routingNumberController, required this.specificAmountController, required this.onPressed,}) : super(key: key);

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
                 Text("Bank #${bankId.toString()}",
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
                    onPressed:onPressed,
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
                  Spacer(),
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
