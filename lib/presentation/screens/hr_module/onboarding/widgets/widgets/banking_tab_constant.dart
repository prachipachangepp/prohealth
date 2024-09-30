import 'dart:async';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/onboarding_manager/onboarding_banking_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/onboarding_data/onboarding_banking_data.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/const_card_details.dart';
import '../../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../manage/const_wrap_widget.dart';

class BankingTabContainerConstant extends StatefulWidget {
  final int employeeId;
  BankingTabContainerConstant({required this.employeeId});
  @override
  State<BankingTabContainerConstant> createState() =>
      _BankingTabContainerConstantState();
}

class _BankingTabContainerConstantState
    extends State<BankingTabContainerConstant> {
  final StreamController<List<OnboardingBankingData>> bankingStreamController = StreamController<List<OnboardingBankingData>>();

  @override
  void initState() {
    super.initState();
    getOnboardingBanking(context, widget.employeeId,'no').then((data){
      bankingStreamController.add(data);
    }).catchError((error){});
  }


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return StreamBuilder<List<OnboardingBankingData>>(
        stream: bankingStreamController.stream,
        builder: (context,snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 150),
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
                  AppStringHRNoData.noOnboardBanking,
                style: AllNoDataAvailable.customTextStyle(context)
              ),
            ));
      }
      if(snapshot.hasData){
        return WrapWidget(childern: List.generate(snapshot.data!.length, (index){
          return CardDetails(childWidget: DetailsFormate(
            row1Child1: [
              Text('Type :',
                  style: ThemeManagerDark.customTextStyle(context)),
              const SizedBox(
                height: 10,
              ),
              Text('Effective Date :',
                  style: ThemeManagerDark.customTextStyle(context)),
              const SizedBox(
                height: 10,
              ),
              Text('Bank Name :',
                  style: ThemeManagerDark.customTextStyle(context)),
              const SizedBox(
                height: 10,
              ),
              Text('Routing/Transit No. :',
                  style: ThemeManagerDark.customTextStyle(context)),
              // const SizedBox(
              //   height: 10,
              // ),
              // Text('Emergency Contact :',
              //     style: ThemeManagerDark.customTextStyle(context)),
            ],
            row1Child2: [

              Text(
                snapshot.data![index].type,
                style: ThemeManagerDarkFont.customTextStyle(context),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                snapshot.data![index].effectiveDate,
                style: ThemeManagerDarkFont.customTextStyle(context),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                snapshot.data![index].bankName,
                style: ThemeManagerDarkFont.customTextStyle(context),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                snapshot.data![index].rountingNumber,
                style: ThemeManagerDarkFont.customTextStyle(context),
              ),
            ],
            row2Child1: [
              Text('Account No. :',
                  style: ThemeManagerDark.customTextStyle(context)),
              const SizedBox(
                height: 10,
              ),
              Text('Requested amount :',
                  style: ThemeManagerDark.customTextStyle(context)),
              const SizedBox(
                height: 10,
              ),
              Text('',
                  style: ThemeManagerDark.customTextStyle(context)),
              const SizedBox(
                height: 10,
              ),
              Text('',
                  style: ThemeManagerDark.customTextStyle(context)),
            ],
            row2Child2: [
              Text(
                snapshot.data![index].accNum,
                style: ThemeManagerDarkFont.customTextStyle(context),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                snapshot.data![index].amtRequested.toString(),
                style: ThemeManagerDarkFont.customTextStyle(context),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '',
                style: ThemeManagerDarkFont.customTextStyle(context),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '',
                style: ThemeManagerDarkFont.customTextStyle(context),
              ),
            ],
            button:  Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomElevatedButton(
                  icon: Icons.remove_red_eye,
                  label: 'Void Check',
                  onPressed: () async {
                    try {
                      final pdf = pw.Document();
                      final bankingData = snapshot.data![index];
                      pdf.addPage(
                        pw.Page(
                          build: (pw.Context context) => pw.Padding(
                            padding: pw.EdgeInsets.all(20),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  'Banking Details',
                                  style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
                                ),
                                pw.Divider(),
                                pw.SizedBox(height: 10),
                                pw.Text(
                                  'Bank #${bankingData.empBankId.toString()}',
                                  style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
                                ),
                                pw.SizedBox(height: 20),
                                pw.Table(
                                  border: pw.TableBorder.all(),
                                  children: [
                                    pw.TableRow(
                                      children: [
                                        pw.Padding(
                                          padding: pw.EdgeInsets.all(8),
                                          child: pw.Text('Type', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                                        ),
                                        pw.Padding(
                                          padding: pw.EdgeInsets.all(8),
                                          child: pw.Text(bankingData.type),
                                        ),
                                      ],
                                    ),
                                    pw.TableRow(
                                      children: [
                                        pw.Padding(
                                          padding: pw.EdgeInsets.all(8),
                                          child: pw.Text('Effective Date', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                                        ),
                                        pw.Padding(
                                          padding: pw.EdgeInsets.all(8),
                                          child: pw.Text(bankingData.effectiveDate),
                                        ),
                                      ],
                                    ),
                                    pw.TableRow(
                                      children: [
                                        pw.Padding(
                                          padding: pw.EdgeInsets.all(8),
                                          child: pw.Text('Bank Name', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                                        ),
                                        pw.Padding(
                                          padding: pw.EdgeInsets.all(8),
                                          child: pw.Text(bankingData.bankName),
                                        ),
                                      ],
                                    ),
                                    pw.TableRow(
                                      children: [
                                        pw.Padding(
                                          padding: pw.EdgeInsets.all(8),
                                          child: pw.Text('Routing/Transit No.', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                                        ),
                                        pw.Padding(
                                          padding: pw.EdgeInsets.all(8),
                                          child: pw.Text(bankingData.rountingNumber),
                                        ),
                                      ],
                                    ),
                                    pw.TableRow(
                                      children: [
                                        pw.Padding(
                                          padding: pw.EdgeInsets.all(8),
                                          child: pw.Text('Account No.', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                                        ),
                                        pw.Padding(
                                          padding: pw.EdgeInsets.all(8),
                                          child: pw.Text(bankingData.accNum),
                                        ),
                                      ],
                                    ),
                                    pw.TableRow(
                                      children: [
                                        pw.Padding(
                                          padding: pw.EdgeInsets.all(8),
                                          child: pw.Text('Requested Amount', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                                        ),
                                        pw.Padding(
                                          padding: pw.EdgeInsets.all(8),
                                          child: pw.Text(bankingData.amtRequested.toString()),
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
                        onLayout: (PdfPageFormat format) async => pdf.save(),
                      );
                    } catch (e) {
                      print('Error generating PDF: $e');
                    }
                  },
                ),
                //SizedBox(width: 8.0),
                // CustomElevatedButton(
                //   icon: Icons.print_outlined,
                //   label: 'Print',
                //   iconPosition: IconPosition.right,
                //   onPressed: () {
                //
                //   },
                // ),

                // CustomElevatedButton(
                //   icon: Icons.print_outlined,
                //   label: 'Print',
                //   iconPosition: IconPosition.right,
                //   onPressed: () async {
                //     final pdf = pw.Document();
                //     final bankingData = snapshot.data![index];
                //     pdf.addPage(
                //       pw.Page(
                //         build: (pw.Context context) => pw.Center(
                //           child: pw.Column(
                //             mainAxisAlignment: pw.MainAxisAlignment.center,
                //             children: [
                //               pw.Text(
                //                 'Bank #${bankingData.empBankId.toString()}',
                //               ),
                //               pw.SizedBox(height: 10),
                //               pw.Row(
                //                 mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                //                 children: [
                //                   pw.Column(
                //                     crossAxisAlignment: pw.CrossAxisAlignment.start,
                //                     children: [
                //                       pw.Text('Type'),
                //                       pw.SizedBox(height: 5),
                //                       pw.Text('Effective Date'),
                //                       pw.SizedBox(height: 5),
                //                       pw.Text('Bank Name'),
                //                       pw.SizedBox(height: 5),
                //                       pw.Text('Routing/Transit No.'),
                //                       pw.SizedBox(height: 5),
                //                       pw.Text('Account No.'),
                //                       pw.SizedBox(height: 5),
                //                       pw.Text('Requested amount'),
                //                       pw.SizedBox(height: 5),
                //                     ],
                //                   ),
                //                   pw.Column(
                //                     crossAxisAlignment: pw.CrossAxisAlignment.start,
                //                     children: [
                //                       pw.Text(bankingData.type),
                //                       pw.SizedBox(height: 5),
                //                       pw.Text(bankingData.effectiveDate),
                //                       pw.SizedBox(height: 5),
                //                       pw.Text(bankingData.bankName),
                //                       pw.SizedBox(height: 5),
                //                       pw.Text(bankingData.rountingNumber),
                //                       pw.SizedBox(height: 5),
                //                       pw.Text(bankingData.accNum),
                //                       pw.SizedBox(height: 5),
                //                       pw.Text(bankingData.amtRequested.toString()),
                //                       pw.SizedBox(height: 5),
                //                     ],
                //                   ),
                //                 ],
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     );
                //
                //     await Printing.layoutPdf(
                //       onLayout: (PdfPageFormat format) async => pdf.save(),
                //     );
                //   },
                // // CustomElevatedButton(
                // //   icon: Icons.print_outlined,
                // //   label: 'Print',
                // //   iconPosition: IconPosition.right,
                // //   onPressed: () async {
                // //     final pdf = pw.Document();
                // //     pdf.addPage(
                // //       pw.Page(
                // //         build: (pw.Context context) => pw.Center(
                // //           child: pw.Text('Hello, this is a test print!'),
                // //         ),
                // //       ),
                // //     );
                // //
                // //     // You can modify the content of the PDF as needed.
                // //
                // //     await Printing.layoutPdf(
                // //       onLayout: (PdfPageFormat format) async => pdf.save(),
                // //     );
                // //   },
                // ),
                // SizedBox(width: 8.0),
                // CustomElevatedButton(
                //   icon: Icons.file_download_outlined,
                //   label: 'Download',
                //   iconPosition: IconPosition.right,
                //   onPressed: () async {
                //     try {
                //       final pdf = pw.Document();
                //       final bankingData = snapshot.data![index];
                //
                //       pdf.addPage(
                //         pw.Page(
                //           build: (pw.Context context) => pw.Padding(
                //             padding: pw.EdgeInsets.all(20),
                //             child: pw.Column(
                //               crossAxisAlignment: pw.CrossAxisAlignment.start,
                //               children: [
                //                 pw.Text(
                //                   'Banking Details',
                //                   style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
                //                 ),
                //                 pw.Divider(),
                //                 pw.SizedBox(height: 10),
                //                 pw.Text(
                //                   'Bank #${bankingData.empBankId.toString()}',
                //                   style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
                //                 ),
                //                 pw.SizedBox(height: 20),
                //                 pw.Table(
                //                   border: pw.TableBorder.all(),
                //                   children: [
                //                     pw.TableRow(
                //                       children: [
                //                         pw.Padding(
                //                           padding: pw.EdgeInsets.all(8),
                //                           child: pw.Text('Type', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                //                         ),
                //                         pw.Padding(
                //                           padding: pw.EdgeInsets.all(8),
                //                           child: pw.Text(bankingData.type),
                //                         ),
                //                       ],
                //                     ),
                //                     pw.TableRow(
                //                       children: [
                //                         pw.Padding(
                //                           padding: pw.EdgeInsets.all(8),
                //                           child: pw.Text('Effective Date', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                //                         ),
                //                         pw.Padding(
                //                           padding: pw.EdgeInsets.all(8),
                //                           child: pw.Text(bankingData.effectiveDate),
                //                         ),
                //                       ],
                //                     ),
                //                     pw.TableRow(
                //                       children: [
                //                         pw.Padding(
                //                           padding: pw.EdgeInsets.all(8),
                //                           child: pw.Text('Bank Name', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                //                         ),
                //                         pw.Padding(
                //                           padding: pw.EdgeInsets.all(8),
                //                           child: pw.Text(bankingData.bankName),
                //                         ),
                //                       ],
                //                     ),
                //                     pw.TableRow(
                //                       children: [
                //                         pw.Padding(
                //                           padding: pw.EdgeInsets.all(8),
                //                           child: pw.Text('Routing/Transit No.', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                //                         ),
                //                         pw.Padding(
                //                           padding: pw.EdgeInsets.all(8),
                //                           child: pw.Text(bankingData.rountingNumber),
                //                         ),
                //                       ],
                //                     ),
                //                     pw.TableRow(
                //                       children: [
                //                         pw.Padding(
                //                           padding: pw.EdgeInsets.all(8),
                //                           child: pw.Text('Account No.', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                //                         ),
                //                         pw.Padding(
                //                           padding: pw.EdgeInsets.all(8),
                //                           child: pw.Text(bankingData.accNum),
                //                         ),
                //                       ],
                //                     ),
                //                     pw.TableRow(
                //                       children: [
                //                         pw.Padding(
                //                           padding: pw.EdgeInsets.all(8),
                //                           child: pw.Text('Requested Amount', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                //                         ),
                //                         pw.Padding(
                //                           padding: pw.EdgeInsets.all(8),
                //                           child: pw.Text(bankingData.amtRequested.toString()),
                //                         ),
                //                       ],
                //                     ),
                //                   ],
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       );
                //
                //       await Printing.layoutPdf(
                //         onLayout: (PdfPageFormat format) async => pdf.save(),
                //       );
                //     } catch (e) {
                //       print('Error generating PDF: $e');
                //     }
                //   },
                // ),
              ],
            ),
            title: 'Bank #${index + 1}',));
        }));
      }else{
        return const SizedBox();
      }
        }
    );
  }
}


class InfoText extends StatelessWidget {
  final String text;

  const InfoText(this.text);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text, style:  ThemeManager.customTextStyle(context)),
        const SizedBox(height: 10),
      ],
    );
  }
}

