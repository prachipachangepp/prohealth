import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/employee_banking_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/employee_banking_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/bancking_child/widget/edit_banking_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';

import '../../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../app/resources/hr_resources/string_manager.dart';
import '../../../const_wrap_widget.dart';

class BankingHeadTabbar extends StatefulWidget {
  final int employeeID;
  BankingHeadTabbar({
    super.key,
    required this.employeeID,
  });
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
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController verifyAccountController = TextEditingController();
  TextEditingController routingNumberController = TextEditingController();
  TextEditingController specificAmountController = TextEditingController();
  final StreamController<List<EmployeeBankingData>> bankingStreamController =
      StreamController<List<EmployeeBankingData>>();

  String expiryType = 'No';
  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: CustomIconButtonConst(
                    width: 130,
                    text: AppStringHr.addNew,
                    icon: Icons.add,
                    onPressed: () {
                      effectiveDateController.clear();
                      bankNameController.clear();
                      accountNumberController.clear();
                      verifyAccountController.clear();
                      routingNumberController.clear();
                      specificAmountController.clear();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AddBankingPopup(
                                employeeID: widget.employeeID,
                                banckId: 0,
                              ));

                      //   EditBankingPopUp(
                      //     title: "Add Banking",
                      //     banckId: 0,
                      //     effectiveDateController:
                      //         effectiveDateController,
                      //     bankNameController: bankNameController,
                      //     accountNumberController:
                      //         accountNumberController,
                      //     verifyAccountController:
                      //         verifyAccountController,
                      //     routingNumberController:
                      //         routingNumberController,
                      //     specificAmountController:
                      //         specificAmountController,
                      //
                      //     onPressed: () async {
                      //       var response = await addNewEmployeeBanking(
                      //           context: context,
                      //           employeeId: widget.employeeID,
                      //           accountNumber:
                      //               accountNumberController.text,
                      //           bankName: bankNameController.text,
                      //           amountRequested: int.parse(
                      //               specificAmountController.text),
                      //           checkUrl: "",
                      //           effectiveDate:
                      //               effectiveDateController.text,
                      //           routingNumber:
                      //               routingNumberController.text,
                      //           percentage: 'Na',
                      //           //type: "Checking",
                      //           type: expiryType.toString(),
                      //           //type:selectedType.toString(),
                      //       );

                      //   Navigator.pop(context);
                      //   if(response.statusCode == 200 || response.statusCode == 201){
                      //     showDialog(
                      //       context: context,
                      //       builder: (BuildContext context) {
                      //         return AddSuccessPopup(
                      //           message: 'Banking Added Successfully',
                      //         );
                      //       },
                      //     );
                      //   }
                      // },
                      //
                      // radioButton: StatefulBuilder(
                      //   builder: (BuildContext context, void Function(void Function()) setState) {
                      //     return Container(
                      //       width: 280,
                      //       child: Row(
                      //         children: [
                      //           Expanded(
                      //             child: CustomRadioListTile(
                      //               value: "Yes",
                      //               groupValue:
                      //               expiryType.toString(),
                      //               onChanged: (value) {
                      //                 setState(() {
                      //                   expiryType = value!;
                      //                 });
                      //               },
                      //               title: "Yes",
                      //             ),
                      //           ),
                      //           Expanded(
                      //             child: CustomRadioListTile(
                      //               value: "No",
                      //               groupValue:
                      //               expiryType.toString(),
                      //               onChanged: (value) {
                      //                 setState(() {
                      //                   expiryType = value!;
                      //                 });
                      //               },
                      //               title: "No",
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     );
                      //   },
                      // ),
                      //   ));
                    }),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          StreamBuilder<List<EmployeeBankingData>>(
              stream: bankingStreamController.stream,
              builder: (context, snapshot) {
                getEmployeeBanking(context, widget.employeeID).then((data) {
                  bankingStreamController.add(data);
                }).catchError((error) {
                  // Handle error
                });
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 100),
                      child: CircularProgressIndicator(
                        color: ColorManager.blueprime,
                      ),
                    ),
                  );
                }
                if (snapshot.data!.isEmpty) {
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100),
                    child: Text(
                      AppStringHRNoData.bankingNoData,
                      style: AllNoDataAvailable.customTextStyle(context),
                    ),
                  ));
                }
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: SingleChildScrollView(
                      child: WrapWidget(
                          children:
                              List.generate(snapshot.data!.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 15),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: Row(
                              children: [
                                snapshot.data![index].approve == true
                                    ? Checkbox(
                                        activeColor: ColorManager.blueprime,
                                        hoverColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        value: snapshot.data![index].approve,
                                        onChanged: (value) {
                                          setState(() {
                                            // snapshot.data![index].approve == true ?
                                            //  rejectBankPatch(context, snapshot.data![index].empBankingId):
                                            // approveBankPatch(context,snapshot.data![index].empBankingId);
                                          });
                                        },
                                      )
                                    : Offstage(),
                                const SizedBox(width: 8),
                                BankingContainerConst(
                                  index: index,
                                  bankId: snapshot.data![index].empBankingId,
                                  typeName: snapshot.data![index].type,
                                  acNumber: snapshot.data![index].accountNumber,
                                  effectiveDate:
                                      snapshot.data![index].effectiveDate,
                                  requestPercentage:
                                      snapshot.data![index].percentage,
                                  bankName: snapshot.data![index].bankName,
                                  routinNo: snapshot.data![index].routinNumber,
                                  selectedType: selectedType,
                                  effectiveDateController:
                                      effectiveDateController,
                                  bankNameController: bankNameController,
                                  accountNumberController:
                                      accountNumberController,
                                  verifyAccountController:
                                      verifyAccountController,
                                  routingNumberController:
                                      routingNumberController,
                                  specificAmountController:
                                      specificAmountController,
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) =>
                                            FutureBuilder<
                                                    EmployeeBankingPrefillData>(
                                                future:
                                                    getPrefillEmployeeBancking(
                                                        context,
                                                        snapshot.data![index]
                                                            .empBankingId),
                                                builder:
                                                    (context, snapshotPrefill) {
                                                  if (snapshotPrefill
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: ColorManager
                                                            .blueprime,
                                                      ),
                                                    );
                                                  }
                                                  var bankName = snapshotPrefill
                                                      .data!.bankName;
                                                  bankNameController =
                                                      TextEditingController(
                                                          text: snapshotPrefill
                                                              .data!.bankName);

                                                  var effectiveDate =
                                                      snapshotPrefill
                                                          .data!.effectiveDate;
                                                  effectiveDateController =
                                                      TextEditingController(
                                                          text: snapshotPrefill
                                                              .data!
                                                              .effectiveDate);

                                                  var accountNumber =
                                                      snapshotPrefill
                                                          .data!.accountNumber;
                                                  accountNumberController =
                                                      TextEditingController(
                                                          text: snapshotPrefill
                                                              .data!
                                                              .accountNumber);

                                                  //var verifyAcNumber = snapshotPrefill.data.
                                                  var routingNumber =
                                                      snapshotPrefill
                                                          .data!.routinNumber;
                                                  routingNumberController =
                                                      TextEditingController(
                                                          text: snapshotPrefill
                                                              .data!
                                                              .routinNumber);

                                                  var amount = snapshotPrefill
                                                      .data!.amountRequested;
                                                  selectedType = snapshotPrefill
                                                      .data!.type;
                                                  specificAmountController =
                                                      TextEditingController(
                                                          text: snapshotPrefill
                                                              .data!
                                                              .amountRequested
                                                              .toString());
                                                  verifyAccountController =
                                                      TextEditingController(
                                                          text: snapshotPrefill
                                                              .data!
                                                              .accountNumber);

                                                  return EditBankingPopUp(
                                                    title: 'Edit Banking',
                                                    banckId: index,
                                                    effectiveDateController:
                                                        effectiveDateController,
                                                    bankNameController:
                                                        bankNameController,
                                                    accountNumberController:
                                                        accountNumberController,
                                                    verifyAccountController:
                                                        verifyAccountController,
                                                    routingNumberController:
                                                        routingNumberController,
                                                    specificAmountController:
                                                        specificAmountController,
                                                    selectedType: selectedType,
                                                    onPressed:
                                                        (gropvalue) async {
                                                      var response =
                                                          await PatchEmployeeBanking(
                                                              context,
                                                              snapshot
                                                                  .data![index]
                                                                  .empBankingId,
                                                              snapshotPrefill
                                                                  .data!
                                                                  .employeeId,
                                                              accountNumber ==
                                                                      accountNumberController
                                                                          .text
                                                                  ? accountNumber
                                                                      .toString()
                                                                  : accountNumberController
                                                                      .text,
                                                              bankName ==
                                                                      bankNameController
                                                                          .text
                                                                  ? bankName
                                                                      .toString()
                                                                  : bankNameController
                                                                      .text,
                                                              amount == int.parse(specificAmountController.text)
                                                                  ? amount
                                                                  : int.parse(
                                                                      specificAmountController
                                                                          .text),
                                                              snapshotPrefill
                                                                  .data!
                                                                  .checkUrl,
                                                              effectiveDate ==
                                                                      effectiveDateController
                                                                          .text
                                                                  ? effectiveDate
                                                                      .toString()
                                                                  : effectiveDateController
                                                                      .text,
                                                              routingNumber ==
                                                                      routingNumberController
                                                                          .text
                                                                  ? routingNumber
                                                                      .toString()
                                                                  : routingNumberController
                                                                      .text,
                                                              snapshotPrefill
                                                                  .data!
                                                                  .percentage,
                                                              // snapshotPrefill.data!.type.toString()
                                                              selectedType =
                                                                  gropvalue

                                                              //"Checking",
                                                              );
                                                      print("::::;${bankName}");
                                                      print(
                                                          "::::;${effectiveDate}");
                                                      print(
                                                          "::::;${routingNumber}");
                                                      print(
                                                          "::::;${accountNumber}");

                                                      Navigator.pop(context);
                                                      if (response.statusCode ==
                                                              200 ||
                                                          response.statusCode ==
                                                              201) {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AddSuccessPopup(
                                                              message:
                                                                  'Banking Edit Successfully',
                                                            );
                                                          },
                                                        );
                                                      } else {
                                                        print("Error");
                                                      }
                                                    },
                                                  );
                                                }));
                                  },
                                  onPressedPrint: () async {
                                    try {
                                      final pdf = pw.Document();
                                      final bankingData = snapshot.data![index];

                                      pdf.addPage(
                                        pw.Page(
                                          build: (pw.Context context) =>
                                              pw.Padding(
                                            padding: pw.EdgeInsets.all(20),
                                            child: pw.Column(
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.start,
                                              children: [
                                                pw.Text(
                                                  'Banking Details',
                                                  style: pw.TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          pw.FontWeight.bold),
                                                ),
                                                pw.Divider(),
                                                pw.SizedBox(height: 10),
                                                pw.Text(
                                                  'Bank #${index + 1}',
                                                  // 'Bank #${bankingData.empBankingId.toString()}',
                                                  style: pw.TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          pw.FontWeight.bold),
                                                ),
                                                pw.SizedBox(height: 20),
                                                pw.Table(
                                                  border: pw.TableBorder.all(),
                                                  children: [
                                                    pw.TableRow(
                                                      children: [
                                                        pw.Padding(
                                                          padding:
                                                              pw.EdgeInsets.all(
                                                                  8),
                                                          child: pw.Text('Type',
                                                              style: pw.TextStyle(
                                                                  fontWeight: pw
                                                                      .FontWeight
                                                                      .bold)),
                                                        ),
                                                        pw.Padding(
                                                          padding:
                                                              pw.EdgeInsets.all(
                                                                  8),
                                                          child: pw.Text(
                                                              bankingData.type),
                                                        ),
                                                      ],
                                                    ),
                                                    pw.TableRow(
                                                      children: [
                                                        pw.Padding(
                                                          padding:
                                                              pw.EdgeInsets.all(
                                                                  8),
                                                          child: pw.Text(
                                                              'Effective Date',
                                                              style: pw.TextStyle(
                                                                  fontWeight: pw
                                                                      .FontWeight
                                                                      .bold)),
                                                        ),
                                                        pw.Padding(
                                                          padding:
                                                              pw.EdgeInsets.all(
                                                                  8),
                                                          child: pw.Text(
                                                              bankingData
                                                                  .effectiveDate),
                                                        ),
                                                      ],
                                                    ),
                                                    pw.TableRow(
                                                      children: [
                                                        pw.Padding(
                                                          padding:
                                                              pw.EdgeInsets.all(
                                                                  8),
                                                          child: pw.Text(
                                                              'Bank Name',
                                                              style: pw.TextStyle(
                                                                  fontWeight: pw
                                                                      .FontWeight
                                                                      .bold)),
                                                        ),
                                                        pw.Padding(
                                                          padding:
                                                              pw.EdgeInsets.all(
                                                                  8),
                                                          child: pw.Text(
                                                              bankingData
                                                                  .bankName),
                                                        ),
                                                      ],
                                                    ),
                                                    pw.TableRow(
                                                      children: [
                                                        pw.Padding(
                                                          padding:
                                                              pw.EdgeInsets.all(
                                                                  8),
                                                          child: pw.Text(
                                                              'Routing/Transit No.',
                                                              style: pw.TextStyle(
                                                                  fontWeight: pw
                                                                      .FontWeight
                                                                      .bold)),
                                                        ),
                                                        pw.Padding(
                                                          padding:
                                                              pw.EdgeInsets.all(
                                                                  8),
                                                          child: pw.Text(
                                                              bankingData
                                                                  .routinNumber),
                                                        ),
                                                      ],
                                                    ),
                                                    pw.TableRow(
                                                      children: [
                                                        pw.Padding(
                                                          padding:
                                                              pw.EdgeInsets.all(
                                                                  8),
                                                          child: pw.Text(
                                                              'Account No.',
                                                              style: pw.TextStyle(
                                                                  fontWeight: pw
                                                                      .FontWeight
                                                                      .bold)),
                                                        ),
                                                        pw.Padding(
                                                          padding:
                                                              pw.EdgeInsets.all(
                                                                  8),
                                                          child: pw.Text(
                                                              bankingData
                                                                  .accountNumber),
                                                        ),
                                                      ],
                                                    ),
                                                    pw.TableRow(
                                                      children: [
                                                        pw.Padding(
                                                          padding:
                                                              pw.EdgeInsets.all(
                                                                  8),
                                                          child: pw.Text(
                                                              'Requested Amount',
                                                              style: pw.TextStyle(
                                                                  fontWeight: pw
                                                                      .FontWeight
                                                                      .bold)),
                                                        ),
                                                        pw.Padding(
                                                          padding:
                                                              pw.EdgeInsets.all(
                                                                  8),
                                                          child: pw.Text(
                                                              bankingData
                                                                  .amountRequested
                                                                  .toString()),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );

                                      await Printing.layoutPdf(
                                        onLayout:
                                            (PdfPageFormat format) async =>
                                                pdf.save(),
                                      );
                                    } catch (e) {
                                      print('Error generating PDF: $e');
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      })),
                    ),
                  );
                }
                return const SizedBox();
              }),
        ],
      ),
    );
  }
}