class InfoData extends StatelessWidget {
  final String text;

  const InfoData(this.text);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text, style:  ThemeManagerDark.customTextStyle(context)),
        const SizedBox(height: 10),
      ],
    );
  }
}

class ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomElevatedButton(
          icon: Icons.remove_red_eye,
          label: 'Void Check',
          onPressed: () {

          },
        ),
        SizedBox(width: 8.0),
        // CustomElevatedButton(
        //   icon: Icons.print_outlined,
        //   label: 'Print',
        //   iconPosition: IconPosition.right,
        //   onPressed: () {
        //
        //   },
        // ),

        CustomElevatedButton(
          icon: Icons.print_outlined,
          label: 'Print',
          iconPosition: IconPosition.right,
          onPressed: () async {
            final pdf = pw.Document();
            pdf.addPage(
              pw.Page(
                build: (pw.Context context) => pw.Center(
                  child: pw.Text('Hello, this is a test print!'),
                ),
              ),
            );

            // You can modify the content of the PDF as needed.

            await Printing.layoutPdf(
              onLayout: (PdfPageFormat format) async => pdf.save(),
            );
          },
        ),
        SizedBox(width: 8.0),
        CustomElevatedButton(
          icon: Icons.sim_card_download_outlined,
          label: 'Download',
          iconPosition: IconPosition.right,
          onPressed: () {

          },
        ),
      ],
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final IconPosition iconPosition;
  final VoidCallback onPressed;

  const CustomElevatedButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.iconPosition = IconPosition.left,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Color(0xff1696C8),
        side: BorderSide(color: Color(0xff1696C8)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: iconPosition == IconPosition.left
            ? [
          Container(
            width: 16.0,
            height: 16.0,
            decoration: BoxDecoration(
              color: Color(0xff1696C8),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Icon(
              icon,
              size: 12.0,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 6.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ]
            : [
          Text(
            label,
            style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(width: 6.0),
          Icon(
            icon,
            size: 16.0,
            color: Color(0xff1696C8),
          ),
        ],
      ),
    );
  }
}

enum IconPosition { left, right }