///Container Constant
class BankingContainerConst extends StatelessWidget {
  int index;
  int bankId;
  String typeName;
  String acNumber;
  String effectiveDate;
  String requestPercentage;
  String bankName;
  String routinNo;
  String? selectedType;
  final VoidCallback onPressed;
  final VoidCallback onPressedPrint;
  final TextEditingController effectiveDateController;
  final TextEditingController bankNameController;
  final TextEditingController accountNumberController;
  final TextEditingController verifyAccountController;
  final TextEditingController routingNumberController;
  final TextEditingController specificAmountController;

  BankingContainerConst({
    Key? key,
    required this.index,
    required this.bankId,
    this.selectedType,
    required this.typeName,
    required this.acNumber,
    required this.effectiveDate,
    required this.requestPercentage,
    required this.bankName,
    required this.routinNo,
    required this.effectiveDateController,
    required this.bankNameController,
    required this.accountNumberController,
    required this.verifyAccountController,
    required this.routingNumberController,
    required this.specificAmountController,
    required this.onPressed,
    required this.onPressedPrint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    const SizedBox(
      height: 30,
    );
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        // height: MediaQuery.of(context).size.height / 3.4,
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ///heading
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Bank #${index + 1}',
                    // "Bank #${bankId.toString()}",
                    style: BoxHeadingStyle.customTextStyle(context)),

                ///Edit
                Container(
                  // color: Colors.cyan,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x40000040),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  height: MediaQuery.of(context).size.height / 33,
                  width: MediaQuery.of(context).size.width / 17,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    child: Text(AppStringHr.edit,
                        style: CustomTextStylesCommon.commonStyle(
                          fontSize: FontSize.s12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        )),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
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
            // SizedBox(height: 5,),

            ///aligment
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStringHr.type,
                        textAlign: TextAlign.start,
                        style: ThemeManagerDark.customTextStyle(context)),
                    SizedBox(
                      height: 8,
                    ),
                    Text(AppStringHr.effectiveDate,
                        textAlign: TextAlign.start,
                        style: ThemeManagerDark.customTextStyle(context)),
                    SizedBox(
                      height: 8,
                    ),
                    Text(AppStringHr.bankName,
                        textAlign: TextAlign.start,
                        style: ThemeManagerDark.customTextStyle(context)),
                    SizedBox(
                      height: 8,
                    ),
                    Text(AppStringHr.routingNo,
                        textAlign: TextAlign.start,
                        style: ThemeManagerDark.customTextStyle(context)),
                    SizedBox(
                      height: 8,
                    ),
                    Text(AppStringHr.accNo,
                        textAlign: TextAlign.start,
                        style: ThemeManagerDark.customTextStyle(context)),
                    SizedBox(
                      height: 8,
                    ),
                    Text(AppStringHr.requestPercent,
                        textAlign: TextAlign.start,
                        style: ThemeManagerDark.customTextStyle(context)),
                  ],
                ),
                SizedBox(
                  width: 50,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      typeName.toString(),
                      textAlign: TextAlign.start,
                      style: ThemeManagerDarkFont.customTextStyle(context),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      effectiveDate.toString(),
                      textAlign: TextAlign.start,
                      style: ThemeManagerDarkFont.customTextStyle(context),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      bankName.toString(),
                      textAlign: TextAlign.start,
                      style: ThemeManagerDarkFont.customTextStyle(context),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      routinNo.toString(),
                      textAlign: TextAlign.start,
                      style: ThemeManagerDarkFont.customTextStyle(context),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      acNumber,
                      textAlign: TextAlign.start,
                      style: ThemeManagerDarkFont.customTextStyle(context),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      requestPercentage,
                      textAlign: TextAlign.start,
                      style: ThemeManagerDarkFont.customTextStyle(context),
                    ),
                  ],
                ),
              ],
            ),
            ///void check button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width / 180),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xff1696C8)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButtonWidget(
                    width: 110,
                    iconData1: Icons.remove_red_eye_outlined,
                    buttonText: AppStringHr.voidcheck,
                    onPressed: onPressedPrint,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
